Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D274AC4332F
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 22:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D0C860B58;
	Wed, 12 Oct 2022 22:08:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D0C860B58
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XX+48jZW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IIMHD8nVts25; Wed, 12 Oct 2022 22:08:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC29760757;
	Wed, 12 Oct 2022 22:08:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC29760757
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE5FCC0032;
	Wed, 12 Oct 2022 22:08:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FB3BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 22:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 71D07416C8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 22:08:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 71D07416C8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XX+48jZW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rsWSwtaLPsNL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 22:08:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8589341505
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8589341505
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 22:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665612527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e1Csc5OKDLMm08qWQhJj0nFioDDfbxhqyYmrCk7iHHE=;
 b=XX+48jZWvKaFm3q5NoTsJwvqcyNTvUrUk2992YGCNwx+plWlyMY7l8M5oZ+eeSBJsWO1GO
 6/0vwFwx+cnb/Gso+pljGLLnjQG3FstaqLqadKV9Oz8y9/272UPROHJWt2YYuNgiBzP+Kf
 FfvVND/bdvGe3eoBc9BkC0nwDVCravc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-191-QBSgEGVyPJy7QrmRe8Z4MQ-1; Wed, 12 Oct 2022 18:08:33 -0400
X-MC-Unique: QBSgEGVyPJy7QrmRe8Z4MQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 r132-20020a1c448a000000b003c3a87d8abdso34495wma.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 15:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1Csc5OKDLMm08qWQhJj0nFioDDfbxhqyYmrCk7iHHE=;
 b=JNQrYZmkQeip00qNEgUlaJOb8yntvU+4L8o3GevVMNognQZTFhHwmtzxJl2l9VS24g
 DOEsZ0fsBPlnCt0eQchZMBWfHh3YESepPaf6myxrnGD2f6xLZb4fzioyZYnw/lEI+V/w
 q0ZmxIZnNizOE3+3adHyJ2ZrmoVPcB+jZrixkRHBG66Un3b275+xvyZjOg8lCZVBQThA
 aKxXOdDK8o/Gj34bhg8phwu3H5WIEuN+kvteJ01zL8Cwaw5MJxw0KVINLSMBE6XfqyIi
 mQy3Wxdesf18DZD5kln19QPjNw7tQ7ofVN0x5Ll1pNc9CFTLjyAualmk2ZFk/Vhxt+V0
 y2aQ==
X-Gm-Message-State: ACrzQf3AqRdzDpSu2J2wJnAL16E4rBR2h5V95JcoqGvEfijRkkt2vjnL
 sx/yg8xi8e6d7OobO5sYOvmcVOJ0Z8eKqA1/r3YfEUs6mcU0zDDy9nljFeuN6ytKFWm2xtPUw/B
 fW4vjUCOtM6iwLKjG42YQGcfJmTaOosfmzY5uQc5XoQ==
X-Received: by 2002:adf:d1cc:0:b0:22e:6371:65ad with SMTP id
 b12-20020adfd1cc000000b0022e637165admr19590803wrd.326.1665612512759; 
 Wed, 12 Oct 2022 15:08:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Hfapj638ZSQQKBud2DiNS0QJza/l7oyJMq2zEMTl7MZoMYSzTy3MWiISMgB3bUUa2AIbrEw==
X-Received: by 2002:adf:d1cc:0:b0:22e:6371:65ad with SMTP id
 b12-20020adfd1cc000000b0022e637165admr19590785wrd.326.1665612512531; 
 Wed, 12 Oct 2022 15:08:32 -0700 (PDT)
Received: from redhat.com ([2.54.162.123]) by smtp.gmail.com with ESMTPSA id
 a1-20020a05600c348100b003a5f4fccd4asm2812081wmq.35.2022.10.12.15.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Oct 2022 15:08:31 -0700 (PDT)
Date: Wed, 12 Oct 2022 18:08:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] virtio: fixes, features
Message-ID: <20221012180806-mutt-send-email-mst@kernel.org>
References: <20221010132030-mutt-send-email-mst@kernel.org>
 <87r0zdmujf.fsf@mpe.ellerman.id.au>
 <20221012070532-mutt-send-email-mst@kernel.org>
 <87mta1marq.fsf@mpe.ellerman.id.au>
 <87edvdm7qg.fsf@mpe.ellerman.id.au>
 <20221012115023-mutt-send-email-mst@kernel.org>
 <CAHk-=wg2Pkb9kbfbstbB91AJA2SF6cySbsgHG-iQMq56j3VTcA@mail.gmail.com>
 <38893b2e-c7a1-4ad2-b691-7fbcbbeb310f@app.fastmail.com>
MIME-Version: 1.0
In-Reply-To: <38893b2e-c7a1-4ad2-b691-7fbcbbeb310f@app.fastmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xiujianfeng@huawei.com, kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, wangdeming@inspur.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Netdev <netdev@vger.kernel.org>, angus.chen@jaguarmicro.com,
 Bjorn Helgaas <bhelgaas@google.com>, lingshan.zhu@intel.com,
 Linus Torvalds <torvalds@linux-foundation.org>, gavinl@nvidia.com
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

On Wed, Oct 12, 2022 at 11:06:54PM +0200, Arnd Bergmann wrote:
> On Wed, Oct 12, 2022, at 7:22 PM, Linus Torvalds wrote:
> >
> > The NO_IRQ thing is mainly actually defined by a few drivers that just
> > never got converted to the proper world order, and even then you can
> > see the confusion (ie some drivers use "-1", others use "0", and yet
> > others use "((unsigned int)(-1)".
> 
> The last time I looked at removing it for arch/arm/, one problem was
> that there were a number of platforms using IRQ 0 as a valid number.
> We have converted most of them in the meantime, leaving now only
> mach-rpc and mach-footbridge. For the other platforms, we just
> renumbered all interrupts to add one, but footbridge apparently
> relies on hardcoded ISA interrupts in device drivers. For rpc,
> it looks like IRQ 0 (printer) already wouldn't work, and it
> looks like there was never a driver referencing it either.


Do these two boxes even have pci?

> I see that openrisc and parisc also still define NO_IRQ to -1, but at
> least openrisc already relies on 0 being the invalid IRQ (from
> CONFIG_IRQ_DOMAIN), probably parisc as well.
> 
>      Arnd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
