Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F12C433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 19:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49C3F41733;
	Wed,  9 Nov 2022 19:14:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49C3F41733
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bqEgvkKs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fAjG6T7uIMqb; Wed,  9 Nov 2022 19:14:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 711C0416F9;
	Wed,  9 Nov 2022 19:14:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 711C0416F9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45A2FC0032;
	Wed,  9 Nov 2022 19:14:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15D0DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 19:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F14CA81DE1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 19:14:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F14CA81DE1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=bqEgvkKs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SLUOVbJzkLSg
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 19:14:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98A038176D
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 98A038176D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 19:14:17 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 94AC1B81FFA;
 Wed,  9 Nov 2022 19:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF08C433C1;
 Wed,  9 Nov 2022 19:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668021254;
 bh=1uVDPNJRQ+D3xfqxDufJ9hfMqQFP0sCRLukEn84C9tc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bqEgvkKsUshQBVyh05e4wb4YfxyMwRH1UulPWrOWqpOtoNuwcva78j9sr3AGlX1GK
 SUaJpgJZ0MR3VDUnzXk64yKL+xO35EwSlp6e6g8pH//Uxcoq/EoQ0t8Gc65g7uTArl
 Fo+7DHewb1AydQT641SYKiRl8eViJTyw9r7sKuKRHPjkjbVLYlH1mlFZwN34tleoTj
 6SXL8gKdpkyOxgnCvcvs1alzDCWABQQRJrECrkRBtLdefzVWetFYM+E6mUpQzpmc9M
 7es1n20IMzpLYxGUKfGuGulLiXY7khojzo3/hSzxRDi5Ujq+6aJpBNmq8gQd3deSmn
 9pa4COGZY2Nww==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 Usama Arif <usama.arif@bytedance.com>, steven.price@arm.com,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, maz@kernel.org,
 linux@armlinux.org.uk, yezengruan@huawei.com, catalin.marinas@arm.com,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] arm64: paravirt: remove conduit check in
 has_pv_steal_clock
Date: Wed,  9 Nov 2022 19:14:00 +0000
Message-Id: <166801751676.863548.12274621159317849693.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221104061659.4116508-1-usama.arif@bytedance.com>
References: <20221104061659.4116508-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Cc: punit.agrawal@bytedance.com, Will Deacon <will@kernel.org>,
 liangma@liangbit.com, kernel-team@android.com, fam.zheng@bytedance.com
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

On Fri, 4 Nov 2022 06:16:59 +0000, Usama Arif wrote:
> arm_smccc_1_1_invoke() which is called later on in the function
> will return failure if there's no conduit (or pre-SMCCC 1.1),
> hence the check is unnecessary.
> 
> 

Applied to arm64 (for-next/trivial), thanks!

[1/1] arm64: paravirt: remove conduit check in has_pv_steal_clock
      https://git.kernel.org/arm64/c/1e55b44d9ecd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
