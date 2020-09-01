Return-Path: <SRS0=JuYR=CK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1CCC433E6
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 08:01:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E753F2065F
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 08:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WvVYlLyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E753F2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9D54786D88;
	Tue,  1 Sep 2020 08:01:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uxwp6H1JP2pU; Tue,  1 Sep 2020 08:01:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 722C886C0A;
	Tue,  1 Sep 2020 08:01:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57769C07FF;
	Tue,  1 Sep 2020 08:01:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06E42C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 08:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E2EF086DEA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 08:01:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LPtuWTcyU4DN
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 08:01:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 34B9986DD3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 08:01:18 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id c2so362559ljj.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Sep 2020 01:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=uBet/qOZ4arKPd9HG45s6/yizvDfyghb5+cpF1ynNlk=;
 b=WvVYlLyur5enfsW0jQmGhW/33TGWeA+s81WiSCZtZGnTGInRKT4lauH7Tv1Ncl35e2
 MBX5Tgg7qp8H8HcEG0u+P7InO1kW6IesVw7yOSV3w6hoG7v7YNwh+0elQjnUhzR8dPSM
 ehQdEWDPud2Aj7A0/V0iRfznqpu4qvj7PURgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=uBet/qOZ4arKPd9HG45s6/yizvDfyghb5+cpF1ynNlk=;
 b=Rmt+CZ0MJmHVntWHYqgq7PMNd3W7jlOnu8GDPXmCiUwwblPMCinOCUBx0X/G6goojG
 sRRkVFtOcNRJtaeo9dITyqQnnTzbAdr2emD9KGZDXPnUhl0MG+aT1T0yj3tD55iN8wpN
 qqxSpLuJs80csv8Bb0mw+JyujykKiQYKk5z1ZUd5kNL63nA7ik/AtJSXoDlbp8Kt5cZk
 dsgNVDohIillvQnJY7oOGPtzp9ohm7gIhkFa9Ddf9rLYYJ5MBxaQkP345qhV9ULfk9OJ
 7ofefg78AQwyAfZeXlvBSmlqvYMBY4xYqvD4GAtHaAnPfeSownB7IXPS4v5VFv6MMNtG
 6VVQ==
X-Gm-Message-State: AOAM533juspkWInKdDAt46t2/kl3ySrYMbOb9Q+qmRIyP0LhZESjp5zB
 X3x4ZfjiNdI9766lkkooP+i5/lLv4uZSrp7R
X-Google-Smtp-Source: ABdhPJyt8crlnEcBML2lk0r4FJiVx9broYmBFybtfg7pUBuXao0ZikQLrPS8dTTtHkn7WHCj3P0hHw==
X-Received: by 2002:adf:e2c7:: with SMTP id d7mr408449wrj.110.1598945675900;
 Tue, 01 Sep 2020 00:34:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id 2sm831925wrs.64.2020.09.01.00.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 00:34:35 -0700 (PDT)
Date: Tue, 1 Sep 2020 09:34:33 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/2] drm/virtio: fix unblank
Message-ID: <20200901073433.GS2352366@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
 Jiri Slaby <jirislaby@kernel.org>, David Airlie <airlied@linux.ie>,
 1882851@bugs.launchpad.net,
 open list <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
References: <20200818072511.6745-1-kraxel@redhat.com>
 <20200818072511.6745-2-kraxel@redhat.com>
 <88ae71c2-c3ed-e0e4-e62c-bdf9d6534f2a@kernel.org>
 <20200828112759.rmeeh5bonrewiqte@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200828112759.rmeeh5bonrewiqte@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, 1882851@bugs.launchpad.net
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

On Fri, Aug 28, 2020 at 01:27:59PM +0200, Gerd Hoffmann wrote:
> On Mon, Aug 24, 2020 at 09:24:40AM +0200, Jiri Slaby wrote:
> > On 18. 08. 20, 9:25, Gerd Hoffmann wrote:
> > > When going through a disable/enable cycle without changing the
> > > framebuffer the optimization added by commit 3954ff10e06e ("drm/virtio:
> > > skip set_scanout if framebuffer didn't change") causes the screen stay
> > > blank.  Add a bool to force an update to fix that.
> > > 
> > > v2: use drm_atomic_crtc_needs_modeset() (Daniel).
> > > 
> > > Cc: 1882851@bugs.launchpad.net
> > > Fixes: 3954ff10e06e ("drm/virtio: skip set_scanout if framebuffer didn't change")
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > 
> > Tested-by: Jiri Slaby <jirislaby@kernel.org>
> 
> Ping.  Need an ack or an review to merge this.

In case you still need that, on both patches:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> thanks,
>   Gerd
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
