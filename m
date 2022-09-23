Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B015C6FA82
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 15:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F38C083E3E;
	Fri, 23 Sep 2022 15:15:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F38C083E3E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bFBFyrGJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M7jpJRsmBsrf; Fri, 23 Sep 2022 15:15:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7B9C483443;
	Fri, 23 Sep 2022 15:15:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B9C483443
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E710C0033;
	Fri, 23 Sep 2022 15:15:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55B53C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 15:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3000460FE2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 15:15:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3000460FE2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bFBFyrGJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JJkgVwPN-NVW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 15:15:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE94961118
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE94961118
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 15:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663946108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i/7qErjHQwpjdxeuxG56UOY53/Pb3ceXUixswzrpqTk=;
 b=bFBFyrGJUWMRmMxQa1IWFql0ZOi36fAqmXNFYBD2AqxN0IGNlLlB6ZsBVYjErT8abruYl4
 hs8yrfeK/BXujeLGn3BX+RPGUGW5sx5lfESinS/GuarSlOoYTJ65+S6z6H3uk1OtnZCeWo
 onUxdw3ygOUJUFcp0wQi3kjVr5agmE8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-185-rxk9ZzNSNzmIm7heG_pv9g-1; Fri, 23 Sep 2022 11:15:07 -0400
X-MC-Unique: rxk9ZzNSNzmIm7heG_pv9g-1
Received: by mail-qk1-f199.google.com with SMTP id
 de16-20020a05620a371000b006ceb92bc740so219368qkb.15
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 08:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=i/7qErjHQwpjdxeuxG56UOY53/Pb3ceXUixswzrpqTk=;
 b=0Ay2/mLLbxC3yjftpQFVgzAl2bkiR0UErN19LbGvrQ183eOPmR4tXA2KCkeJkui/xx
 5v+zxxF0xjEQOIp8ZHr7W7MFZMtpLFDZGAMPAfM2/r8OiX0fflY/HYIRKhxYL9ytBRQn
 SmkLTCa+3diyE/fpaNaE1je49KMpvxwdVL8Ze2mMZ06SqCeTxd39hgtG5xqRirIqXbIl
 0LReYOJICJYdy7JQkAtftgaabzrTxmufx2tQ0qC2AAk0OG9RDwMWNT0ixDhgJA+s8Lpv
 +OWpoVm6lHDTWLUMhS+NDjOu06OA/3jgV33lX1WCrTGkjb57PoQbfxfoIvqnDfD08/yo
 pWEQ==
X-Gm-Message-State: ACrzQf1c0ZLgbBkTMG7HRNpeDqp8H+YGhK/uk+ZDe5SMZ718TYmoRBuu
 SdhPBLNKDcJFriBjzuW37SUOPGqutzANGgdUfyD5Nmc1BCq7FRMdpIFXI+DUbGpz/phwaosM2pN
 dBLpRDj2MbR+Vh2SoQ6arWkNnXSRDPrw2tWECO7t5
X-Received: by 2002:a05:6214:76b:b0:4ac:be62:d2e5 with SMTP id
 f11-20020a056214076b00b004acbe62d2e5mr7176242qvz.91.1663946106773; 
 Fri, 23 Sep 2022 08:15:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Jg5JqThdy0P5kS2uSLUoQ3+kfdp9Ppg4QGXjxFRDk5XYyybGVmtH43Lh/lTr6N1EDYoCkpg==
X-Received: by 2002:a05:6214:76b:b0:4ac:be62:d2e5 with SMTP id
 f11-20020a056214076b00b004acbe62d2e5mr7176213qvz.91.1663946106592; 
 Fri, 23 Sep 2022 08:15:06 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net.
 [68.160.173.162]) by smtp.gmail.com with ESMTPSA id
 g12-20020ac8468c000000b0035cb9531851sm5432876qto.65.2022.09.23.08.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Sep 2022 08:15:06 -0700 (PDT)
Date: Fri, 23 Sep 2022 11:15:05 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: Re: [PATCH RFC 1/8] block: Introduce provisioning primitives
Message-ID: <Yy3NeY02zEMLTdsa@redhat.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-2-sarthakkukreti@google.com>
MIME-Version: 1.0
In-Reply-To: <20220915164826.1396245-2-sarthakkukreti@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Gwendal Grignou <gwendal@google.com>,
 Theodore Ts'o <tytso@mit.edu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Bart Van Assche <bvanassche@google.com>, Mike Snitzer <snitzer@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Andreas Dilger <adilger.kernel@dilger.ca>, Daniil Lunev <dlunev@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-ext4@vger.kernel.org, Evan Green <evgreen@google.com>,
 Alasdair Kergon <agk@redhat.com>
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

On Thu, Sep 15 2022 at 12:48P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> 
> Introduce block request REQ_OP_PROVISION. The intent of this request
> is to request underlying storage to preallocate disk space for the given
> block range. Block device that support this capability will export
> a provision limit within their request queues.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  block/blk-core.c          |  5 ++++
>  block/blk-lib.c           | 55 +++++++++++++++++++++++++++++++++++++++
>  block/blk-merge.c         | 17 ++++++++++++
>  block/blk-settings.c      | 19 ++++++++++++++
>  block/blk-sysfs.c         |  8 ++++++
>  block/bounce.c            |  1 +
>  include/linux/bio.h       |  6 +++--
>  include/linux/blk_types.h |  5 +++-
>  include/linux/blkdev.h    | 16 ++++++++++++
>  9 files changed, 129 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 8bb9eef5310e..be79ad68b330 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -57,6 +57,7 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->misaligned = 0;
>  	lim->zoned = BLK_ZONED_NONE;
>  	lim->zone_write_granularity = 0;
> +	lim->max_provision_sectors = 0;
>  }
>  EXPORT_SYMBOL(blk_set_default_limits);
>  
> @@ -81,6 +82,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
>  	lim->max_dev_sectors = UINT_MAX;
>  	lim->max_write_zeroes_sectors = UINT_MAX;
>  	lim->max_zone_append_sectors = UINT_MAX;
> +	lim->max_provision_sectors = UINT_MAX;
>  }
>  EXPORT_SYMBOL(blk_set_stacking_limits);
>  

Please work through the blk_stack_limits() implementation too (simple
min_not_zero?).

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
