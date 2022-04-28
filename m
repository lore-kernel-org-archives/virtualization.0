Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2DAC433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 05:25:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61540401B3;
	Thu, 28 Apr 2022 05:25:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3W24ZvI74d14; Thu, 28 Apr 2022 05:24:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8151E4016C;
	Thu, 28 Apr 2022 05:24:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 569DAC0032;
	Thu, 28 Apr 2022 05:24:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1493C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B71974016C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:24:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VbJ6v9V3SWIr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:24:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76B61400FE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651123494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E2WT+5Dj/uF92md4vRvJ45vZd5NBiJcHUWg+Un6DF70=;
 b=bAf3BZ6QaqgK//q2caMT5ah594EnZT2Jb2yx0WlQz5kZGIMdilaS/65RHmJzhG5/Noqc4A
 BgvmKO0KGnOf9qIu9QNPXMYN1kQyHayLWGuqdfBrobKlSkbAFkIqbBfl66V4WCjkMflBwc
 1KLO2CQjWFUENHPxY3IEp6XCiF+9TNE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-LEE_1PgsOoylFq-xz5AGsQ-1; Thu, 28 Apr 2022 01:24:52 -0400
X-MC-Unique: LEE_1PgsOoylFq-xz5AGsQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 r186-20020a1c44c3000000b00393f52ed5ceso3089323wma.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 22:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=E2WT+5Dj/uF92md4vRvJ45vZd5NBiJcHUWg+Un6DF70=;
 b=g7bRimLf8P3OrJLDn8oAGNQFTVba8lARmmVKlk37dPTQjz6eucuMlHe0Ie2v2O/LIC
 DT/k/UTT5Bz9b3tbkHIR0i1qQVkX+bD7qYcvgzkGawW4wxzivvjJw1EED8Pb6tXRF+WS
 O55ZXY16cIa2pIKTE1yszQugz23cYYELIzqGXFddN/E6AoyMpB7Mcv1IHPr5zgIT7zmw
 FfJtzOT8tmfvur7Fyc2fr7nK3GJc3eTRiduS3T3tapaSBs1ahA7MBsDLVX+3HssZtaeL
 JO0z5bLLB66Z3kEOBzWgoD11sboY23ghRsbLcPi4Zc+6rAA9s24yPmwkzbPr9g76hNYg
 8ACA==
X-Gm-Message-State: AOAM531QWjAJmqI7tVftnhbbx1yhxsaUpU8qDcQ+MLq2zF8z4lCaUvpQ
 loliuzAemptB8ebf9ym3t2wd2m9cfugCD0unjScNZattxidlq7OBfBsACTaboC++bA/jHWLZshB
 TDbhOVP2xowGFULPBAVfFZD97HEqinEVji14jces0+A==
X-Received: by 2002:adf:dd0e:0:b0:20a:d00a:fcf0 with SMTP id
 a14-20020adfdd0e000000b0020ad00afcf0mr20082704wrm.239.1651123491568; 
 Wed, 27 Apr 2022 22:24:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1Dc+Z1n8cfxiweI/O1wRWrqc7b8BNVYC1ZGuXlRWcoYm4SDgXmSVs64meStwS7OhANEavmw==
X-Received: by 2002:adf:dd0e:0:b0:20a:d00a:fcf0 with SMTP id
 a14-20020adfdd0e000000b0020ad00afcf0mr20082687wrm.239.1651123491114; 
 Wed, 27 Apr 2022 22:24:51 -0700 (PDT)
Received: from redhat.com ([2.53.18.16]) by smtp.gmail.com with ESMTPSA id
 c12-20020a05600c0a4c00b00381141f4967sm3674279wmq.35.2022.04.27.22.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 22:24:49 -0700 (PDT)
Date: Thu, 28 Apr 2022 01:24:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220428012156-mutt-send-email-mst@kernel.org>
References: <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com>
 <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com>
 <20220428044315.3945e660.pasic@linux.ibm.com>
 <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Cindy Lu <lulu@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Thu, Apr 28, 2022 at 11:04:41AM +0800, Jason Wang wrote:
> > But my guess is that rwlock + some testing for the legacy indicator case
> > just to double check if there is a heavy regression despite of our
> > expectations to see none should do the trick.
> 
> I suggest this, rwlock (for not airq) seems better than spinlock, but
> at worst case it will cause cache line bouncing. But I wonder if it's
> noticeable (anyhow it has been used for airq).
> 
> Thanks

Which existing rwlock does airq use right now? Can we take it to sync?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
