Received: from mx4.sberdevices.ru (mx4.sberdevices.ru [152.89.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF503101B9
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.89.196.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257089; cv=none; b=NsgzrTpsF06QGElYF5riavLfEoR7UxK0Pr2S+2EQjtWh0xk69NYrmgb658mgscfDOsQSZVpfFQ03URoXBL4z+mRXNEg+bfPNInkT0YMweel2//wpQczEEXuXska12wKlq3jbvzWUs7KruexXv6Z5IjbNH0+ILKNYnuRfuPH+gzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257089; c=relaxed/simple;
	bh=WQyVtSx/y9hNs4O01MnJ42SKhEVG89n5peaQekF4v8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ALQ/G/doo3XgPik94BmrW8aZvTpvR17P0lIQHpsLcav2H3EpeN5WNWfTTt8DKIdA5+6rkNVxhEvw1naMtq1GcBahXdsc1/4YCi9kcsRptgAKb5BhvpMJIya9TmpN7UHjmE4CggaVFnobNZXvRMwXJj3JsyxXhbcseqO3RJZICrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=mQNSKrpE; arc=none smtp.client-ip=152.89.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="mQNSKrpE"
Received: from p-antispam-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id DD5A540009;
	Fri,  8 May 2026 19:18:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru DD5A540009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1778257083;
	bh=8FanPFtHCyWnQhGMmz2FaDUvfQG0DDuyhVa231+3qZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=mQNSKrpEVJn6pHaLu3l/u13bN0l5TUKTQvSsVdNti4VqPT4JxXIS9nX1doIEfH8rn
	 T9iaRAO/RT44MiaZwouwXXcFfjz/ez4VXW7alfMIewwBxdhLY6TcXwSk+uu3r/kasq
	 34QDBKRXR6GirmNfZDsggB1PHcwMzqL+IInpVyd4Fn9sQV2TEbXY9Wyy9gIoQSFHBD
	 P8nMldzQd0DtX9v0VTM2sYey+wCC3M2QiUu2+JA72Jzpdm5WxkQ5wqN8eYBrogTigm
	 8o6pc2JuM0RmT/qVXwrW8IVx8HUzCoVrYIQgioDpbhvOAL46HCIzyiDa/NBSVz2GPs
	 rOeQcVMURCfdw==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx4.sberdevices.ru (Postfix) with ESMTPS;
	Fri,  8 May 2026 19:18:03 +0300 (MSK)
Message-ID: <34fe4fe3-4345-4d84-b0b9-739fcb6d8265@salutedevices.com>
Date: Fri, 8 May 2026 19:17:57 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap,
 copy
To: Stefano Garzarella <sgarzare@redhat.com>
CC: Paolo Abeni <pabeni@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Yiqi Sun <sunyiqixm@gmail.com>,
	<kvm@vger.kernel.org>, <virtualization@lists.linux.dev>
References: <afnXIGtswspSEk8x@sgarzare-redhat>
 <a7b95294-3aa6-4bca-9eab-a4bcd0202ae2@salutedevices.com>
 <af4GIeSEQ_65V5C2@sgarzare-redhat>
Content-Language: ru
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <af4GIeSEQ_65V5C2@sgarzare-redhat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-exch-cas-s-m1.sberdevices.ru (172.16.210.2) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 104 0.3.104 557b3c2486a74077a103cf2acd83f2ecf4c95118, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 202995 [May 08 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/05/08 11:39:00 #28514221
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5



On 08/05/2026 18:50, Stefano Garzarella wrote:
> On Thu, May 07, 2026 at 11:03:57PM +0300, Arseniy Krasnov wrote:
>>> CCing Arseniy and Bobby.
>>
>> Thanks!
>>
>>>
>>> On Tue, May 05, 2026 at 12:26:21PM +0200, Paolo Abeni wrote:
>>>> On 4/30/26 9:11 AM, Yiqi Sun wrote:
>>>>> vsockmon mirrors packets through virtio_transport_build_skb(), which
>>>>> builds a new skb and copies the payload into it. For non-linear skbs,
>>>>> this goes through virtio_transport_copy_nonlinear_skb().
>>>>>
>>>>> Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
>>>>> As a result, skb_copy_datagram_iter() sees zero writable bytes
>>>>> in the destination iterator and copies no payload data.
>>>>>
>>>>> This becomes an info leak because virtio_transport_build_skb() has
>>>>> already reserved payload_len bytes in the new skb with skb_put(). The
>>>>> skb is then returned to the tap path with that payload area still
>>>>> uninitialized, so userspace reading from a vsockmon device can observe
>>>>> heap contents and potentially kernel address.
>>>>>
>>>>> Fix it by initializing iov_iter.count to the number of bytes to copy.
>>>>>
>>>>> Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
>>>>> Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
>>>>> ---
>>>>>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>>> index 416d533f493d..6b26ee57ccab 100644
>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>> @@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>>>>>      iov_iter.nr_segs = 1;
>>>>>
>>>>>      to_copy = min_t(size_t, len, skb->len);
>>>>> -
>>>>> +    iov_iter.count = to_copy;
>>>>>      skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
>>>>>                     &iov_iter, to_copy);
>>>>
>>>> @Stefano, @Stefan, the patch LGTM, but sashiko pointed out to a
>>>> pre-existing issue you should probably want to address:
>>>>
>>>>>      to_copy = min_t(size_t, len, skb->len);
>>>> Does this length calculation account for the offset when a packet is
>>>> split across multiple transmissions?
>>>> If a packet is requeued, VIRTIO_VSOCK_SKB_CB(skb)->offset is increased,
>>>> but to_copy still evaluates to the full length of the skb.
>>>
>>> Yep, I just checked and vhost-vsock is the only place where we call
>>> virtio_transport_deliver_tap_pkt() wiht an offset != 0, but I agree that
>>> we should also fix it.
>>
>> Yes, looks like the only place where offset could be non zero is 'vhost_transport_do_send_pkt()'.
>> And we set valid length in header every attempt to send it:
>>
>>                /* Set the correct length in the header */
>>                hdr->len = cpu_to_le32(payload_len);
>>
>> In all other places we call 'virtio_transport_deliver_tap_pkt()' with offset == 0. And thus
>> skb->len == hdr->len.
>>
>> So for me looks ok. E.g. len in header is actual data.
>>
>>>
>>> Looking better in net/vmw_vsock/virtio_transport_common.c I think this
>>> is a regression, indeed we have this comment in
>>> virtio_transport_build_skb():
>>>
>>>     /* A packet could be split to fit the RX buffer, so we can retrieve
>>>      * the payload length from the header and the buffer pointer taking
>>>      * care of the offset in the original packet.
>>>      */
>>>     pkt_hdr = virtio_vsock_hdr(pkt);
>>>
>>> Before commit 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with
>>> sk_buff") we read the payload lenght from the header that is always set
>>> to the right value before delivering the packet to the tap.
>>>
>>> From that commit, we don't to consider the offset anymore since we
>>> started to use `len` from the skb, so IMO we should go back to what we
>>> did before it, I mean:
>>>
>>>     payload_len = le32_to_cpu(pkt->hdr.len);
>>>
>>> @Bobby do you remember why we did that change? Or if you see any issue
>>> going back to what we did initially?
>>>
>>>
>>> Also IMO we should avoid to set all the iov_iter fields by hand and
>>> start to use iov_iter_kvec(). Plus, we can just use
>>> skb_copy_datagram_iter() in any case, like we already do in vhost-vsock,
>>> since it already handles linear vs non linear.
>>>
>>> At the end I mean something like this:
>>>
>>> @@ -171,7 +150,7 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>>>       * care of the offset in the original packet.
>>>       */
>>>      pkt_hdr = virtio_vsock_hdr(pkt);
>>> -    payload_len = pkt->len;
>>> +    payload_len = le32_to_cpu(pkt_hdr->len);
>>>
>>>      skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
>>>              GFP_ATOMIC);
>>> @@ -214,13 +193,17 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>>>      skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
>>>
>>>      if (payload_len) {
>>> -        if (skb_is_nonlinear(pkt)) {
>>> -            void *data = skb_put(skb, payload_len);
>>> +        struct iov_iter iov_iter;
>>> +        struct kvec kvec;
>>> +        void *data = skb_put(skb, payload_len);
>>>
>>> -            virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
>>> -        } else {
>>> -            skb_put_data(skb, pkt->data, payload_len);
>>> -        }
>>> +        kvec.iov_base = data;
>>> +        kvec.iov_len = payload_len;
>>> +        iov_iter_kvec(&iov_iter, READ, &kvec, 1, payload_len);
>>> +
>>> +        skb_copy_datagram_iter(pkt,
>>> +                       VIRTIO_VSOCK_SKB_CB(pkt)->offset,
>>> +                       &iov_iter, payload_len);
>>>      }
>>>
>>>      return skb;
>>>
>>> And removing virtio_transport_copy_nonlinear_skb().
>>
>> Yes, this looks shorter and better.
> 
> Thanks for confirming, I'll send a series soon and CC you.
> Please review it :-)

Sure, thanks!

> 
> Thanks,
> Stefano
> 

