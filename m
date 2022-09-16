Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7F9C6FA86
	for <virtualization@archiver.kernel.org>; Fri, 16 Sep 2022 11:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ABC2B40017;
	Fri, 16 Sep 2022 11:56:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ABC2B40017
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dFabAYtx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wNeUgy2RuSNW; Fri, 16 Sep 2022 11:56:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1463540B00;
	Fri, 16 Sep 2022 11:56:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1463540B00
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4580C0033;
	Fri, 16 Sep 2022 11:56:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FC30C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 11:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 250EF6121B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 11:56:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 250EF6121B
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=dFabAYtx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1zsVwAky5eXo
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 11:56:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 270906120B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 270906120B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 11:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663329406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=chTOa9nfsN85Mo0aKyNtpBSHWBBmRSbzW50vElTD5ws=;
 b=dFabAYtx4s4mOVWC0ZZKRNvBFn9HjXIKJHJAGEHo/oVtoIQYJDV1rW2rnGqQi8LGan/tvG
 DYBvVyDNExpUJ5ydIcMGX4nVUSY6TvWGfs/p4FFB8WCS9OpBehAW2sJLKg7BQZNH4f5xKD
 SVa3tyRBs/ICbKhLXQ9kglsAhVlXIUg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-462-wrntvUFVOo-uuV_DMJPIPQ-1; Fri, 16 Sep 2022 07:56:43 -0400
X-MC-Unique: wrntvUFVOo-uuV_DMJPIPQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 e8-20020ac85988000000b0035c39dd5eb9so8423171qte.16
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 04:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=chTOa9nfsN85Mo0aKyNtpBSHWBBmRSbzW50vElTD5ws=;
 b=4vpC6ovCFyGxOElQc/1y5zoUN1rrxHyPGr9xRg28FEe6u9BOqresQzectnqg0g9IlE
 S4Lnq0af48En4ND6kX0xHRIAwIYrUVbJyTo1US1az+ej908uYcMT4xBnd9IPIcy+l28z
 SApClUmbaCTKNigZvPkNjryqapjVTqizvMriXa3SNz4gQtbdbYaNiACE10vE9RI5I6Cl
 yHoZF23oUtHmrUGH14Q85vpOCPsEKFUOQZ9Ob6yEQHtrs++/aNczROvM6UYqFzSIMzGh
 H36ntiAf5VAhFYYAWbmbofoJgr6pJ7fLaKY1V8/QG/W5R+hrIjUM47EYH2rRY0yox9d0
 yU0Q==
X-Gm-Message-State: ACrzQf1Vk+/myhupOBEagrCUtzpwtzJE3BudOFvKIiQ120l288ewuXSO
 nI+cs7G1gCE3IFPCF5/c9mWZtW19lEVDP83f6Qe7byOSKmdH/oiPHEE7QGGcZva3mKN24GL70hj
 bVxGfKbiNxbtzf525oBb1ZoL91dfCtL/s2dLaJXOhvA==
X-Received: by 2002:a05:622a:1a96:b0:35b:b868:fb1 with SMTP id
 s22-20020a05622a1a9600b0035bb8680fb1mr3907080qtc.116.1663329403269; 
 Fri, 16 Sep 2022 04:56:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM61rQguxip3VopENuW5BChfGUPbrsDyfGFwkeqvgW8D2mtv8HxW9f+7RmfWCZydcsFZ19h22g==
X-Received: by 2002:a05:622a:1a96:b0:35b:b868:fb1 with SMTP id
 s22-20020a05622a1a9600b0035bb8680fb1mr3907066qtc.116.1663329403013; 
 Fri, 16 Sep 2022 04:56:43 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a05620a20d000b006b95b0a714esm5498036qka.17.2022.09.16.04.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Sep 2022 04:56:42 -0700 (PDT)
Date: Fri, 16 Sep 2022 07:56:39 -0400
From: Brian Foster <bfoster@redhat.com>
To: Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: Re: [PATCH RFC 4/8] fs: Introduce FALLOC_FL_PROVISION
Message-ID: <YyRkd8YAH1lal8/N@bfoster>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-5-sarthakkukreti@google.com>
MIME-Version: 1.0
In-Reply-To: <20220915164826.1396245-5-sarthakkukreti@google.com>
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

On Thu, Sep 15, 2022 at 09:48:22AM -0700, Sarthak Kukreti wrote:
> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> 
> FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> sends a hint to (supported) thinly provisioned block devices to
> allocate space for the given range of sectors via REQ_OP_PROVISION.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  block/fops.c                | 7 ++++++-
>  include/linux/falloc.h      | 3 ++-
>  include/uapi/linux/falloc.h | 8 ++++++++
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index b90742595317..a436a7596508 100644
> --- a/block/fops.c
> +++ b/block/fops.c
...
> @@ -661,6 +662,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
>  					     len >> SECTOR_SHIFT, GFP_KERNEL);
>  		break;
> +	case FALLOC_FL_PROVISION:
> +		error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
> +					       len >> SECTOR_SHIFT, GFP_KERNEL);
> +		break;
>  	default:
>  		error = -EOPNOTSUPP;
>  	}

Hi Sarthak,

Neat mechanism.. I played with something very similar in the past (that
was much more crudely hacked up to target dm-thin) to allow filesystems
to request a thinly provisioned device to allocate blocks and try to do
a better job of avoiding inactivation when overprovisioned.

One thing I'm a little curious about here.. what's the need for a new
fallocate mode? On a cursory glance, the provision mode looks fairly
analogous to normal (mode == 0) allocation mode with the exception of
sending the request down to the bdev. blkdev_fallocate() already maps
some of the logical falloc modes (i.e. punch hole, zero range) to
sending write sames or discards, etc., and it doesn't currently look
like it supports allocation mode, so could it not map such requests to
the underlying REQ_OP_PROVISION op?

I guess the difference would be at the filesystem level where we'd
probably need to rely on a mount option or some such to control whether
traditional fallocate issues provision ops (like you've implemented for
ext4) vs. the specific falloc command, but that seems fairly consistent
with historical punch hole/discard behavior too. Hm? You might want to
cc linux-fsdevel in future posts in any event to get some more feedback
on how other filesystems might want to interact with such a thing.

BTW another thing that might be useful wrt to dm-thin is to support
FALLOC_FL_UNSHARE. I.e., it looks like the previous dm-thin patch only
checks that blocks are allocated, but not whether those blocks are
shared (re: lookup_result.shared). It might be useful to do the COW in
such cases if the caller passes down a REQ_UNSHARE or some such flag.

Brian

> diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> index f3f0b97b1675..a0e506255b20 100644
> --- a/include/linux/falloc.h
> +++ b/include/linux/falloc.h
> @@ -30,7 +30,8 @@ struct space_resv {
>  					 FALLOC_FL_COLLAPSE_RANGE |	\
>  					 FALLOC_FL_ZERO_RANGE |		\
>  					 FALLOC_FL_INSERT_RANGE |	\
> -					 FALLOC_FL_UNSHARE_RANGE)
> +					 FALLOC_FL_UNSHARE_RANGE |                          \
> +					 FALLOC_FL_PROVISION)
>  
>  /* on ia32 l_start is on a 32-bit boundary */
>  #if defined(CONFIG_X86_64)
> diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> index 51398fa57f6c..2d323d113eed 100644
> --- a/include/uapi/linux/falloc.h
> +++ b/include/uapi/linux/falloc.h
> @@ -77,4 +77,12 @@
>   */
>  #define FALLOC_FL_UNSHARE_RANGE		0x40
>  
> +/*
> + * FALLOC_FL_PROVISION acts as a hint for thinly provisioned devices to allocate
> + * blocks for the range/EOF.
> + *
> + * FALLOC_FL_PROVISION can only be used with allocate-mode fallocate.
> + */
> +#define FALLOC_FL_PROVISION		0x80
> +
>  #endif /* _UAPI_FALLOC_H_ */
> -- 
> 2.31.0
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
