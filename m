Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2856CE7A89
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 04:44:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60F80417E0;
	Mon, 25 Sep 2023 04:44:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60F80417E0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SOn971nm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cOxkb-esamur; Mon, 25 Sep 2023 04:44:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 79CAD417D2;
	Mon, 25 Sep 2023 04:44:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79CAD417D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AF2CC0071;
	Mon, 25 Sep 2023 04:44:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFFE3C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 04:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 94648811F6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 04:44:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 94648811F6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SOn971nm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ECNCgHgdxcuZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 04:44:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 55916810D6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 04:44:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 55916810D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695617079; x=1727153079;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=2Udk7ILXK8hVm0kStsF/kjFOzc0bvoZMNSExj5jdI7M=;
 b=SOn971nmNScAjIKn/lYmadWGyQDxkXMPVAqbfFXkER2SbFIA9IUNFLM+
 zUgT0nePZtqKroEUiVdaiRTH/c5xE9LWey19gVnkUcApaW3Mb5s3SAJoW
 z0FD4czORjXIWWe0SATtdnXZss3MD3FBuB8raGZdP0+N9YSivLQJlR8Lq
 ev+3zbCScuM+CD0L7cEtvdwGoNHVAx5TmZI0fzNWPMfP1oDbIv356teQM
 btQyuwBWdhMQ0dEkD2bynlH4b8Pls0uYyNcUubJ75voOKvYFPL3lK7R/V
 HKTc9coGTCNU1EmCl2YkdTFSeOu+RcHnql2O+IlCI6w9KQDXpVujQVSYN w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="380040936"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; d="scan'208";a="380040936"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2023 21:44:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818476376"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; d="scan'208";a="818476376"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.21.134])
 ([10.93.21.134])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2023 21:44:36 -0700
Message-ID: <db8c1f00-39d2-8305-faca-18fe418d249a@intel.com>
Date: Mon, 25 Sep 2023 12:44:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921090844-mutt-send-email-mst@kernel.org>
 <20230921141125.GM13733@nvidia.com>
 <20230921101509-mutt-send-email-mst@kernel.org>
 <20230921164139.GP13733@nvidia.com>
 <20230921124331-mutt-send-email-mst@kernel.org>
 <20230921183926.GV13733@nvidia.com>
 <20230921151325-mutt-send-email-mst@kernel.org>
 <20230921195115.GY13733@nvidia.com>
 <20230921164558-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230921164558-mutt-send-email-mst@kernel.org>
Cc: leonro@nvidia.com, jiri@nvidia.com, maorg@nvidia.com, kvm@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 9/22/2023 4:55 AM, Michael S. Tsirkin wrote:
> On Thu, Sep 21, 2023 at 04:51:15PM -0300, Jason Gunthorpe wrote:
>> On Thu, Sep 21, 2023 at 03:17:25PM -0400, Michael S. Tsirkin wrote:
>>> On Thu, Sep 21, 2023 at 03:39:26PM -0300, Jason Gunthorpe wrote:
>>>>> What is the huge amount of work am I asking to do?
>>>> You are asking us to invest in the complexity of VDPA through out
>>>> (keep it working, keep it secure, invest time in deploying and
>>>> debugging in the field)
>>> I'm asking you to do nothing of the kind - I am saying that this code
>>> will have to be duplicated in vdpa,
>> Why would that be needed?
> For the same reason it was developed in the 1st place - presumably
> because it adds efficient legacy guest support with the right card?
> I get it, you specifically don't need VDPA functionality, but I don't
> see why is this universal, or common.
>
>
>>> and so I am asking what exactly is missing to just keep it all
>>> there.
>> VFIO. Seriously, we don't want unnecessary mediation in this path at
>> all.
> But which mediation is necessary is exactly up to the specific use-case.
> I have no idea why would you want all of VFIO to e.g. pass access to
> random config registers to the guest when it's a virtio device and the
> config registers are all nicely listed in the spec. I know nvidia
> hardware is so great, it has super robust cards with less security holes
> than the vdpa driver, but I very much doubt this is universal for all
> virtio offload cards.
I agree with MST.
>>> note I didn't ask you to add iommufd to vdpa though that would be
>>> nice ;)
>> I did once send someone to look.. It didn't succeed :(
>>
>> Jason
> Pity. Maybe there's some big difficulty blocking this? I'd like to know.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
