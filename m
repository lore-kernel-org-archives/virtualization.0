Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E39B479872
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455368; cv=none; b=pGLfg6kmLT8oNVHVgEAPDdY2r+6I9gA1m0mJ4X5bFapLs9WV3nqX5aoajeGBEnI7fg6lHtB5FenzAsGWNeHOMQrM4ZFM+U1iNZ6Dqp1Bgx+fpe0BGe6v0MLtiVNId9Me3pkjxN0VLBW3oQaBJvqGOUEQRlGTGJZJ6KTfaCx5MYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455368; c=relaxed/simple;
	bh=QBPX2FlNZdNHfPS9xAx4hnsjicFqelsPaGbARid3Jq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=isFfaP4YYrH0pVN5Bd2lYFOHHh1lLpWjQRJ57XCh8nqAhxKtl95n/BquISKDRGlMKU8BKIPL2OYelyhbsNd4Bb3mtfDs7OhtBlVe02xeeJixbOQ4Mgv1LLefX9WCXV1tfCvpuMZ60bzTVyldLG9W7HcAXAXQ9v66ThBTk5VbmZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2esO6pB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2esO6pB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785455366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0imh//Ln8azssKsT3gHIO0joG70m1DE2os+hdd9glB8=;
	b=f2esO6pBuSTskpTrlJwnmloS9d2CO+BqdRzMIpLINGq6RM3Qr0wmoKGVqT8+TQ1AGB/YUI
	WIBpSSAcKwDYVYoOXxQEf7t59ewZ4D7Qx2b+rr12RIy1ToZByZzFCvf8Rk+Wh2/Px3BAMm
	pdFwYWgE9X7o6qQlUOi3jqhHOhwue7g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-j6YshgCuOfeVKjN_phRAFA-1; Thu, 30 Jul 2026 19:49:24 -0400
X-MC-Unique: j6YshgCuOfeVKjN_phRAFA-1
X-Mimecast-MFC-AGG-ID: j6YshgCuOfeVKjN_phRAFA_1785455363
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f8398ed9fso186452f8f.0
        for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 16:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785455363; x=1786060163;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0imh//Ln8azssKsT3gHIO0joG70m1DE2os+hdd9glB8=;
        b=DNsQbIsH71l8MTeTqzqMdDm5uW7J1pR/nIoLltfsM4xcn1kdFTLww7Rg0WHZ0nGWtb
         MQYKc3shk7WAKi4QTsdI7ZgubuCdr4LlV2BuP1WK0+8Poq1yJSo+8v5Z5CjiBATpXLfX
         QixA3l5ZIlYCgxNZXZplzyryGpoNouZzKn53z5JHVeSK/iv/tb/aBiz+QpzW0Ttf49A5
         HdjJp70lwjVFZZvD8DLsVXYmSH4LhQRsZUU7NqlxV9f4kUGP3cHGZzmDXuiPHZ4iVQwQ
         9mqysWGfJGVzDJ3JMYQIwf3K81DyeOLXLGlJW3WhN/FB/lRJPRv1PguIDfJpwrKqVgTz
         mHRg==
X-Forwarded-Encrypted: i=1; AHgh+Rq5f+pIxR1D6KF4f42VKL3i/CHdBsR/SJy+KL0aI8ji2627xqm4/TLzpMSCqNqr65U+VZ/OAiSBRu3tJin+sg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPkxzhC3TjSbe1T8ZRv0C9pm9nndGq15csm597K41GPue/zoVJ
	b1hVqQ88nFyWvyJSwztCZioa/ZMD44AYU88cCOmeFLHv3+wPJouww/O4J73BV41Hua4wXl1JHcE
	MGfl4PxFIcZykZFalPzitchDW8kirVKw/ffKp7OELQ4MsroWmxqOCRgXoHyw4rKzoXO8a
X-Gm-Gg: AR+sD10aH3SlCOVEpYg9UP2605myYsR56zknmxwE9Wv+ERRKcbT5fLB58ztYoBNfHv5
	JJkXi78OkL2UzYNqdtstYIXEF13dVXmb6369mdMRjQzxX/pYD1Bv2De4kZHdBIUmtscpLj2qTkY
	9Cd70FJ3qqAFdHvx4o8K4dxBCLhuxeScsWjMAHba0twmky8GoeWFl7mZ56nGsZqTEY9UEKMLkgp
	K8DbfzS92zJmWgrHOs6lf80n+xQ3CfeDNUjOaD44yn1egOkYokxqflnryDqVOLO1lq29pvSKIvi
	UpyI9+VCM0R2HOBZgJ1uI1N262Ogp6trydwtowmScp8fKIaLEOg5ovm52aJ7o+I1gjdi1W5IQLB
	BXa2SWl1JAbG7wcGpYZfwPBE=
X-Received: by 2002:a5d:5f88:0:b0:474:cd60:1154 with SMTP id ffacd0b85a97d-47fc8200021mr6660274f8f.41.1785455363414;
        Thu, 30 Jul 2026 16:49:23 -0700 (PDT)
X-Received: by 2002:a5d:5f88:0:b0:474:cd60:1154 with SMTP id ffacd0b85a97d-47fc8200021mr6660223f8f.41.1785455362999;
        Thu, 30 Jul 2026 16:49:22 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e3c73sm10792795f8f.10.2026.07.30.16.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:49:22 -0700 (PDT)
Date: Thu, 30 Jul 2026 19:49:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	sgarzare@redhat.com, stefanha@redhat.com, dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com, bchaney@akamai.com,
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v6 0/5] vhost/vsock: add support for VHOST_RESET_OWNER
 and CPR migration
Message-ID: <20260730194858-mutt-send-email-mst@kernel.org>
References: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aUoxLU1UDn6qDbgM_HTMpovS_7gGlWRnWb0y7fkrzMU_1785455363
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 24, 2026 at 02:45:37PM +0300, Andrey Drobyshev wrote:
> v5 -> v6:
> 
>   * Patch 4:
>     - make sync+flush conditional by adding a bool 'sync' param to the
>       chain, as suggested by Michael:
>         vhost_dev_reset_owner()
>           vhost_dev_cleanup()
>             vhost_workers_free()
> 
>     - reword commit message and comment;
>     - drop Fixes;
> 
>   * Patch 5:
>     - add 'sync' param to vhost_dev_reset_owner() call.
> 
> v5: https://lore.kernel.org/virtualization/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com

does not apply for me is this for net next?
in that case

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Andrey Drobyshev (3):
>   vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
>   vhost/vsock: re-scan TX virtqueue on device start
>   vhost: synchronize with RCU readers when freeing workers
> 
> Pavel Tikhomirov (2):
>   vhost/vsock: split out vhost_vsock_drop_backends helper
>   vhost/vsock: add VHOST_RESET_OWNER ioctl
> 
>  drivers/vhost/net.c   |  4 +-
>  drivers/vhost/scsi.c  |  2 +-
>  drivers/vhost/test.c  |  4 +-
>  drivers/vhost/vdpa.c  |  4 +-
>  drivers/vhost/vhost.c | 26 ++++++++++---
>  drivers/vhost/vhost.h |  5 ++-
>  drivers/vhost/vsock.c | 89 +++++++++++++++++++++++++++++++++----------
>  7 files changed, 100 insertions(+), 34 deletions(-)
> 
> -- 
> 2.47.1

