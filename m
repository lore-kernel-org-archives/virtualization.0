Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D84C43460
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 08:12:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54586113D
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 08:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54586113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 675F560D78;
	Thu, 15 Apr 2021 08:12:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tn2sVdhQs6Zh; Thu, 15 Apr 2021 08:12:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CC9E60815;
	Thu, 15 Apr 2021 08:12:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C90DBC000C;
	Thu, 15 Apr 2021 08:12:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94190C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74CA3846D2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:12:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CrBrEpJjJMRR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:12:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 72D68846CC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618474363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uok685ar2aRiyh2dl0JSULm/jJ/D8RgjO+Fo8IDWGJU=;
 b=F1to4fHkRSVSwCWgacu5lLLKwN53UwxsnpIAdY0hTCv/QAM1elIzrq3wBhvrvHKo9DXvH3
 sTaI41Bk7MUjaptBL4XNjnUfymUgqM7b+JrkfKnuTtVtFMUHCE9nXolJQgd0UP0RTqQKDC
 5Ln2gQ4zsGjpSC1taUbfV6Baq/n+uCQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-FHDTUNtcOouJONXiYEZL8Q-1; Thu, 15 Apr 2021 04:12:40 -0400
X-MC-Unique: FHDTUNtcOouJONXiYEZL8Q-1
Received: by mail-ed1-f71.google.com with SMTP id
 d27-20020a50f69b0000b02903827b61b783so4786062edn.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 01:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Uok685ar2aRiyh2dl0JSULm/jJ/D8RgjO+Fo8IDWGJU=;
 b=b0giwoqQwRkkz2creZb3Wrwgc8CDj/en6CdEsnhOZUzQd9znuny/IDMqDz9yPTTgyv
 pJDe+tnaDhSx7M+JogMm9HWakLEERB1xR6AIJLtPjHfTTpEO6RCc7P/NyQRLAb1hHv/H
 x7yHfRq8dYt8RHURECo3hhSnbipGCsmijRcPBebRABs/irAY+34iSHUzx1MtQDi+O959
 xeZtbTpCl/ywXNQw+YiE6HsP965DCsl5bjvHo3XcVaOt4X8Ah/BWisQzdQ4YtGtgXGOX
 2OI/Uz+F3mn/QfWTepIPtqc2PBfTvKWqO7yTs5J31suNtcH/chhGbWpd6q8LVoepwT5J
 M5Mw==
X-Gm-Message-State: AOAM5318wM5hAVBIVslmPyBW/Al8PMeSSi4Asscrw3duAcvDgJAuA9i9
 FC0MizJmwn1B9LehKs4w5KJih7Y8P3eVZG0kF+LKD0a6dCXZX5q8oXDC7lRSQI/O4ZW2asWKmmb
 is9PZIBdWnOWWuyw3xVc2RbKt6utQoRI49Sb7IlR+mg==
X-Received: by 2002:a17:906:d110:: with SMTP id
 b16mr2182978ejz.146.1618474358962; 
 Thu, 15 Apr 2021 01:12:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/ODVdHnATxPBtkndhJ7egTCylTFfXw5aTQ3MS4uE7R4xjYS19p1A2QjPyN6E/lbnVqiSGRg==
X-Received: by 2002:a17:906:d110:: with SMTP id
 b16mr2182957ejz.146.1618474358784; 
 Thu, 15 Apr 2021 01:12:38 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id w13sm911888edx.80.2021.04.15.01.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 01:12:38 -0700 (PDT)
Date: Thu, 15 Apr 2021 10:12:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH 3/3] vDPA/ifcvf: get_config_size should return dev
 specific config size
Message-ID: <20210415081236.anbssqtsyjnmiaby@steredhat>
References: <20210414091832.5132-1-lingshan.zhu@intel.com>
 <20210414091832.5132-4-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20210414091832.5132-4-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, lulu@redhat.com, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, leonro@nvidia.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Apr 14, 2021 at 05:18:32PM +0800, Zhu Lingshan wrote:
>get_config_size() should return the size based on the decected
>device type.
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>---
> drivers/vdpa/ifcvf/ifcvf_main.c | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>index 9b6a38b798fa..b48b9789b69e 100644
>--- a/drivers/vdpa/ifcvf/ifcvf_main.c
>+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>@@ -347,7 +347,16 @@ static u32 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
>
> static size_t ifcvf_vdpa_get_config_size(struct vdpa_device *vdpa_dev)
> {
>-	return sizeof(struct virtio_net_config);
>+	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>+	size_t size;
>+
>+	if (vf->dev_type == VIRTIO_ID_NET)
>+		size = sizeof(struct virtio_net_config);
>+
>+	if (vf->dev_type == VIRTIO_ID_BLOCK)
>+		size = sizeof(struct virtio_blk_config);
>+
>+	return size;

I'm not familiar with the ifcvf details, but can it happen that the 
device is not block or net?

Should we set `size` to 0 by default to handle this case or are we sure 
it's one of the two?

Maybe we should add a comment or a warning message in this case, to 
prevent some analysis tool or compiler from worrying that `size` might 
be uninitialized.

I was thinking something like this:

	switch(vf->dev_type) {
	case VIRTIO_ID_NET:
		size = sizeof(struct virtio_net_config);
		break;
	case VIRTIO_ID_BLOCK:
		size = sizeof(struct virtio_blk_config);
		break;
	default:
		/* or WARN(1, "") if dev_warn() not apply */
		dev_warn(... , "virtio ID [0x%x] not supported\n")
		size = 0;

	}

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
