Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCA4C4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 21:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 026254038B;
	Tue, 20 Dec 2022 21:55:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 026254038B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=lTBbHcgY;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JQ5P4Ejy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d1UtxQOHsbEd; Tue, 20 Dec 2022 21:55:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9774C403E2;
	Tue, 20 Dec 2022 21:55:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9774C403E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E367C0032;
	Tue, 20 Dec 2022 21:55:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33EC0C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 21:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C44D36079D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 21:55:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C44D36079D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de
 header.a=rsa-sha256 header.s=fm1 header.b=lTBbHcgY; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=JQ5P4Ejy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Akdkq1BJoV6O
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 21:55:49 +0000 (UTC)
X-Greylist: delayed 00:06:47 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D780A600CA
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D780A600CA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 21:55:48 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 3F86D5C012E;
 Tue, 20 Dec 2022 16:48:59 -0500 (EST)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Tue, 20 Dec 2022 16:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1671572939; x=1671659339; bh=qFNrjE+MU/
 aHWOuwaY9sLeM6ocoYDHmnOKkYGdXz6Ks=; b=lTBbHcgYoQZEGGaHuIbvpX/x5t
 hpxUG4HobRHjPfpEBI9DUySOvbUPDku7Wdt/wacxlVuGwVSrr4HpiLOTswIFvGvv
 zXjbpD/jHf9suSmuS/FxM4YTTJ0J6nZHxsax8WjD/n/LtCsHEU+CTKR7Xk+nw+NJ
 cNqaHe2XPeEWXdZxm3eSN3h4GnEKp7QDd+ozIzZoEL4W0UOpJcA0a3+5SCFTaJDg
 5K7eCkEF8+/9EtivlEZitdhH67d49cb5OxNB50Iq7He64JaU3wo2kSRXRXsAgFYT
 /SjccVLz5mfgtsV39n+U5AMhcyzL3mAHe2p2EHDmaHbmbHQhBPC0oKLAIy4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1671572939; x=1671659339; bh=qFNrjE+MU/aHWOuwaY9sLeM6ocoY
 DHmnOKkYGdXz6Ks=; b=JQ5P4EjydGRaa0w/hRPrIdAv/wgWy64UiIDbWtDzaR2e
 pBXzhTfcpJfIjKSJrXSGMpSLy3+P8p9r2MB0euBqrWX2V1qSaUyFDHRppNzbmCvC
 hAiotAmG8w2fbqsqzJ6QWg19M3tB01FMOZovi32UWH7nR5EcSOuAX2fTuVkgHkS3
 wU4XM/hV5453CJn3dX/qJwDHVr9whriM6vDPmDCG3oxTtK390/54mX66vk3pY2f0
 ZrSHAs5Ga0hYosGJ9UHGIM3IwPvN2tOPIEdQ0B2VrKfo1AHcjY23wRazpLlraetN
 fDKBlCHKHRSnfXo/zIl8hVtj/C7QQFclx6W/Sr9W6A==
X-ME-Sender: <xms:yy2iY79pVamm-m8ywGcXVF805qhm7i3uHm3QlguahNKqOvUmT17YTQ>
 <xme:yy2iY3u8aTyAjI1HnJp68fzyOpDB5TFuJz1XNhn6nN1n93ragUdebZ1Kvh0Xzo0pr
 MEt0VL8rHgIBnSsIlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeigdduvdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
 nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
 htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
 teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
 hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:yy2iY5AaIBsZx-7oZGK7mbEXiy3jlmxKNWgrVWJwSFVDMye9fKpvDA>
 <xmx:yy2iY3cbLAZVNxZQI0J0Tb-rB4KfPsxJwB1hqx1dwBGdpGNUpyPTYQ>
 <xmx:yy2iYwNgbAGE4f8PZjjWejpxx4eANgO2CDhkuFyp-zK29Psrarb6YA>
 <xmx:yy2iY3dbd6Sll9_DW01LQJ7bK8SLbR81gccc8ZtfKMlS06Tc39WkyQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 004BDB60086; Tue, 20 Dec 2022 16:48:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <ee60ef99-b09c-4ed7-ab8e-5df97037cad1@app.fastmail.com>
In-Reply-To: <CAJs=3_B7WoERAiXPyvz=6d7O5rcwXMfWZJFsi_ds-OAemvfcgQ@mail.gmail.com>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <Y6HjpvDfIusAz2uS@dev-arch.thelio-3990X>
 <CAJs=3_B7WoERAiXPyvz=6d7O5rcwXMfWZJFsi_ds-OAemvfcgQ@mail.gmail.com>
Date: Tue, 20 Dec 2022 22:48:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alvaro Karsz" <alvaro.karsz@solid-run.com>,
 "Nathan Chancellor" <nathan@kernel.org>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
Cc: Jean Delvare <jdelvare@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-pci@vger.kernel.org, llvm@lists.linux.dev,
 virtualization@lists.linux-foundation.org, bhelgaas@google.com,
 Guenter Roeck <linux@roeck-us.net>
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

On Tue, Dec 20, 2022, at 17:46, Alvaro Karsz wrote:
> Hi Nathan,
>
>> This does not appear to be a false positive but what was the intent
>> here? Should the local name variables increase their length or should
>> the buffer length be reduced?
>
> You're right, the local name variables and snprintf argument don't match.
> Thanks for noticing.
> I think that we should increase the name variables  to be
> SNET_NAME_SIZE bytes long.

If you can show that the string fits into the current length, it
would be better to keep the stack usage low and just adapt the
length to be sizeof(string) instead of SNET_NAME_SIZE.

    Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
