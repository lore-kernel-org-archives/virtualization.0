Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D68AC32772
	for <virtualization@archiver.kernel.org>; Tue, 23 Aug 2022 14:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D06540606;
	Tue, 23 Aug 2022 14:10:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D06540606
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZMdEepLx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ai7ZSl1TAZfs; Tue, 23 Aug 2022 14:10:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7163840535;
	Tue, 23 Aug 2022 14:10:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7163840535
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4535FC0032;
	Tue, 23 Aug 2022 14:10:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90FB0C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 14:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6595B81449
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 14:10:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6595B81449
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZMdEepLx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z46Dz3dv43S2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 14:10:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F36F81447
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F36F81447
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 14:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1661263824; x=1692799824;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4lie7gCXObgs3m8jIr59zMMngmZ8Lu+4cTjSxyVLY4Q=;
 b=ZMdEepLxgxK1KtGfmfDGfIRr32tijLc7Axsi3ehBjBELmHpb1Vl2Aj0A
 Qfb8GwQtdemiXaFFUThc+iu+49W0iaaant0BAJyAlYZmdAdh8d5Mt5c++
 f/ybjJhvg6iNCldHkl1s0f+Yw86hI8+9adkNKqmQ036MwLHWbSm1tLRDM
 TP+eByjWKCHVorkBB37M67QT7IV6YH8uI8/CGZZoTw+95noaoXF5EQuQm
 AgU4iU5EUeZtleZWSY/pcLYR4bajILjFGc4R6YCxr+aLbjDZWZXSCUqpA
 n+O3zbZ+kvl5uOlxhXCzQaEkOQeIrpxuq+jOtVaRJ6gGKtJuFU5zt/u8N A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="355425127"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; d="scan'208";a="355425127"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2022 07:08:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; d="scan'208";a="735491062"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2022 07:08:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1oQUaA-002T4V-1A; Tue, 23 Aug 2022 17:08:42 +0300
Date: Tue, 23 Aug 2022 17:08:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v1 1/1] iommu/virtio: Do not dereference fwnode in struct
 device
Message-ID: <YwTfam7KZKzgn8sq@smile.fi.intel.com>
References: <20220801165142.20898-1-andriy.shevchenko@linux.intel.com>
 <YvIK0KMi1yECL9vc@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YvIK0KMi1yECL9vc@myrica>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Joerg Roedel <jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
 Will Deacon <will@kernel.org>
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

On Tue, Aug 09, 2022 at 08:20:48AM +0100, Jean-Philippe Brucker wrote:
> On Mon, Aug 01, 2022 at 07:51:42PM +0300, Andy Shevchenko wrote:
> > In order to make the underneath API easier to change in the future,
> > prevent users from dereferencing fwnode from struct device.
> > Instead, use the specific device_match_fwnode() API for that.

> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Thanks!

Can it be applied now?

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
