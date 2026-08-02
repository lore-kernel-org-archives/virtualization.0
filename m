Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA43515F4
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785705041; cv=none; b=eXqIVFuDZcDV+0PjV2L+dlbZy6a+yRnDFy7AGR5FbAWwfrNUawdhlvtK2bMxieyFsvinIbpPj1Na/W37tSY0RSBpTr7h59MjKgZcOqDJ2ZtCl9wgnBY/xHoNZadYjs6H/JdBfU8702OqSi5VwxOZTUBZFojl2oL8MEpdN82+kPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785705041; c=relaxed/simple;
	bh=8XHhBJSaOao1ra7Th8dCO+IUDowG1Hd6FxTnD1DgZPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cVvtezJj9aoALJ5C2I9O2tpN2q+XkMNAg1114FiUlb4j/yiABlheyBpdjzvk42kC8uS/w09cHA2tnQFi2UjQhnXRuIBOSNjBiak+AQUGG8Racl1dAbgRkAdh4q95+gHRy84Zm2+NYo+ZMgsxspqp5YHKtLaUFC//WqT6RgFEZP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbXWNCc9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbXWNCc9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785705028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Xqxsjy354sVq1muPTWLc7ZtrNPulk9p/RuRel+d6OA=;
	b=UbXWNCc9E4KW3VQHQg/F3IIkI0wFP1S/so7+4vyNyhyors7kV9YrSksH1wa7uwzReCUI0L
	9vbv8qEJzChcRpLVtmnl5umUZ043hB05M621gYUNBFIprlWM5U5tPopc2fvsnCTW5YSAtO
	2o/9t1JJMIiTybn6P9R0aKlCVNoZtnQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-o3TtzdwOMDm0FmkBz5WDpw-1; Sun, 02 Aug 2026 17:10:27 -0400
X-MC-Unique: o3TtzdwOMDm0FmkBz5WDpw-1
X-Mimecast-MFC-AGG-ID: o3TtzdwOMDm0FmkBz5WDpw_1785705026
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so16083345e9.3
        for <virtualization@lists.linux.dev>; Sun, 02 Aug 2026 14:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785705026; x=1786309826;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Xqxsjy354sVq1muPTWLc7ZtrNPulk9p/RuRel+d6OA=;
        b=NWTl09AwWDzqPB8go5yFX9m2SSOUl4Eaotwl5jS6GpPLixrZ28A9UgpRa2Cy4289WU
         rZOMC7rgvp4mcxMwyqJn5cA5zsOY0CkLO5ucdAlNldxbp8fJLtNNjLLhe0cncCtXg7wT
         DSmufvzqgr0FSHwWmmU38nThU52sR3kR/pEYetDXBDpFlVkVBbGTKCKPRGvlpETptAPa
         Q6ssP0D9EdSaLG/rVnwwvd72Fg7iP5Od/XOUXdr9rpOA1vk8xEGMauoW4PULD+q59HTu
         IZAx//BLzTNGmL878wvmrIDMkS5c3strKZa7tqWoxhJR+kmJuXvJ6tQ9vPN0F5nZJMw9
         Bn7A==
X-Forwarded-Encrypted: i=1; AHgh+Rro3Zhx1vakWKCF1+ynJLu8tYXmjSd0t/gQ1GdS5xadrmofFjtrxlhHqJOhiRfx8aRe+Lh767GNmxDbdiHPEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDtNbfWsVKMOJTIe4yWNcS8rR7Cc1thXjQk//TV0IPnnF1ZN41
	kUFVf4BGi8EdhVRY5EKGNrZ6pTteuw1wkczm0Argg4jyyTBOfaelgCJJgqK26+Xoeq30V6wX74T
	+sCeU6KW6puzxBza1879wJdMKJLgZVMvEmBQaydkGJPokfnddzSHQYPY9lYjndSCdMSJD
X-Gm-Gg: AR+sD10YzSzAfCXLnevkIk83049WVtVjuBUbDHmUwErk9aKYMpy4HAzR0nZ5xTUU+dZ
	aO1B+a8RePOqGStKGpL1reoeidpYLPZIeIq9Cw+EGp3jz4XNTupfGJvtEAKLTLGr9KHmCkHpU9s
	ilha2LU6iIzX7NI9S+TqX6aeKqY99VijDnasmud7kkGKEn86/Bsw7v1529/qZr2QlIjsT1DUnSQ
	mib9S4GGp/w1ctpIyuL5bgig2pt8wi+5ucAZMG1sHm5JOhAz+p2wTbjzshjeFBMfxzB0DBQ9ayL
	QpseTmMzaSeoh3uJWrCo9M4W0dXAmayzOqRNakvTTy+Uxm55dEjTskYclH5odGYpjVge9xa5T3l
	zfNUu8cA0m4ZGIXNsax1XUA==
X-Received: by 2002:a05:600c:19cf:b0:495:7a04:b006 with SMTP id 5b1f17b1804b1-4980c66b572mr144625975e9.8.1785705026061;
        Sun, 02 Aug 2026 14:10:26 -0700 (PDT)
X-Received: by 2002:a05:600c:19cf:b0:495:7a04:b006 with SMTP id 5b1f17b1804b1-4980c66b572mr144625545e9.8.1785705025517;
        Sun, 02 Aug 2026 14:10:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980878dbaesm284117615e9.12.2026.08.02.14.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 14:10:24 -0700 (PDT)
Date: Sun, 2 Aug 2026 17:10:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
	axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] virtio-pci: add error_detected for PCI AER
 recovery
Message-ID: <20260802165915-mutt-send-email-mst@kernel.org>
References: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn>
 <cover.virtio-blk-ers-v2.1785468000.git.liuxixin@kylinos.cn>
 <e2dda946e70e.v2.1785468000.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e2dda946e70e.v2.1785468000.git.liuxixin@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -kaOCeSzcu5s8kjfDZ6Jrl2nCU1nfRrZOs0n3kmPTYg_1785705026
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2026 at 11:17:00AM +0800, Xixin Liu wrote:
> virtio-pci only registered reset_prepare/reset_done.  The PCI error
> recovery core treats devices without error_detected as NO_AER_DRIVER and
> does not deliver pci_channel_io_perm_failure to the driver after a failed
> recovery.

Maybe it should?

> Virtio devices therefore miss the normal ERS quiesce/teardown
> sequence.
> 
> Register error_detected: quiesce on frozen (reset_prepare) before bus
> reset; on perm_failure break virtqueues and return DISCONNECT.  Block-layer
> cleanup for virtio-blk is handled in the follow-up patch.
> 
> Assisted-by: DeepSeek:deepseek-v3
> Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
> ---
>  drivers/virtio/virtio_pci_common.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 164f480b18a6..fff6b6e2d0c5 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -828,7 +828,37 @@ static void virtio_pci_reset_done(struct pci_dev *pci_dev)
>  		dev_warn(&pci_dev->dev, "Reset done failure: %d", ret);
>  }
>  
> +static pci_ers_result_t virtio_pci_error_detected(struct pci_dev *pci_dev,
> +						  pci_channel_state_t state)
> +{
> +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> +
> +	/*
> +	 * PCI ERS error_detected: quiesce on frozen before bus reset; on
> +	 * permanent failure break virtqueues (follow-up may call driver
> +	 * .shutdown for block teardown).

block specifically? this is common code.

> +	 */
> +	switch (state) {
> +	case pci_channel_io_normal:
> +		return PCI_ERS_RESULT_CAN_RECOVER;
> +	case pci_channel_io_frozen:
> +		pci_info(pci_dev, "frozen error detected, quiesce device\n");
> +		if (virtio_device_reset_prepare(&vp_dev->vdev))
> +			dev_warn(&pci_dev->dev, "frozen: reset prepare failed\n");
> +		return PCI_ERS_RESULT_NEED_RESET;

so I guess pci will do slot reset? but what will call driver reset later? confused.


> +	case pci_channel_io_perm_failure:
> +		dev_warn(&pci_dev->dev,
> +			 "permanent failure, disconnecting device\n");
> +		virtio_break_device(&vp_dev->vdev);
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	default:
> +		break;
> +	}
> +	return PCI_ERS_RESULT_NEED_RESET;

here, too, and we didn't virtio_device_reset_prepare either.

> +}
> +
>  static const struct pci_error_handlers virtio_pci_err_handler = {
> +	.error_detected = virtio_pci_error_detected,
>  	.reset_prepare  = virtio_pci_reset_prepare,
>  	.reset_done     = virtio_pci_reset_done,
>  };
> -- 
> 2.43.0

