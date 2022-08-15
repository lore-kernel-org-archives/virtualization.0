Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D92C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 21:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7DE1408BA;
	Mon, 15 Aug 2022 21:01:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7DE1408BA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=anarazel.de header.i=@anarazel.de header.a=rsa-sha256 header.s=fm1 header.b=GrND2lXe;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=jJZqRm7r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Md1VqPeMZ7GU; Mon, 15 Aug 2022 21:01:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8B2EE40541;
	Mon, 15 Aug 2022 21:01:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B2EE40541
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F254C0032;
	Mon, 15 Aug 2022 21:01:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85306C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 42705402B1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:01:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 42705402B1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=anarazel.de
 header.i=@anarazel.de header.a=rsa-sha256 header.s=fm1 header.b=GrND2lXe; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=jJZqRm7r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vrFJ7SrSTe6p
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:01:05 +0000 (UTC)
X-Greylist: delayed 00:07:29 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C3FB74028D
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3FB74028D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:01:04 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 2A2A6320005D;
 Mon, 15 Aug 2022 16:53:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Mon, 15 Aug 2022 16:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
 cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1660596812; x=1660683212; bh=HPFMScc5rh
 1n/KUQUKK3sj0YWkmSXqa3merVTxllExE=; b=GrND2lXe7MGK4VptRdZgr8SmV2
 UHsbE+tvYBCAgUWGaTCGwBDbHtn05YfYLitzF4HYhSrDD3VOlh6BjcLdeswQr0a3
 0c1BD1I5KNMqAuCqDUQojm5DVGKlDz1YMhoRtnVrO5NhX3Iao7mrSsJOaTyxwSN1
 GGrwFUbkGZ8sEPQACUt3ys1wBu3p70IYFsRDPkMVxi/2/Tam2EYL6R1e57+eKjlJ
 v7XtUV4Swdia9uQ2zo7MdqxClGR220tS0CJVMFkBunq65nuTASnMdWbJgiXPZ6/g
 40lKbXFRsXHR/ygaTBwzHP6bRimZmNf5UbNbJPDw+muf0ktEZjQfZb6OrkOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1660596812; x=1660683212; bh=HPFMScc5rh1n/KUQUKK3sj0YWkmS
 Xqa3merVTxllExE=; b=jJZqRm7ree9prKdUYWegxgRMEgZItep/jM86M1SQt9+J
 b7ghCdihuulSBOVnXdcRl6boF0IK9h5o+X6kxYqM9Ub3J+Mq2TM20FOYGU7DAd+L
 0cFYDC7YlSnPrQC7I7ymf2kRm4xALmg11KYziprI0UvHwffBZpvkFTjuK9VvFw5R
 cpJmmw+pkcuQZ1lZQ129K1ngIR3wpjt1fo/w4mCGvcPZY2ZfK2000ha2u1wAY9F7
 KDR+HshGHzz2B23S8BnH05rQyo1HvbK8Z0AZOx344rcTFrmYyw3tPTVhx2xHrbcQ
 Wxw3Oq8iopJwOvkSvrqnIqJGCxqVe300o5A3tGEa1A==
X-ME-Sender: <xms:S7L6Ykjf56ArH60Ke5dBi9Vcg8xi1f5acU892ZSUIE5gc9K8ukSqpA>
 <xme:S7L6YtDdqmOW-sM7szpv1IzigqqSJdSRZeoHpQItIuHyVO8yGUipgMlWV1ER50TnP
 kE4Y5sXxQA4ei_wog>
X-ME-Received: <xmr:S7L6YsGpKcazbvPWp2o3gwfsD7M5XYRSKth6O6SojFsrmMslbySNLdw_rhGoJ6d8hyDJuieIGdkqEgKPx_pNJP9OfG7lfHC0jvHchkAzNXwGqhRRG72O7VObUvCj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddgudehjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgu
 rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
 frrghtthgvrhhnpedvffefvefhteevffegieetfefhtddvffejvefhueetgeeludehteev
 udeitedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:S7L6YlQZEO9CSpN512tovSiJNM7oZ34W_NhYim79y7bYqroSU14Bqg>
 <xmx:S7L6YhwFUK50LTIf5jTvxSD_rtN63jWH_br1Z_QuHBWrWHFICy0uEg>
 <xmx:S7L6Yj7xX5to0FCcJpfmaCL87adpuJaaoScEuLiWr7_NX0gka3M9yQ>
 <xmx:TLL6YpB9XIEnAcPxX0o0cl_tCoxr_1v19RkbpATjGVqfcDmkW7zssg>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 16:53:31 -0400 (EDT)
Date: Mon, 15 Aug 2022 13:53:30 -0700
From: Andres Freund <andres@anarazel.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: upstream kernel crashes
Message-ID: <20220815205330.m54g7vcs77r6owd6@awork3.anarazel.de>
References: <20220815071143.n2t5xsmifnigttq2@awork3.anarazel.de>
 <20220815034532-mutt-send-email-mst@kernel.org>
 <20220815081527.soikyi365azh5qpu@awork3.anarazel.de>
 <20220815042623-mutt-send-email-mst@kernel.org>
 <FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE@anarazel.de>
 <20220815113729-mutt-send-email-mst@kernel.org>
 <20220815164503.jsoezxcm6q4u2b6j@awork3.anarazel.de>
 <20220815124748-mutt-send-email-mst@kernel.org>
 <20220815174617.z4chnftzcbv6frqr@awork3.anarazel.de>
 <20220815161423-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220815161423-mutt-send-email-mst@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 c@redhat.com, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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

Hi,

On 2022-08-15 16:21:51 -0400, Michael S. Tsirkin wrote:
> On Mon, Aug 15, 2022 at 10:46:17AM -0700, Andres Freund wrote:
> > Hi,
> >
> > On 2022-08-15 12:50:52 -0400, Michael S. Tsirkin wrote:
> > > On Mon, Aug 15, 2022 at 09:45:03AM -0700, Andres Freund wrote:
> > > > Hi,
> > > >
> > > > On 2022-08-15 11:40:59 -0400, Michael S. Tsirkin wrote:
> > > > > OK so this gives us a quick revert as a solution for now.
> > > > > Next, I would appreciate it if you just try this simple hack.
> > > > > If it crashes we either have a long standing problem in virtio
> > > > > code or more likely a gcp bug where it can't handle smaller
> > > > > rings than what device requestes.
> > > > > Thanks!
> > > >
> > > > I applied the below and the problem persists.
> > > >
> > > > [...]
> > >
> > > Okay!
> >
> > Just checking - I applied and tested this atop 6.0-rc1, correct? Or did you
> > want me to test it with the 762faee5a267 reverted? I guess what you're trying
> > to test if a smaller queue than what's requested you'd want to do so without
> > the problematic patch applied...
> >
> >
> > Either way, I did this, and there are no issues that I could observe. No
> > oopses, no broken networking. But:
> >
> > To make sure it does something I added a debugging printk - which doesn't show
> > up. I assume this is at a point at least earlyprintk should work (which I see
> > getting enabled via serial)?
> >

> Sorry if I was unclear.  I wanted to know whether the change somehow
> exposes a driver bug or a GCP bug. So what I wanted to do is to test
> this patch on top of *5.19*, not on top of the revert.

Right, the 5.19 part was clear, just the earlier test:

> > > > On 2022-08-15 11:40:59 -0400, Michael S. Tsirkin wrote:
> > > > > OK so this gives us a quick revert as a solution for now.
> > > > > Next, I would appreciate it if you just try this simple hack.
> > > > > If it crashes we either have a long standing problem in virtio
> > > > > code or more likely a gcp bug where it can't handle smaller
> > > > > Thanks!

I wasn't sure about.

After I didn't see any effect on 5.19 + your patch, I grew a bit suspicious
and added the printks.


> Yes I think printk should work here.

The reason the debug patch didn't change anything, and that my debug printk
didn't show, is that gcp uses the legacy paths...

If there were a bug in the legacy path, it'd explain why the problem only
shows on gcp, and not in other situations.

I'll queue testing the legacy path with the equivalent change.

- Andres


Greetings,

Andres Freund
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
