Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6E9C433F5
	for <virtualization@archiver.kernel.org>; Tue, 30 Nov 2021 09:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE95F81D7C;
	Tue, 30 Nov 2021 09:32:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xm4SO6ZWdGJE; Tue, 30 Nov 2021 09:32:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A48DF81B25;
	Tue, 30 Nov 2021 09:32:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60E4BC001C;
	Tue, 30 Nov 2021 09:32:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6EF0C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 09:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95CC240155
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 09:32:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iYp5890NWhOO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 09:32:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA47240114
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 09:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638264756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=95/wbwyuxE7DzbjpYWIIgT2MISDRD/0Z2RLccr1nMBk=;
 b=RwPrBlT8uXK8jPze6JfTHBKWSWLyoXrC/2mTsTQiA31SB2/EUk2QCUJXPhTpduq6BZcOrZ
 x2hkGGcEMA7n7kTOjQ0QTzxGYKkjzrjuNLKLjSPuzqCUFiUumokqcWNgS48/tbkTcT8OZP
 vwpODXhV0WhQJwuapShLFoDAW48SJRQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-jYKXw_I5OwaJsqpdYLpCfw-1; Tue, 30 Nov 2021 04:32:34 -0500
X-MC-Unique: jYKXw_I5OwaJsqpdYLpCfw-1
Received: by mail-ed1-f70.google.com with SMTP id
 w18-20020a056402071200b003e61cbafdb4so16413066edx.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 01:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=95/wbwyuxE7DzbjpYWIIgT2MISDRD/0Z2RLccr1nMBk=;
 b=1Q88qQbdFGYOa8gaP/wHdVr1GslKQ2fP9v/5u/cObIWOG7VtNDsqwdwfp+YRrT3luP
 NZqEm2BiPxwmjfxYogHw/8ge6u+bky+7IGRlCHl4B4TsBF6IDdMB9S4ISVmVU0ds7YMt
 7WUJrRaplBzCjPDud6oyi/yE0oBqKDRKAR06ViKXC4TKrqlaxFzN+B1Zke4GUWOtbnAF
 FDUOD1SlecupphBuZ2SluHMIaS93h5HBPCe4TYTA7Ua1ebJWkFB/lAdTYkaEAoR5V5C/
 vXU7QI7osjum27YDXgkeElFmHp+4DBZESIiz/Mm8ZBesUU19xMDyH5/VJsBKJ5gzcXvF
 hdRA==
X-Gm-Message-State: AOAM533XZIl+2Woi7JNE7R9wY+4Lyg1OrmWJ3LqHuiBNgKrRGpQY/wRL
 nosn/qbLSkNilwQksBy1BnH50RfkntOj3a/wnppvRYV44z1quc6a9NQpQTX5tN/P0MIOINCSutw
 6V8uvwlokn7C3HgoC3ezf4hnRsG0TQsMGDNP26iXtPQ==
X-Received: by 2002:a05:6402:4413:: with SMTP id
 y19mr80697594eda.26.1638264753186; 
 Tue, 30 Nov 2021 01:32:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDmTv7P796/A2e4IqQPa36J8ENyP8CCY9GhkFhEgsEHepB5C2PoVkKOSzCqO+t0lSL2tloFw==
X-Received: by 2002:a05:6402:4413:: with SMTP id
 y19mr80697562eda.26.1638264752958; 
 Tue, 30 Nov 2021 01:32:32 -0800 (PST)
Received: from steredhat (host-79-46-195-175.retail.telecomitalia.it.
 [79.46.195.175])
 by smtp.gmail.com with ESMTPSA id gz10sm8564363ejc.38.2021.11.30.01.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Nov 2021 01:32:32 -0800 (PST)
Date: Tue, 30 Nov 2021 10:32:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH] ifcvf/vDPA: fix misuse virtio-net device config size for
 blk dev
Message-ID: <20211130093228.iiz2r43e7mcgecnk@steredhat>
References: <20211129093144.8033-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20211129093144.8033-1-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Nov 29, 2021 at 05:31:44PM +0800, Zhu Lingshan wrote:
>This commit fixes a misuse of virtio-net device config size issue
>for virtio-block devices.
>
>A new member config_size in struct ifcvf_hw is introduced and would
>be initialized through vdpa_dev_add() to record correct device
>config size.
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>Reported-and-suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Fixes: 6ad31d162a4e ("vDPA/ifcvf: enable Intel C5000X-PL virtio-block for vDPA")
>Cc: <stable@vger.kernel.org>
>---
> drivers/vdpa/ifcvf/ifcvf_base.c | 41 +++++++++++++++++++++++++--------
> drivers/vdpa/ifcvf/ifcvf_base.h |  9 +++++---
> drivers/vdpa/ifcvf/ifcvf_main.c | 24 ++++---------------
> 3 files changed, 41 insertions(+), 33 deletions(-)

The patch LGTM. Maybe we could add in the description that we rename 
some fields and functions in a more generic way.

In both cases:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
