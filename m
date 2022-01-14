Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F079CC433FE
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 23:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 867ED415B8;
	Fri, 14 Jan 2022 23:58:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 769CQDUgwanL; Fri, 14 Jan 2022 23:58:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 333B1410BE;
	Fri, 14 Jan 2022 23:58:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C89CC002F;
	Fri, 14 Jan 2022 23:58:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49EAFC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 23:58:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27E3C410D8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 23:58:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gxrRqVkbJImJ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 23:58:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBB4A410BE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 23:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642204711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z96rFxjaZq03HF+/4vSJxCOyIeHO3mdhR6fuB13CdmU=;
 b=Ulcq29WqJT6meBAZAorRupUx5xbw6/cifjPH5jzJh5f3xmvzuCCy4DO0YepZO7BN072ipw
 xIkQpQfItsNcHS89jC9L1E5ChL/b7poI/WF+MHO34dYJ2vgMDmtlBjNNDQMn8B9LwMr1uB
 NhM3dCKGkZ6+ohGhCPy5wjLOzj58p20=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-DZOwCZFxPhie4kGR0Gsvzg-1; Fri, 14 Jan 2022 18:58:30 -0500
X-MC-Unique: DZOwCZFxPhie4kGR0Gsvzg-1
Received: by mail-ed1-f72.google.com with SMTP id
 q15-20020a056402518f00b003f87abf9c37so9458908edd.15
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 15:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Z96rFxjaZq03HF+/4vSJxCOyIeHO3mdhR6fuB13CdmU=;
 b=FId/XVxFNeQp/zJD5tNQYNDYqLuUp8uCgB4PqcbB9SRHDLnuYVLY1S9HPMUDnJkW1p
 5TeoFsgDBIY9BSogL4oWUO8poQT4Zxq6jcGwqjDGI2Mm1JIBNF3FHT76wKPeNz05KgmV
 NOP1PMwr/IV7HSqsdrub7gzOBQQPC63uHKkVGxLKu7LWRJRK5d4u0/wG3+zru0Z1a9EV
 wK4uCGhQCJKs7kqN/q67J4sQj1crWZiI6vL8ft+83491lWrLXFzA/MXdTJPsOPM/3X9s
 JrECsTzneRs0xPOXWx3U/X41RWkUVi9OijBVzLehtctqkO07d75wEooRSUsI7OKhupzy
 eOHQ==
X-Gm-Message-State: AOAM5310/K0b9koBxURDZaT6D3qb2z7+18VyoimXNd0vwdhsDK59zQJC
 Bb4g1p9LYBP1xRj8VlEpx+yDoMz8FDiHH5f2N8jAr3f7Sf3ijGfULhzq7FfaAt+Nmv6s2+xhSo5
 73ocN+gv+RferdWxtSBHBoQX40CnZR+AsUcztIVHAew==
X-Received: by 2002:a17:907:2d0c:: with SMTP id
 gs12mr8944392ejc.4.1642204709514; 
 Fri, 14 Jan 2022 15:58:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxW2fvrNZm9/TYOc8HE5c1s8HuiVecialuIVfXhWTkeTLHQJd93BZCE8SXVRzIjzngp0E7DEQ==
X-Received: by 2002:a17:907:2d0c:: with SMTP id
 gs12mr8944357ejc.4.1642204709309; 
 Fri, 14 Jan 2022 15:58:29 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
 by smtp.gmail.com with ESMTPSA id f27sm1466917ejd.95.2022.01.14.15.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 15:58:28 -0800 (PST)
Date: Fri, 14 Jan 2022 18:58:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [GIT PULL] virtio,vdpa,qemu_fw_cfg: features, cleanups, fixes
Message-ID: <20220114185801-mutt-send-email-mst@kernel.org>
References: <20220114153515-mutt-send-email-mst@kernel.org>
 <YeHjbqjY8Dd+3o1E@larix>
MIME-Version: 1.0
In-Reply-To: <YeHjbqjY8Dd+3o1E@larix>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yun.wang@linux.alibaba.com, kvm@vger.kernel.org, trix@redhat.com,
 flyingpeng@tencent.com, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, guanjun@linux.alibaba.com, lkp@intel.com,
 xianting.tian@linux.alibaba.com, pasic@linux.ibm.com, eperezma@redhat.com,
 luolikang@nsfocus.com, wu000273@umn.edu, lvivier@redhat.com,
 keescook@chromium.org, somlo@cmu.edu, jiasheng@iscas.ac.cn, johan@kernel.org,
 christophe.jaillet@wanadoo.fr, flyingpenghao@gmail.com, dapeng1.mi@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, labbott@kernel.org,
 gregkh@linuxfoundation.org, lingshan.zhu@intel.com,
 Linus Torvalds <torvalds@linux-foundation.org>
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

On Fri, Jan 14, 2022 at 08:56:14PM +0000, Jean-Philippe Brucker wrote:
> Hi,
> 
> On Fri, Jan 14, 2022 at 03:35:15PM -0500, Michael S. Tsirkin wrote:
> > Jean-Philippe Brucker (5):
> >       iommu/virtio: Add definitions for VIRTIO_IOMMU_F_BYPASS_CONFIG
> >       iommu/virtio: Support bypass domains
> >       iommu/virtio: Sort reserved regions
> >       iommu/virtio: Pass end address to viommu_add_mapping()
> >       iommu/virtio: Support identity-mapped domains
> 
> Please could you drop these patches, they are from an old version of the
> series. The newer version was already in Joerg's pull request and was
> merged, so this will conflict.
> 
> Thanks,
> Jean

I just sent v2 without your changes, thanks.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
