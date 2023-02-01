Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79680C05027
	for <virtualization@archiver.kernel.org>; Wed,  1 Feb 2023 15:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D52F56106E;
	Wed,  1 Feb 2023 15:52:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D52F56106E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZPcX9Q53
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LlKMsu4_e7fP; Wed,  1 Feb 2023 15:52:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7073561069;
	Wed,  1 Feb 2023 15:52:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7073561069
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E155C0032;
	Wed,  1 Feb 2023 15:52:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A47FDC002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 15:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 77A7740A18
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 15:52:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 77A7740A18
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZPcX9Q53
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CJFpR2VPMpDX
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 15:52:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AEBFC40A07
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AEBFC40A07
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675266763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XzoNqKV6Cz9SVsHFKDeNJCe9fKu9P6AEJ0vvGP1TI1k=;
 b=ZPcX9Q53yVIImJojI+GgaCuJhqbq1QvFPcRZAF/dXLJflMdW3/vO+ob/twrtJRLIM/wL43
 eRUdFwGKuUSPkoQuF5sA7Q/79TddAita17qspH7zirBbc4lYksTHY3HQZVlj22iGg9Oqrx
 Z+dx4jYnI3IsNBbB1QG0D9Eumr6lP5Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-224-EMDstfyrN1O_5Znuwobkig-1; Wed, 01 Feb 2023 10:52:42 -0500
X-MC-Unique: EMDstfyrN1O_5Znuwobkig-1
Received: by mail-wm1-f70.google.com with SMTP id
 ay19-20020a05600c1e1300b003dc54daba42so5814682wmb.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Feb 2023 07:52:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XzoNqKV6Cz9SVsHFKDeNJCe9fKu9P6AEJ0vvGP1TI1k=;
 b=6RlzPCo02Is/an/dcWpwRoOVe1yf55bU3bE1q2yHWOhNKdBR2ySMOTtknyB53oQgEf
 Op8cxTPGl18DAndJnhGszrIxHCoEavB1/bPDnJeIlj0e3Bx0tQVhvh+jScjw3wDEELTl
 F7YTaed+dW/stnIFDDfySohGd0Lxnoi1iovcpr0QCN1D+0lkJ5juCWWcOW5HAsfvhv8C
 n/0u9Pdyzx9I4wn/M2Vtu1/+qsAFtw3EhopGoRb00EHKiynMvoHBtmH+WX57VaSJbygb
 iu9kB34HoxGvnC0HPMCdy/WzNN3SuiTeckoSj2QN7+vRZXfwWbGdE54lEBOPo8RVERmY
 wPGg==
X-Gm-Message-State: AO0yUKXnX8tB1tgzI6rGS38wsJHjesRshBiA2xp/5rDH+8FYsbulV+X/
 R+Pr3K/gFqMATcIWRTwMk3j6l7jb1oPZ9Pq57umhlhT+iKHbrUm9h6CskEzRGJP5aL2Q72tjbWw
 4nvPNOiziYYqwdm2oVhORbNzvyoRbB0rhkekcW0WEhA==
X-Received: by 2002:a5d:68c8:0:b0:2bb:6b92:d4cc with SMTP id
 p8-20020a5d68c8000000b002bb6b92d4ccmr2670040wrw.53.1675266759477; 
 Wed, 01 Feb 2023 07:52:39 -0800 (PST)
X-Google-Smtp-Source: AK7set8qYSlMDMNOSFaN19grpNcj5RrzZI2G3D9+Cd/RumqUU7LsytpntPRQ2vaoy76EUXG76UA3pA==
X-Received: by 2002:a5d:68c8:0:b0:2bb:6b92:d4cc with SMTP id
 p8-20020a5d68c8000000b002bb6b92d4ccmr2670025wrw.53.1675266759217; 
 Wed, 01 Feb 2023 07:52:39 -0800 (PST)
Received: from redhat.com ([2.52.144.173]) by smtp.gmail.com with ESMTPSA id
 j15-20020a5d452f000000b002be505ab59asm17589261wra.97.2023.02.01.07.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Feb 2023 07:52:38 -0800 (PST)
Date: Wed, 1 Feb 2023 10:52:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH] vhost-vdpa: print error when vhost_vdpa_alloc_domain fails
Message-ID: <20230201105200-mutt-send-email-mst@kernel.org>
References: <20230201152018.1270226-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20230201152018.1270226-1-alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, Eugenio Perez Martin <eperezma@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Feb 01, 2023 at 05:20:18PM +0200, Alvaro Karsz wrote:
> Add a print explaining why vhost_vdpa_alloc_domain failed if the device
> is not IOMMU cache coherent capable.
> 
> Without this print, we have no hint why the operation failed.
> 
> For example:
> 
> $ virsh start <domain>
> 	error: Failed to start domain <domain>
> 	error: Unable to open '/dev/vhost-vdpa-<idx>' for vdpa device:
> 	       Unknown error 524
> 
> Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>

I'm not sure this is a good idea. Userspace is not supposed to be
able to trigger dev_err.

> ---
>  drivers/vhost/vdpa.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 23db92388393..56287506aa0d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1151,8 +1151,11 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>  	if (!bus)
>  		return -EFAULT;
>  
> -	if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY))
> +	if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY)) {
> +		dev_err(&v->dev,
> +			"Failed to allocate domain, device is not IOMMU cache coherent capable\n");
>  		return -ENOTSUPP;
> +	}
>  
>  	v->domain = iommu_domain_alloc(bus);
>  	if (!v->domain)
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
