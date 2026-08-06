Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1BF3C73C9
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786057223; cv=none; b=tIaF7+jvq79omJ+gWDo1BwPYYyU5WAPqdAAGDocbHMudkl8SNOiGKln8ko/AOSsKkk0WK2zl23OEeRnnEGbYoue4136fa5S4jmfIpnfWi5rb9DLcmLsu/df/lFIv6hhcgG0Y34wIxoOoTz4z9O52jkCGYF4RZ+cDhxlZSMbe2A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786057223; c=relaxed/simple;
	bh=I0wqDwZyoQSIsMb6537lKMySu1ARTn+0eN39hDtnsKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ot2r2D63RNJL9Ppi9X/qluarzAXEWgywD03TsrtT6dDrJUWuI8M7zarSTz1qPRnQYPHk0zKHtweFYb0IgvrlDXGHM/pTVGsXqxLVtXXNTSdM+cGmcvCie40MuEPRWJYNCGnQ8pSITQcJ/XZffySsDRvW09DQU74PfdvX6YMlptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByvyTw1N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByvyTw1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786057220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/XyIJ0P1Ncw2ZC5RUbuOjY9InJ1Bze3sfj+kDZLJRI=;
	b=ByvyTw1N4MfMpMUK+t96yxbBqXKWefbzfGijHjLv7YxQQlixgy4L2VUEwNABGI9agKSNBa
	tZB2+7gw2o4wQG+/KMNWs7XSCSsGTxDkm8C/S6PbMTCbpqFLJm149P03wKNWRQFSFF4S5V
	2raOUtMTC1cmmaMv3URHB1naKWV/HO0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-m_g47vQzNfyATyHyFfa1GQ-1; Thu, 06 Aug 2026 19:00:09 -0400
X-MC-Unique: m_g47vQzNfyATyHyFfa1GQ-1
X-Mimecast-MFC-AGG-ID: m_g47vQzNfyATyHyFfa1GQ_1786057208
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49953abe51fso9937505e9.1
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786057208; x=1786662008;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/XyIJ0P1Ncw2ZC5RUbuOjY9InJ1Bze3sfj+kDZLJRI=;
        b=JftQOmTPwEzJmfEdxIPIxJWF1vDAkjF26dEbevRV0x7SnhiEyC3mhXASD+fKxCpHdp
         3fR37E47k83Msm14ZP7gJV+LXsKM8lPGLd0XW1331xuh9SCHBLNVfJ7kNMd2WujvKmqM
         UMUvwcIemMvSwjGodAp+zjvSVAOR99bII7Z0ECm994sMIdY7Ru7QwEE3RM+tTSfWY175
         JAT2Y86kYZCKxj8kkWTbVbCAcZvETYYYSPCONQuxIB7DbHwgCyQ682EMtFMi3lqHhFOv
         y1BEtQk4q1inAH+H+zYE0F7Z31CdaFITfno9vw7jpKraA/9TN8cTaT1SNAAhCqvcUR+m
         reLg==
X-Forwarded-Encrypted: i=1; AHgh+Ro1sHVFF1dJev9Kd/JnIy7xxIANlCcqboz90ii+V9pAA7m6b8sFy2r+/MaxhvgO6oBY3m8NvzPx74LAJ8Dpng==@lists.linux.dev
X-Gm-Message-State: AOJu0YyudCgoDAoZ9Z7y1NQUYP0zCi3EDnGfyVpcBNpnYTX/v8wUdGkD
	h8VDE+RIjTs1DGl73u2ZYZ4ETyWafDv+7Ih+CML10JPun669Tk08zgTwSsDQRcpna4mAesAkIVQ
	WdTk1qAex96LZguEEq+dlk0bwqu6FJQL1ugLBvSQVCdsNZuQozqh5PFP8GMz3q3i1Fxhv
X-Gm-Gg: AR+sD11/ac7sD5C9ssQyxtnN4dUdobN1GUpL3CJt/vnRucrowAEoyu+PO+vMUoNSpBo
	dUQfedtCHkcjmPlAw5f0b2+YVGGagX3v8prAv5JQUGcISaCG2VqNLPAZyONPZ/CZTRBs12o92tr
	VAfMSPuLLoxFKoO7Y799Y01jS3ZPBpNXzh9iK7OUfCBryp+U00228NxapQke1jm1B3Qc1Tg2uHW
	gkROUcA5Mb8AJuwV1oX+TxondV0ArP/t362thdGIIrBjjMri9H8rZg9JSuOiqly+/qkrfb5DGL0
	RpV9OBiv3+DWNAXFnWkPZ6mxSYOVJMJwm88GOSGylO6JW73HgunTmadZBh6TmiM0Gmg5iS55Dsh
	JrUtQgndzAJaucjCh1HttaA==
X-Received: by 2002:a05:600c:3b04:b0:495:5e86:4e11 with SMTP id 5b1f17b1804b1-4994e7baa85mr237163595e9.12.1786057207652;
        Thu, 06 Aug 2026 16:00:07 -0700 (PDT)
X-Received: by 2002:a05:600c:3b04:b0:495:5e86:4e11 with SMTP id 5b1f17b1804b1-4994e7baa85mr237162725e9.12.1786057207114;
        Thu, 06 Aug 2026 16:00:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995d85254asm1707125e9.1.2026.08.06.16.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 16:00:06 -0700 (PDT)
Date: Thu, 6 Aug 2026 19:00:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Link Lin <linkl@google.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, prasin@google.com,
	rientjes@google.com, duenwen@google.com, jiaqiyan@google.com,
	ahwilkins@google.com, Greg Thelen <gthelen@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com,
	stable@vger.kernel.org, Cory Maccarrone <maccarro@google.com>,
	Taylor Scanlon <tayy@google.com>
Subject: Re: [RFC PATCH] virtio_balloon: add
 VIRTIO_BALLOON_F_REPORTING_PM_SAFE feature bit
Message-ID: <20260806185414-mutt-send-email-mst@kernel.org>
References: <20260724014605.3377283-1-linkl@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260724014605.3377283-1-linkl@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vbj_6U57atWBUyWn05OnNes26Wu0wU7RFaHUAdRPdZo_1786057208
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 24, 2026 at 01:46:05AM +0000, Link Lin wrote:
> Following up on the fix for the PM suspend Use-After-Free race condition in
> mm/page_reporting (merged in mm-hotfixes-unstable: 
> https://lore.kernel.org/all/20260723003650.CAAF01F000E9@smtp.kernel.org/), 
> we face a hypervisor-side deployment dilemma.
> 
> Cloud hypervisors want to safely enable the Free Page Reporting (FPR) 
> virtqueue across their fleets, but enabling it indiscriminately on guests 
> without the recent suspend fix exposes them to UAF crashes. Relying on 
> out-of-band metadata (e.g., OS image tags) to selectively enable the 
> feature is fragile for custom user images or live-patched kernels.
> 
> To address this at the protocol level, we propose adding a new feature bit 
> to the Virtio Specification: 
> VIRTIO_BALLOON_F_REPORTING_PM_SAFE (Bit 6)
> 
> This establishes a formal device lifecycle contract for power management:
> If negotiated, the driver MUST guarantee that all page reporting operations
> are halted and pending requests are flushed before the device/system
> transitions into a suspended state (e.g., ACPI S3/S4).


> Deployment semantics:
> - Hypervisors operating in a strict "safe mode" can offer Bit 6 exclusively 
>   (suppressing Bit 5 / VIRTIO_BALLOON_F_REPORTING).
> - Older, unpatched Linux guests will see Bit 5 is absent, ignore Bit 6, and 
>   safely skip FPR initialization, preventing the suspend crash. Standard
>   ballooning remains 100% functional.
> - Patched Linux guests will recognize Bit 6 and safely initialize FPR.
> - Note for fleet deployments: Non-Linux guests (e.g., Windows, FreeBSD) 
>   that rely on Bit 5 will temporarily lose FPR if the hypervisor exclusively 
>   offers Bit 6. This is considered an acceptable trade-off to globally 
>   protect unpatched guests without relying on OS image tags, until those 
>   respective virtio drivers adopt Bit 6.

This makes no sense to me. So there's a bug in the guest and it crashes.
Patch the guest.

There's just no chance we'll add flags every time some guest drivers
on some OSes have a UAF.

What makes this specific bug special?

Trust me when I say UAF issues e.g. around hotplug are a dime a dozen.
Now what, let's add another one around hotplug? And so on.

> 
> Implementation Note on Upstream/Downstream Dependencies:
> --------------------------------------------------------
> Because it is critical that downstream Linux distros do not accidentally 
> backport Bit 6 without the core MM UAF fix, the final upstream 
> implementation of this patch will enforce a strict compile-time dependency. 
> We plan to export a macro (e.g., PAGE_REPORTING_HAS_FREEZABLE_WQ) from the 
> core MM fix, and wrap Bit 6 behind an #ifdef of that macro in 
> virtio_balloon.c. This guarantees that compiler backports must consume the 
> entire dependency chain to advertise the feature.
> 
> Below is the proposed Linux proof-of-concept based on upstream master. We 
> introduce a helper virtio_balloon_has_reporting() to ensure virtqueues are 
> properly allocated, torn down, and validated if either bit is negotiated.
> 
> If this architectural approach is acceptable for cloud deployments, we will 
> formally submit this patch and open a corresponding issue for the OASIS 
> Virtio specification.
> 
> Depends-on: <Message-ID: 20260723003650.CAAF01F000E9@smtp.kernel.org>
> Signed-off-by: Link Lin <linkl@google.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 15 +++++++++++----
>  include/uapi/linux/virtio_balloon.h |  1 +
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 581ac799d9..00e8273dc3 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -39,6 +39,12 @@
>  	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
>  #define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER)
>  
> +static inline bool virtio_balloon_has_reporting(struct virtio_device *vdev)
> +{
> +	return virtio_has_feature(vdev, VIRTIO_BALLOON_F_REPORTING) ||
> +	       virtio_has_feature(vdev, VIRTIO_BALLOON_F_REPORTING_PM_SAFE);
> +}
> +
>  enum virtio_balloon_vq {
>  	VIRTIO_BALLOON_VQ_INFLATE,
>  	VIRTIO_BALLOON_VQ_DEFLATE,
> @@ -598,7 +604,7 @@ static int init_vqs(struct virtio_balloon *vb)
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>  		vqs_info[VIRTIO_BALLOON_VQ_FREE_PAGE].name = "free_page_vq";
>  
> -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> +	if (virtio_balloon_has_reporting(vb->vdev)) {
>  		vqs_info[VIRTIO_BALLOON_VQ_REPORTING].name = "reporting_vq";
>  		vqs_info[VIRTIO_BALLOON_VQ_REPORTING].callback = balloon_ack;
>  	}
> @@ -635,7 +641,7 @@ static int init_vqs(struct virtio_balloon *vb)
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>  		vb->free_page_vq = vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
>  
> -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> +	if (virtio_balloon_has_reporting(vb->vdev))
>  		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
>  
>  	return 0;
> @@ -1013,7 +1019,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  	}
>  
>  	vb->pr_dev_info.report = virtballoon_free_page_report;
> -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> +	if (virtio_balloon_has_reporting(vb->vdev)) {
>  		unsigned int capacity;
>  
>  		capacity = virtqueue_get_vring_size(vb->reporting_vq);
> @@ -1099,7 +1105,7 @@ static void virtballoon_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb = vdev->priv;
>  
> -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> +	if (virtio_balloon_has_reporting(vb->vdev))
>  		page_reporting_unregister(&vb->pr_dev_info);
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>  		unregister_oom_notifier(&vb->oom_nb);
> @@ -1162,8 +1168,10 @@ static int virtballoon_validate(struct virtio_device *vdev)
>  	 */
>  	if (!want_init_on_free() && !page_poisoning_enabled_static())
>  		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
> -	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
> +	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
>  		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
> +		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING_PM_SAFE);
> +	}
>  
>  	__virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
>  	return 0;
> @@ -1176,6 +1184,7 @@ static unsigned int features[] = {
>  	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>  	VIRTIO_BALLOON_F_PAGE_POISON,
>  	VIRTIO_BALLOON_F_REPORTING,
> +	VIRTIO_BALLOON_F_REPORTING_PM_SAFE,
>  };
>  
>  static struct virtio_driver virtio_balloon_driver = {
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index ee35a37280..d206f156d6 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -37,6 +37,7 @@
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
>  #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
> +#define VIRTIO_BALLOON_F_REPORTING_PM_SAFE	6 /* PM-safe page reporting */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> --

