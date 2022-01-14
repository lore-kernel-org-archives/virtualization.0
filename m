Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB974C433EF
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 20:56:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3EE7883E4F;
	Fri, 14 Jan 2022 20:56:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1UnVFcGpA4or; Fri, 14 Jan 2022 20:56:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DA57E83E2A;
	Fri, 14 Jan 2022 20:56:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BADCAC0030;
	Fri, 14 Jan 2022 20:56:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68DDCC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 20:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3DBC0416EC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 20:56:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id icXwht9zt8uz
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 20:56:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C1F9416EB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 20:56:18 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 l12-20020a7bc34c000000b003467c58cbdfso9381378wmj.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 12:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=a2LK+XCzRUQuX/FKJ8hTnpMWPOfnbChf1uqBe6evn14=;
 b=TatznFHqz4q/JNQk6ZcSu00tRi1lJns+grkgt68v4JlRwWUwEWskbD7Eo1/QtiimJb
 2DsQk8udeSaRNeTIxoGMeKXeBZLrdk5C8MmBA4y49hugKr6IyKWjGfjAL5lix6bsA8YK
 ulzIzHwIN6eFqCez+iFzFoHBlMIrO4dXddOB4EumZ7hYABe22bNEHQyiXlH2ZL2a1DS4
 d/xnj0pe6mNUK9HfdoYjZ/VFHGZuZpM3k77VpECd0aRmjZop+vebKg17agfiYCAZxTlm
 IYmfdW7BsxqYNuk4Fh3pl1C5qn2hoPNWzFvLJ5AmgrMfDaJ/Bt2nismRmwww3tSSzu+R
 r6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a2LK+XCzRUQuX/FKJ8hTnpMWPOfnbChf1uqBe6evn14=;
 b=CjXc0aGFucINoeylMRRHhaRZCipkR6CyzkMd8k2b/Yw81AR85ChZ2Lfxj99xXYF67A
 EBGG1y6Jxfr+TxA6j7xT6NQn4WIAgG9Bit+Vj3R2wM3acV4XqmRiPwzW1ieO11HCVdUW
 Ni1uGAhq7oom0Oez0niga6+iI5C49CcaAaGyWUedYlh81tViQoZWLSHcdA1nC5lSFlN3
 w/OG2hq09g7boZ5XvjQJRlDeFt7R0VqHrQrvz0nX0ziPtwI3DV+VCPOwuQsW2C4EJF66
 kdK4MoXWhz7DcTcPV7jtb9bPQbqerAHGqXHJFY9UMmr9m8qx8H4T3EBWrOj92SJCodGa
 cB4Q==
X-Gm-Message-State: AOAM532kZiw6S5lGyydGTnUgQRgn8X2KTXRe17SvAMRmFYNNag9lv8eI
 Lr7XvcpviqvE2ccFjm8N8c8ioQ==
X-Google-Smtp-Source: ABdhPJxEOp2Wo1ezLBKMdg3Rs8D9/4m/Bwa6/dloggb4D57MyDeWhvpnWUAVCmPkdzXMY6R9wWCD9A==
X-Received: by 2002:a1c:1d17:: with SMTP id d23mr9767788wmd.46.1642193777164; 
 Fri, 14 Jan 2022 12:56:17 -0800 (PST)
Received: from larix (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id p62sm6050452wmp.10.2022.01.14.12.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 12:56:16 -0800 (PST)
Date: Fri, 14 Jan 2022 20:56:14 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [GIT PULL] virtio,vdpa,qemu_fw_cfg: features, cleanups, fixes
Message-ID: <YeHjbqjY8Dd+3o1E@larix>
References: <20220114153515-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220114153515-mutt-send-email-mst@kernel.org>
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

Hi,

On Fri, Jan 14, 2022 at 03:35:15PM -0500, Michael S. Tsirkin wrote:
> Jean-Philippe Brucker (5):
>       iommu/virtio: Add definitions for VIRTIO_IOMMU_F_BYPASS_CONFIG
>       iommu/virtio: Support bypass domains
>       iommu/virtio: Sort reserved regions
>       iommu/virtio: Pass end address to viommu_add_mapping()
>       iommu/virtio: Support identity-mapped domains

Please could you drop these patches, they are from an old version of the
series. The newer version was already in Joerg's pull request and was
merged, so this will conflict.

Thanks,
Jean

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
