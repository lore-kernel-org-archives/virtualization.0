Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E8D2C69A
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562006; cv=none; b=E7LQjXEl7wRHIGuljB2zRfkGQ+EMBnt3fu+Z+h8Aj/g2oaN2gFA7lWJoU//BJbbbTKHMNSqOMrcM/DdQ0qR76lkNJFNenTDPoGwS2l7yILIQDU8XMs1jb46V27Y0FfxIKfVelN0H0xWSzH13vCEgSE7PGvVgN7RRNt0yFPoGI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562006; c=relaxed/simple;
	bh=rNOqKr343ZSMxime79iGUap0wNoYZSF/QDcsqxpgorI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CvyWTJHn+o9kGnrIpA92KuKSk9rmPDKQ91e90TabZCVvHmEsyFS7YFcKGDK3GQwDV2pTDn5H8Q4NSkzFCfmWQQPtg3S7OB4G5LCcblf0JNrYJyehVdjYOu/kBttmAfaqp/bhbaXK9ahZY2FDeM+yRzm3vFpa6F1SklCzdC1sNn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3yzc0hf; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3yzc0hf"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9223B81769
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:40:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VE53n545X1lh for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Apr 2024 07:40:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B5F6A81761
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5F6A81761
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a3yzc0hf
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B5F6A81761
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712562002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U6c8NxRj9cq6OvbALtg2Roh5bDMfOSXXjT3FSUcwbEE=;
	b=a3yzc0hfnQblN1RQ9xPlpKqER/Y507NphLSGZooTZe+CsiHlfa5GhpTPxcnOHMju3kWh3u
	AsdIPLnHXjqJmiPRo54muE220MfneTb3Q0U3Y2pSdFhLMNcCODcWUkElNj66KWl5VZE5Ts
	cHWztf70VreBSzqREQdWDNQh0QVechA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-SkuaTdDzNOG5Aa6sLMCcgw-1; Mon, 08 Apr 2024 03:40:00 -0400
X-MC-Unique: SkuaTdDzNOG5Aa6sLMCcgw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-516d46e1bafso1539363e87.2
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Apr 2024 00:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712561999; x=1713166799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6c8NxRj9cq6OvbALtg2Roh5bDMfOSXXjT3FSUcwbEE=;
        b=W8gkGAvYWHMvlVhCUpILRDWf1pjA1QpMOjqHrRm/mUBa6OuVaAY7sLI+7XScx/GSl0
         mnkg0piBmU6Zlg0RFfQC4cG0CaMWJKyeRkYWHRHmbEGBCNqpLX0UVpksJukbNbHoTwF9
         lGiX1gHXGyx0nm4JRGJkrRyEuyQG09nAf1CA7HyOMpiePXEIrXaKHkVsvay9m+aFLUz+
         kVfFRWzf4e3BLHe+CPQ2IYiPpWA0D6o4yltbIOSOFvzGIYWak47qpxfv10DIhBLvcgSd
         cXvh0W0KynXbsvy+AgvdOkuMNMH6/MUsqCYOofxfIlWiY3yT+XaXIOJ4ukh6zNMVtvWe
         867g==
X-Forwarded-Encrypted: i=1; AJvYcCUUUVD46/f52Ctp/AMchdigQ+Mq1bMd3iHG2WsEQ1YFFNLArYHECIpl/xzsZhjldcTn55dHYpSJK91dG5qakQu7Hs1sKOfaPBIRmiuBW7lMKGTYyeqfHAZ5Ig==
X-Gm-Message-State: AOJu0Yz+3F1gsaQziAdQRpVokuOqLaFxZYzkt9As+wAi+cg+nVjowizS
	iwGXstkhl4h0t7GzSERn/U5HbhZ8gUHVdp/jSp0h8VU6y+kDYP2501xLqbkXFgPfBCOJp6hANbi
	tmdG8au8unVjnm2cEDJPG6hi+vw7ktxdLOUrHcJ4hGxVDI+vhPMSEgE47ZP3LPX8WgGTV3en5SS
	Jzca0=
X-Received: by 2002:a05:6512:6c9:b0:516:c8e5:db35 with SMTP id u9-20020a05651206c900b00516c8e5db35mr6894124lff.18.1712561999177;
        Mon, 08 Apr 2024 00:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYDBkJjgbRSv4emXcuf1/HTD8JQtEuPSUD5eeQ3QrlOhXQrKMs2KEWRXNbHyZBPzEseuHvbQ==
X-Received: by 2002:a05:6512:6c9:b0:516:c8e5:db35 with SMTP id u9-20020a05651206c900b00516c8e5db35mr6894089lff.18.1712561998195;
        Mon, 08 Apr 2024 00:39:58 -0700 (PDT)
Received: from redhat.com ([2.52.152.188])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4c48000000b0033e7b05edf3sm8276904wrt.44.2024.04.08.00.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:39:57 -0700 (PDT)
Date: Mon, 8 Apr 2024 03:39:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: Add reconnect process for VDUSE
Message-ID: <20240408033804-mutt-send-email-mst@kernel.org>
References: <20240404055635.316259-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240404055635.316259-1-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2024 at 01:56:31PM +0800, Cindy Lu wrote:
> Add a document explaining the reconnect process, including what the
> Userspace App needs to do and how it works with the kernel.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
> index bdb880e01132..7faa83462e78 100644
> --- a/Documentation/userspace-api/vduse.rst
> +++ b/Documentation/userspace-api/vduse.rst
> @@ -231,3 +231,44 @@ able to start the dataplane processing as follows:
>     after the used ring is filled.
>  
>  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> +
> +HOW VDUSE devices reconnection works
> +------------------------------------
> +1. What is reconnection?
> +
> +   When the userspace application loads, it should establish a connection
> +   to the vduse kernel device. Sometimes,the userspace application exists,
> +   and we want to support its restart and connect to the kernel device again
> +
> +2. How can I support reconnection in a userspace application?
> +
> +2.1 During initialization, the userspace application should first verify the
> +    existence of the device "/dev/vduse/vduse_name".
> +    If it doesn't exist, it means this is the first-time for connection. goto step 2.2
> +    If it exists, it means this is a reconnection, and we should goto step 2.3
> +
> +2.2 Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> +    /dev/vduse/control.
> +    When ioctl(VDUSE_CREATE_DEV) is called, kernel allocates memory for
> +    the reconnect information. The total memory size is PAGE_SIZE*vq_mumber.

Confused. Where is that allocation, in code?

Thanks!

> +2.3 Check if the information is suitable for reconnect
> +    If this is reconnection :
> +    Before attempting to reconnect, The userspace application needs to use the
> +    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GET_FEATURES...)
> +    to get the information from kernel.
> +    Please review the information and confirm if it is suitable to reconnect.
> +
> +2.4 Userspace application needs to mmap the memory to userspace
> +    The userspace application requires mapping one page for every vq. These pages
> +    should be used to save vq-related information during system running. Additionally,
> +    the application must define its own structure to store information for reconnection.
> +
> +2.5 Completed the initialization and running the application.
> +    While the application is running, it is important to store relevant information
> +    about reconnections in mapped pages. When calling the ioctl VDUSE_VQ_GET_INFO to
> +    get vq information, it's necessary to check whether it's a reconnection. If it is
> +    a reconnection, the vq-related information must be get from the mapped pages.
> +
> +2.6 When the Userspace application exits, it is necessary to unmap all the
> +    pages for reconnection
> -- 
> 2.43.0

