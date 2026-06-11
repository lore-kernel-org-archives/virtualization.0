Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936EB2F1FE3
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189373; cv=none; b=TICRYqgJuGGTMQTCamS28o6X1SiGbYPcHg/C4/ch3AiYT1aVvtbgGAUFZeHkS80GOXbax7v5RAYIU4ICDG5p7RZ98ip/2oiqU30ru0Lpi/ye5uP4gw8+m19C0U9PQh1tAkHvqBbfWkqdcjK3TbAEboVQ5Ytf4HuNbUnaCtzjb4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189373; c=relaxed/simple;
	bh=GVR3IzepjIau27q934U4LHfHOmq90DeMvAfprRoWz1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hobN8F34+sfkO3kHmcjcTk0H9M+emKbbyxKS2THgQRuC1Xxs56a5vorjdfep320gobP2pthygllycirb+QVq6TqM75emLuttY/zPEzhsYczN7aRgZUMDV2ZckiQQ9D8txAIwQNRWmvczZhpdHB1Igdjg3JUh27aTf+pWPIvAHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=id9/zCib; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="id9/zCib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781189371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N72ufb7CXlxMySq23Pr+DrLKTSb8AC1L0hhig87DTpI=;
	b=id9/zCibheIn7efm11Rsx18IeNBodcEm1I+8s7IBTC4ZB0iCn4pWGjGhkXTpPCoqqiPZrE
	32OSbShBpgmI5ohE3cPbzWSOyyzFj2nFuYD0iGXfQQGL4ZbzPzPPava6JIaIKrETZULgXg
	Jhtrs4C1NgPWObJcWRQxm5azi2+xpv0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-zHjM0QIvM7yntp1NEW0dOA-1; Thu, 11 Jun 2026 10:49:29 -0400
X-MC-Unique: zHjM0QIvM7yntp1NEW0dOA-1
X-Mimecast-MFC-AGG-ID: zHjM0QIvM7yntp1NEW0dOA_1781189368
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490ae016853so16510115e9.2
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 07:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781189368; x=1781794168;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N72ufb7CXlxMySq23Pr+DrLKTSb8AC1L0hhig87DTpI=;
        b=mu0cS23fdT/jT8Lb02yTk1aV/SfyQIflPMpjS03NwU8F4o5C4IrLuW1XTKyrgHHX4+
         kbuRXawZ0cO9R4t4cksNymAYM1hipwuufEx/1Bm1g5pz9E6ir3nAgtWsPl/MwvHyZmSX
         homQuur4ZjicbxFtPLmSeSjH26hbYsj6PnReKwyK/tq9+t450hivNh49aiN1HW3JXsPU
         zfjOJRcoukRUgwJS2lT5hqG+YmdStuBn03+ALW1qIfZNfbt2hdi4xO0Z0UC/sIbDx7gR
         GLOqPkhL9hNVy4XzrfoiPdILHbMi3U07CFFI0LTSyyOK5Hwwe4rzrMMg9bYCMfLpqO9s
         ca9g==
X-Forwarded-Encrypted: i=1; AFNElJ/jSUjgu9KQdxVYM9wBlxsPLc+Re9qe5V8q9XL58Bx5XK0koJWBf23WElaFiEGziFKRI3idzfw3zbbhB96y7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/JzO9jSXz/mW9NaFRD0+3qDV51MHvCfNF4XzRA985FDGCA+PJ
	OUs7x93qo/Fn2w5QOPDAYDy5zQWfCnQi+9TP2j4PK2pFDs26rizVQ/vwOF7C34fQ4JD5fn+mdZQ
	di9E5+x8A6LwFjvNdbgpJJVf9UjR3QfyIfxIjeodAg+ri8xaXkCG1QkTITNnzPvfAswvZ
X-Gm-Gg: Acq92OH7NfCTikWoZOwyS9nwG8PnIKsSVKZu1goU+5rKVztupAwAyNOR9KCbxv4ZnRz
	TkwN7LLf7cxBWX7n+J6d5vHlMZxN4i1N/AxfHW9uf+OCP9FT/IhcoSgKEUi2eVIwirA8uNOtFHb
	Ji6sxzlJUjn7w5lQSB0x3/7knZlvuHuxxsW4owFexf7CZmmHtbQIus62AjHTraGp8a8ebqnaU1R
	Q/PXBzy+k0O8FXE3fpQ71hOQBw29eVx2r90FdbiUsA2VJ4dq7M+xHa25cXRXGnalld/sHI8p2kE
	uqg9r5D6Y805S5X+/0H59Q8K1vmxCROqZS8D/aGDCfpKyUBBQSvrUZRQOcizNdmOAb5sZUAzUw9
	m4m1SPS8iZsC1l6QPkXq0Y1ICoUCD9/Eb/wNLnTDUOa+RRvN/F+djFA==
X-Received: by 2002:a05:600c:c493:b0:490:b780:13f7 with SMTP id 5b1f17b1804b1-490e5639b1bmr42945805e9.23.1781189367661;
        Thu, 11 Jun 2026 07:49:27 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:490:b780:13f7 with SMTP id 5b1f17b1804b1-490e5639b1bmr42945295e9.23.1781189367167;
        Thu, 11 Jun 2026 07:49:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c7ea52sm76480855e9.2.2026.06.11.07.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:49:26 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:49:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH 0/2] Fix lock errors in VDUSE suspend feature
Message-ID: <20260611104914-mutt-send-email-mst@kernel.org>
References: <20260611133806.198402-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260611133806.198402-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HcAkIoCcPFI1XDfVR0BpWp4ETG9VmCv0tEj9Aw8Jqas_1781189368
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 03:38:04PM +0200, Eugenio Pérez wrote:
> Fix wrong ordering at taking semaphore after spinlock and convert the spinlock
> take and release into guards, so they are not lost after a return.
> 
> This series goes on top of https://lore.kernel.org/lkml/20260610083452.477759-1-eperezma@redhat.com/

You mean
20260610-vduse_vq_kick-fix-guard-usage-v1-1-0ce02c08006e@kernel.org
actually

> ---
> It would be great if these can be squashed.
> 
> Eugenio Pérez (2):
>   vduse: fix not releasing taken semaphore in vduse_dev_queue_irq_work
>   vduse: not take the device semaphore while holding vq spinlock
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> --
> 2.54.0

