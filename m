Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493337;
	b=MA0yyKhFvjZnXc8p3WPKs3QAFjVxLEhv70YJnb4V84hfDPlaZo0f5nrFsdLHlU9IE02U
	 Ol0AkzIFRss0mLXGIe5H/OWysDrdO0Wt6qFNns/hQhC6/k9ckuwmnS7lN/QqxyZ3187ZA
	 ztVn4ZPZpp2wTMFHVc5NF/NhXto2mUG1D6IGePJczP7JR2BQxu924j9ChItdYCKaYG/ZY
	 /eGJDhAg3AEOJZkBYa1gBQ44AAcafWE2kNgnqWfaqV6Tivpwtc9XHATz22qZx+5P7pvFJ
	 K/QUDqaNY9/F9TXl06ZFJiNFo5vM5BFdcTbJ+T4NDMS+8PBPgtpW4lGwO0vvCJm6sKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493337;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=q5ycgM6KpIgl8GosUfIZQ6wJ8AxoFNABYsI2jhCC9jo=;
	b=vsOHGgIaydLk41PDrQFWgcJXxLLnGsSdMsXlOQnObyEwjle4Uu7FHtvZbupmyhs8vmeH
	 IIgyCLT8V3owbYeoGWtr8/0oQCeiaw4CI48Ud+S1+ZAxKxzBOTeHiwz2FNp0yLrBFdl/v
	 JKZiVR+V0uSSC7txYQqi9xyytgsGpaGwPqXbkAm8+q16FyeHABs549yjL7Yynx2pT0yE/
	 jceIgJ+B6F8quc26iyl9iQkkRbwit3I4ZNiJeLHVsTnie/IYc65U+O8PRE7jPcLL8tq4l
	 8ey4+ZB3WtSREVxzq4sxEqPQ6NiN8GXfEAdt4F5Rj1Pllb4hHTlr2PgAUZkSCLZjg2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cKOSqlB7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E510C606D561
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 14:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E510C606D561
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cKOSqlB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794493336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q5ycgM6KpIgl8GosUfIZQ6wJ8AxoFNABYsI2jhCC9jo=;
	b=cKOSqlB7r6419D3IqpSwULSv58sZTBwaBy8uhfqb5oVH8Acy5LKVouyAdgzOiJVGhayEi6
	fC7TOpYzTi0bmAWMu0WvlZzW7KR2e6u4xX0l0LwIdwnK+Jy4KZZGQgjMPWhAKehZA+192J
	P51UgTTjbEwXunCsGzrwSO44KFgXXv0=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-BaISpkriPVC-lDTxUy2ZXg-1; Thu, 12 Nov 2026 09:22:12 -0500
X-MC-Unique: BaISpkriPVC-lDTxUy2ZXg-1
X-Mimecast-MFC-AGG-ID: BaISpkriPVC-lDTxUy2ZXg_1794493331
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-8210034ccc0so5544108a34.1
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:22:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493331; x=1795098131;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5ycgM6KpIgl8GosUfIZQ6wJ8AxoFNABYsI2jhCC9jo=;
        b=zqGpLDZCjdDhxb2RlOLk2Hh0xQceUpvTliuu4e2b8kbBZnN+EFBKiXK+1CLBwwjQlL
         VW253Uwu1QYObIDBMXSIZrCxsF/ZraKhherj0VYnBjdC7/qXVU5CN9hfD+XitPmb2SwL
         Ks7zCkOedcFw817uP3CdZslzgN6N7sSzsfJU4dbVneqOnSsKVZQr2iiECFXOvggjIfpc
         nLBAcdXveIdf6HR2ZBnLVCdxr9oWfT4XkaJlbRI5GZjeo33WozOKvdaYF5PiFAnz0nRM
         5x6Q8h9gdzJrMVnZIlVjPk1Q39THrwkJNFLL/ZsI6y5EfYBM2KQaB6tMVvHIzSuEdVNn
         wxSA==
X-Forwarded-Encrypted: i=1; AL+hErHAXy/XBKudSwvMwDkTNSzP5bVvLM6pFY8S+EiN7fugJWsnJdinpmP3YDIbPuIGeAd/IKmdcLyd0e0CeJ5UJw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9ECu6v8eptTspiNgBNbx3xb7m6t+08Cro5UB0pB+1jKGB/+LMt
	yCVsGuGCsnYiZSh7vqjBIdKyQZ5uCB4rn2AL7omdEb5DQDsUBoh1ly7LlUAGs8Q24QQSG3pb/iR
	80Oe1QAr89GKMNG4tJI7AeILiE2jM6z7vYQEHW5drkuEuJR2XSF/LdKpeKiX1ujTaxlDx
X-Gm-Gg: AYBFou1WFOrXVWDPB5RruVSDux0E8q5STEL+uRttaL/oiAmdirXsAcGkecFe4EcrjJM
	0ZApnjyMGlEdwq1qn2xdLJ+ed2xb+UpseSKWQA8HAaIub7EHEYghE0WWLmCD8DKbtVthk1GAQpd
	IU/E4j/TCFIv8EdnCiVTtlwicxAInAscBPH1UHOD77yDmZ8iUCEGkxUsA2YxRc4gFcU8voQR8aK
	b4HE+TKb6X8j3iKCfjOdGWdILDOa2zk7rsFUmr3VTV9zo0ZbK9AVGYNgdj8iJVkj/tm/6/337rw
	akd0CuONxQ27lU8wLmT/bg0/fyFKr6Yn2o5yt/m4Gv73PSl7Sy4fzpFvfHDRcWlGBM9Co6q6j+N
	p11hZBip/lc8BsBIIv/uZ9VIWJSqoAKyeD4Wl2N0ryib1OySCU9Ms
X-Received: by 2002:a05:6808:5198:b0:4f4:9314:af39 with SMTP id 5614622812f47-56b96bd3b81mr4468309b6e.28.1794493331002;
        Thu, 12 Nov 2026 06:22:11 -0800 (PST)
X-Received: by 2002:a05:6808:5198:b0:4f4:9314:af39 with SMTP id 5614622812f47-56b96bd3b81mr4468260b6e.28.1794493329942;
        Thu, 12 Nov 2026 06:22:09 -0800 (PST)
Received: from sgarzare-redhat ([209.52.143.85])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22fbc9c5sm5819481fac.9.2026.11.12.06.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:22:09 -0800 (PST)
Date: Thu, 12 Nov 2026 15:21:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, bobbyeshleman@meta.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] vhost/vsock: release the accounting of
 packets dropped on rx errors
Message-ID: <avXG51ibBiap9tG9@sgarzare-redhat>
References: <20261106050244.602625-1-green@linuxhacker.ru>
 <20261106050244.602625-2-green@linuxhacker.ru>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261106050244.602625-2-green@linuxhacker.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UD5FONFDCwgXPnN1xTQ8Q0HIptK5A2u1FFczU4pDIQM_1794493331
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Nov 06, 2026 at 12:02:42AM -0500, Oleg Drokin wrote:
>When vhost_transport_do_send_pkt() fails to deliver a packet to the guest
>(unexpected output buffers, a buffer smaller than the header, a fault
>while copying the header or the payload) it frees the skb with
>kfree_skb() and gives up. The success path does more:
>virtio_transport_consume_skb_sent() subtracts the payload from the
>socket's bytes_unsent (SIOCOUTQ), and for a reply the queued_replies
>counter is decremented, restarting the guest's tx queue once it drops
>below the ring size.
>
>The error paths skip both. Every such drop leaves SIOCOUTQ too high for
>the life of the socket, and every dropped reply permanently takes one
>slot of the queued_replies budget, so that after a ring's worth of them
>vhost stops processing the guest's tx queue for good.
>
>Release both on the error paths, as the success path does.
>
>Found by an LLM-assisted security review of vhost-vsock, done while
>porting a project from Xen to KVM. These error paths were not
>reproduced: they need a guest that posts malformed rx buffers.
>
>Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
>Fixes: e6ab45005772 ("vsock/virtio: add SIOCOUTQ support for all virtio based transports")

Why this Fixes tag?

>Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
>---
> drivers/vhost/vsock.c | 23 +++++++++++++++++++----
> 1 file changed, 19 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 88a310390eb0..b0004cb48999 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -104,6 +104,21 @@ static bool vhost_transport_has_remote_cid(struct 
>vsock_sock *vsk, u32 cid)
> 	return found;
> }
>
>+/* Undo the send accounting of an undelivered skb; true if tx may restart. */
>+static bool vhost_vsock_drop_skb(struct vhost_vsock *vsock, struct sk_buff *skb)
>+{
>+	bool restart_tx = false;
>+
>+	if (virtio_vsock_skb_reply(skb)) {
>+		int val = atomic_dec_return(&vsock->queued_replies);
>+
>+		restart_tx = val + 1 == vsock->vqs[VSOCK_VQ_TX].num;

Can we add a comment to explain this check?

>+	}

nit: try to follow the style, e.g. leave a blank line here.

>+	virtio_transport_consume_skb_sent(skb, false);

mmm, this entire function is very similar to the code we have in 
vhost_transport_do_send_pkt() where we also call 
virtio_transport_consume_skb_sent() but with consume=true.

What about renaming this entire function to vhost_vsock_release_skb(), 
adding a new `delivered` parameter to be passed to 
virtio_transport_consume_skb_sent() (and to be used to call or not 
kfree_skb()) ?

Thanks,
Stefano

>+	kfree_skb(skb);
>+	return restart_tx;
>+}
>+
> static void
> vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			    struct vhost_virtqueue *vq)
>@@ -162,14 +177,14 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		}
>
> 		if (out) {
>-			kfree_skb(skb);
>+			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
> 			vq_err(vq, "Expected 0 output buffers, got %u\n", out);
> 			break;
> 		}
>
> 		iov_len = iov_length(&vq->iov[out], in);
> 		if (iov_len < sizeof(*hdr)) {
>-			kfree_skb(skb);
>+			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
> 			vq_err(vq, "Buffer len [%zu] too small\n", iov_len);
> 			break;
> 		}
>@@ -212,7 +227,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>
> 		nbytes = copy_to_iter(hdr, sizeof(*hdr), &iov_iter);
> 		if (nbytes != sizeof(*hdr)) {
>-			kfree_skb(skb);
>+			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
> 			vq_err(vq, "Faulted on copying pkt hdr\n");
> 			break;
> 		}
>@@ -221,7 +236,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 					   offset,
> 					   &iov_iter,
> 					   payload_len)) {
>-			kfree_skb(skb);
>+			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
> 			vq_err(vq, "Faulted on copying pkt buf\n");
> 			break;
> 		}
>-- 
>2.56.0
>

