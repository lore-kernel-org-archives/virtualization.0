Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9584C0015E
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 18:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72D9C6124C;
	Wed, 26 Jul 2023 18:37:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72D9C6124C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=frgcLyLF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S14vzD622DLc; Wed, 26 Jul 2023 18:37:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 25E8060F23;
	Wed, 26 Jul 2023 18:37:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 25E8060F23
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAAECC0071;
	Wed, 26 Jul 2023 18:37:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04464C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 18:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BECAE8366E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 18:37:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BECAE8366E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=frgcLyLF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D4erZtGIjKZc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 18:37:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E134982F31
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 18:37:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E134982F31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690396626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IIAg2CLp9xDuIJyXx/zxbXpSOXSxiP7iZoyT0IErBLI=;
 b=frgcLyLF83l4Brb6PiGToei9WF0C33sh0m0jFSWKx7ZAkOz+TZ75727zqF8ptZy4utaTWe
 0mKoLHlYapHwxO01ThzwPLA9MzttdRkEnmgAskPKH79Lo5GSixOS65lkD1RuA25zbN5Qh2
 7NgrN0iDybMpYzEGj2kxMf+HlhrB3Jk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681--hUcDTBaM1qT3hR-fmlxzQ-1; Wed, 26 Jul 2023 14:37:05 -0400
X-MC-Unique: -hUcDTBaM1qT3hR-fmlxzQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbab56aac7so267825e9.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 11:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396624; x=1691001424;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IIAg2CLp9xDuIJyXx/zxbXpSOXSxiP7iZoyT0IErBLI=;
 b=ecmdBGi9gLe9YynwzWs0nXMGIMeSofYOvA+V7jtSoAxvUpgOi6G3l8rZicZPbuEN9g
 URiGWaTAMjrvBJPAa2lkmhN4ebaAEeI9uEGNQL5+Xw/szcq07nqbpGCr46uSWaHi1b3w
 JzMZr12Tdplv9a2+sjAEFELwXaqyHEi8/oamEh9JSXlBHwMPnErDT4B2wWXgoIIYou+s
 KpEWhK/j/K2pbWSXHC/tcHbyb/9E9ie7KP6DZkhAW8T81p3tyMILFl5lDD2PdKqRzzAZ
 nJMKDcQK6igqK9n74D7yIHq5ncd8H6teiDsDundoxcDW19AjaJtoS78ECLGwF+OClgWL
 7a7A==
X-Gm-Message-State: ABy/qLYrsEj7AjZs3G51qxtXz0m5AY74+3QAOnHWNCVyXZsQVCTCZ7oO
 tLxU3m+wATr6X4xzLogikX3st1jdYoLJiDyS/PNjsuCY7LXefqRPuoq4TsgXGZFyw097cXQz2cG
 uWrki4Wc1otDWhq9nGqBq0O5oSFR3KIFrHgyfpOOsUQ==
X-Received: by 2002:a5d:65d1:0:b0:317:5ed4:d821 with SMTP id
 e17-20020a5d65d1000000b003175ed4d821mr2198621wrw.55.1690396623962; 
 Wed, 26 Jul 2023 11:37:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEkeVse3g7BMmMqZZpW4iVmRF/VxccwoNYoG2x1Cq2HpC5/SgntUwQLeTxvRJYedmVt4ctsxA==
X-Received: by 2002:a5d:65d1:0:b0:317:5ed4:d821 with SMTP id
 e17-20020a5d65d1000000b003175ed4d821mr2198606wrw.55.1690396623611; 
 Wed, 26 Jul 2023 11:37:03 -0700 (PDT)
Received: from redhat.com ([2.52.14.22]) by smtp.gmail.com with ESMTPSA id
 s25-20020a056402165900b0052229d203a4sm4971784edx.36.2023.07.26.11.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:37:01 -0700 (PDT)
Date: Wed, 26 Jul 2023 14:36:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH 0/2] vdpa: Enable strict validation for netlink ops
Message-ID: <20230726143640-mutt-send-email-mst@kernel.org>
References: <20230726183054.10761-1-dtatulea@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230726183054.10761-1-dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Lin Ma <linma@zju.edu.cn>
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

On Wed, Jul 26, 2023 at 09:30:48PM +0300, Dragos Tatulea wrote:
> The original patch from Lin Ma enables the vdpa driver to use validation
> netlink ops.
> 
> The second patch simply disables the validation skip which is no longer
> neccesary. Patchset started of from this discussion [0].
> 
> [0] https://lore.kernel.org/virtualization/20230726074710-mutt-send-email-mst@kernel.org/T/#t

Cc stable with at least 1/2 ?

> Dragos Tatulea (1):
>   vdpa: Enable strict validation for netlinks ops
> 
> Lin Ma (1):
>   vdpa: Complement vdpa_nl_policy for nlattr length check
> 
>  drivers/vdpa/vdpa.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> -- 
> 2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
