Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28DA30BF52
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255454; cv=none; b=lTWP49M58nYl8/zAizOqUfSl8tZQazW8OK3uKSVpbNRCVU3HxNqDHAAKUty4bICvcaZTvbFYAW3XVYCtG43xLIOjKrc+kbYy1PEaWkVyrarb7WW9BdBYVQptzBcrrucEihD6NJ5j2vWRUQElvg/hyjIW1NdsmOdrxbA7OlVFoJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255454; c=relaxed/simple;
	bh=rdDtrTgIi+rN4hhDCNeEhPYuXlZ/J2y+H8n1qLpmtsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Hra58uS5g7jTT3ivUMwl6szdQkyt0Lu2U/JpavvpBO+hUHo2hZoU51x1LLwTfwlecpNp47/NCsUPr2SqlbzBLh+bovoHKwXnh2NE660V+lS6UxNOo7hqT0g6F7BA4C5LU3wUYKKSbtKwVGwCIicArMwI4ocBvjt1/oqotSdsP24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aoG6h6uw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aoG6h6uw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778255449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdBAwN+ZE1eYNiJtu0H0OHxl4J/6xgxxgGUcknEIPjk=;
	b=aoG6h6uwWfwPj4Oa7tfZ84TXZPd6AtyEmI8NiLKu8gKOShX/BqNkcKajnizu4aU/VigkYo
	O24rQeO9AtgTGt6t2ZzJzbDkAPxxz8O+adKaswWd9quzmy99cz7cF9Xcr2BkZerIRHS18X
	aSTCZygcYaIzd6WHVJn8MblQGo7ps6w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-bLCKTegpPRGAszXN-Gtlng-1; Fri, 08 May 2026 11:50:48 -0400
X-MC-Unique: bLCKTegpPRGAszXN-Gtlng-1
X-Mimecast-MFC-AGG-ID: bLCKTegpPRGAszXN-Gtlng_1778255447
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4891f97aef0so11469845e9.2
        for <virtualization@lists.linux.dev>; Fri, 08 May 2026 08:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778255447; x=1778860247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdBAwN+ZE1eYNiJtu0H0OHxl4J/6xgxxgGUcknEIPjk=;
        b=BvCDeYQ4f4PKzAmRrFXz/h6GfBFufrscyes1OICaI8+yWmlziwRRw93syWUQakl+Rt
         nxQhY22E7ZgxliUtPO5CncdD1+A9a9GSfmt3/b2LY/ce7/DiYbBB+pgDDTAWDijgAhEf
         pKIsNtQqXp+n68BXGd2dkgu0FbEg5LD3pLycVoAhyfo0eIfrSC0YcO77nJItfnhAvlcf
         4rHwYRidCbGIz7bUF+8as2cLav7WZ3KVfre3UhlGcOY1dyJ2WFKvWjAO1gXyo6DTZqVd
         Bxu23dTBOC9FulE6FOuP1hZ58synAtcVeE24hq88aAFwPb1CgJcAdmHFgrXyScFs+hUw
         R8Lg==
X-Forwarded-Encrypted: i=1; AFNElJ+grlTVEqDleEswrg8WFxWwPVqjgw+pY3YID1vXFcIvijgUJlZtP3Q3mGTf+9awGQi/EgiFtjVYssSE+rHTgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJhaYN1zPDDLH6P+mf/k/q2fdO8S1LQYRZ5/ItrZQJxx/ohBzD
	w2XllgyxsDVqzmWWj6c2y/jnTra7glhTspRy3b5zHm0uEbPiefyj3P4znMv0bKmE9w+PVUVI6F/
	wDu7L+PDALq1z7OXqbG4nZxasoKU8Ut7LVWag2D/M+1Xpqnh7vSU8OzPcOQPkkQuyh2qG
X-Gm-Gg: AeBDiety76vGGsQw/nNxl+/s0PwuC0j/q13FIJUenga0T3/2IBLUpvQN88ptMgTElWn
	ry2/q/69OwAUKoOySi+Dxmpe7b2VPQr79qU4pQIeyeGjsl+sLd+L2EmJRXD79VZlfFJgeeYZSrD
	xIK6Cmvx4azrvOEK90/218GPTQTpBVlmVA8c4h1wgfh/1gaDPfbh2VELKy2HNeRWILso7LOMWAB
	LMxWkEK0kvEKzlxfsjxwmpJA3zwaBCXXSQHVgQu6XYypDL0v/lgLD28Y4A+Y6+OUtatTYvOiWXR
	PM06hUDakqQTIx1/k2wdbIun/laBEn4G0cOJW5QNXHFhclZxyjJhgklGSjKfZD+JPWUHUzhXteL
	e8jnD+l2JXG+g1MLcq0bd7E8ujW4DJ8oXpn5QLrpuLbBeEMpEChjKZb3RSYYqJmI=
X-Received: by 2002:a05:600c:8485:b0:48a:58ae:9933 with SMTP id 5b1f17b1804b1-48e51f32806mr210416085e9.18.1778255446899;
        Fri, 08 May 2026 08:50:46 -0700 (PDT)
X-Received: by 2002:a05:600c:8485:b0:48a:58ae:9933 with SMTP id 5b1f17b1804b1-48e51f32806mr210415475e9.18.1778255446303;
        Fri, 08 May 2026 08:50:46 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db11fc4sm2280025e9.27.2026.05.08.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:50:45 -0700 (PDT)
Date: Fri, 8 May 2026 17:50:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yiqi Sun <sunyiqixm@gmail.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap,
 copy
Message-ID: <af4GIeSEQ_65V5C2@sgarzare-redhat>
References: <afnXIGtswspSEk8x@sgarzare-redhat>
 <a7b95294-3aa6-4bca-9eab-a4bcd0202ae2@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a7b95294-3aa6-4bca-9eab-a4bcd0202ae2@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cAOCCmgYNqc0BZoui99fzShqsC7BBhSuZtOrBI3RkTw_1778255447
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, May 07, 2026 at 11:03:57PM +0300, Arseniy Krasnov wrote:
>>CCing Arseniy and Bobby.
>
>Thanks!
>
>>
>>On Tue, May 05, 2026 at 12:26:21PM +0200, Paolo Abeni wrote:
>>>On 4/30/26 9:11 AM, Yiqi Sun wrote:
>>>> vsockmon mirrors packets through virtio_transport_build_skb(), which
>>>> builds a new skb and copies the payload into it. For non-linear skbs,
>>>> this goes through virtio_transport_copy_nonlinear_skb().
>>>>
>>>> Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
>>>> As a result, skb_copy_datagram_iter() sees zero writable bytes
>>>> in the destination iterator and copies no payload data.
>>>>
>>>> This becomes an info leak because virtio_transport_build_skb() has
>>>> already reserved payload_len bytes in the new skb with skb_put(). The
>>>> skb is then returned to the tap path with that payload area still
>>>> uninitialized, so userspace reading from a vsockmon device can observe
>>>> heap contents and potentially kernel address.
>>>>
>>>> Fix it by initializing iov_iter.count to the number of bytes to copy.
>>>>
>>>> Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
>>>> Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
>>>> ---
>>>>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>> index 416d533f493d..6b26ee57ccab 100644
>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>> @@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>>>>  	iov_iter.nr_segs = 1;
>>>>
>>>>  	to_copy = min_t(size_t, len, skb->len);
>>>> -
>>>> +	iov_iter.count = to_copy;
>>>>  	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
>>>>  			       &iov_iter, to_copy);
>>>
>>>@Stefano, @Stefan, the patch LGTM, but sashiko pointed out to a
>>>pre-existing issue you should probably want to address:
>>>
>>>>  	to_copy = min_t(size_t, len, skb->len);
>>>Does this length calculation account for the offset when a packet is
>>>split across multiple transmissions?
>>>If a packet is requeued, VIRTIO_VSOCK_SKB_CB(skb)->offset is increased,
>>>but to_copy still evaluates to the full length of the skb.
>>
>>Yep, I just checked and vhost-vsock is the only place where we call
>>virtio_transport_deliver_tap_pkt() wiht an offset != 0, but I agree that
>>we should also fix it.
>
>Yes, looks like the only place where offset could be non zero is 'vhost_transport_do_send_pkt()'.
>And we set valid length in header every attempt to send it:
>
>                /* Set the correct length in the header */
>                hdr->len = cpu_to_le32(payload_len);
>
>In all other places we call 'virtio_transport_deliver_tap_pkt()' with offset == 0. And thus
>skb->len == hdr->len.
>
>So for me looks ok. E.g. len in header is actual data.
>
>>
>>Looking better in net/vmw_vsock/virtio_transport_common.c I think this
>>is a regression, indeed we have this comment in
>>virtio_transport_build_skb():
>>
>>	/* A packet could be split to fit the RX buffer, so we can retrieve
>>	 * the payload length from the header and the buffer pointer taking
>>	 * care of the offset in the original packet.
>>	 */
>>	pkt_hdr = virtio_vsock_hdr(pkt);
>>
>>Before commit 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with
>>sk_buff") we read the payload lenght from the header that is always set
>>to the right value before delivering the packet to the tap.
>>
>> From that commit, we don't to consider the offset anymore since we
>>started to use `len` from the skb, so IMO we should go back to what we
>>did before it, I mean:
>>
>>	payload_len = le32_to_cpu(pkt->hdr.len);
>>
>>@Bobby do you remember why we did that change? Or if you see any issue
>>going back to what we did initially?
>>
>>
>>Also IMO we should avoid to set all the iov_iter fields by hand and
>>start to use iov_iter_kvec(). Plus, we can just use
>>skb_copy_datagram_iter() in any case, like we already do in vhost-vsock,
>>since it already handles linear vs non linear.
>>
>>At the end I mean something like this:
>>
>>@@ -171,7 +150,7 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>>  	 * care of the offset in the original packet.
>>  	 */
>>  	pkt_hdr = virtio_vsock_hdr(pkt);
>>-	payload_len = pkt->len;
>>+	payload_len = le32_to_cpu(pkt_hdr->len);
>>
>>  	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
>>  			GFP_ATOMIC);
>>@@ -214,13 +193,17 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>>  	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
>>
>>  	if (payload_len) {
>>-		if (skb_is_nonlinear(pkt)) {
>>-			void *data = skb_put(skb, payload_len);
>>+		struct iov_iter iov_iter;
>>+		struct kvec kvec;
>>+		void *data = skb_put(skb, payload_len);
>>
>>-			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
>>-		} else {
>>-			skb_put_data(skb, pkt->data, payload_len);
>>-		}
>>+		kvec.iov_base = data;
>>+		kvec.iov_len = payload_len;
>>+		iov_iter_kvec(&iov_iter, READ, &kvec, 1, payload_len);
>>+
>>+		skb_copy_datagram_iter(pkt,
>>+				       VIRTIO_VSOCK_SKB_CB(pkt)->offset,
>>+				       &iov_iter, payload_len);
>>  	}
>>
>>  	return skb;
>>
>>And removing virtio_transport_copy_nonlinear_skb().
>
>Yes, this looks shorter and better.

Thanks for confirming, I'll send a series soon and CC you.
Please review it :-)

Thanks,
Stefano

