Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFA3C433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 12:49:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFFE264DE7
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 12:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFE264DE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A2E5A85124;
	Wed,  3 Feb 2021 12:49:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w_5EYzWcRMVX; Wed,  3 Feb 2021 12:49:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3EC2885010;
	Wed,  3 Feb 2021 12:49:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EA83C1DA7;
	Wed,  3 Feb 2021 12:49:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E26BC0174;
 Wed,  3 Feb 2021 12:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6579F8653F;
 Wed,  3 Feb 2021 12:49:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XI9JYc3xxmOl; Wed,  3 Feb 2021 12:49:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2A33485A82;
 Wed,  3 Feb 2021 12:49:27 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3E31267357; Wed,  3 Feb 2021 13:49:23 +0100 (CET)
Date: Wed, 3 Feb 2021 13:49:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin Radev <martin.b.radev@gmail.com>
Subject: Re: [PATCH] swiotlb: Validate bounce size in the sync/unmap path
Message-ID: <20210203124922.GB16923@lst.de>
References: <X/27MSbfDGCY9WZu@martin> <20210113113017.GA28106@lst.de>
 <YAV0uhfkimXn1izW@martin>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YAV0uhfkimXn1izW@martin>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: thomas.lendacky@amd.com, file@sect.tu-berlin.de,
 robert.buhren@sect.tu-berlin.de, kvm@vger.kernel.org, konrad.wilk@oracle.com,
 mathias.morbitzer@aisec.fraunhofer.de, joro@8bytes.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 Christoph Hellwig <hch@lst.de>, kirill.shutemov@linux.intel.com,
 m.szyprowski@samsung.com
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

On Mon, Jan 18, 2021 at 12:44:58PM +0100, Martin Radev wrote:
> Your comment makes sense but then that would require the cooperation
> of these vendors and the cloud providers to agree on something meaningful.
> I am also not sure whether the end result would be better than hardening
> this interface to catch corruption. There is already some validation in
> unmap path anyway.

So what?  If you guys want to provide a new capability you'll have to do
work.  And designing a new protocol based around the fact that the
hardware/hypervisor is not trusted and a copy is always required makes
a lot of more sense than throwing in band aids all over the place.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
