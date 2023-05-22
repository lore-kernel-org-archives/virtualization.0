Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41D0C7EE26
	for <virtualization@archiver.kernel.org>; Mon, 22 May 2023 13:07:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DF4A61439;
	Mon, 22 May 2023 13:07:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DF4A61439
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=MLCMKmdR;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=ZFevDW2W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lt9mxy783_po; Mon, 22 May 2023 13:07:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6C97461425;
	Mon, 22 May 2023 13:07:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C97461425
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EE17C0035;
	Mon, 22 May 2023 13:07:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18EB9C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 13:07:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9019A41744
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 13:07:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9019A41744
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de
 header.a=rsa-sha256 header.s=fm3 header.b=MLCMKmdR; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=ZFevDW2W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HcjtYg9luRZN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 13:07:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB4DD415A0
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DB4DD415A0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 13:07:06 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id C056C5803A7;
 Mon, 22 May 2023 09:07:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Mon, 22 May 2023 09:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1684760820; x=1684768020; bh=c9
 3SmvLDeC64L51UuCFxKGnCCgmnVKaRqTKgfxWZ1ys=; b=MLCMKmdR20X7i+uMMB
 p+8Bl8mcfuXsoN9oxkaYz9yJqNc+Uq0a0hGJ+SPuV5ZisOoi/9oUJYzVbdJ5mMsC
 wcn+reG+to+Nl024aZdHjvAndkmYyVIRPEooNtirOnocO6hajNyHYRikw3ONMlrt
 fK6766QSCaEUk8QYm+KF2R6aqV7aIN87uGt3Nm7/oHvpscIAfmp5IpMbBEnQvKbW
 w00+4GyOmUgnjxEjFJ73/VxZO6o/hMYs/o8+cSnBiUlZR0fGyZjbRnttT0Ypgy3U
 53ISsGPqwikreb3ymgPcUWlwUVUj8ut0FteHzMfjygw8SVBXfDv4n//c18zDU3b0
 xlLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1684760820; x=1684768020; bh=c93SmvLDeC64L
 51UuCFxKGnCCgmnVKaRqTKgfxWZ1ys=; b=ZFevDW2W8S7FjKYvqGFg4RabbRy9j
 D0vDK2N3DUtLciR97xwV9tvExxWzTBevblDXEdxtoh9du0rDBkeyR/Dj0zE6gxkE
 XPETVYrImwtFOAPzuQGAptzZraTnVt48wU8sXo7sGpeN4FAfgmG+nMhZCNYfTyE7
 R5xBtnpMmklQ7JOsMBq9AZ70e1+eiPXjsobjzNHLZPFtrfThVW8gSo6Bi0449djK
 FT9mxoQGUq9Vkjm4POE6SYunF4yNYjxEMJhbLKgY3dH1YTkyKxLnVkyrlJSfjt7m
 LtUi3oGh9+57TywxB4t/XDwnQs+mq7oTUyLsNkCe84yqKEfCAJghKJz8g==
X-ME-Sender: <xms:8mhrZNRjH4YYUGSj8UsLoa6o_P2wl1tPwAzXDAmqbW-ZGJfZCSOsSw>
 <xme:8mhrZGwVdHbY2c8bkLkjqHfMOiNlOk8xrLthGbT51RQqALKqbdw66Adh46jQWpM-D
 opwTdT0ne2-h9232PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejuddggeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
 nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
 htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
 teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
 hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:8mhrZC1_nBlypOTS2fXYV--cUSR2LKArBobBwRH7JJkoFKOMjMVPbw>
 <xmx:8mhrZFAARAra-R85PT2JOAuNpdOCmec_W7XHCctRVRM_hqyCBtavUA>
 <xmx:8mhrZGjGP12Y9RDUaS2okglSFxGWQ4NatOph0oswfIUBU02iLRsGjA>
 <xmx:9GhrZBj_SK5fBJXEYP7q15nX172iDSohGuTzXFd0Mdriur6iRcn-FA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 6CA3FB60086; Mon, 22 May 2023 09:06:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <5dcf01e7-4378-4b4c-9751-454b16270c69@app.fastmail.com>
In-Reply-To: <2043cea3-7553-ee9d-4aaa-6f1d22ac4d87@suse.de>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <20230522105049.1467313-10-schnelle@linux.ibm.com>
 <2043cea3-7553-ee9d-4aaa-6f1d22ac4d87@suse.de>
Date: Mon, 22 May 2023 15:06:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Dave Airlie" <airlied@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>,
 "Dave Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>
Subject: Re: [PATCH v5 09/44] drm: handle HAS_IOPORT dependencies
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Albert Ou <aou@eecs.berkeley.edu>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Alan Stern <stern@rowland.harvard.edu>,
 Paul Walmsley <paul.walmsley@sifive.com>, Bjorn Helgaas <bhelgaas@google.com>,
 spice-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>
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

On Mon, May 22, 2023, at 14:38, Thomas Zimmermann wrote:
> Am 22.05.23 um 12:50 schrieb Niklas Schnelle:

>> There is also a direct and hard coded use in cirrus.c which according to
>> the comment is only necessary during resume.  Let's just skip this as
>> for example s390 which doesn't have I/O port support also doesen't
>> support suspend/resume.
>
> I think we should consider making cirrus depend on HAS_IOPORT. The 
> driver is only for qemu's cirrus emulation, which IIRC can only be 
> enabled for i586. And it has all been deprecated long ago.

I tried it out in arm64 debvm, and both the kernel and Xorg drivers
are detected just fine according to the log. I only get a black
screen, which could be the result of a missing VGA BIOS or the missing
unblank Port I/O in the driver (I doubt the VGA ports are hooked up
on arm64 qemu), but there is a good chance that it's currently
working for someone else.

      Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
