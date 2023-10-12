Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142BACDB46E
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 10:29:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E7D060E11;
	Thu, 12 Oct 2023 10:29:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E7D060E11
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IXIwJqxl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CoPKKxHcQdDc; Thu, 12 Oct 2023 10:29:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F1C9B60A70;
	Thu, 12 Oct 2023 10:29:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F1C9B60A70
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C95E9C0039;
	Thu, 12 Oct 2023 10:29:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D58CFC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 10:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A35FA81282
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 10:29:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A35FA81282
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IXIwJqxl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0GoVQSIEkP8p
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 10:29:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5280180F50
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 10:29:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5280180F50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697106593; x=1728642593;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5SKj5y0nzEh+mHktVwMtOXvHLzceY+BjcxTXjOUlQBE=;
 b=IXIwJqxl8muXrQWGo7hJeLUXAdlYOLn6oanByG1/01OWbLJAdZ3lksb7
 /2/ZSKgSpm7bxWaSo/EEieWkW2on4bkuqv2/LVf+RCy4p//HCTfMI+kC0
 SmWsIUHBRUFL3kalBQF7VfmyPead5bt9nu5DRHofVaTEvvafmqJ4mwGoE
 70PtWbH3N7+oM/xy00H+o9NIJ8NIgLB7oCOipgg9Dq+PlqYvihaEFG5LJ
 f1IvMmcxru30+hjQuQPYNA8nYY9+IjluiA2JQRicohh1WPlDzbDJDxR4k
 r0ZPnKQI+mBrL23agQ+lTIbM/w2dPFGTBAK71TGB14LW6/FC4Sgf9prV2 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="449074000"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; d="scan'208";a="449074000"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 03:29:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="820085560"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; d="scan'208";a="820085560"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.29.0])
 ([10.93.29.0])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 03:29:49 -0700
Message-ID: <c75bb669-76fe-ef12-817e-2a8b5f0b317b@intel.com>
Date: Thu, 12 Oct 2023 18:29:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over virtio
 device
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <ZSAG9cedvh+B0c0E@infradead.org> <20231010131031.GJ3952@nvidia.com>
 <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <20231010155937.GN3952@nvidia.com> <ZSY9Cv5/e3nfA7ux@infradead.org>
 <20231011021454-mutt-send-email-mst@kernel.org>
 <ZSZHzs38Q3oqyn+Q@infradead.org>
 <PH0PR12MB5481336B395F38E875ED11D8DCCCA@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481336B395F38E875ED11D8DCCCA@PH0PR12MB5481.namprd12.prod.outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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



On 10/11/2023 4:00 PM, Parav Pandit via Virtualization wrote:
> Hi Christoph,
>
>> From: Christoph Hellwig <hch@infradead.org>
>> Sent: Wednesday, October 11, 2023 12:29 PM
>>
>> On Wed, Oct 11, 2023 at 02:43:37AM -0400, Michael S. Tsirkin wrote:
>>>> Btw, what is that intel thing everyone is talking about?  And why
>>>> would the virtio core support vendor specific behavior like that?
>>> It's not a thing it's Zhu Lingshan :) intel is just one of the vendors
>>> that implemented vdpa support and so Zhu Lingshan from intel is
>>> working on vdpa and has also proposed virtio spec extensions for migration.
>>> intel's driver is called ifcvf.  vdpa composes all this stuff that is
>>> added to vfio in userspace, so it's a different approach.
>> Well, so let's call it virtio live migration instead of intel.
>>
>> And please work all together in the virtio committee that you have one way of
>> communication between controlling and controlled functions.
>> If one extension does it one way and the other a different way that's just
>> creating a giant mess.
> We in virtio committee are working on VF device migration where:
> VF = controlled function
> PF = controlling function
>
> The second proposal is what Michael mentioned from Intel that somehow combine controlled and controlling function as single entity on VF.
>
> The main reasons I find it weird are:
> 1. it must always need to do mediation to do fake the device reset, and flr flows
> 2. dma cannot work as you explained for complex device state
> 3. it needs constant knowledge of each tiny things for each virtio device type
>
> Such single entity appears a bit very weird to me but maybe it is just me.
sorry for the late reply, we have discussed this for weeks in virtio 
mailing list.
I have proposed a live migration solution which is a config space solution.

We(me, Jason and Eugenio) have been working on this solution for more 
than two years
and we are implementing virtio live migration basic facilities.

The implementation is transport specific, e.g., for PCI we implement new 
or extend registers which
work as other config space registers do.

The reason we are arguing is:
I am not sure admin vq based live migration solution is a good choice, 
because:
1) it does not work for nested
2) it does not work for bare metal
3) QOS problem
4) security leaks.

Sorry to span the discussions here.

Thanks,
Zhu Lingshan
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
