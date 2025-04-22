Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F240828150B
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Apr 2025 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329821; cv=none; b=JbhPiIFZ/BYR/YEDFNNalMaHFdk8cI8fwBU21vTFQUQvxDRSJ5gJruO6QqFt7ME1YyraO9HtdGACr39JyJ3CelRGmPcUEhkAjBdWacO9it1tyPfQEdJburxUbt2ZL/+Psvb1AyvltOq2Ku2EyK6VuRwBBLvybkmGNAEza/TKBuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329821; c=relaxed/simple;
	bh=dkCmKq3j0PhWQbKGGX4/SXtHAhGav5AP9tWWdDGr5gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QY2W248o11ShO3exB4M9XsN41n9e24McUgv2tDf2IKcmRLbpK2Tti1gNeC5sZ+thmhBNIg+AtgiOwjYm6sDvKWWrRafoJsf1crJ7VALBqDhusL2LPrnUa2hVGqAXvHXhB5y7Kkh+Zu65Gq8qMB5+h1sSAVENVA5BYSzbn248mmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajI15rWT; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajI15rWT"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8746B4105F
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Apr 2025 13:50:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XV80tQfROmJo for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Apr 2025 13:50:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CEF8741036
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CEF8741036
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ajI15rWT
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CEF8741036
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Apr 2025 13:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745329817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tGrrkrKKBqlG8Lh7JFZpiU/FR9zy5tYWV0eT1+VwfIQ=;
	b=ajI15rWT3WNSW2LzY5ZaQm71uaE+jIx9hlrMiDmmG/4DKECeaKw+XLE4ZaavibSIAkQHER
	dDIUQLGkzwX+fdJqP7MZl8TvlyFYMOWvXNEM2MiFPATq+6cxCpbB5+nj7kbY9ioaoMAnrP
	SOFDYu09h9+g5SKFrjtRc0SPQeNfXdE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-vn4urJ4_OQiFhwlptFzEqw-1; Tue, 22 Apr 2025 09:50:13 -0400
X-MC-Unique: vn4urJ4_OQiFhwlptFzEqw-1
X-Mimecast-MFC-AGG-ID: vn4urJ4_OQiFhwlptFzEqw_1745329812
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-acbbb00099eso119675766b.2
        for <virtualization@lists.linux-foundation.org>; Tue, 22 Apr 2025 06:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745329812; x=1745934612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGrrkrKKBqlG8Lh7JFZpiU/FR9zy5tYWV0eT1+VwfIQ=;
        b=uhVOKSq1DkuJOquGf4oecyKPY3enyg5u4Ol2SL/05CSrhqcmM0MYW4/KbBM7+Ez8IS
         ijHvNOF2zAZ4b8Qbc8OFy6jhkUfL3W+BPXJSLtgTvxD58yxDjxZpqmn0A/yhM+2LRaxy
         QAfpPePAORrq4pRUu1xJD4nGGD0aByWS45EvNGkFqWGisb9Hiyam7MO3qxRjNqUVFSX4
         rqrJKqIRS25bttC+3HUxcXB+2IWJ/QCWC1HK1S71HanLTjD04UVLg/hcjqZmbj01LFhe
         zo7ep6tPhN1OxJJGOZEbAh4VA0X0Dr5TkbC68i00EFzs1Dk8EbQqJHtZD2oazUfeGoVZ
         XYMA==
X-Forwarded-Encrypted: i=1; AJvYcCVnsr67QEQ9q4qMFqmzImGgyB1pHFqb8fbd7JeMLLUgAe5Ng2gaKX1p7OU57c8Ku68OpwwJG4PiM4pnodGiBQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyiEdtaq6CidxocsVDasrv/XjvBtUuRG1GpA6RBdtj2tw/25Pr5
	83MJlxs85CM4u2+OdHu/H0tRNWBC0YdD7kb31xfecdxNlFFsmUHGn/rRIRaM92pFu9Xegq5rqBZ
	VkUzTDAW1OnKjnEbughhtcKTpLgMxfa77OieKe9dwig0kzFDQCzKO/+9BU2m/gZ4F8elwqAJe0Z
	f1maE=
X-Gm-Gg: ASbGncu+8JwYjOahvknmz2fwp7voLRGCCOcwuNp8p8FaeonVYyQbOdjxdIxGqBK/bdR
	SNPV2oJCLu1qbnf7eEGsMrYjUFZPZUHqtVUORK7OhhfcKBdBMMfHmvxL9+3JigSbXf8XKROiZsf
	vB3mJfwnRocZXMCyxJVDZ+Hz6Q+wjdfVIHSQGcjUDiVHjiwuWwBURFzYbLuJad9oLT4JKS5vhHt
	wc3CnU3BGUwuQOctvN2iYUXyAGLGkdahlOlPn9QalE0tDvrjYfVjxGIrC0KWAmJ706eBXS4B4gW
	bVWy3Mju8x1PX0jv
X-Received: by 2002:a17:907:7da5:b0:acb:4cd7:2963 with SMTP id a640c23a62f3a-acb74b8e55dmr1223055466b.33.1745329811875;
        Tue, 22 Apr 2025 06:50:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQvXSYXhBqNx9LOtFRQbGzKaEda8F/rKCshPfN314qnQj7UlAV89zqf9GyuhprD3N9TfTw0Q==
X-Received: by 2002:a17:907:7da5:b0:acb:4cd7:2963 with SMTP id a640c23a62f3a-acb74b8e55dmr1223052566b.33.1745329811204;
        Tue, 22 Apr 2025 06:50:11 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.218.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb905183a0sm489771366b.110.2025.04.22.06.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:50:10 -0700 (PDT)
Date: Tue, 22 Apr 2025 15:50:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <4xh3i7qikqiffxocxms4wfplg4tvemnszvywmtpkfyiqvq3age@jcq3aqvumig2>
References: <20250421024457.112163-1-lulu@redhat.com>
 <20250421024457.112163-5-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250421024457.112163-5-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sX5aPwO0-SVLK1sMI59BFq4F7I4i4qg4l82KQSGunuY_1745329812
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Apr 21, 2025 at 10:44:10AM +0800, Cindy Lu wrote:
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
>
>diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
>index 020d4fbb947c..bc8fadb06f98 100644
>--- a/drivers/vhost/Kconfig
>+++ b/drivers/vhost/Kconfig
>@@ -96,3 +96,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> 	  If unsure, say "N".
>
> endif
>+
>+config VHOST_ENABLE_FORK_OWNER_IOCTL
>+	bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
>+	default n
>+	help
>+	  This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allows
>+	  userspace applications to modify the thread mode for vhost devices.
>+
>+          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n`,
>+          meaning the ioctl is disabled and any operation using this ioctl
>+          will fail.
>+          When the configuration is enabled (y), the ioctl becomes
>+          available, allowing users to set the mode if needed.

I think I already pointed out, but here there is a mix of tabs and 
spaces that IMHO we should fix.

>+
>+	  If unsure, say "N".
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

As I mentioned in the previous version, IMO this patch should be merged 
with the previous patch. I don't think it is good for bisection to have 
a commit with an IOCTL supported in any case and in the next commit 
instead supported only through a config.

Maybe I'm missing something, but what's the point of having a separate 
patch for this?

Thanks,
Stefano

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

