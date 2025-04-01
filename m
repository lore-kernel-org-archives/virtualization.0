Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA851F09B7
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743513716; cv=none; b=crgzf7y9S52Sodr57FlHikvlce6BwZ7liM/7FNHD/FjuFzwnry8kHgyHV9an4gH8USsKHPFN/hRvNa6rgVAHTB6oUa/bKGhxSMD7zsjj09rXVXlFw0B4grhSIATPAtaMjIgpDrHCpA3QamjCz2P+POwo0ZHKul+1XFHRq4UbwKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743513716; c=relaxed/simple;
	bh=ycqaVfo4cc/Z15EASZ9JqEGL8RqMFYZHnyysBu7HA+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Njes1eVL/qBKy3b62FTnG8RFP4+LNshLhEV9XjKtW1LW2WoBS1HdAXWp2MJji3NmTegB1P4EdkKTSpuBvmLGhv5RozLF/Lg1Vp4LZq3XY78RM6aHP9+sav+DIJC/4j5MSRC8xkvc15awOMXJxGIEBdoJ/JUa+QQ3+UUPFBIpKks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsgNgCU4; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsgNgCU4"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B77061040
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:21:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dx8IrGQVvgTL for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Apr 2025 13:21:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 930E86107D
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 930E86107D
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bsgNgCU4
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 930E86107D
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743513712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRPbMyE5s2HZPVPM3LxqZ+mTI/kiq2Z60zsrimmnKds=;
	b=bsgNgCU4e3mnZuiU6NFY9RUxJ/d5oW64wO+rJqySUFkTtpoQtMSMhE1IovTKjmtVAlEgn2
	sHV+QLZoSY87MYXUC9bew0SSYJ3ryYNvwiTGMBcfZL8UBaUeX0knELDIkEO1zW9u179Fto
	+PFDHpuj/K8Iw+oti0+lYKPgwBmtmxg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Pf17bFqPNlmoGHZQ5fueIA-1; Tue, 01 Apr 2025 09:21:50 -0400
X-MC-Unique: Pf17bFqPNlmoGHZQ5fueIA-1
X-Mimecast-MFC-AGG-ID: Pf17bFqPNlmoGHZQ5fueIA_1743513710
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3913aea90b4so2286268f8f.2
        for <virtualization@lists.linux-foundation.org>; Tue, 01 Apr 2025 06:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743513709; x=1744118509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRPbMyE5s2HZPVPM3LxqZ+mTI/kiq2Z60zsrimmnKds=;
        b=LbJOFpIJAzQ5mn4zDU/ouh1TizUJQp/XEJQjBmzvrzb3DhlBJksmQ9ewiwZxnie44h
         UjkcHfKufD8RFh75GYYV26+Ow9Bk2cFn8EbETED3KH+ohaQqNqfWZl2WF2fEqPu8tOsI
         hXLlKS5ZkCz4rissQcomqraIN298kYU/5gs0JqDPAztBlp3rr/iz5KP9h2C0DT5HpU44
         /57DE/ExBpx3a5RmvwxR8vtsoZ3j6aQaozH/WoHfsMF06JLqYZ6ZkPMPtqGPXKJMCoAk
         BrY3rbZkLHPHyvwim6scyEiukNMvEK/6Ja4yRcSWkYLKxQkJIYar3MY4xqgCRmieckqA
         1U8w==
X-Forwarded-Encrypted: i=1; AJvYcCVMtHiw61H4ma9gsGpLjMnRdoIX9eTpEslVwwBvl0aQS0Mncnseksqvw9x8C9ImFuuf/713ZcKXZV63qKdqXA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzWhak1CnxGeYfmbW5HTDF4XMGdUy/YrESIWAeGJjD7sHMpvuGd
	SG1GafJDVZy+TnGtpcaTN4Y7vdalZwbWZanPRn53vvzXF+yt7iCDX15C3ZwTDQnsJ1M8OdTEIz0
	zEf5mws+9PhYYIdkasTV+/Loogbo8NZEdceusK1nhKWnlr07C5FCXOuJZLSLrASf8XlXMztuvF9
	FozuA=
X-Gm-Gg: ASbGnctZu+mvgUy9JW57YPfU/1WwmlAW7AJmeyDlVk8QIV+WZtJdgWCML7pXalBr/xL
	/juLu2zFQwAdHlgC8Os0JqOCZfCPnWZy76IBceGnDtAv9S3+MZ6lLEs2s0WQbcJ8zzLMcMpRQQl
	jNA1HtaBoCkCg/14nggbxqFvIQ7uI6y0FNHlLi2v/WZ2THp3ErO2T2bn08u9aggvC9gXOrsU7fB
	7WDEEMlA/Qbz5oN6V+Qk8WOVqXdjbQWEVFuM065HY7sQ6b9lQ0AdaJtES2CedwAekqDD8LknsD0
	nUPV5xMTPvzOJxTbb7SpLMPMQRSFK+rLduVpvTaquBiES91NlfToGyl9iuo=
X-Received: by 2002:a05:6000:1864:b0:391:2f2f:818 with SMTP id ffacd0b85a97d-39c120cc896mr10576007f8f.9.1743513709524;
        Tue, 01 Apr 2025 06:21:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiWSuzzoAuRNaX6AE7+30mbeGythA/LKCONvKE8G1+2K+Xi1SRoClR/KoadewifmZl/GAkjw==
X-Received: by 2002:a05:6000:1864:b0:391:2f2f:818 with SMTP id ffacd0b85a97d-39c120cc896mr10575974f8f.9.1743513709009;
        Tue, 01 Apr 2025 06:21:49 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66277dsm14027524f8f.24.2025.04.01.06.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:21:48 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:21:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 8/8] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <3zmkrimo2nghk42iatj4tuhfb7qrxx235srleuavi4at5dsv26@zj6wqgj7hj62>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-9-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250328100359.1306072-9-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D7e37DoYHoYB9czd0VbEGbrE_GPypOSmDoQGLZaAGfU_1743513710
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Mar 28, 2025 at 06:02:52PM +0800, Cindy Lu wrote:
>Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
>to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
>When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
>is disabled, and any attempt to use it will result in failure.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/Kconfig | 15 +++++++++++++++
> drivers/vhost/vhost.c |  3 +++
> 2 files changed, 18 insertions(+)

IMHO this patch should be squashed with "[PATCH v8 6/8] vhost: uapi to
control task mode (owner vs kthread)".

It might break the bisection to support an ioctl, and after a few
commits enable or disable it depending on a kernel configuration.

>
>diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
>index b455d9ab6f3d..e5b9dcbf31b6 100644
>--- a/drivers/vhost/Kconfig
>+++ b/drivers/vhost/Kconfig
>@@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> 	  If unsure, say "N".
>
> endif

nit: there is a mix of tabs and spaces in the next block, should we
fix it?

>+
>+config VHOST_ENABLE_FORK_OWNER_IOCTL
>+	bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
>+	default n
>+	help
>+	  This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allows
>+	  userspace applications to modify the thread mode for vhost devices.
   ^
   tabs

>+
>+          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n`,
>+          meaning the ioctl is disabled and any operation using this ioctl
>+          will fail.
>+          When the configuration is enabled (y), the ioctl becomes
>+          available, allowing users to set the mode if needed.
   ^
   spaces
>+
>+	  If unsure, say "N".
   ^
   tabs

>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index fb0c7fb43f78..568e43cb54a9 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> 		r = vhost_dev_set_owner(d);
> 		goto done;
> 	}
>+
>+#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> 	if (ioctl == VHOST_FORK_FROM_OWNER) {
> 		u8 inherit_owner;
> 		/*inherit_owner can only be modified before owner is set*/
>@@ -2313,6 +2315,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> 		r = 0;
> 		goto done;
> 	}
>+#endif
> 	/* You must be the owner to do anything else */
> 	r = vhost_dev_check_owner(d);
> 	if (r)
>-- 
>2.45.0
>

