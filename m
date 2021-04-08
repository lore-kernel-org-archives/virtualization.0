Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585CDC43461
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 09:17:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F9C61139
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 09:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F9C61139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C182984CFC;
	Thu,  8 Apr 2021 09:17:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 48R5HepQJZwv; Thu,  8 Apr 2021 09:17:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78F82837D2;
	Thu,  8 Apr 2021 09:17:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50F33C000B;
	Thu,  8 Apr 2021 09:17:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7819BC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 655384193E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:17:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X0kYB4SK__oK
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:17:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6935341935
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:17:31 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 785BD61139;
 Thu,  8 Apr 2021 09:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1617873451;
 bh=BL5ONyxMkyZ0JDNLF0/KGTXxejLggZKA1i2touSW/Lo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H2kO/NV0cOemarRn8dQRmy2JVmre7kLc+iSpTRx5Qeq5XqdBrp4YnuFZD6eecYAkm
 PPkyPBzpbD87zxP0gxF1IL6W8WET2WR3avFXfnhTZ4qNuKGNXd3qE8zZ5X+O7C9m1h
 p8E+ywKKe7mW3RAKDwKQwcC9tNhfRAb7bpFNKWdA=
Date: Thu, 8 Apr 2021 11:17:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 0/5] VDPA mlx5 fixes
Message-ID: <YG7KKI+8Z6ocGwNf@kroah.com>
References: <20210408091047.4269-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408091047.4269-1-elic@nvidia.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com
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

On Thu, Apr 08, 2021 at 12:10:42PM +0300, Eli Cohen wrote:
> Hi Michael,
> 
> The following series contains fixes to mlx5 vdpa driver.  Included first
> is Siwei's fix to queried MTU was already reviewed a while ago and is
> not in your tree.
> 
> Patches 2 and 3 are required to allow mlx5_vdpa run on sub functions.
> 
> This series contains patches that were included in Parav's series
> http://lists.infradead.org/pipermail/linux-mtd/2016-January/064878.html
> but that series will be sent again at a later time.
> 
> Eli Cohen (4):
>   vdpa/mlx5: Use the correct dma device when registering memory
>   vdpa/mlx5: Retrieve BAR address suitable any function
>   vdpa/mlx5: Fix wrong use of bit numbers
>   vdpa/mlx5: Fix suspend/resume index restoration
> 
> Si-Wei Liu (1):
>   vdpa/mlx5: should exclude header length and fcs from mtu
> 
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  4 +++
>  drivers/vdpa/mlx5/core/mr.c        |  9 +++++--
>  drivers/vdpa/mlx5/core/resources.c |  3 ++-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 40 ++++++++++++++++++------------
>  4 files changed, 37 insertions(+), 19 deletions(-)
> 
> -- 
> 2.30.1
> 


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
