From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] virtio-net: share receive_*() and add_recvbuf_*() with
	virtio-vsock
Date: Mon, 15 Jul 2019 17:16:09 +0800
Message-ID: <880c1ad2-7e02-3d5d-82d7-49076cc8d02b__35808.1288331718$1563182191$gmane$org@redhat.com>
References: <20190710153707.twmzgmwqqw3pstos@steredhat>
	<9574bc38-4c5c-2325-986b-430e4a2b6661@redhat.com>
	<20190711114134.xhmpciyglb2angl6@steredhat>
	<20190711152855-mutt-send-email-mst@kernel.org>
	<20190712100033.xs3xesz2plfwj3ag@steredhat>
	<a514d8a4-3a12-feeb-4467-af7a9fbf5183@redhat.com>
	<20190715074416.a3s2i5ausognotbn@steredhat>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190715074416.a3s2i5ausognotbn@steredhat>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


>>>>>>>        struct sk_buff *virtskb_receive_small(struct virtskb *vs, ...);
>>>>>>>        struct sk_buff *virtskb_receive_big(struct virtskb *vs, ...);
>>>>>>>        struct sk_buff *virtskb_receive_mergeable(struct virtskb *vs, ...);
>>>>>>>
>>>>>>>        int virtskb_add_recvbuf_small(struct virtskb*vs, ...);
>>>>>>>        int virtskb_add_recvbuf_big(struct virtskb *vs, ...);
>>>>>>>        int virtskb_add_recvbuf_mergeable(struct virtskb *vs, ...);
>>>>>>>
>>>>>>> For the Guest->Host path it should be easier, so maybe I can add a
>>>>>>> "virtskb_send(struct virtskb *vs, struct sk_buff *skb)" with a part of the code
>>>>>>> of xmit_skb().
>>>>>> I may miss something, but I don't see any thing that prevents us from using
>>>>>> xmit_skb() directly.
>>>>>>
>>>>> Yes, but my initial idea was to make it more parametric and not related to the
>>>>> virtio_net_hdr, so the 'hdr_len' could be a parameter and the
>>>>> 'num_buffers' should be handled by the caller.
>>>>>
>>>>>>> Let me know if you have in mind better names or if I should put these function
>>>>>>> in another place.
>>>>>>>
>>>>>>> I would like to leave the control part completely separate, so, for example,
>>>>>>> the two drivers will negotiate the features independently and they will call
>>>>>>> the right virtskb_receive_*() function based on the negotiation.
>>>>>> If it's one the issue of negotiation, we can simply change the
>>>>>> virtnet_probe() to deal with different devices.
>>>>>>
>>>>>>
>>>>>>> I already started to work on it, but before to do more steps and send an RFC
>>>>>>> patch, I would like to hear your opinion.
>>>>>>> Do you think that makes sense?
>>>>>>> Do you see any issue or a better solution?
>>>>>> I still think we need to seek a way of adding some codes on virtio-net.c
>>>>>> directly if there's no huge different in the processing of TX/RX. That would
>>>>>> save us a lot time.
>>>>> After the reading of the buffers from the virtqueue I think the process
>>>>> is slightly different, because virtio-net will interface with the network
>>>>> stack, while virtio-vsock will interface with the vsock-core (socket).
>>>>> So the virtio-vsock implements the following:
>>>>> - control flow mechanism to avoid to loose packets, informing the peer
>>>>>     about the amount of memory available in the receive queue using some
>>>>>     fields in the virtio_vsock_hdr
>>>>> - de-multiplexing parsing the virtio_vsock_hdr and choosing the right
>>>>>     socket depending on the port
>>>>> - socket state handling
>>
>> I think it's just a branch, for ethernet, go for networking stack. otherwise
>> go for vsock core?
>>
> Yes, that should work.
>
> So, I should refactor the functions that can be called also from the vsock
> core, in order to remove "struct net_device *dev" parameter.
> Maybe creating some wrappers for the network stack.
>
> Otherwise I should create a fake net_device for vsock_core.
>
> What do you suggest?


I'm not quite sure I get the question. Can you just use the one that 
created by virtio_net?


Thanks
