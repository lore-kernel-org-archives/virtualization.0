Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A586EE784B2
	for <virtualization@archiver.kernel.org>; Mon,  2 Oct 2023 10:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B2188174F;
	Mon,  2 Oct 2023 10:16:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B2188174F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Midz3GQE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OOGv5h1s7Vec; Mon,  2 Oct 2023 10:16:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5AE80813F1;
	Mon,  2 Oct 2023 10:16:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5AE80813F1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43871C0039;
	Mon,  2 Oct 2023 10:16:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39274C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 10:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06ECB41BE6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 10:16:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 06ECB41BE6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Midz3GQE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id trOnLvyg-nwm
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 10:16:25 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BCEFF41BEE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 10:16:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BCEFF41BEE
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 03FF860C52;
 Mon,  2 Oct 2023 10:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5421FC433C8;
 Mon,  2 Oct 2023 10:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696241784;
 bh=Zp1fUQdvvDOBn2zC04x0dm4q+E+VpLrN7Vzr5lIB0F4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Midz3GQE/+bTWncFNRiewuFy1y+nRs0kSgUdvSA4XWlS/09Qu45v/gb1i005N0cPh
 rXwF7Oe0TnNvp4jLr8oo+MjsOOoPCqhzbj/OJ4y9/2murYaOOD8NoOqcRMgQEAZmmU
 xvUBTl0MUGrtgu5mplBZPpk+DaQibzza4hCFSr7bFLrrAtjR22ByCCERGPb4DxLUvI
 YkPB89+gv64FHQOCiDoMROyDqUONytht3mmvA2saKayiCGqbO+fpcHvHjaP9yvMBG4
 3084LKsoDEDxdHDv+6XOWtsCztDia7huFEYcCEmS/MCOVOILzwJHSlFAcPfWRZ2CdC
 03auPIhXKKWqg==
From: Leon Romanovsky <leon@kernel.org>
To: eperezma@redhat.com, gal@nvidia.com,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
Subject: Re: (subset) [PATCH vhost v2 00/16] vdpa: Add support for vq
 descriptor mappings
Message-Id: <169624178143.78680.3290011186914893676.b4-ty@kernel.org>
Date: Mon, 02 Oct 2023 13:16:21 +0300
MIME-Version: 1.0
X-Mailer: b4 0.12-dev-a055d
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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


On Thu, 28 Sep 2023 19:45:11 +0300, Dragos Tatulea wrote:
> This patch series adds support for vq descriptor table mappings which
> are used to improve vdpa live migration downtime. The improvement comes
> from using smaller mappings which take less time to create and destroy
> in hw.
> 
> The first part adds the vdpa core changes from Si-Wei [0].
> 
> [...]

Applied, thanks!

[01/16] vdpa/mlx5: Expose descriptor group mkey hw capability
        https://git.kernel.org/rdma/rdma/c/d424348b060d87

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
