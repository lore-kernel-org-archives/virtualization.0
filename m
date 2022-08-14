Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEA3C25B06
	for <virtualization@archiver.kernel.org>; Sun, 14 Aug 2022 19:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A513C81BD6;
	Sun, 14 Aug 2022 19:40:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A513C81BD6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=anarazel.de header.i=@anarazel.de header.a=rsa-sha256 header.s=fm1 header.b=uH75q/Oz;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=sk9ii4aX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5kemyEFrdVYW; Sun, 14 Aug 2022 19:40:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C6F0282725;
	Sun, 14 Aug 2022 19:40:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6F0282725
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99D92C0032;
	Sun, 14 Aug 2022 19:40:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5593AC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 19:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ECAC282725
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 19:40:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ECAC282725
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wYEyG05k35kS
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 19:40:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4A9881BD6
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4A9881BD6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 19:40:40 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 4605B5C0075;
 Sun, 14 Aug 2022 15:40:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Sun, 14 Aug 2022 15:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
 cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1660506035; x=1660592435; bh=OFDS3Ok0yf
 v0moILB97wP3ESPtiwUDtMRJp1ZG51Sj8=; b=uH75q/OzmmB40Yjv4xjn0dDp09
 XBh1CAgIfN7IU5ALlW1lsT3zSrRb4fCzjb5iG5tYqKExCYNnE7W6NsIV8PnIpzbG
 WfD8Z1UgArCnHOHDdsCW5VNKaQV0YOsPeSsKoxx5/sTarSD/o8b2t+tWjxFdl92o
 jASY+/ZepjkQLn6WaOIGBkYb9ykYCgYf0LGVeTztsbVeg7/UlzrwjpPy8MxyRqE3
 XCQC865gnWwoKtgrd23Vce48ZR1Bzbk3yOogkCCWZDMPzMwC+OX+zzxfNKZL/PdO
 61fDyxfkNbQxL2ZQgjKMclIhvfEMS7E2lK0dF9I1UMaMyZBoVRQUxPO+YBeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1660506035; x=1660592435; bh=OFDS3Ok0yfv0moILB97wP3ESPtiw
 UDtMRJp1ZG51Sj8=; b=sk9ii4aXH/3jVA9fddHFDm48OBqIaUOntKcROmicKQrh
 COlH601UOwpnDR12lb7lJgbxzVtkPN+J3jnqZ37l4lpvo/A/bi1gcv2m71S8tZQC
 AmKOHzGnkCOKCuMF3Ts56/28kOE59E2Qergj2MeKpq98XEQel0zKHpIk7UG5u/+K
 gtKC0TJpLs2+gMuh2LuxBMaMapmLZRRDZ73bKPkWxZSxi85tVqjh0j5KCydrwMnz
 Gl+EjrGBzTK0CGaJd2wqEXlACbY0XUri/afSdt9biuZKhK8UF9MwDyxOxqNDBU74
 HOG4KoNNBN/UQOfoP25aZRwNQZZRyx/OXmwmB0IObw==
X-ME-Sender: <xms:sU_5YiTe5wqJsCWmf1j7jScCYIoOIuGgK6mBpj5svVgh3xsafPPagQ>
 <xme:sU_5YnwJdD8vs7LhVGMkKbvEasnvdpHdSAw1qiVcvrH0xH1-VdzNQX_nsZK_NSqKP
 XcX5WPUwIFCjD3Jxg>
X-ME-Received: <xmr:sU_5Yv3JnYJt6WwcGb0jGnWSZStf8qsDkC7HXPPaLwTaqX9PKWRubjzLN1ZevacA7OAPWfbu8t2wC6LCJyXIwVWWtXRX3IUQv1Aq344bwM_e9lV8vyzEm2vUHQKt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehtddgudegudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgu
 rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
 frrghtthgvrhhnpedvffefvefhteevffegieetfefhtddvffejvefhueetgeeludehteev
 udeitedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:sU_5YuC6x0AkDcy0k1TxCWh67N2aZOXEsAm-BpZ61Nt4Iip923V8Ow>
 <xmx:sU_5YriVs8ldXhNXKnyeYU1IqQ6BzySWVSpElFy-8gUhc_9WHynEaw>
 <xmx:sU_5YqqrgFDpjkd4C1j5knMFr1Jgxyt3M_VssQXsbablF7UTuVkNfw>
 <xmx:s0_5YuMbcnHFU0IF30q_brMWsXuethJVTLzLesNi--Kk-T8meBptkg>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Aug 2022 15:40:32 -0400 (EDT)
Date: Sun, 14 Aug 2022 12:40:31 -0700
From: Andres Freund <andres@anarazel.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [GIT PULL] virtio: fatures, fixes
Message-ID: <20220814194031.ciql3slc5c34ayjw@awork3.anarazel.de>
References: <20220812114250-mutt-send-email-mst@kernel.org>
 <20220814004522.33ecrwkmol3uz7aq@awork3.anarazel.de>
 <1660441835.6907768-1-xuanzhuo@linux.alibaba.com>
 <20220814035239.m7rtepyum5xvtu2c@awork3.anarazel.de>
 <20220814043906.xkmhmnp23bqjzz4s@awork3.anarazel.de>
 <20220814045853-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220814045853-mutt-send-email-mst@kernel.org>
Cc: peng.fan@nxp.com, kvm@vger.kernel.org, alvaro.karsz@solid-run.com,
 virtualization@lists.linux-foundation.org, quic_mingxue@quicinc.com,
 syoshida@redhat.com, elic@nvidia.com, eperezma@redhat.com,
 jiaming@nfschina.com, hulkci@huawei.com, liubo03@inspur.com,
 dan.carpenter@oracle.com, kangjie.xu@linux.alibaba.com, robin.murphy@arm.com,
 hdegoede@redhat.com, pankaj.gupta@amd.com, gautam.dawar@xilinx.com,
 suwan.kim027@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xuqiang36@huawei.com, xieyongji@bytedance.com, colin.i.king@gmail.com,
 lingshan.zhu@intel.com, colin.king@intel.com,
 Linus Torvalds <torvalds@linux-foundation.org>
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

On 2022-08-14 04:59:48 -0400, Michael S. Tsirkin wrote:
> On Sat, Aug 13, 2022 at 09:39:06PM -0700, Andres Freund wrote:
> > Hi,
> > 
> > On 2022-08-13 20:52:39 -0700, Andres Freund wrote:
> > > Is there specific information you'd like from the VM? I just recreated the
> > > problem and can extract.
> > 
> > Actually, after reproducing I seem to now hit a likely different issue. I
> > guess I should have checked exactly the revision I had a problem with earlier,
> > rather than doing a git pull (up to aea23e7c464b)
> 
> Looks like there's a generic memory corruption so it crashes
> in random places.

Either a generic memory corruption, or something wrong with IO.

> Would bisect be possible for you?

I'll give it a go.

Greetings,

Andres Freund
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
