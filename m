Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3F43D6CCF
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255937; cv=none; b=AiO/fzMuyMqUvZo6fqc5cQnvle+K7L8pf0Hm4dmDMukmV6jZkm38XZxFR0kXw5XkGsXUS65eMOQGaI+CypdO+RN5NqyeX+EsqyudJUErjDzG5CWOWciYfp8nMfkcka9GJUyLUQTp9HsbtouQZ536Yc3R8fooLtclEPx/gT1LtSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255937; c=relaxed/simple;
	bh=4F7maXO0a9FkT9euxBuc8PxcpOM2bW3TZJpMRTTqC3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RAI5trrFn/59GQiMvuhTXhNybrzMNQenr+FyblmX41yZ10lyQcNd5Bbh1EOXbpLwxL8cHjFCl8NaefQC7PukIklsY8mtYDTFk08WoZ/NBySS7pP5Fsn7wEKknIR7te58Oft1MgR+oQx0n7Ky0sgUVSmh5h8i6292NT3DvoGhAb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KeIdlJhA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeIdlJhA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778255928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gt9PkZ1udEZB7A5kTfc6cLitnqLtrOlHUOEwVlvJ/vE=;
	b=KeIdlJhAkmmL2OxiDOH+QrQbWfFLELhnVyhaVV4TM/ULJM/ePH6WfaFNKwUze8jZvrKcVU
	kg7vvHZYFn7Ir6omoK1Ez6+SodVXhKyKA7AXj0cadvmOG/Hfr5GqrnvLp31mxl3S6J88AM
	vH1uZwtGOj3GHgHTl/6e8paBqr7Cqvg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-H5Y6ay-aMLqCHgMcoV-wvw-1; Fri, 08 May 2026 11:58:47 -0400
X-MC-Unique: H5Y6ay-aMLqCHgMcoV-wvw-1
X-Mimecast-MFC-AGG-ID: H5Y6ay-aMLqCHgMcoV-wvw_1778255926
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44a52d5e572so1340233f8f.3
        for <virtualization@lists.linux.dev>; Fri, 08 May 2026 08:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778255926; x=1778860726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt9PkZ1udEZB7A5kTfc6cLitnqLtrOlHUOEwVlvJ/vE=;
        b=XdKrF1UGmVIceX9X1+ItB11u8BV7o+Ly9nj4ZwLce7elYLq2f5WHOxUcLgVxihMWL6
         VyRjutPoHcC+iZ29EtkpgiYQ7Iurwhvg0mMZvXjfbMBOEsqOUAMF8uGrqJxT+HTjytXW
         GETjSOCaO/hkLdRQ5DptPw8eWdYeft2PP9H/qr4bwQ6laJuWRDGRbQAu9Zp9YISEA/HB
         CGpZ+3eyqLvoevkXhYQk20fpB/bC/Ce4O4R488dBfkJ0zqpwIvdqCl4XDmP+9YcC8R9U
         bsT5yz/jjrVGYblIvM9iHP6airzGEu1A4Yf4hSqXrJQVdolqCFQwPLbCDncoJ+SD5UTS
         Gb8g==
X-Forwarded-Encrypted: i=1; AFNElJ85K1+l/V6hI/GqeD2GTbpXvRVNkpkKTIQRsvecRSyD/w1p/20TJyWW1t+Ob4oHhV+OOWMaN+UgND5l06egXg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxf1zs7/RDiB6skPqiRGFwNmDmLO5PyK5GcfQT7a1THny3h/e53
	FnUi7fPmgsNvSrGrpItBCLmjhqRbFimIPOMzbhQG6arF8PIYfiIl1FHVC5B2PFyjBGOci0bNMXy
	pM0efN0UnmODfXgAQPLqEvSjIGC2LCPdxEVavOZacrrgjX/dgwqKpIXiutQmQ2S6QPLLB
X-Gm-Gg: Acq92OHOt5MmmokWH2lFqJmZwT40Qxkypm6m6IAPDUwVj0Bg/nVDOUe/4PlRPXEgt6T
	9F5wpqbbNv1rKkkmWlLFgqZbNZThN+g/nbFIDk6fPWspANY6a5WGxwfFJbngPHkZakE71MmL0aF
	37NezVjZktI34YrC0wLcHkrG03hKn19GBLHpwW7nJ60cBdJ7xSKjXTcTWrytYeHmglhAM7rjLnm
	nTEV7DMlsq7bE5GKXPS9mCJoa45ROv/siJgCaXjXewRkgiKSjS25ZvkF/WxZ+LW+UZgSp/abG6Z
	u1uVfW/fMAfEXLBjaUrmOgdsJablF2qteyengudWTPOF7Vi3wo1ZevZvSavqj5THtjZijes2KND
	Ab+ZWPdUNqwFjjxhS667oKqMVEpn+WsZ85peXiHY/h2yde1s3x08QK/F5BDJox2fZ+BiZir/vvQ
	==
X-Received: by 2002:a5d:588b:0:b0:43d:71f4:7ed4 with SMTP id ffacd0b85a97d-4515b525075mr22331118f8f.15.1778255926232;
        Fri, 08 May 2026 08:58:46 -0700 (PDT)
X-Received: by 2002:a5d:588b:0:b0:43d:71f4:7ed4 with SMTP id ffacd0b85a97d-4515b525075mr22331047f8f.15.1778255925539;
        Fri, 08 May 2026 08:58:45 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6c79fsm5529634f8f.15.2026.05.08.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:58:44 -0700 (PDT)
Date: Fri, 8 May 2026 17:58:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, stefanha@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org, 
	Yiqi Sun <sunyiqixm@gmail.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap
 copy
Message-ID: <af4IAzRUFZdYKvaq@sgarzare-redhat>
References: <20260430071110.380509-1-sunyiqixm@gmail.com>
 <f4e52dcd-59ba-4c2e-9936-49cf27528b21@redhat.com>
 <afnXIGtswspSEk8x@sgarzare-redhat>
 <afzyM6fTTAl0Hnvm@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <afzyM6fTTAl0Hnvm@devvm29614.prn0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Hx8KzguePlfuHXMluVyvLKZCAreB_17ObPbITQuPzLk_1778255926
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, May 07, 2026 at 01:12:35PM -0700, Bobby Eshleman wrote:
>On Tue, May 05, 2026 at 02:44:16PM +0200, Stefano Garzarella wrote:
>> CCing Arseniy and Bobby.
>>
>> On Tue, May 05, 2026 at 12:26:21PM +0200, Paolo Abeni wrote:
>> > On 4/30/26 9:11 AM, Yiqi Sun wrote:
>> > > vsockmon mirrors packets through virtio_transport_build_skb(), which
>> > > builds a new skb and copies the payload into it. For non-linear skbs,
>> > > this goes through virtio_transport_copy_nonlinear_skb().
>> > >
>> > > Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
>> > > As a result, skb_copy_datagram_iter() sees zero writable bytes
>> > > in the destination iterator and copies no payload data.
>> > >
>> > > This becomes an info leak because virtio_transport_build_skb() has
>> > > already reserved payload_len bytes in the new skb with skb_put(). The
>> > > skb is then returned to the tap path with that payload area still
>> > > uninitialized, so userspace reading from a vsockmon device can observe
>> > > heap contents and potentially kernel address.
>> > >
>> > > Fix it by initializing iov_iter.count to the number of bytes to copy.
>> > >
>> > > Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
>> > > Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
>> > > ---
>> > >  net/vmw_vsock/virtio_transport_common.c | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > > index 416d533f493d..6b26ee57ccab 100644
>> > > --- a/net/vmw_vsock/virtio_transport_common.c
>> > > +++ b/net/vmw_vsock/virtio_transport_common.c
>> > > @@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>> > >  	iov_iter.nr_segs = 1;
>> > >
>> > >  	to_copy = min_t(size_t, len, skb->len);
>> > > -
>> > > +	iov_iter.count = to_copy;
>> > >  	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
>> > >  			       &iov_iter, to_copy);
>> >
>> > @Stefano, @Stefan, the patch LGTM, but sashiko pointed out to a
>> > pre-existing issue you should probably want to address:
>> >
>> > >  	to_copy = min_t(size_t, len, skb->len);
>> > Does this length calculation account for the offset when a packet is
>> > split across multiple transmissions?
>> > If a packet is requeued, VIRTIO_VSOCK_SKB_CB(skb)->offset is increased,
>> > but to_copy still evaluates to the full length of the skb.
>>
>> Yep, I just checked and vhost-vsock is the only place where we call
>> virtio_transport_deliver_tap_pkt() wiht an offset != 0, but I agree that we
>> should also fix it.
>>
>> Looking better in net/vmw_vsock/virtio_transport_common.c I think this is a
>> regression, indeed we have this comment in virtio_transport_build_skb():
>>
>> 	/* A packet could be split to fit the RX buffer, so we can retrieve
>> 	 * the payload length from the header and the buffer pointer taking
>> 	 * care of the offset in the original packet.
>> 	 */
>> 	pkt_hdr = virtio_vsock_hdr(pkt);
>>
>> Before commit 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with
>> sk_buff") we read the payload lenght from the header that is always set to
>> the right value before delivering the packet to the tap.
>>
>> From that commit, we don't to consider the offset anymore since we started
>> to use `len` from the skb, so IMO we should go back to what we did before
>> it, I mean:
>>
>> 	payload_len = le32_to_cpu(pkt->hdr.len);
>>
>> @Bobby do you remember why we did that change? Or if you see any issue going
>> back to what we did initially?
>
>I think this was just one that made it through the cracks. I vaguely
>recall a few other instances where I assumed skb->len could stand-in for
>hdr.len, but it didn't hold.
>
>Using hdr.len like the original looks correct to me.

Thanks for confirming, I'll fix it.

Stefano

