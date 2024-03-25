Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CAD82D89
	for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391080; cv=none; b=hLk9eyLBaRQD/h3Saz8Lb27RFvR9lYuKyekwC9ijFL1gCHIK9FGnj1xo+PCNDv3ZNPK866Z2JmoXmEJnSkSpG394opHJ4euXuRzayEvJPS8ucpy+4d5vuvILemiMBI5afpfOwcRwFhYF4JKvviGuP0v2lJzS30bgSfeBLptPthQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391080; c=relaxed/simple;
	bh=1y7PY1oTFX7Axkh8dq81egggxtYVixKQqkHsEHIH+zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FRpO+FR6HU+kSXfrXaPeEpiEoPng9En07BdSh+i7VlyoFI0nMpvEuhskywPdnzmVWm8cJxfF+eElrMnl40U4OWjDjpUYMSUwXLImVThUsZZ5+vHpLSPvqsIdppHJ1lpwWXcTCecvqIwJsI7MfdCay+rDHGGPGK+2ltxsQU88b6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPq48287; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPq48287"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711391077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b8m7155r4ZtiZ6OJmssDUl1N2SECV45y4cCUPbb/2rA=;
	b=IPq482879s/e87DUaOmJy2IZg1VNwBbWCuzYF1pGxh0dAI/dChkZWXvdFq/YDoYzLbEM4m
	rQk8KOJS7gMbU5p1fmoesMatRMwt2g2Vn6nAbunJPQjTilNXyN1Fv08Gi2nk8KxVSO1r2B
	bEyi+toHGwWh9n19BTBDveoR6j7Kbdo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-WcpO5qTVN9S5Njmrf0r-rg-1; Mon, 25 Mar 2024 14:24:35 -0400
X-MC-Unique: WcpO5qTVN9S5Njmrf0r-rg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33ed26f20e4so2603271f8f.0
        for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 11:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391074; x=1711995874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8m7155r4ZtiZ6OJmssDUl1N2SECV45y4cCUPbb/2rA=;
        b=mBSB6AEoERhlvQH7DyV2uCM6niCQhM8aLmhd6UdcNmLajLbhAfOmQLoUVOoiUnWnV7
         0UXu1OE+odjR7bYfErr0TS+dMKcKEATpZiwkLN0Wc9a3LFZyXE0YCQlqYYodNg/RTYip
         2cQ8m3f4r36D7KX+5LF1xdcky2oqMPEBrmxt6N/UdQwy3+c1Yoj/uqp94/1ECzEUCMzU
         n30SXY5SUR1zhHE4B79bgVH6X79gKeIFis9YH4sd2t+CZv2LGDQbtUQAJov4yQqdsMeF
         99DZmVuo+v8Yrb5qGil42eMuYhWcf7DrjESVfigqIQrBmZ0ETOj4Q7uZjVLQ2jSn7Xek
         D1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3f8cpcFN7TRBO3VrDl1Si7IzYHyWsaN/rutKnEwL62DInuhOwhPIQfxGi5sHWAeIhwmIhZqod388Z0rdH9DrmAHrjoqhNtmqRu/LLmTQ=
X-Gm-Message-State: AOJu0Yz03CbEC/3op5Qnc2wOfkGykOZd9GgR4lcqx6cqwh/jQbcc8Kw0
	/AlmRf++0uaSnUW2jU34qPtJPp92y27ZoB8ZXc7f9S594xJPTfT5mebYS+L9tf0jZUPNBeC8jzX
	RrpyaMZvuZoGzG1ET1H+mkwPH0m7X8uvgtuzbQfAkhBPbt4U38Kr1tjqXZuV1AdTz
X-Received: by 2002:adf:c04b:0:b0:33e:bed4:c418 with SMTP id c11-20020adfc04b000000b0033ebed4c418mr5929005wrf.3.1711391074134;
        Mon, 25 Mar 2024 11:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5r/lLnQrrP+FsfZkx/tzC+B0pi96TLNpWuweDBMHLcZfzhANDx6D6CScWAtrWW3d5fWN17Q==
X-Received: by 2002:adf:c04b:0:b0:33e:bed4:c418 with SMTP id c11-20020adfc04b000000b0033ebed4c418mr5928981wrf.3.1711391073750;
        Mon, 25 Mar 2024 11:24:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id z17-20020a056000111100b0033ecbfc6941sm10112932wrw.110.2024.03.25.11.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 11:24:33 -0700 (PDT)
Date: Mon, 25 Mar 2024 19:24:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Marco Pinna <marco.pinn95@gmail.com>
Cc: stefanha@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ggarcia@deic.uab.cat, jhansen@vmware.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: fix packet delivery to tap device
Message-ID: <6vlaxnqqyhppbajmmwyco62b7gzasflgrxpgl4h3ippuk4jwme@qfne3i72eej4>
References: <20240325171238.82511-1-marco.pinn95@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240325171238.82511-1-marco.pinn95@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Mar 25, 2024 at 06:12:38PM +0100, Marco Pinna wrote:
>Commit 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks") added
>virtio_transport_deliver_tap_pkt() for handing packets to the
>vsockmon device. However, in virtio_transport_send_pkt_work(),
>the function is called before actually sending the packet (i.e.
>before placing it in the virtqueue with virtqueue_add_sgs() and checking
>whether it returned successfully).

 From here..

> This may cause timing issues since
>the sending of the packet may fail, causing it to be re-queued
>(possibly multiple times), while the tap device would show the
>packet being sent correctly.

to here...

This a bit unclear, I would rephrase with something like this:

Queuing the packet in the virtqueue can fail even multiple times.
However, in virtio_transport_deliver_tap_pkt() we deliver the packet
to the monitoring tap interface only the first time we call it.
This certainly avoids seeing the same packet replicated multiple
times in the monitoring interface, but it can show the packet
sent with the wrong timestamp or even before we succeed to queue
it in the virtqueue.

>
>Move virtio_transport_deliver_tap_pkt() after calling virtqueue_add_sgs()
>and making sure it returned successfully.
>
>Fixes: 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks")
>Signed-off-by: Marco Pinna <marco.pinn95@gmail.com>
>---
> net/vmw_vsock/virtio_transport.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 1748268e0694..ee5d306a96d0 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -120,7 +120,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 		if (!skb)
> 			break;
>
>-		virtio_transport_deliver_tap_pkt(skb);
> 		reply = virtio_vsock_skb_reply(skb);
> 		sgs = vsock->out_sgs;
> 		sg_init_one(sgs[out_sg], virtio_vsock_hdr(skb),
>@@ -170,6 +169,8 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 			break;
> 		}
>
>+		virtio_transport_deliver_tap_pkt(skb);
>+

I was just worried that consume_skb(), called in
virtio_transport_tx_work() when the host sends an interrupt to the guest
after it has consumed the packet, might be called before this point,
but both run with `vsock->tx_lock` held, so we are protected from
this case.

So, the patch LGTM, I would just clarify the commit message.

Thanks,
Stefano

> 		if (reply) {
> 			struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
> 			int val;
>-- 
>2.44.0
>

