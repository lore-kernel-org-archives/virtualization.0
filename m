Return-Path: <SRS0=D/xy=H6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865F3C433DB
	for <virtualization@archiver.kernel.org>; Sun, 28 Feb 2021 21:35:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25CDE64E62
	for <virtualization@archiver.kernel.org>; Sun, 28 Feb 2021 21:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CDE64E62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D928E434D7;
	Sun, 28 Feb 2021 21:35:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y4lwzAtdJtqz; Sun, 28 Feb 2021 21:35:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 861224301D;
	Sun, 28 Feb 2021 21:35:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53920C000A;
	Sun, 28 Feb 2021 21:35:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBFCDC0001
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 21:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6E714EE75
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 21:35:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kn6i1CN5s0uo
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 21:35:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0987C4DF7C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 21:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614548099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ReI9nC5t0ilGJKO9iEAq6ntFlruOaE8Rz2Sr5GLVUJo=;
 b=Hm330mEl0HmLWRDSjiGWPTI+Ji90yV+g5IW3uZCqQqflFQy59EzDK1OadFZ32R2lQus2zQ
 mxeDp8lIhI9l9hQLSPXOIFeOXBY9STuLWZzl1iqEmMHdw/Ez61quNhLUixZ0I63MY/FQQW
 3ZTDPrjSV/JvZrJN06mOOGXJOSFH1s0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-28sbHo5nNhuEw2yy0SF4vA-1; Sun, 28 Feb 2021 16:34:57 -0500
X-MC-Unique: 28sbHo5nNhuEw2yy0SF4vA-1
Received: by mail-ej1-f70.google.com with SMTP id v10so5642216ejh.15
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 13:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ReI9nC5t0ilGJKO9iEAq6ntFlruOaE8Rz2Sr5GLVUJo=;
 b=ZfFohPKlni5XpSod8PNyG2RXBjF0hBzJxHhodZTgj1gX4wl9d1R+UzB0p2T60cVhOW
 x96Y87dsBGBkmzyrWcTnRDHlHXh9Px2nqlOdnlQxEv4UNWHo4LwmYtt2LY3gAESr47Ih
 6bRDgrCqTKONJJpA4s9mhQ/OXoV3bl9A9VNzegZWDi2dddDc1b56ytYHN3lLjHAk1i8Z
 an9MvYovq7a6N3x7vEvQKvZ8dXWJGtWkLmUbgN3CfIgKoXQd4pD5rWyfmlhkAYpp6yqU
 rVYht9inobLxBxO0MS4rEM+FTTpu2kyZ3lx4qFglvnKebBNY7Ly/iDtDSbwPCisH0WJA
 hZrQ==
X-Gm-Message-State: AOAM531jModGDhPgP2B2hRIQOWTPiZk2ggPUAdfPnAOHfVQia8HE4kQu
 x5/jFwJdza0usqzGK81XJIY1Gv1JrutTgxceTn6c+SoGkWd2QEE/Mwx4cZasGkOnDSCVjTWZ/4n
 JF6mKrvhYTXkAaCyRxXcIbsBzdDI/TYsEXMtJcZTEdA==
X-Received: by 2002:aa7:d954:: with SMTP id l20mr9537929eds.1.1614548096612;
 Sun, 28 Feb 2021 13:34:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZfpQusPlK8SeLupsX5MkpMrCMoVqG9E1G+3AItVqjBlS3hF76KS3hDto3VFFR3Yt+hLv8gQ==
X-Received: by 2002:aa7:d954:: with SMTP id l20mr9537925eds.1.1614548096518;
 Sun, 28 Feb 2021 13:34:56 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id lm24sm4333097ejb.53.2021.02.28.13.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Feb 2021 13:34:56 -0800 (PST)
Date: Sun, 28 Feb 2021 16:34:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210228163031-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
MIME-Version: 1.0
In-Reply-To: <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, linux-kernel@vger.kernel.org
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

On Wed, Feb 24, 2021 at 10:24:41AM -0800, Si-Wei Liu wrote:
> > Detecting it isn't enough though, we will need a new ioctl to notify
> > the kernel that it's a legacy guest. Ugh :(
> Well, although I think adding an ioctl is doable, may I know what the use
> case there will be for kernel to leverage such info directly? Is there a
> case QEMU can't do with dedicate ioctls later if there's indeed
> differentiation (legacy v.s. modern) needed?

BTW a good API could be

#define VHOST_SET_ENDIAN _IOW(VHOST_VIRTIO, ?, int)
#define VHOST_GET_ENDIAN _IOW(VHOST_VIRTIO, ?, int)

we did it per vring but maybe that was a mistake ...

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
