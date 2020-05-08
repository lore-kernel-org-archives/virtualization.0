From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 2/2] virtio-net: fix the XDP truesize calculation
 for mergeable buffers
Date: Fri, 8 May 2020 09:54:05 +0800
Message-ID: <0e59287f-8333-c715-da03-91306cef9878@redhat.com>
References: <20200506061633.16327-1-jasowang@redhat.com>
 <20200506061633.16327-2-jasowang@redhat.com>
 <20200506033259-mutt-send-email-mst@kernel.org>
 <789fc6e6-9667-a609-c777-a9b1fed72f41@redhat.com>
 <20200506075807-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200506075807-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/5/6 下午8:08, Michael S. Tsirkin wrote:
> On Wed, May 06, 2020 at 04:21:15PM +0800, Jason Wang wrote:
>> On 2020/5/6 下午3:37, Michael S. Tsirkin wrote:
>>> On Wed, May 06, 2020 at 02:16:33PM +0800, Jason Wang wrote:
>>>> We should not exclude headroom and tailroom when XDP is set. So this
>>>> patch fixes this by initializing the truesize from PAGE_SIZE when XDP
>>>> is set.
>>>>
>>>> Cc: Jesper Dangaard Brouer<brouer@redhat.com>
>>>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>>> Seems too aggressive, we do not use up the whole page for the size.
>>>
>>>
>>>
>> For XDP yes, we do:
>>
>> static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
>>                        struct ewma_pkt_len *avg_pkt_len,
>>                        unsigned int room)
>> {
>>      const size_t hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
>>      unsigned int len;
>>
>>      if (room)
>>          return PAGE_SIZE - room;
>>
>> ...
>>
>> Thanks
> Hmm. But that's only for new buffers. Buffers that were outstanding
> before xdp was attached don't use the whole page, do they?


They don't and in either case, we've encoded truesize in the ctx. Any 
issue you saw?


>
>
>
>
> Also, with TCP smallqueues blocking the queue like that might be a problem.
> Could you try and check performance impact of this?


I'm not sure I get you, TCP small queue is more about TX I guess. And 
since we've invalidated the vnet header, the performance of XDP_PASS 
won't be good.


> I looked at what other drivers do and I see they tend to copy the skb
> in XDP_PASS case. ATM we don't normally - but should we?


My understanding is XDP runs before skb, so I don't get here. Or maybe 
you can point me the driver you mentioned here? I've checked i40e and 
mlx5e, both of them build skb after XDP.

Thanks

>
