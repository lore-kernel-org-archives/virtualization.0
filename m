Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307DC2D5925
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817546; cv=none; b=XTRagEId3VR/y8gmHywTq9hNsjM8vaDGm2idJZ/XnL3HfnvPp5xIjSu1IQRux2Pr9z8jN2J0kjn35JX9sQX0x/sME90SSlBBiJdl4cd9q1CwWBUza3iR+KIJYZRpxHG6g73z23CQleDxU6Vjo2TlWAmYh20aTlptChKk8IC1t2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817546; c=relaxed/simple;
	bh=2z+7OZ/8s1izu6DqIUIRPHmKWhBimeDK/7uC8qr1E7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qS7QMc56bMOO82Fwc4jjlflDYtmfsXpQTi41F3UDjBHgQoeVs/Z/l3Nhh4iNEidSm+uni9uLd/AN9/I98lTfPCQ2w88wty+ktaOyQllzumQTlQJom1f58rawVzT481LpGGqWaC/2YjM6rhGQIzDbIbfeBbc/JLoQHMu8KhMkkXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpwmahTA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpwmahTA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788817544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zgpCJtcUJEpX0DtKX/LyNeVmPwd5hRkpw0WrWcgdUoE=;
	b=MpwmahTAYyQ89vHVma42WXiGuRo1BE2OnexMfVTykeGZ0kMBQr0SJ6UtaJFGz0VJa4dx3w
	QSvNPGa87iNDlG+zPT8Zx6jm7YS0GbJMfc5FV8AgWM8qh7NoJRD9cqik+WyWU+4izPtJF4
	o1e73vYAJDvs2xrbA2URKMJzAwmfy5M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-rfg7JomNNVaMj3UhF1_mvg-1; Mon, 07 Sep 2026 17:45:42 -0400
X-MC-Unique: rfg7JomNNVaMj3UhF1_mvg-1
X-Mimecast-MFC-AGG-ID: rfg7JomNNVaMj3UhF1_mvg_1788817542
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cc954a3edso30769875e9.2
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 14:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817541; x=1789422341;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zgpCJtcUJEpX0DtKX/LyNeVmPwd5hRkpw0WrWcgdUoE=;
        b=orjd97yn/LbDI2e5A/0W3XlWyK/19mKclGk96tMDroO/W0a7XSkSelfNt1GenFcRUX
         mnYBO/dnEWChS994UJfqbtFYwwgxkxkisEJfISHdNv8e+0dqc6AVqPJVMSVei4re/YaG
         ZGPdNyIritI7b9zrVsOUT0i2QQo4o2QGt99foj4B861nuYW4cKMqOeJ2KIypmPHWAUiL
         ixJkxvppFeNKRkusqhb5LYmHomG/YquDpJBA8GnukDew2Z/1+HSBpptIhTgBmw8MS2Cu
         LNRjF7zQsKoPvaJoJ1zcdj9TFvtsteqQ9zmPmZW6F96BIU6bf4jLHqzyplJIdQS21+Bo
         ytsw==
X-Forwarded-Encrypted: i=1; AKwUvByTc/J9+G+cnXnuosOlG49ZLRDt7r4ZTYLjjgIx6o23cVUdsJiTazAmmN4YiMVt/mHo82uEt92aTuXVjhT2oQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kM/Cmi1B+Lvsp2CZ381aP9f8Lb5Zl0m4+QFLVWJNJxCsVx+189
	Zlg1zAuD1IuUjEkTS4d78mVE66OpNJfdEvWdVTj+GV+fXajSqnhilE8OkEVaajB5xLSXaedHesX
	RK/mglon/7/e6yQ0mjhlVI2l/JExtXI1QiCoRPf2dNjTuosLsoVg6hMFsPJFBZQxE+olV
X-Gm-Gg: AYBFou24zFtw453PbEkLI/VIy4mrr2DAwZfwwJuJIyT3H7JW0qQ6XebllNrW4U81/mB
	1pb0VoAL4JLOfw9EIIeBUMFSD3A1VYc4Wst9+U50CnhQkxfc2Xjj1Ns4kGEABgDt9UNUMLvPCep
	4HN4ZUaqRsbtaX7sPGWwnoL8FHtIzP/HXifUVrx6mbO0qgibZ5oixWc71Ig5l7OTJZoyj2Pdc4t
	3yDDBknJf7VHJmhoaQ2yDYs8ZzYn/3qWqLeZuGaiwpqM5K7tOy/es40M4uV5QVib6snVKGXT660
	bFb5Z4TU1qPPFFRJUjRkoVKEE708s3CsPhvSTcCJuINb2x5aArmkmvAbpU6GONqgW0WehavdJ6s
	GrmwYmvfk9UGrf6x3dM2PeKE=
X-Received: by 2002:a05:600c:524b:b0:49c:fa20:cc08 with SMTP id 5b1f17b1804b1-49cfa20cd2cmr231525225e9.31.1788817541428;
        Mon, 07 Sep 2026 14:45:41 -0700 (PDT)
X-Received: by 2002:a05:600c:524b:b0:49c:fa20:cc08 with SMTP id 5b1f17b1804b1-49cfa20cd2cmr231525025e9.31.1788817541017;
        Mon, 07 Sep 2026 14:45:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d07b371afsm242068095e9.9.2026.09.07.14.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:45:40 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:45:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio-pci: return IRQ_HANDLED after non-zero ISR
Message-ID: <20260907174523-mutt-send-email-mst@kernel.org>
References: <20260904141318.30278-1-astellman@stellman-greene.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260904141318.30278-1-astellman@stellman-greene.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: km7QK9uGJnUt0azUQVAJFUWM5SamqkfgRX7CaOVeYfA_1788817542
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2026 at 10:13:18AM -0400, Andrew Stellman wrote:
> vp_interrupt() reads the ISR before dispatching config-change and
> vring handling. Reading the ISR also clears it, so once the read
> returns non-zero the interrupt was from this device and has already
> been consumed.
> 
> Currently vp_interrupt() returns the result of vp_vring_interrupt().
> For a config-change interrupt with no vring work, that can return
> IRQ_NONE even though the ISR was non-zero and the interrupt was
> handled.
> 
> Call vp_vring_interrupt() for any queue work, but once the ISR is
> non-zero return IRQ_HANDLED.
> 
> Tested with QEMU virtio-blk-pci forced to INTx using vectors=0 and
> pci=nomsi. On an idle device, 200 config-change interrupts were
> generated using QMP block_resize.
> 
> Before this change, irq_handler_exit reported ret=unhandled and
> /proc/irq/11/spurious increased from 0 to 200 unhandled interrupts.
> After this change, irq_handler_exit reported ret=handled and the
> unhandled count remained at 0.
> 
> The issue was found during an LLM-assisted Quality Playbook review.
> 
> Fixes: 77cf524654a8 ("virtio_pci: split up vp_interrupt")
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: LLM

tell us which llm and which agent pls

> Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
> ---
> Changes from v2:
> - Repost as a standalone patch in a new thread, per maintainer request.
> - Add LLM-assistance disclosure.
> - No code changes.
> 
> Changes from v1:
> - Return IRQ_HANDLED for any non-zero ISR, as suggested by Michael.
> - Add Fixes and Suggested-by tags.
> - Test the change with virtio-blk forced to legacy INTx under QEMU.
> 
> Full red/green test logs and the tested v2 patch:
> https://github.com/andrewstellman/quality-playbook/tree/11ba61d/evidence/virtio-pci-intx
> 
>  drivers/virtio/virtio_pci_common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 10371ecbc054..b90c174450b2 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -120,7 +120,9 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
>  	if (isr & VIRTIO_PCI_ISR_CONFIG)
>  		vp_config_changed(irq, opaque);
>  
> -	return vp_vring_interrupt(irq, opaque);
> +	vp_vring_interrupt(irq, opaque);
> +
> +	return IRQ_HANDLED;
>  }
>  
>  static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
> 
> -- 
> 2.43.0

