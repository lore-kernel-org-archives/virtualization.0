Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D151B2494FE
	for <virtualization@lists.linux.dev>; Sat,  4 Jul 2026 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783179326; cv=none; b=P/gvQXXNgaB26AWcqioZ0C1d4m49VG8xZ5Xar74hezL4qwSY4SPx0fkFZzU1kGqBZ+HWIDmMHgDKzeEnBmi2+zcYooZU8bFV71LzW2fgZO8HaqYRHRJEAz3iKXLa6VqzYPCMT6i/fEqFJfc7uDtsxlVb4+3f0xHzPm3skEKUPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783179326; c=relaxed/simple;
	bh=2fQ9urNSxcklh0phZkHbGfVadyqUTMqX8qpnTPawXYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PkHQ2Fodq2zF65BSxZXgJVVtuJQ9dXJw2ubGeeK4wXO8Hfdslrd58p/nCCUdHHs2SVgZpz1n9GnLXrjgFUZxfIzAsDbjrH2ShmuNLeoL7i6OONnCk099DAhQc8D0Y27zGaoaFQNXYQiscPq0CIWbgscljDXanfeCobONCHOWDps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ea7EP/Ug; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ea7EP/Ug"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783179323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eNL4oD7c4ez8lPpkyBqxMc2/GbTsjJZa+epkmtw6DhY=;
	b=Ea7EP/UgeMy34+xGrL3EKmJXhUe+gZhGAZWASYF3VMaEAn6MyDk9oxssSigvmvHTxgtx+o
	t/w4nOTRz5q0pg+P2R+jN98LWRzVWhUYssro0RR91c6pEtcU5PjEWMPSH+F5COH1PJDGBs
	RyvhU0m8bLbHnPXgkgupERpEQqPxEJM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-k_81ko5_P7WSPsW_CTTqzw-1; Sat, 04 Jul 2026 11:35:22 -0400
X-MC-Unique: k_81ko5_P7WSPsW_CTTqzw-1
X-Mimecast-MFC-AGG-ID: k_81ko5_P7WSPsW_CTTqzw_1783179321
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493c1bc7a70so12652475e9.1
        for <virtualization@lists.linux.dev>; Sat, 04 Jul 2026 08:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783179321; x=1783784121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNL4oD7c4ez8lPpkyBqxMc2/GbTsjJZa+epkmtw6DhY=;
        b=Qe7q0uNbjc//aYa81rfW3B1Mcq+lnRFzwEH1Xgp3i4xfJAvAA0CclTYThGU/4QyuBP
         2a1q+aJJ/+EJ+K0QTCzBECdllCwvSqY8itrGyuurwxGatBAQfONxn+BHzPO5z23cYM+C
         Rth6CLATvckeHvzRWk3wDK1zY38ElwGbK0MKWLqxA7nNdnjZTqSc7KRe/gsRHI1MBn+y
         ObLypuLFAaE3+VuHR4lTJKKgS7QBTkSncgtz2TCho/qtsG2iwY6orbScLv+8Xqh/a7xb
         rq5tyLnNnrvqTDINZUZ+YJdK3sVKV3RpD9HT+wuWKK1IMS/E9lJGS7OQcO3wG7eE5IFA
         s26g==
X-Forwarded-Encrypted: i=1; AFNElJ9HB3eb6NJZBQobXfJxBwp41jzpugLoKEHUrYCGQu36CSL52h8MFn11+wJ0gD4pcoZvUt1fzPiaVvEVCLpxdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfCZ9juOfXPY3XueXe/+Sv7y2CODQBMIYXaL8USKOufDQCRMNy
	PhrYDrGvA93zoedRI6RCd32Kpv1/0rNedZe6AdADBTndYJCzFIJyGOvC64MNCaTdx9O5/isYpnq
	bpNCz992WNHQZIwXxE3szMOESpIhpdizsJz9zoqjSKjtXAaixwZUBrqfbcej6z0XE6Hqd
X-Gm-Gg: AfdE7ckiPeUT7Q7TOGTdACxJJBux8ClK3nYBEiaNUuuBoXTdr8geiFLifwGwL/mDZbx
	+1qKrJezQDo0SWZLpokzOrWnoDoEP7zJ/eHz9xzS5Jdze18EIQUTgIRscztZdflz0vGA/ehmsdy
	xMUZ4DmfYg5weAS4WloTgjrV8jXUevq59c7zDBg0vBKjuzgJvgeGSFdHgIA8n6aHg+h0CX4TSFQ
	ezyWcu2ndNMsG63aVyHHIm88BVLQWWFg56PH0/I27/kSJy5VzHmdCx6HE4K7NLogQibz2nhSym3
	WQHkBgfbnXAgPniVW5I6laCKln2gcTq+wu+cbrj904W9emGM0uqDoevPGHIc097h4AVU/AMyRAS
	AuXN6tvAzCulys2D4WXgKtLAg73rhlMDDa0TxIrE4Fw==
X-Received: by 2002:a05:600c:3551:b0:493:9b02:484c with SMTP id 5b1f17b1804b1-493d11f7eb2mr43950795e9.29.1783179321055;
        Sat, 04 Jul 2026 08:35:21 -0700 (PDT)
X-Received: by 2002:a05:600c:3551:b0:493:9b02:484c with SMTP id 5b1f17b1804b1-493d11f7eb2mr43950535e9.29.1783179320694;
        Sat, 04 Jul 2026 08:35:20 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net. [79.177.145.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdabda3sm139310675e9.5.2026.07.04.08.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 08:35:20 -0700 (PDT)
Date: Sat, 4 Jul 2026 11:35:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa: alibaba: add missing MODULE_DEVICE_TABLE()
Message-ID: <20260704113429-mutt-send-email-mst@kernel.org>
References: <20260704152732.55338-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260704152732.55338-1-pengpeng@iscas.ac.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g6kJ8oaaSIMVlfYEYCql1gl6CaisU1-EahBt5I4IPhg_1783179321
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 04, 2026 at 11:27:32PM +0800, Pengpeng Hou wrote:
> The driver has a match table for the pci bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.


what does this paragraph mean?

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> index e476504db0c8..fd6fdba46094 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -545,6 +545,7 @@ static struct pci_device_id eni_pci_ids[] = {
>  			 VIRTIO_ID_NET) },
>  	{ 0 },
>  };
> +MODULE_DEVICE_TABLE(pci, eni_pci_ids);
>  
>  static struct pci_driver eni_vdpa_driver = {
>  	.name		= "alibaba-eni-vdpa",
> -- 
> 2.53.0

