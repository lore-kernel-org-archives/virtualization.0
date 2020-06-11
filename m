From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC v6 02/11] vhost: use batched get_vq_desc version
Date: Thu, 11 Jun 2020 11:02:57 +0800
Message-ID: <76b14132-407a-48bf-c4d5-9d0b2c700bb0@redhat.com>
References: <20200608125238.728563-1-mst@redhat.com>
 <20200608125238.728563-3-mst@redhat.com>
 <81904cc5-b662-028d-3b4a-bdfdbd2deb8c@redhat.com>
 <20200610070259-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200610070259-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, eperezma@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/6/10 下午7:05, Michael S. Tsirkin wrote:
>>> +EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
>>>    /* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
>>>    void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
>>>    {
>>> +	unfetch_descs(vq);
>>>    	vq->last_avail_idx -= n;
>> So unfetch_descs() has decreased last_avail_idx.
>> Can we fix this by letting unfetch_descs() return the number and then we can
>> do:
>>
>> int d = unfetch_descs(vq);
>> vq->last_avail_idx -= (n > d) ? n - d: 0;
>>
>> Thanks
> That's intentional I think - we need both.


Yes, but:


>
> Unfetch_descs drops the descriptors in the cache that were
> *not returned to caller*  through get_vq_desc.
>
> vhost_discard_vq_desc drops the ones that were returned through get_vq_desc.
>
> Did I miss anything?

We could count some descriptors twice, consider the case e.g we only 
cache on descriptor:

fetch_descs()
     fetch_buf()
         last_avail_idx++;

Then we want do discard it:
vhost_discard_avail_buf(1)
     unfetch_descs()
         last_avail_idx--;
     last_avail_idx -= 1;

Thanks
