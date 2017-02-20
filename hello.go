package main

import (
	"log"

	"github.com/golang/protobuf/proto"
	protobufsdb "github.com/william-richard/protobufs-db/gens"
)

func main() {
	test := &protobufsdb.Test{
		Label: "Hello",
	}

	log.Printf("%+v", test)

	data, err := proto.Marshal(test)
	if err != nil {
		log.Fatal("marshaling error: ", err)
	}
	newTest := &protobufsdb.Test{}
	err = proto.Unmarshal(data, newTest)
	if err != nil {
		log.Fatal("unmarshaling error: ", err)
	}
	// Now test and newTest contain the same data.
	if test.GetLabel() != newTest.GetLabel() {
		log.Fatalf("data mismatch %q != %q", test.GetLabel(), newTest.GetLabel())
	}

	log.Printf("%v", newTest)
}
