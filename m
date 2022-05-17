Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D924FC433F5
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 14:05:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6FB2840C72;
	Tue, 17 May 2022 14:05:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MHoeq86J3z0V; Tue, 17 May 2022 14:05:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7D18040C6F;
	Tue, 17 May 2022 14:05:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51853C0032;
	Tue, 17 May 2022 14:05:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61B3EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A1354093D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:04:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z4SidnckwrH0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:04:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4AAA140902
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:04:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 19E32615C7;
 Tue, 17 May 2022 14:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449AEC34116;
 Tue, 17 May 2022 14:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652796295;
 bh=Q2KpV/j2HnVCcTf13L/YKoxhkcb4XM6FTwEhlWOH0vA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j32IXsAfOr79u1X0Suaw8ekFaezaseBcc7NgoIGbMpu3OKCg7nXWb6piMdPzCtH3T
 8jM7pHfs5dkojn9N4AgfpIVj/ZckGLqc07q0UZI8+ZAdqcebRy642vy3Ilb1ynoNri
 tmH/Tz8gWMY043W39P9duG3I/UyHdgfRXIn2HvM0jR/3xvrhTR1MlGqvJjUqOjg2qp
 LrCg9AanQK1ars7TGq/R6AENgZxWEaUof7PtWtqT4eT8CBmvtUnA8O6icQ9wH9GZEM
 BOnM3LFV7cCc+9ObMGUOBKKxeJpT+Ur7GVhZ6Oi9iiuls3GPHfA0rXhS60ZcXe8PxF
 K3UqJq5CYVpZA==
From: Will Deacon <will@kernel.org>
To: Elliot Berman <quic_eberman@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Alexey Makhalov <amakhalov@vmware.com>, Juergen Gross <jgross@suse.com>,
 "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH v3] arm64: paravirt: Use RCU read locks to guard
 stolen_time
Date: Tue, 17 May 2022 15:04:44 +0100
Message-Id: <165279381181.2978864.3665903579432057917.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220513174654.362169-1-quic_eberman@quicinc.com>
References: <20220513174654.362169-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Cc: Murali Nalajala <quic_mnalajal@quicinc.com>, kernel-team@android.com,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Fri, 13 May 2022 10:46:54 -0700, Elliot Berman wrote:
> From: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> 
> During hotplug, the stolen time data structure is unmapped and memset.
> There is a possibility of the timer IRQ being triggered before memset
> and stolen time is getting updated as part of this timer IRQ handler. This
> causes the below crash in timer handler -
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: paravirt: Use RCU read locks to guard stolen_time
      https://git.kernel.org/arm64/c/19bef63f951e

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
