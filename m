Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F7EC05027
	for <virtualization@archiver.kernel.org>; Fri, 20 Jan 2023 09:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 491DF40550;
	Fri, 20 Jan 2023 09:51:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 491DF40550
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=lOLKVLD4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fosN4tRnaLle; Fri, 20 Jan 2023 09:51:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E3FB140283;
	Fri, 20 Jan 2023 09:51:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E3FB140283
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C30E3C0032;
	Fri, 20 Jan 2023 09:51:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0650FC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 09:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D589A4105A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 09:51:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D589A4105A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F94pkZHZUfO8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 09:51:07 +0000 (UTC)
X-Greylist: delayed 00:26:08 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7393C4118B
Received: from mail.8bytes.org (mail.8bytes.org
 [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7393C4118B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 09:51:07 +0000 (UTC)
Received: from 8bytes.org
 (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de
 [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id E12D62626D1;
 Fri, 20 Jan 2023 10:24:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1674206697;
 bh=N0Ez9jlBhYWiOK7+xYABfIe0+VmfRPgpACpzUje2F4A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lOLKVLD4dyMYfuGfszt0Aqi18MMtbwUvgwVbHoDO6hE/pu3jlsoFnfOvfV2sSJ6i8
 k3lOBgDA7x9bkKbnD+qVSk6qrzEVOc/9/JS99/CzblV3IjUWMNUsDLegoejr0hYkyT
 NIAGgbjvSNtqhO8clUAYjH7vWYcGoTKi2kDTgKFmFcsSDinl9Vo2l2M2oUTe7UNJh3
 4hHtdAX4so62XBRGFWlRKgCJW94p/lPduMMBp2SCZ238xwGOe1m0xh9F5SouN8x7NO
 06U5w+umYu9ogUcIQK1YpQ4ciXMhW+H2quzpMMrP7f3cTLkb2U0hf6Ab3xk/GMJY5E
 1P63Vv4/HChRw==
Date: Fri, 20 Jan 2023 10:24:55 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/8] iommu: Add a gfp parameter to iommu_map()
Message-ID: <Y8pd50mdNShTyVRX@8bytes.org>
References: <1-v1-6e8b3997c46d+89e-iommu_map_gfp_jgg@nvidia.com>
 <4fd1b194-29ef-621d-4059-a8336058f217@arm.com>
 <Y7hZOwerwljDKoQq@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y7hZOwerwljDKoQq@nvidia.com>
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

On Fri, Jan 06, 2023 at 01:24:11PM -0400, Jason Gunthorpe wrote:
> I think it is just better to follow kernel convention and have
> allocation functions include the GFP because it is a clear signal to
> the user that there is an allocation hidden inside the API. The whole
> point of gfp is not to have multitudes of every function for every
> allocation mode.

Well, having GFP parameters is not a strict kernel convention. There are
places doing it differently and have sleeping and atomic variants of
APIs. I have to say I like the latter more. But given that this leads to
an invasion of API functions here which all do the same under the hood, I
agree it is better to go with a GFP parameter here.

Regards,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
