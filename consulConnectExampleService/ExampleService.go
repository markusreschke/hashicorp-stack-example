package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
)

func main() {
	addr := "127.0.0.1:8080"
	if len(os.Args) > 1 {
		addr = os.Args[1]
	}

	call := func (resp http.ResponseWriter, req *http.Request) {
		extResp, err := http.Get("http://127.0.0.1:8082/respond")
		if err != nil {
			fmt.Printf("Error Getting: %v\n", err)
			return
		}

		resp.Write([]byte(addr))
		extRespBytes, err := ioutil.ReadAll(extResp.Body)
		if err != nil {
			fmt.Printf("Error Reading: %v\n", err)
			return
		}

		resp.Write(extRespBytes)
	}

	respond := func (resp http.ResponseWriter, req *http.Request) {
		resp.Write([]byte(addr))
	}

	http.HandleFunc("/call", call)
	http.HandleFunc("/respond", respond)
	http.ListenAndServe(addr, nil)
}
