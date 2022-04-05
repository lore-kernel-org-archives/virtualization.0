Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE35AC433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Apr 2022 11:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 693AB60D64;
	Tue,  5 Apr 2022 11:55:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f-JjEnep6pJ5; Tue,  5 Apr 2022 11:55:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EDD7960672;
	Tue,  5 Apr 2022 11:55:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2429C002C;
	Tue,  5 Apr 2022 11:55:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB7EEC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 11:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93754410A8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 11:55:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LA-1dQ2W16tr
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 11:55:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C194740947
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 11:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649159730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=28KE+M63X+ahVj/a4F3r0KzFPc/lbb3JFcGix4GxqtQ=;
 b=VO7oSQn5me1rxoKu39wEwt0q1IwLRhtDlRrSIjv014AXitvh+0OfOniiLFSv2I+nsQP+IJ
 LA3pw+lTybH4BtOJy21IbBlW9sUZ6eVDjQX2tnA8tQmg7IqYpSZLH+zFbuanjfVqZIevL+
 CHPrUq6zGv2GhoxUjPJ8fKIZWSJY/vo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-Z_U4CPFYNvSfCgIPZSSuAA-1; Tue, 05 Apr 2022 07:55:29 -0400
X-MC-Unique: Z_U4CPFYNvSfCgIPZSSuAA-1
Received: by mail-wm1-f70.google.com with SMTP id
 r64-20020a1c2b43000000b0038b59eb1940so1077442wmr.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Apr 2022 04:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=28KE+M63X+ahVj/a4F3r0KzFPc/lbb3JFcGix4GxqtQ=;
 b=iET6LPVYg2dHr7ClKG6cMi2J6emQgMnK10MFdbQ73dZHpTxzKoM/0NqiTvoWdX3y9+
 1pP/rMx329SYbmTurjHo02iSvgHoVk4LUMjVp7n2nX1K6FCCr5WkD7a9ci/ujXWdHlrf
 +tTlDaox39+palOHwIvTsGamCCN/LYLQyEPWQXKHXsLd2l/Lg3BxGLoy/nZiTdsu0Yet
 ZUyPCeunjN2yaLgcZ9QyVI0oRlSwgUHVowmBo5lJNyKH1HjJVXNsRMMrXJh8fP+3Mg/e
 u3DXzrWkDkQJm6e+VFUC8pUo2nqmx9pDT0KzvIUeO5dph7nfTM3i7n9VTg0FTcn/MJSU
 WHlg==
X-Gm-Message-State: AOAM532utn4tyT7Qzc7LmabIWEviXrepfPtOI/7QodVdrB1XtfSHxgRq
 piZFxRNRgbz7nrcUkpLv6JfLMTFCsJyAtvZbW3Ap7C4LqmSat9jdaQQvAMFxzvUfNdEeOtnAKVO
 4FCtmYmuBKX3sBNMoxT57FTX8cx6hJkF5C0oXOk7O/A==
X-Received: by 2002:a5d:50d2:0:b0:206:b6f:f7db with SMTP id
 f18-20020a5d50d2000000b002060b6ff7dbmr2452904wrt.248.1649159728269; 
 Tue, 05 Apr 2022 04:55:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1Tka5E6L9URIsWeBley60SCe/IUE6j/uwyJ5KZatVAUY55Lp2TF7WwIu2UssrhlRPLr4P1Q==
X-Received: by 2002:a5d:50d2:0:b0:206:b6f:f7db with SMTP id
 f18-20020a5d50d2000000b002060b6ff7dbmr2452885wrt.248.1649159727975; 
 Tue, 05 Apr 2022 04:55:27 -0700 (PDT)
Received: from redhat.com ([2.52.17.211]) by smtp.gmail.com with ESMTPSA id
 o17-20020a05600c4fd100b0038cd5074c83sm2159309wmq.34.2022.04.05.04.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Apr 2022 04:55:27 -0700 (PDT)
Date: Tue, 5 Apr 2022 07:55:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from
 exported header
Message-ID: <20220405074223-mutt-send-email-mst@kernel.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-9-masahiroy@kernel.org>
 <Ykqh3mEy5uY8spe8@infradead.org>
 <CAK8P3a07ZdqA0UBC_qkqzMsZWLUK=Rti3AkFe2VVEWLivuZAqA@mail.gmail.com>
 <YkvVOLj/Rv4yPf5K@infradead.org>
 <CAK8P3a0FjfSyUtv9a9dM7ixsK2oY9VF7WZPvDctn2JRi7A0YyQ@mail.gmail.com>
 <YkvpT3PFcbgcMCWy@infradead.org>
MIME-Version: 1.0
In-Reply-To: <YkvpT3PFcbgcMCWy@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization list <virtualization@lists.linux-foundation.org>
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

On Tue, Apr 05, 2022 at 12:01:35AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 05, 2022 at 08:29:36AM +0200, Arnd Bergmann wrote:
> > I think the users all have their own copies, at least the ones I could
> > find on codesearch.debian.org. However, there are 27 virtio_*.h
> > files in include/uapi/linux that probably should stay together for
> > the purpose of defining the virtio protocol, and some others might
> > be uapi relevant.
> > 
> > I see that at least include/uapi/linux/vhost.h has ioctl() definitions
> > in it, and includes the virtio_ring.h header indirectly.
> 
> Uhh.  We had a somilar mess (but at a smaller scale) in nvme, where
> the uapi nvme.h contained both the UAPI and the protocol definition.
> We took a hard break to only have a nvme_ioctl.h in the uapi header
> and linux/nvme.h for the protocol.  This did break a bit of userspace
> compilation (but not running obviously) at the time, but really made
> the headers much easier to main.  Some userspace keeps on copying
> nvme.h with the protocol definitions.

So far we are quite happy with the status quo, I don't see any issues
maintaining the headers. And yes, through vhost and vringh they are part
of UAPI.

Yes users have their own copies but they synch with the kernel.

That's generally. Specifically the vring_init thing is a legacy thingy
used by kvmtool and maybe others, and it inits the ring in the way that
vring/virtio expect.  Has been there since day 1 and we are careful not
to add more stuff like that, so I don't see a lot of gain from incurring
this pain for users.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
