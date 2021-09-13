Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3671CC433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 20:54:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E481C61107
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 20:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E481C61107
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AEDF640135;
	Mon, 13 Sep 2021 20:54:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tG1m_8nfhYRu; Mon, 13 Sep 2021 20:54:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0F61640195;
	Mon, 13 Sep 2021 20:54:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8D1BC0011;
	Mon, 13 Sep 2021 20:54:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08C68C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DFF4860586
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:54:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I7mmAYuvVGaZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:54:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 572106009C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:54:32 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 m7-20020a9d4c87000000b0051875f56b95so15211133otf.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 13:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=JhNwW9vKPdT/8xW2t5CnBHG5KTMvD7rZ1Q1VcJJES5U=;
 b=aAOcyW/3Q9/QTeYM94UGTMXq1FcYtUCn9FBGI/MFltxTl2PypT1ZbgcRQ4YQIVKebb
 zS7Z/qtGWxSwj5qgOopRIkw8uk4FKG1m7tUlDIvZ3QSAWAP9wN99VlQBqVrJ2CLk4cnb
 UAmZ+FvUa2Q4WTfR75zsoa+8QF1O1vS2O5DX9iEaJ3gHy3MuhHV+Nd3xHQmWKBWw37Sb
 4VpVcqk4aWmh30ccQLwFVA07TJNFdfE3sGr9UkFDPfZ7SPjGnBHGa9dqqufo5l07QQtJ
 fhua5lg0l4Yp/b5E5TOFFbEVbvLGvZeoBHlG9uR/NYBzB8qeSqznxG9VM3EwYs/wiTcI
 4b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=JhNwW9vKPdT/8xW2t5CnBHG5KTMvD7rZ1Q1VcJJES5U=;
 b=g8Bb9PpSmCKk+w1PcuOD9EG0YzVaiRY6BFb5V2y7yPtHsyUzV0z60eenXI8P6EVcaZ
 UGDrQy9kzf/viPE5aFIfbkiFI1f+TgfOfaNnHy4m2aueFZP9E57libL3uYhL+/blIVBz
 nyCIbU2astvh8F205rNbr/wWQcFF3vWmpIJFVZDvGks65YQ4QENjmITA0m6v1cxrmJ5x
 E8/vijs30lbvLkAkzC1RbndkGcCCsaUsxDAFoA11V1WBr1VN2NRQqotKaYfTvYMvLeP/
 4vanyqmotM2zPYbtm3F6fw6KzIdsOQptYlivHSkznW1MpGS93SFsVWn8CCrK5a93/brl
 23IQ==
X-Gm-Message-State: AOAM530zHpi6URzzHWBxQlvd77wL2QNVBucwcG48lIrPpqEvHH13sbKa
 Cquz2K+HZOLxi6H+kq3KFqc=
X-Google-Smtp-Source: ABdhPJxcJ1N6icl5s1a4lizrnA9pq1ecVtoE+OOOH7RyC3quPK4yUX9d7HkImt0eOEyoBSbMVE/nDA==
X-Received: by 2002:a9d:798c:: with SMTP id h12mr11406547otm.215.1631566471411; 
 Mon, 13 Sep 2021 13:54:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 be5sm1960153oib.10.2021.09.13.13.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 13:54:30 -0700 (PDT)
Date: Mon, 13 Sep 2021 13:54:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: don't fail on !of_device_is_compatible
Message-ID: <20210913205429.GA1085962@roeck-us.net>
References: <20210913104640.85839-1-mst@redhat.com>
 <20210913162308-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913162308-mutt-send-email-mst@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Bill Mills <bill.mills@linaro.org>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>
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

On Mon, Sep 13, 2021 at 04:23:57PM -0400, Michael S. Tsirkin wrote:
> On Mon, Sep 13, 2021 at 06:47:52AM -0400, Michael S. Tsirkin wrote:
> > A recent change checking of_device_is_compatible on probe broke some
> > powerpc/pseries setups. Apparently there virtio devices do not have a
> > "compatible" property - they are matched by PCI vendor/device ids.
> > 
> > Let's just skip of_node setup but proceed with initialization like we
> > did previously.
> > 
> > Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")
> > Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> 
> 
> Guenter could you take a look at this patch pls? Does it help?
> 
> 
I confirmed that this patch fixes the problem. I replied in that thread.

Thanks,
Guenter

> 
> > Arnd could you help review this pls? Viresh is on vacation.
> > 
> >  drivers/virtio/virtio.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index c46cc1fbc7ae..19a70a2361b4 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -347,8 +347,13 @@ static int virtio_device_of_init(struct virtio_device *dev)
> >  	ret = snprintf(compat, sizeof(compat), "virtio,device%x", dev->id.device);
> >  	BUG_ON(ret >= sizeof(compat));
> >  
> > +	/*
> > +	 * On powerpc/pseries virtio devices are PCI devices so PCI
> > +	 * vendor/device ids play the role of the "compatible" property.
> > +	 * Simply don't init of_node in this case.
> > +	 */
> >  	if (!of_device_is_compatible(np, compat)) {
> > -		ret = -EINVAL;
> > +		ret = 0;
> >  		goto out;
> >  	}
> >  
> > -- 
> > MST
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
