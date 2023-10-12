Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B662CDB482
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 10:30:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0ADD4087A;
	Thu, 12 Oct 2023 10:30:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0ADD4087A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Iu1maRYc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F7Y_EazbGetb; Thu, 12 Oct 2023 10:30:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2FD6040491;
	Thu, 12 Oct 2023 10:30:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FD6040491
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16141C0039;
	Thu, 12 Oct 2023 10:30:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B517EC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 10:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 832BE81D02
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 10:30:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 832BE81D02
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Iu1maRYc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8ips-1Mpwu3w
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 10:30:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 98AD981CAF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 10:30:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98AD981CAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697106638; x=1728642638;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=hradNalj6PFxuR3qnMWgd3TgXQ0asLVDZrCofaoeVQI=;
 b=Iu1maRYcMLqbCk1YVnXA2Dur+P70uFmDRUjRhHJXA/RLpVjti6AEHqJQ
 eJhlS4ymp8Cr0T5ZOmuZbwjaYPJLGzSMj/KFDN122lLSHZFkIA/HVxQkf
 vXu4oT88wcNW2E9aOuwuCJ/izPswHt9dnhLs4aPm63tgRWKNlfig8kIPo
 V4U5U3NjQGbMxO4ZGjmUPC7Z7YXLDUSqpcZQPktRvDm8RIUkpbNWikGTx
 zq91cEM7d1A9v0kyURTHu+0o3dNuAYAaRzJmqWnHuL45BnTm4WxBi5vd6
 Iye2dB18wawejK2qsudBynyeoZPtJGOz4V4kQoU0S1DjilrPrXs6RL91D Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="449074057"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; d="scan'208";a="449074057"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 03:30:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="820085773"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; d="scan'208";a="820085773"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.29.0])
 ([10.93.29.0])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 03:30:35 -0700
Message-ID: <3aaec14f-6b54-6a4c-7fb3-49120607c42c@intel.com>
Date: Thu, 12 Oct 2023 18:30:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over virtio
 device
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <ZSAG9cedvh+B0c0E@infradead.org> <20231010131031.GJ3952@nvidia.com>
 <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <20231010155937.GN3952@nvidia.com> <ZSY9Cv5/e3nfA7ux@infradead.org>
 <20231011021454-mutt-send-email-mst@kernel.org>
 <ZSZHzs38Q3oqyn+Q@infradead.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <ZSZHzs38Q3oqyn+Q@infradead.org>
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 jiri@nvidia.com, leonro@nvidia.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 10/11/2023 2:59 PM, Christoph Hellwig wrote:
> On Wed, Oct 11, 2023 at 02:43:37AM -0400, Michael S. Tsirkin wrote:
>>> Btw, what is that intel thing everyone is talking about?  And why
>>> would the virtio core support vendor specific behavior like that?
>> It's not a thing it's Zhu Lingshan :) intel is just one of the vendors
>> that implemented vdpa support and so Zhu Lingshan from intel is working
>> on vdpa and has also proposed virtio spec extensions for migration.
>> intel's driver is called ifcvf.  vdpa composes all this stuff that is
>> added to vfio in userspace, so it's a different approach.
> Well, so let's call it virtio live migration instead of intel.
>
> And please work all together in the virtio committee that you have
> one way of communication between controlling and controlled functions.
> If one extension does it one way and the other a different way that's
> just creating a giant mess.
I hope so, Jason Wang has proposed a solution to cooperate, but sadly
rejected...
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
