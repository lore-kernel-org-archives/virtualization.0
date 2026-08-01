Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87C24322FC
	for <virtualization@lists.linux.dev>; Sat,  1 Aug 2026 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785578153; cv=none; b=NpgKnyfo9E3l6UjU777hl9zZ/o4ITMRzxoKjg7GKvPr4XE3/05imHWlYU5RxS6wfa3UHcfv7wV5x5m4hFbtoLTI2rh4FyhjDFIyLWzPmKIrrbQjSLJMw9pVLDsLM7YJXPiMLCVPWAU/kwN70WWrhnA1s4qoIIW5iHt3bO34WlAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785578153; c=relaxed/simple;
	bh=WsvcNPl55v9nYsrEXdYBZpBX+UgJcrc+VrHr1cAnrMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tfCL5aPO/BIWXPEX2bwEF0NkAOZOPOCT9rAeeNb9b5XdFlAmHZu5ABa+nROnlHfO9+j21TCNGphfZAqkV4GN/cokAGCIt7yA8jI+5NTAkvhCmDItyFeXhCExRwJCunqi8XERwyZ6mI3g5Zd92mDyfQJM6eBAkCh7Nc1GoZRyqwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLGWCqLF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLGWCqLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785578148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cRBH7yAyG3b0nA/NrlCXIpZjagKMKnfPJMe1ZdV0/hY=;
	b=CLGWCqLFLHWPqj2Q0nRK2JHbnva1XEwd1de4HWXgoGMUWVazpRZQEUczq+MwlxTuS99PcK
	NRIR1sq7TPmCx98atnwBdHCMAy2ld7xhcLbiH4SVtptze0ACAA1o6YDznX4r3tTh3t5r4Z
	TcUbC3KjSFSboNSAdwWFpQiwPtwEXG8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-hhFgFNP0NsqtFrPiNTCsTw-1; Sat, 01 Aug 2026 05:55:46 -0400
X-MC-Unique: hhFgFNP0NsqtFrPiNTCsTw-1
X-Mimecast-MFC-AGG-ID: hhFgFNP0NsqtFrPiNTCsTw_1785578146
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f8398ed9fso1930599f8f.0
        for <virtualization@lists.linux.dev>; Sat, 01 Aug 2026 02:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785578145; x=1786182945;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRBH7yAyG3b0nA/NrlCXIpZjagKMKnfPJMe1ZdV0/hY=;
        b=Mrtz6+XBinxFAi+iHrtfEKuLnSbJ1hol08B4DOQfBoIin6y/tPwQwX+jhqhkAPz9Io
         N43+0EEblSPpCBFCcSL2N7ZrsOo9cV9OYouqetrEATlmXrDb13ckjK1vJD+hbp7dKkfW
         t7DrttV4+LrXle5EE586tcrPt3NqfvaffcOiWtGdGKOAAsrqYpAQBkw1Xa7DIpkYSHtG
         stcp2tcVASe0+XDwmEcFokb56bbrPR3vidM2DdSO6lp49mHskrNDU4sIPQiZo/R7vt6/
         xNsT9MPEspGDmsrOckl+7ajzIVl6GM9qC7DYiiif9PRD16tTRxoRC3QyV63upgGGvy12
         mMkA==
X-Gm-Message-State: AOJu0Yy8AdF1y/wFKKbIfFsWuVf4i2ANZ+DW9TyRg5YSOP5SEQuyzb1r
	M6qO1QlNMxG1K0ZZD364iJXNsPharB7OcBVQrIfRGOtgPw2K41qCLjuuu3b1LLN6hPu19h7MtCp
	zh6NYgbCiFf9YC7AvfXhvroXEQoBtP2sb23syjPMHn/wuZDwdkCCyupOLdbmREpXRANyv
X-Gm-Gg: AR+sD13UfwMsTXNwB3carc6PyhaxaQFPnl94IKjZMPfjwngINva4WoI+/K+n28xXUPP
	7XpcLPEStYUNZymogef/Mfr1lQyu2TwNmDlp5HSCG0aFIulYDczsd2J/nqez2UKaKeLnkBmddR9
	wEXabCdwYuWLWEVb9jEMVrmIuxof1EkbLWWTVYTfzSHRsLHm64dm/NVcRhLK/ellRGGbxhFT/os
	EYw+wA7NxtbU9C9tMEN/OsdCZFaFBbrk+BelJRXcL+YnVAkYekNz+N6ZWnPGXSQapIPfjtGebGe
	g6frkY9P6h4Ybfjfxw400acLvltgl002rssp6WDdEHHVh1CvVllMo19pbQh93cC4O7wPKtyfqRt
	V6CanrXS1ObNHJNyXPIbmn7k=
X-Received: by 2002:a05:6000:2203:b0:47f:8487:a686 with SMTP id ffacd0b85a97d-47fd9b63489mr2883293f8f.23.1785578145574;
        Sat, 01 Aug 2026 02:55:45 -0700 (PDT)
X-Received: by 2002:a05:6000:2203:b0:47f:8487:a686 with SMTP id ffacd0b85a97d-47fd9b63489mr2883234f8f.23.1785578144986;
        Sat, 01 Aug 2026 02:55:44 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d17f2sm17118960f8f.2.2026.08.01.02.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:55:44 -0700 (PDT)
Date: Sat, 1 Aug 2026 05:55:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, jasowangio@gmail.com,
	michael.christie@oracle.com, pbonzini@redhat.com,
	stefanha@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
	joe.jin@oracle.com
Subject: Re: [PATCH 2/2] vhost-scsi: reject invalid max_io_vqs module
 parameter
Message-ID: <20260801055436-mutt-send-email-mst@kernel.org>
References: <20260731221116.236791-1-dongli.zhang@oracle.com>
 <20260731221116.236791-3-dongli.zhang@oracle.com>
 <20260731195756-mutt-send-email-mst@kernel.org>
 <d24ab42f-fa00-4a5c-b987-c05f6a9898f2@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d24ab42f-fa00-4a5c-b987-c05f6a9898f2@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z6YSCRmjxPMv-_Q1Ld4-rH_RztCsuCng-9XMNeVTNAQ_1785578146
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2026 at 11:59:21PM -0700, Dongli Zhang wrote:
> 
> 
> On 2026-07-31 5:00 PM, Michael S. Tsirkin wrote:
> > On Fri, Jul 31, 2026 at 03:10:24PM -0700, Dongli Zhang wrote:
> >> max_io_vqs is currently validated only when a vhost-scsi device is opened.
> >> This allows sysfs to show values larger than the driver will actually use,
> >> e.g. writing 2048 succeeds even though vhost_scsi_open() later clamps it to
> >> VHOST_SCSI_MAX_IO_VQ. This makes the sysfs value differ from the value that
> >> will actually be used.
> >> 
> >> hv# echo 2048 > /sys/module/vhost_scsi/parameters/max_io_vqs
> >> 
> >> hv# cat /sys/module/vhost_scsi/parameters/max_io_vqs
> >> 2048
> >> 
> >> [  315.630495] Invalid max_io_vqs of 2048. Using 1024.
> >> 
> >> Use a module parameter callback to reject out-of-range updates when the
> >> parameter is written. This keeps the visible parameter value consistent
> >> with the effective queue limit.
> >> 
> >> With the parameter value kept in range, remove the duplicate validation
> >> from vhost_scsi_open().
> >> 
> >> Invalid values now fail with -EINVAL at write/load time instead of being
> >> accepted and silently adjusted later when the device is opened.
> >> 
> >> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> > 
> > why should we change userspace visible behaviour now?
> > 
> 
> Everything started with PATCH 1/1.
> 
> The original purpose was to resolve the memory allocation failure addressed by
> PATCH 1/1.
> 
> To validate the bugfix, I increased max_io_vqs to see what would happen.
> 
> To my surprise, I was able to increase max_io_vqs to 2048 even though
> VHOST_SCSI_MAX_IO_VQ is 1024.
> 
> hv# echo 2048 > /sys/module/vhost_scsi/parameters/max_io_vqs
> 
> hv# cat /sys/module/vhost_scsi/parameters/max_io_vqs
> 2048
> 
> However, a value of 2048 does not work when creating a guest VM with vhost-scsi
> because vhost_scsi_open() fails.
> 
> This behavior is quite confusing.
> 
> Therefore, PATCH 2/2 was proposed to avoid confusing users. If 2048 is an
> invalid value, then setting max_io_vqs to 2048 should fail explicitly.
> 
> Is this really a "userspace-visible behavior change"? Without PATCH 1/1,
> increasing the default value to 256 could already fail because of memory
> allocation. Perhaps this is a good opportunity to define the expected behavior
> of max_io_vqs before more users start increasing its value.
> 
> This also makes the behavior of max_io_vqs consistent with inline_sg_cnt. For
> module parameters, it may be better to perform sanity checks when the parameter
> is configured rather than at runtime.
> 
> Thank you very much!
> 
> Dongli Zhang


There's no telling if someone had a large value configured and now the
module will start failing for them. I can accept making the read return
the actual value, if that helps.

