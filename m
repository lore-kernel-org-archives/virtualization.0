Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20215C38142
	for <virtualization@archiver.kernel.org>; Mon, 23 Jan 2023 09:59:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F09460C0A;
	Mon, 23 Jan 2023 09:59:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F09460C0A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=Tr3JGNsZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lOqVxLszzDW9; Mon, 23 Jan 2023 09:59:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 58A0560BD1;
	Mon, 23 Jan 2023 09:59:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58A0560BD1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43758C0033;
	Mon, 23 Jan 2023 09:59:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48D8CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 09:59:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1545081E66
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 09:59:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1545081E66
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org
 header.a=rsa-sha256 header.s=default header.b=Tr3JGNsZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hsy6zVIfogeW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 09:59:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C095881E28
Received: from mail.8bytes.org (mail.8bytes.org
 [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by smtp1.osuosl.org (Postfix) with ESMTP id C095881E28
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 09:59:37 +0000 (UTC)
Received: from 8bytes.org (p5b006afb.dip0.t-ipconnect.de [91.0.106.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 9A316262C2B;
 Mon, 23 Jan 2023 10:59:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1674467975;
 bh=0KQBObUcnpg5GrqXq3hC5RyjGf2zS6TIXg2zcVgFWn0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Tr3JGNsZMXVI480xgKW5iIBnC2CS9vyEqh9gWSstha079Y/cRMHa9gi+uxnReHb5d
 fwek2sY7wwUJnFwFFwIvWemH12HdN0YbgdSZ2RWwC0269UqDUwGwB35CRDyXhq60AT
 USyIwI3wP05/5oGtUOpS94M53A08jNcPckKA5ZXpZIPRaNJ96Q+BFkTkmpgSNGCPm5
 YogHT95t/tBdYhxC9Y35A2TokJihCUBd4VwOl8Pa35zfKfyCatWPy6AY7P+apvfw5a
 T/W6TQnG+GLz390G6KRQWUX8KnoKg77Sxn7JUzcugID6/sS1m397rjmidCEXxQK2Lj
 1j8HX1fY4eNAw==
Date: Mon, 23 Jan 2023 10:59:32 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/8] iommu: Add a gfp parameter to iommu_map()
Message-ID: <Y85ahCk3sRTVAU8O@8bytes.org>
References: <1-v1-6e8b3997c46d+89e-iommu_map_gfp_jgg@nvidia.com>
 <4fd1b194-29ef-621d-4059-a8336058f217@arm.com>
 <Y7hZOwerwljDKoQq@nvidia.com> <Y8pd50mdNShTyVRX@8bytes.org>
 <Y8rVJGyTKAjXjLwV@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y8rVJGyTKAjXjLwV@nvidia.com>
Cc: kvm@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-s390@vger.kernel.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, linux-rdma@vger.kernel.org,
 ath10k@lists.infradead.org, iommu@lists.linux.dev, ath11k@lists.infradead.org,
 linux-media@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>,
 linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Lu Baolu <baolu.lu@linux.intel.com>
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

On Fri, Jan 20, 2023 at 01:53:40PM -0400, Jason Gunthorpe wrote:
> > Well, having GFP parameters is not a strict kernel convention. There are
> > places doing it differently and have sleeping and atomic variants of
> > APIs. I have to say I like the latter more. But given that this leads to
> > an invasion of API functions here which all do the same under the hood, I
> > agree it is better to go with a GFP parameter here.
> 
> Ok, I think we are done with this series, I'll stick it in linux-next
> for a bit and send you a PR so the trees stay in sync

This series mostly touches parts outside of IOMMUFD, so we should follow
the process here and let this reach linux-next via the IOMMU tree.
Please send me a new version and I will put it into a separate branch
where you can pull it from.

Regards,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
