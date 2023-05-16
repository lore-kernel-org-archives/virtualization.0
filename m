Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41055C77B7A
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 17:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4AB741F3F;
	Tue, 16 May 2023 17:56:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4AB741F3F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=tjSVD2GD;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=ciFx69qJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NSTCbZogHDXE; Tue, 16 May 2023 17:56:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 77E6541F30;
	Tue, 16 May 2023 17:56:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77E6541F30
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BCDBC0037;
	Tue, 16 May 2023 17:56:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F26BC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 17:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 06FDA405B0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 17:56:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06FDA405B0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de
 header.a=rsa-sha256 header.s=fm3 header.b=tjSVD2GD; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=ciFx69qJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vfjYhKMPmjC8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 17:56:11 +0000 (UTC)
X-Greylist: delayed 00:08:28 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9CB2C401B7
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9CB2C401B7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 17:56:10 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 9F99D581012;
 Tue, 16 May 2023 13:47:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Tue, 16 May 2023 13:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1684259259; x=1684266459; bh=7R
 Tlb4yPLwyEbMekf/kZ3q59ewoUpiiohu1ETmUvaCM=; b=tjSVD2GDDI6vJ83hu2
 J0wG8DQCFOFbtD4wryKKIsm8NrKyYWw9AxEpnAygm+AGD4nEF+j2mlJ4DdXq8T7f
 5QNxCwjCLFwN4LQVkqurLDF0jW1A9Zzz9wuP8KmJ+dOKMC7ySN2l+XD2DB+vAURd
 6HwY0kPm0vBIX61vZDEmsG6v4odA+Wveqknzg8HJe84D9+Q/i7EzXkxjhIOGsu4K
 Bn3sr+SEQpMQKfLLbdVTMEAMgMrfED9RHqZwlTkKYfdLgHhBCfQNds8ESPs0wA5+
 2AzSXtwnhzkb+RBCBVRlsb6shv5c3exsHtDbboEghfnX3UvEDusXCS9pSl0ALX42
 +Xyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1684259259; x=1684266459; bh=7RTlb4yPLwyEb
 Mekf/kZ3q59ewoUpiiohu1ETmUvaCM=; b=ciFx69qJrZA7yv8A1zotpocAWV1mM
 DnUP6xkiq9u2k7Phst28yF9pOYB+p24imZJrUwwQF6DaQRUyeCdMCHTN6yVxU/vW
 Zix27X67pchamsczOqs7J0fQmHu0V5swPms3kpa35adfR5aXURViqtvoRoUWTY5a
 VGrXwUFJRCfHN/YuNMUZDl9wn8yBTKr7VBmb16uia+BCMsXDlQJp7yj7UMvHEfiR
 Ebny8zc51oZx4GRbyjokzwqbrXLiBKtObXTWrW3CD5SJCpHHNRnP+f9Dsand+SZT
 dzhYqpvdJUL8oVoDvA2y4v+/D77Af1UZoXejTAWumnmNa1AN9KFpUQmtQ==
X-ME-Sender: <xms:usFjZCA3j9sz5nEwWZIq3UmHGzVX3xq8hC-A-CyhlzVMMgSHRPetnQ>
 <xme:usFjZMhU9wDkNkUa9Ko0jRxG-mz1cmyQTN0VunBG3IHeRNAXPCCPbQ8JGk1HmTj-P
 f3ZVSWUacwY2BBQoXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledgudduiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
 rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
 htthgvrhhnpeevveeggeffjeeuieduheefhfehgfdujeetjeelueejjeffueeiudefveff
 hffhffenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:u8FjZFkhOy80RxQ2BWUV-rzLx8Zo0OByuLOXpQ4jyTEMZULNY_5y-w>
 <xmx:u8FjZAyVEm27DrMzOgnM0JctyZqlH4gGlGXk57isUu1T4RYHJk6Jhg>
 <xmx:u8FjZHQCJi6yyLlJWVSjFUgZE57E9obBOYfWMJ-aSBO-TYSVuDEPwA>
 <xmx:u8FjZIQ8wbnEjbEjDbQYJgfmKy2oTUwCRajab8gsJFAROe09ddfnLQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id E6956B60086; Tue, 16 May 2023 13:47:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <0d6d0620-ab14-47ba-90cd-5bce317ac1eb@app.fastmail.com>
In-Reply-To: <f5c92eb1-83af-4f99-71f5-b7a3e8be1d13@suse.de>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-8-schnelle@linux.ibm.com>
 <f5c92eb1-83af-4f99-71f5-b7a3e8be1d13@suse.de>
Date: Tue, 16 May 2023 19:47:18 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Dave Airlie" <airlied@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>,
 "Dave Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>
Subject: Re: [PATCH v4 07/41] drm: handle HAS_IOPORT dependencies
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

On Tue, May 16, 2023, at 19:13, Thomas Zimmermann wrote:
>
> Am 16.05.23 um 13:00 schrieb Niklas Schnelle:
>> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
>> not being declared. We thus need to add HAS_IOPORT as dependency for
>> those drivers using them. In the bochs driver there is optional MMIO
>> support detected at runtime, warn if this isn't taken when
>> HAS_IOPORT is not defined.
>> 
>> There is also a direct and hard coded use in cirrus.c which according to
>> the comment is only necessary during resume.  Let's just skip this as
>> for example s390 which doesn't have I/O port support also doesen't
>> support suspend/resume.
>> 
>> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> ---
>> Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
>>        per-subsystem patches may be applied independently
>> 
>>   drivers/gpu/drm/qxl/Kconfig   |  1 +
>>   drivers/gpu/drm/tiny/bochs.c  | 17 +++++++++++++++++
>>   drivers/gpu/drm/tiny/cirrus.c |  2 ++
>
> There are more invocations in gma500. See[1]
>
> [1] 
> https://elixir.bootlin.com/linux/v6.3/source/drivers/gpu/drm/gma500/cdv_device.c#L30

GMA500 already has "depends on X86", so I don't think
any changes are needed there -- x86 is already highly dependent
on I/O ports for a number of reasons.

     Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
