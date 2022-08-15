Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD45C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 21:10:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 417A140320;
	Mon, 15 Aug 2022 21:10:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 417A140320
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=anarazel.de header.i=@anarazel.de header.a=rsa-sha256 header.s=fm1 header.b=Sw2GBTR4;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=KOJlnqL0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gbF_woOgdLmA; Mon, 15 Aug 2022 21:10:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD3CF4028D;
	Mon, 15 Aug 2022 21:10:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD3CF4028D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 828A4C0078;
	Mon, 15 Aug 2022 21:10:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63489C0035
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D59040277
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:10:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D59040277
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=anarazel.de
 header.i=@anarazel.de header.a=rsa-sha256 header.s=fm1 header.b=Sw2GBTR4; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=KOJlnqL0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7LHzO6_OlDIb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:10:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 56C354025F
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 56C354025F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:10:40 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 12D0C32002D8;
 Mon, 15 Aug 2022 17:10:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Mon, 15 Aug 2022 17:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
 cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1660597837; x=1660684237; bh=9d7dhCe3Fq
 d/bfA8yD544NDBFEKnJIxJgepP6HupnHc=; b=Sw2GBTR4vuywnmfbU2VucVwN4b
 efRwLx92+SeVxu9DpYiM9sS9H38X+M9nmB2XpzhNvOxxb5JoJDbTxawwkLvyk2c3
 buevRKZhBacx0DwC2+uAC/LsFPKBO76ez0raPhNZoceUAslgZH4W2rO7xZmFFmtt
 NV3qcTcxQFLYsWMFvy4tzaHbZYJ6Vt2/wj/Sta4FHeb65rISF4i+p9Tv4zpDkP8A
 NK+lS5/hOGiOxGACwReToCSic0km/wxhPXT7vfwCUeCdbIMCQ8wgCnkZn78PLK9o
 +pcAZ9QUkGDWP5Mvnob0xP2ktcIZkVN7CKZAoof0l396WC6OVXZHaU/q840Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1660597837; x=1660684237; bh=9d7dhCe3Fqd/bfA8yD544NDBFEKn
 JIxJgepP6HupnHc=; b=KOJlnqL03kLLyaO/0NB3mk/dJoirnU68Nx7JTKUpj8rf
 vVe7p792KJXBC1XDT+m4D2XgZDLPBhNoR4xTIgMVHlR6yfvZ3QIQsgWhIqzQ44V8
 PUSEk7w8PQAn/cFwQq+u3nktOgacR/uZ+f/6/FbpnfDILGqmlI1I8po77UZvWuG2
 wg6vQMgkdVeECgU1fuw5SKVQh+x1HHTMdqhw/Ae0XBcAIi4nLfb24x4PrqZt2H83
 JWa0oWlIGniGkDoc2Y1SnLtkyK6JXlFGoKLWA1QB5a6CrDmNS4mJ6vX5P2Yl+I/+
 v5EOExxCTEDkGcg3t8qDwfwwukD2UeOcM6FCEGo6gw==
X-ME-Sender: <xms:Tbb6YsEkABtzc4Y_Sr5ZmBvRzpXaR81ZHU6DEjuFqNDIQ7DddIR32Q>
 <xme:Tbb6YlUo9yf4_vq38Q77-Pqh-fUecSXPT9kPCwk_4dwcTRVZ6cjmnG3_mhiJYyVdr
 ExyPbqT2Mr-TXcCrw>
X-ME-Received: <xmr:Tbb6YmLiNO647ITbjg7f3pxHrktTjd2oV97wWdqgBttIN1JFZ6hpd8R7e3DQspRulyGm4oFVin6wjfrn2XsFjodZ_NB5Ro5q8XVBweAnnRwfunOFBtiP70Fp5OH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddgudeitdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgu
 rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
 frrghtthgvrhhnpedvffefvefhteevffegieetfefhtddvffejvefhueetgeeludehteev
 udeitedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:Tbb6YuHbI-M3grPW61plMNzu61m3zkee0ETlUw9gk4q6sbJlWg6vNA>
 <xmx:Tbb6YiWJgPtSuMItQui8RNHoixxsOw7S2ug5QkWCOHSulPe9czixag>
 <xmx:Tbb6YhM_9JVkTmRQZblFmAZ_kM-EIsBAgpimesyVUEvFlNzP29ao8Q>
 <xmx:Tbb6YvWGsb5k3UxdvkK7WVOFDAxucBDvrXXvFRG-6dadihdmb0CvaQ>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 17:10:36 -0400 (EDT)
Date: Mon, 15 Aug 2022 14:10:35 -0700
From: Andres Freund <andres@anarazel.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: upstream kernel crashes
Message-ID: <20220815211035.r2ojxkilwsbxyewu@awork3.anarazel.de>
References: <20220815081527.soikyi365azh5qpu@awork3.anarazel.de>
 <20220815042623-mutt-send-email-mst@kernel.org>
 <FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE@anarazel.de>
 <20220815113729-mutt-send-email-mst@kernel.org>
 <20220815164503.jsoezxcm6q4u2b6j@awork3.anarazel.de>
 <20220815124748-mutt-send-email-mst@kernel.org>
 <20220815174617.z4chnftzcbv6frqr@awork3.anarazel.de>
 <20220815161423-mutt-send-email-mst@kernel.org>
 <20220815205330.m54g7vcs77r6owd6@awork3.anarazel.de>
 <20220815210437.saptyw6clr7datun@awork3.anarazel.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220815210437.saptyw6clr7datun@awork3.anarazel.de>
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

On 2022-08-15 14:04:37 -0700, Andres Freund wrote:
> Booting with the equivalent change, atop 5.19, in the legacy setup_vq()
> reliably causes boot to hang:

I don't know much virtio, so take this with a rock of salt:

Legacy setup_vq() doesn't tell the host about the queue size. The modern one
does:
	vp_modern_set_queue_size(mdev, index, virtqueue_get_vring_size(vq));
but the legacy one doesn't.

I assume this means the host will assume the queue is of the size suggested by
vp_legacy_get_queue_size(). If the host continues to write into the space
after the "assumed end" of the queue, but the guest puts other stuff in that
space, well, I'd expect fun roughly like the stuff we've been seeing in this
and related threads.

Greetings,

Andres Freund
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
