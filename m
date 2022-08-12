Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959F6C25B0F
	for <virtualization@archiver.kernel.org>; Fri, 12 Aug 2022 16:59:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F24A8343F;
	Fri, 12 Aug 2022 16:59:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F24A8343F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M0+xi+wW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5HSiNq0Ozyi2; Fri, 12 Aug 2022 16:59:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A414383077;
	Fri, 12 Aug 2022 16:59:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A414383077
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FB5FC0033;
	Fri, 12 Aug 2022 16:59:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E4CDC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 16:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B42460B30
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 16:59:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B42460B30
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=M0+xi+wW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uOOLKWw6hvn7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 16:59:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F07860B2F
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F07860B2F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 16:59:35 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4FF60615D5;
 Fri, 12 Aug 2022 16:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADF31C433C1;
 Fri, 12 Aug 2022 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660323573;
 bh=UTKXm22gxGKOxQwXMb2+WzZLLlwtMaey0B1673Ha0c0=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=M0+xi+wW9kr/9EALHN5PaRgaWI682cL1D0MjZjpUvSKizAEdNmkR+cEMSClYXheBM
 t33+JlyYKkYUWG3uxGRuCzLLLCpXGjUHmy4CJWwEQqlakX79MssnxmFy+zyfM42nkG
 oWxvd69utb3t42NpTAFv7i0Eea7m4D8tfK2nKYFURxyQ11bbceYuiDi10kspiu6bpV
 liBqp36MlEcvcJrf14d5vfWlbDwPVIy9sWYG+CmYFH6cz6pI69hQk5JfIPV0/lkHiZ
 WGcd/21JOEROn9mNDzeIrjWKAxSnGcfpkQKJfq4wEduuUnOsl0Ukdolzl4VxYDXYOj
 Msy4NdT8RHvKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 96D06C43142; Fri, 12 Aug 2022 16:59:33 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: fatures, fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20220812114250-mutt-send-email-mst@kernel.org>
References: <20220812114250-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220812114250-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 93e530d2a1c4c0fcce45e01ae6c5c6287a08d3e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a53e17accce9d310d2e522dfc701d8da7ccfa65
Message-Id: <166032357360.14629.10068636645471683682.pr-tracker-bot@kernel.org>
Date: Fri, 12 Aug 2022 16:59:33 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: peng.fan@nxp.com, kvm@vger.kernel.org, alvaro.karsz@solid-run.com,
 virtualization@lists.linux-foundation.org, quic_mingxue@quicinc.com,
 syoshida@redhat.com, elic@nvidia.com, eperezma@redhat.com, mst@redhat.com,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The pull request you sent on Fri, 12 Aug 2022 11:42:50 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a53e17accce9d310d2e522dfc701d8da7ccfa65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
