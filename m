Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F052CC433EF
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 09:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90B5060BD7;
	Mon, 16 May 2022 09:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m5vCM6iLrFrl; Mon, 16 May 2022 09:03:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0B7C461004;
	Mon, 16 May 2022 09:03:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6076C0032;
	Mon, 16 May 2022 09:03:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B608C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 09:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EEC9C819B4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 09:03:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e9bXMyHK_QxS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 09:03:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54A3081ABB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 09:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652691823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sN8QLfN/A+UySSDA6TKtms8hsiIhhELD2bDlU4mr5p0=;
 b=WwnxRZcBTpiWMoDeqZN4+NyiT/qNmVn7SmI9p+LCmb9rwYxR122n+Xu4G09XpLNdBPnfdS
 n9xVCIqZ8VPa/BbzrBrNw5eytu5sBGPZdJg87WtJlfK+Zn9s2UltU1colIeGWUypIz0Ma2
 K+lQ+7/kSqHYCQtipaExmHB+FLr0MXg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-5JOox_PwO2uxT1h1cLBFeQ-1; Mon, 16 May 2022 05:03:41 -0400
X-MC-Unique: 5JOox_PwO2uxT1h1cLBFeQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ba21-20020a0560001c1500b0020ca6a45dfcso3727225wrb.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 02:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sN8QLfN/A+UySSDA6TKtms8hsiIhhELD2bDlU4mr5p0=;
 b=aD0VxNlh9VUj5eaRYvtj7a4x6kSCgNzpV/nCxtBhrcrF57CJdwtBloffRQr7nt/RL9
 iun/NF63Ckv3CVNkp3L4C0rh+5hqqFa+huZqSgg+LFqhrvE8RhViiGXnt9oG3Vg2E9D7
 W3+WOETPmWPpNunLaHjphkBAmF7okRz9qwFB2oqBh5yQ82S4hkLQZ8gwzYIc5MJvjGF8
 K5y3AgizVYfRKRX6jkIRA7b45uhkwA257c5Lw6aMqAd7VeEc5/55M8t2do8068zGogsl
 dqr9pwpiM3kMlGIGJazyzkF8dlUhzdEup0vsuSzqFjHwAH9QxN8zxA+7oS2WK9VX96J1
 /ugA==
X-Gm-Message-State: AOAM531d50KOUJkjjdByTmRrXdb48Z+uRLlkiONUkvwLITnfkS3TDq+T
 1lKuKslBOxGae7iU+kmnhFaWire9sMV3cUDKHPuSqJchMfQ/Sl0Ybj681v2J+lncok/2Ur9mBtz
 pYPA1reAuvZWqvJ2MlqpRO4MlLGeRMGIN2Sm66MiikQ==
X-Received: by 2002:a05:6000:1847:b0:20c:61a8:4dd3 with SMTP id
 c7-20020a056000184700b0020c61a84dd3mr13647487wri.205.1652691820481; 
 Mon, 16 May 2022 02:03:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAsBp5KvtStVNwjEVznDkDUw7cluWHWPDWh0qjQjlcuAw2dlbUt71Dx2F3EbqPVXfIOPTe5A==
X-Received: by 2002:a05:6000:1847:b0:20c:61a8:4dd3 with SMTP id
 c7-20020a056000184700b0020c61a84dd3mr13647479wri.205.1652691820302; 
 Mon, 16 May 2022 02:03:40 -0700 (PDT)
Received: from redhat.com ([2.55.141.66]) by smtp.gmail.com with ESMTPSA id
 r15-20020a7bc08f000000b00394615cf468sm12639009wmh.28.2022.05.16.02.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 02:03:39 -0700 (PDT)
Date: Mon, 16 May 2022 05:03:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] virtio: last minute fixup
Message-ID: <20220516045821-mutt-send-email-mst@kernel.org>
References: <20220510082351-mutt-send-email-mst@kernel.org>
 <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
 <87czgk8jjo.fsf@mpe.ellerman.id.au>
 <CAHk-=wj9zKJGA_6SJOMPiQEoYke6cKX-FV3X_5zNXOcFJX1kOQ@mail.gmail.com>
 <87mtfm7uag.fsf@mpe.ellerman.id.au>
 <CAHk-=wgnYGY=10sRDzXCC2bmappjBTRNNbr8owvGLEW-xuV7Vw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgnYGY=10sRDzXCC2bmappjBTRNNbr8owvGLEW-xuV7Vw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: KVM list <kvm@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, mie@igel.co.jp,
 Netdev <netdev@vger.kernel.org>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
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

On Thu, May 12, 2022 at 10:10:34AM -0700, Linus Torvalds wrote:
> On Thu, May 12, 2022 at 6:30 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > Links to other random places don't serve that function.
> 
> What "function"?
> 
> This is my argument. Those Link: things need to have a *reason*.
> 
> Saying "they are a change ID" is not a reason. That's just a random
> word-salad. You need to have an active reason that you can explain,
> not just say "look, I want to add a message ID to every commit".

So I want to go to my inbox and compare the patch as received with what
is in my tree.  What did I change? And I tweak both the patch content
when applying and the subject so these are not good indicators.  Is this
at all convincing?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
