Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E36C433FE
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 21:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E52CE607E1;
	Wed, 12 Oct 2022 21:15:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E52CE607E1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=vAwa1ydC;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VFM8vr6J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NL3Z1vPTVaNo; Wed, 12 Oct 2022 21:15:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7FE3D60597;
	Wed, 12 Oct 2022 21:15:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7FE3D60597
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A6CEC0033;
	Wed, 12 Oct 2022 21:15:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 236CFC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 21:15:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDA7C607E1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 21:15:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CDA7C607E1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jPfq505cjfGI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 21:15:48 +0000 (UTC)
X-Greylist: delayed 00:08:17 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0EB3060597
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0EB3060597
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 21:15:47 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 68F2B5C00BC;
 Wed, 12 Oct 2022 17:07:30 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute3.internal (MEProxy); Wed, 12 Oct 2022 17:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm2; t=1665608850; x=1665695250; bh=1zjTzbu3nE
 vKPjEu+A0VVC9cmYrYpXNTso2KnYCuc7o=; b=vAwa1ydC+9d2I9JWQMsHnQzLD0
 NajTZT00Z6YRtX9eVlpSljSvsU/yFsucT7Aq4Oscd1E2DbgdPAvw7h8MKi+SfPJi
 6olwV0ACpfjzjzNIEvpw0f/+c5g/bj3HsWyEX4gLB+349ezXY0uOnWrZsu6S7TNx
 mfiAfZoqvCDtQdLE6T4GDduKjKA2nipxepU9MAG7ujEEXk99r8DrNRZfGlK15Cfu
 z2WWUcSqqd0bankroEDffJ6XWZiKoziKWQd8PePJNpvICMQhTRfBPaFsQfDtKMUQ
 MpT0yNPx59E+CJiAriCqWotq1txyVUSWV7+ett3PIQE6J6q76SW15b7lC0nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1665608850; x=1665695250; bh=1zjTzbu3nEvKPjEu+A0VVC9cmYrY
 pXNTso2KnYCuc7o=; b=VFM8vr6JEg7opglf79F9TeVrikpH40HEGO+JtHdDIeGo
 JDNkv7wsHZKKzWWSsZGrud+/BfHI86ACBp7Eh2fzKmPR66F8OFpDhsKVcYTF3km4
 fFrIaAgxygV9e3TVbuCCWSF+3oxXTTbLWobgiAdbqQm0TbXyIObYp94McGRHBuYL
 O1dyvj+JVJzlRkigjzYCMQ0mYi0YxGQ4Ipe4pnbIw6CFmauLOazr6n3faaW+nETo
 5vFahsqFKyaqFPx8QGAQW3Tdw+ANTXwL8y8U/rytPX57DKMWyIGBdHLm4rMbHaVe
 kqcHrt6Y/l1Vx6o3khLwq3Hlu6WofmmXMSVZWsPt2Q==
X-ME-Sender: <xms:kSxHY4uYl8NqQVKE7TlRYofsBddMRUrI96xa6Pk9mWO3s30GLZXhVw>
 <xme:kSxHY1fxsuw10Uc3pbJSjBs6_0Up0QOclLg48G8pVmvua6kas8vOv7Rp8Ih-15c7Q
 aHhfUnNJWhs47BeYJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejkedgudehlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
 rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
 htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
 keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:kSxHYzxEmXJhVtY7mzAljiIxJ8g7vbYtpPC0tpJEjUSewlAhg0JIhw>
 <xmx:kSxHY7Nhw7JdZ-kUMWRwEPuRQzBFD8USLwWQFxnptjhFcbC8wS7iMg>
 <xmx:kSxHY48vPy4-hM5zI6LGwuSveJEJXMlJt5fVNQg9kSkEIfc1U4af4w>
 <xmx:kixHYydoUmNqBtkkA6x_gy4dCaEesVEAWfyCYVTtN8EfE59z9KQcCw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 02DC4B60086; Wed, 12 Oct 2022 17:07:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <38893b2e-c7a1-4ad2-b691-7fbcbbeb310f@app.fastmail.com>
In-Reply-To: <CAHk-=wg2Pkb9kbfbstbB91AJA2SF6cySbsgHG-iQMq56j3VTcA@mail.gmail.com>
References: <20221010132030-mutt-send-email-mst@kernel.org>
 <87r0zdmujf.fsf@mpe.ellerman.id.au>
 <20221012070532-mutt-send-email-mst@kernel.org>
 <87mta1marq.fsf@mpe.ellerman.id.au> <87edvdm7qg.fsf@mpe.ellerman.id.au>
 <20221012115023-mutt-send-email-mst@kernel.org>
 <CAHk-=wg2Pkb9kbfbstbB91AJA2SF6cySbsgHG-iQMq56j3VTcA@mail.gmail.com>
Date: Wed, 12 Oct 2022 23:06:54 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [GIT PULL] virtio: fixes, features
Cc: xiujianfeng@huawei.com, kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 wangdeming@inspur.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>,
 angus.chen@jaguarmicro.com, Bjorn Helgaas <bhelgaas@google.com>,
 lingshan.zhu@intel.com, linuxppc-dev@lists.ozlabs.org, gavinl@nvidia.com
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

On Wed, Oct 12, 2022, at 7:22 PM, Linus Torvalds wrote:
>
> The NO_IRQ thing is mainly actually defined by a few drivers that just
> never got converted to the proper world order, and even then you can
> see the confusion (ie some drivers use "-1", others use "0", and yet
> others use "((unsigned int)(-1)".

The last time I looked at removing it for arch/arm/, one problem was
that there were a number of platforms using IRQ 0 as a valid number.
We have converted most of them in the meantime, leaving now only
mach-rpc and mach-footbridge. For the other platforms, we just
renumbered all interrupts to add one, but footbridge apparently
relies on hardcoded ISA interrupts in device drivers. For rpc,
it looks like IRQ 0 (printer) already wouldn't work, and it
looks like there was never a driver referencing it either.

I see that openrisc and parisc also still define NO_IRQ to -1, but at
least openrisc already relies on 0 being the invalid IRQ (from
CONFIG_IRQ_DOMAIN), probably parisc as well.

     Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
