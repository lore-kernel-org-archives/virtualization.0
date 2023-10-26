Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C49BC25B48
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 06:42:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AB078261C;
	Thu, 26 Oct 2023 06:42:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0AB078261C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L09sFBce
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ViebckoNHEas; Thu, 26 Oct 2023 06:42:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9339582605;
	Thu, 26 Oct 2023 06:42:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9339582605
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73795C0039;
	Thu, 26 Oct 2023 06:42:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB8CEC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 06:42:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A43E061085
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 06:42:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A43E061085
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=L09sFBce
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vlk3ZJbWsePq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 06:42:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A17A161084
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 06:42:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A17A161084
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698302558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YcSdpoUqOf2Z9R33aI1lokYDTHT4EyidLQqYg+ty5Po=;
 b=L09sFBcerO05jLJd8uhSxIhYebyT59RL1WbHQUzSjKqW30ZKpvcbgSXfV3eyMhyqV8x/k+
 d4fqCdYRgkbgw+/3UkQ5mLTeuGawG6AYdI2lyBuNok2kklz8y1D45uKm3D0jAaFpfEhhyB
 F0UhOScyWAuPJWGsLlgh8WgUYWv9R9Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-XnmSOviNOuuuuVYjO3NEeg-1; Thu, 26 Oct 2023 02:42:36 -0400
X-MC-Unique: XnmSOviNOuuuuVYjO3NEeg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32d933caa8eso281217f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 23:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698302555; x=1698907355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YcSdpoUqOf2Z9R33aI1lokYDTHT4EyidLQqYg+ty5Po=;
 b=BmEGD+FDoArIrs8YvfPHCVmm060y02V+43NIxjDU33Gx3XUN/EdP8E2hwgfS6JrSo1
 BNFeBCVmdmFvYmNhA3J2w5GXilkpFO6NF9Cpz6PI8r5j8o5y88eQvB3Wp0BLTUPzTpPI
 C59nDHGXbm4HaTtCNHAvo5JF/A4jjLvrlneczis9Pm0PYZcr1EzFH7ZVD1PH5ZtsLjVB
 362C8mhSeg9JpyrWSvvB6oS8LhsyVHOdlC6t/GqeWRbfW5bCy6rYn3DH2VsdngVQQ9aU
 YUmbCu5f99M1NfHEk3Gfjnf+8gNGzD/MVVsobzUczM9vxYdjHdQOXfKnH/SGgNviKOCa
 eOtQ==
X-Gm-Message-State: AOJu0YxCXcwHDcRZUDv/ferdMvOYZFTO+RHERQFi609Et6uQPhI5PBgb
 jQVtzqJp8IoKkIrng16wy7wUAbR7BwcIy1E0eC10MvjSD3RqlgdnJ31rghsGO/uMh0uUOEksD5L
 +nzfdwLCYK4sfmD6YVXbsB+pFMiRCEKJD9jX7jIDK9g==
X-Received: by 2002:adf:f346:0:b0:32d:b55c:41fa with SMTP id
 e6-20020adff346000000b0032db55c41famr11780963wrp.28.1698302555145; 
 Wed, 25 Oct 2023 23:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyERIAjDqKu0DYcUvMGZ5OQyQV1lKAaWBiouUmORp6s90/5p5CWf/xBYBrtM78ZcOrPN+XpQ==
X-Received: by 2002:adf:f346:0:b0:32d:b55c:41fa with SMTP id
 e6-20020adff346000000b0032db55c41famr11780951wrp.28.1698302554847; 
 Wed, 25 Oct 2023 23:42:34 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:3c98:7fa5:a31:81ed:a5e2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adfef10000000b0032d8354fb43sm13637693wro.76.2023.10.25.23.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 23:42:34 -0700 (PDT)
Date: Thu, 26 Oct 2023 02:42:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
Message-ID: <20231026024147-mutt-send-email-mst@kernel.org>
References: <20230923170540.1447301-1-lulu@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230923170540.1447301-1-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yi.l.liu@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com
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

On Sun, Sep 24, 2023 at 01:05:33AM +0800, Cindy Lu wrote:
> Hi All
> Really apologize for the delay, this is the draft RFC for
> iommufd support for vdpa, This code provides the basic function 
> for iommufd support 
> 
> The code was tested and passed in device vdpa_sim_net
> The qemu code is
> https://gitlab.com/lulu6/gitlabqemutmp/-/tree/iommufdRFC
> The kernel code is
> https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC
> 
> ToDo
> 1. this code is out of date and needs to clean and rebase on the latest code 
> 2. this code has some workaround, I Skip the check for
> iommu_group and CACHE_COHERENCY, also some misc issues like need to add
> mutex for iommfd operations 
> 3. only test in emulated device, other modes not tested yet
> 
> After addressed these problems I will send out a new version for RFC. I will
> provide the code in 3 weeks

What's the status here?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
