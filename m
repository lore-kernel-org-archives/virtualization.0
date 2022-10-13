Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90DDC433FE
	for <virtualization@archiver.kernel.org>; Thu, 13 Oct 2022 06:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D838837AC;
	Thu, 13 Oct 2022 06:29:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D838837AC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=InSsjplS;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Q2CpNE0R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MDziQXlvvBSx; Thu, 13 Oct 2022 06:29:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7970682B24;
	Thu, 13 Oct 2022 06:29:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7970682B24
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55AB4C0033;
	Thu, 13 Oct 2022 06:29:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88FA7C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 06:29:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6322A61116
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 06:29:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6322A61116
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de
 header.a=rsa-sha256 header.s=fm2 header.b=InSsjplS; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm3 header.b=Q2CpNE0R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lGKnvs2bC3bP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 06:29:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7489B61108
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7489B61108
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 06:29:12 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 55C7E5C00FC;
 Thu, 13 Oct 2022 02:29:11 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute3.internal (MEProxy); Thu, 13 Oct 2022 02:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm2; t=1665642551; x=1665728951; bh=IK7qyXP/Hq
 Hv2l79+EvbWbN9n2PDThaIIYKN+SdCmLU=; b=InSsjplS9Ys0U2AGlXKt7JrKR9
 P4de4X3Des9x2jpi0NY5SqXFP9lDw2DELcTICNVaFYyQVug4NSAlLn2wnv5RNlKE
 yseSXnYYuoWnY4pjo8NBgTmK4BauaA0Vxpaxn30Rme9wCptdagLbtyc4WqCbQL+Q
 cbpa5YWMf59gAIoWc3xf7hsmriAvf6j0yjBXUSGoOutA/yJEXGrfxtUUh5GtWCLx
 zifPjL/UKNieG6TcgJ/e4rUEQQTkNwwTqlJHxlGJxgo3ljAN8kc2ybhzMWsdCfpj
 IJCSW6YUymHtrKbcSmGL7p68Usa2uTDg003fZ+yniKqlbvDqZ69trc46dPqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1665642551; x=1665728951; bh=IK7qyXP/HqHv2l79+EvbWbN9n2PD
 ThaIIYKN+SdCmLU=; b=Q2CpNE0R0yn5ejpW0T6nFjfHoMnRLXBS32u4Y90NWnC0
 1tIINvXRjhsIWBsk9oo21L9SAU2QG0twhkXlxNprdbOVir6CW2viY7ro8/IkN8ok
 W1MerrZ+NRcgQkEAfAo90dHOYlI/yT2O/u4mZarMEBDibKBp2TtBsMdspWbRg2kQ
 Px0D68KqMraQDAElccP2rC/C/MFaZSBgdlWvMtzRW6oqKkXKDumd9MfS8pJCrir2
 nCjkuqxVVg1yMAURsQv5HJ7jx7PktJYsnkYbIGw3/La60yExsGRF81MZ30FuyXLE
 3X3N1SLQ8ZDLF1NicDFofzohyntVbzNOOhnOW0gCgQ==
X-ME-Sender: <xms:NrBHY7_Ni3TZ3cVbcq129ad5lztFqrAYS710Pvv1ow2bZY2XNGV1gw>
 <xme:NrBHY3tQatCkmrhc2_bIhRoGWRGOqxv5firinyaUfWUaMrKmhSZ-4DcpdrafBG5Xr
 vDrDMrPBmVYdpapWdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejledguddutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
 rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
 htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
 keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:NrBHY5AeVxScoHloAQn3dk12_0JBsCSMxhuCYcm0_4fd4jccNPWxqA>
 <xmx:NrBHY3fPMECVqQVWlU7aEwnSnBUtJ3eZzm5kEW7Di4IbMUH406kCmw>
 <xmx:NrBHYwMEJd_OL-fNGSTJEFtKIs8WIBfG6KXbe-VRRsY3OPi7Nu-NYw>
 <xmx:N7BHYyv332Ii0uhigppB6rMr2NLWWMg9MonS7J95YHIiD4hXOpdN6Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 28323B60086; Thu, 13 Oct 2022 02:29:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <a35fd31b-0658-4ac1-8340-99cdf4c75bb7@app.fastmail.com>
In-Reply-To: <20221012180806-mutt-send-email-mst@kernel.org>
References: <20221010132030-mutt-send-email-mst@kernel.org>
 <87r0zdmujf.fsf@mpe.ellerman.id.au>
 <20221012070532-mutt-send-email-mst@kernel.org>
 <87mta1marq.fsf@mpe.ellerman.id.au> <87edvdm7qg.fsf@mpe.ellerman.id.au>
 <20221012115023-mutt-send-email-mst@kernel.org>
 <CAHk-=wg2Pkb9kbfbstbB91AJA2SF6cySbsgHG-iQMq56j3VTcA@mail.gmail.com>
 <38893b2e-c7a1-4ad2-b691-7fbcbbeb310f@app.fastmail.com>
 <20221012180806-mutt-send-email-mst@kernel.org>
Date: Thu, 13 Oct 2022 08:28:03 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [GIT PULL] virtio: fixes, features
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

On Thu, Oct 13, 2022, at 12:08 AM, Michael S. Tsirkin wrote:
> On Wed, Oct 12, 2022 at 11:06:54PM +0200, Arnd Bergmann wrote:
>> On Wed, Oct 12, 2022, at 7:22 PM, Linus Torvalds wrote:
>> >
>> > The NO_IRQ thing is mainly actually defined by a few drivers that just
>> > never got converted to the proper world order, and even then you can
>> > see the confusion (ie some drivers use "-1", others use "0", and yet
>> > others use "((unsigned int)(-1)".
>> 
>> The last time I looked at removing it for arch/arm/, one problem was
>> that there were a number of platforms using IRQ 0 as a valid number.
>> We have converted most of them in the meantime, leaving now only
>> mach-rpc and mach-footbridge. For the other platforms, we just
>> renumbered all interrupts to add one, but footbridge apparently
>> relies on hardcoded ISA interrupts in device drivers. For rpc,
>> it looks like IRQ 0 (printer) already wouldn't work, and it
>> looks like there was never a driver referencing it either.
>
> Do these two boxes even have pci?

Footbridge/netwinder has PCI and PC-style ISA on-board devices
(floppy, ps2 mouse/keyboard, parport, soundblaster, ...), RiscPC
has neither.

    Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
