Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DF4C10F1B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 07:08:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C62C40866;
	Tue, 27 Dec 2022 07:08:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C62C40866
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PxkgSFX/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K0CNsgnsqoSf; Tue, 27 Dec 2022 07:08:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8A2C84081F;
	Tue, 27 Dec 2022 07:08:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A2C84081F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64B62C0032;
	Tue, 27 Dec 2022 07:08:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E449EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB161404ED
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:08:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB161404ED
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PxkgSFX/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id irhcVxdhE7i4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:08:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC880403A7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC880403A7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672124920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CNSl+0ECi610jkobwQHRDIhZHSbY7C3DN466PQa953c=;
 b=PxkgSFX/sin04JdaPqfAiVHDM+DWPHZ3GrhlnGR96A52XoG0PSG3yGnXXcz0FVzhOWxumS
 tltjR4GqRCzKGwKYj/dtV/Iv1jKbxjV8mZXsmbCWn+wXANTgZ5Va5X02fXnEiYqq/BN6VA
 rr9+VHEXNxK35mDCSdKvlAl83f47boc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-404-ikvaWWk-MASisn8_mC23Fw-1; Tue, 27 Dec 2022 02:08:39 -0500
X-MC-Unique: ikvaWWk-MASisn8_mC23Fw-1
Received: by mail-wm1-f71.google.com with SMTP id
 x10-20020a05600c420a00b003cfa33f2e7cso6560073wmh.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNSl+0ECi610jkobwQHRDIhZHSbY7C3DN466PQa953c=;
 b=shC3yxb5HsOborSLVfN9zFVdc4ta/i+wtA5WvQmXZHOHelKHABAOQVdHZTJYdH3pqq
 I2SUE3YAZH2EJ8XpG2YopHd7rs/GUw5jJpnNmTVNMriUgHqSLsfvSj2gl1lV+c7KwB9L
 a6llXTekvy+/xRgmO0n8h7IwCFCbKzVootkDPqhfkIB35C1KzNiqE2wub7MhZWog+V4j
 Fg0nIl8nLpnb3GbeOY6Zh07Fs+WQeXK1BpmmJCSF8xNmfSkVTWRonwzS0D+hO3csfRn6
 X5Vwz5NGdgZblgq3dn0F4ip/BKT1N6yL062s8rH5C1hpHyyV7CARBkmn4Jt8e1l0VPfR
 Fgqw==
X-Gm-Message-State: AFqh2kqz0idP8uenwRu+4nDfIYXW3m4KEl6LsenEuxtDiyRyIqOij3N5
 2fmjK4Y8XH7Tsk7Gfub2RW+kw3s2JysoTMWDVnWFrLjJJ0Ju8p/SWSwhlOk9Z8hlCsS/BMMB0Xn
 ofLs293YK+ZRI62aCuV3UJYdFoT5uTEQA/IMqN9VHwA==
X-Received: by 2002:a05:600c:218f:b0:3d1:fbf9:3bd4 with SMTP id
 e15-20020a05600c218f00b003d1fbf93bd4mr14570198wme.10.1672124918371; 
 Mon, 26 Dec 2022 23:08:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtc99GCoJhnK8zS6H5TFpyy0SjPSOlEw+pD0N2cOTloIwBCRzZwnIIqKPd/kod61jIX+AMcnw==
X-Received: by 2002:a05:600c:218f:b0:3d1:fbf9:3bd4 with SMTP id
 e15-20020a05600c218f00b003d1fbf93bd4mr14570189wme.10.1672124918163; 
 Mon, 26 Dec 2022 23:08:38 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 h14-20020a05600c314e00b003d237d60318sm17613983wmo.2.2022.12.26.23.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 23:08:37 -0800 (PST)
Date: Tue, 27 Dec 2022 02:08:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Chen, Jian Jun" <jian.jun.chen@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update maintainer list for virtio i2c
Message-ID: <20221227020812-mutt-send-email-mst@kernel.org>
References: <20221214053631.3225164-1-conghui.chen@intel.com>
 <20221214063352-mutt-send-email-mst@kernel.org>
 <3557e69a-0c17-0a24-0706-8b48c350b75a@intel.com>
MIME-Version: 1.0
In-Reply-To: <3557e69a-0c17-0a24-0706-8b48c350b75a@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: asowang@redhat.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org,
 linux-i2c@vger.kernel.org, Conghui <conghui.chen@intel.com>
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

On Tue, Dec 27, 2022 at 12:04:10PM +0800, Chen, Jian Jun wrote:
> 
> On 12/14/2022 19:37, Michael S. Tsirkin wrote:
> > On Wed, Dec 14, 2022 at 01:36:31PM +0800, Conghui wrote:
> > > This updates the maintainer for virtio i2c drvier
> > I got that, but what is going on here exactly?
> > I generally expect a new maintainer to be active in the
> > project for a while first.
> > I don't see contributions or reviews for this driver or
> > for that matter for any virtio or i2c drivers from Jian Jun Chen.
> > It looks like you are no longer interested in maintaining
> > this? In that case pls just send a patch removing yourself.
> > 
> > Jian Jun Chen, if you are interested in reviewing
> > patches please start doing so, you don't need to
> > be listed as a maintainer for this to happen.
> > Once you do this for a while and write some patches,
> > you can become a maintainer, this is not a high bar
> > to clear.
> 
> Hi Michael,
> 
> Yes. I am interested in the virtio I2C maintenance. I have lots of virtio
> experience in ACRN device model development and was involved in the early
> phase virtio I2C discussion in ACRN before Jie/Conghui upstream the virtio
> I2C spec. Sure, I will start to collaborate first.


Excellent, thanks a lot!

> > > Signed-off-by: Conghui <conghui.chen@intel.com>
> > > Acked-by: Jian Jun Chen <jian.jun.chen@intel.com>
> > > ---
> > >   MAINTAINERS | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index a8c8f6b42436..44747f4641a6 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -21920,7 +21920,7 @@ F:	include/uapi/linux/virtio_snd.h
> > >   F:	sound/virtio/*
> > >   VIRTIO I2C DRIVER
> > > -M:	Conghui Chen <conghui.chen@intel.com>
> > > +M:	Jian Jun Chen <jian.jun.chen@intel.com>
> > >   M:	Viresh Kumar <viresh.kumar@linaro.org>
> > >   L:	linux-i2c@vger.kernel.org
> > >   L:	virtualization@lists.linux-foundation.org
> > > -- 
> > > 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
