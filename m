Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA66C4727D
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 15:35:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00919208B6
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 15:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8l1/5tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00919208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 625B52E172;
	Fri, 25 Sep 2020 15:35:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w7oQ9FDIU+zQ; Fri, 25 Sep 2020 15:35:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 94DB62E16B;
	Fri, 25 Sep 2020 15:35:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62851C0859;
	Fri, 25 Sep 2020 15:35:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03300C0051;
 Fri, 25 Sep 2020 15:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E4D6D86E34;
 Fri, 25 Sep 2020 15:34:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sZYSfD2rf7Vm; Fri, 25 Sep 2020 15:34:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9CA7F86E33;
 Fri, 25 Sep 2020 15:34:57 +0000 (UTC)
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 03C42208B6;
 Fri, 25 Sep 2020 15:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601048097;
 bh=isVzHZ3nVuZIMD/UCtK27yZnNv9xwKk4e6gsdrwViRE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=Q8l1/5txbGVUFYp+yS5jaVgBKf7HBxVWWvn7dssI/T/VnXgtOB3Yh/7ap1pyo1o5L
 68VuRk9wGLg9eN4ujSNKD2a6mD+n9gCRf/V/9MQCib3gQCnjawrnDRi5UXZY5E+uCt
 JGwodDTR2rO5rp3MdsEcOdGztSNeOjeGLARtuDMk=
Date: Fri, 25 Sep 2020 10:34:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v3 5/6] iommu/virtio: Support topology description in
 config space
Message-ID: <20200925153455.GA2437869@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200925081243.GA490533@myrica>
Cc: virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, mst@redhat.com,
 linux-pci@vger.kernel.org, joro@8bytes.org,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 bhelgaas@google.com
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

On Fri, Sep 25, 2020 at 10:12:43AM +0200, Jean-Philippe Brucker wrote:
> On Thu, Sep 24, 2020 at 10:22:03AM -0500, Bjorn Helgaas wrote:
> > On Fri, Aug 21, 2020 at 03:15:39PM +0200, Jean-Philippe Brucker wrote:

> > > +	/* Perform the init sequence before we can read the config */
> > > +	ret = viommu_pci_reset(common_cfg);
> > 
> > I guess this is some special device-specific reset, not any kind of
> > standard PCI reset?
> 
> Yes it's the virtio reset - writing 0 to the status register in the BAR.

I wonder if this should be named something like viommu_virtio_reset(),
so there's no confusion with PCI resets and all the timing
restrictions, config space restoration, etc. associated with them.

Bjorn
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
