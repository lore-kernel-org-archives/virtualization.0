Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B08CDB465
	for <virtualization@archiver.kernel.org>; Mon, 16 Oct 2023 09:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77C95418BD;
	Mon, 16 Oct 2023 09:53:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77C95418BD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W2rmuOXk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id savj_Vhjuu9T; Mon, 16 Oct 2023 09:53:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A5C1140979;
	Mon, 16 Oct 2023 09:53:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5C1140979
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85FFCC0071;
	Mon, 16 Oct 2023 09:53:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F59AC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 09:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5EC8A81F47
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 09:53:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EC8A81F47
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=W2rmuOXk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NnLKwoEukZGP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 09:53:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7EAA8132E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 09:53:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7EAA8132E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697450013; x=1728986013;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=dAsUnnyluJvXyQp37TtlbSqZLVCD7Sjo47cIWmQv6Pc=;
 b=W2rmuOXktsBe1wH4ZNA3qcjpB6bEtRcDhuGJwY/uZTwcLXAcNaBHOujI
 YxixDIxK2f6fUffl5c0e5MoAgLUpcod16tLdAJW++c6DhdUfoD77FQ55u
 EVmwggiienvMZtb0IV9VB3REYrwr/tUnmZIXgrF/oHgO+qGbJo7ZQHwg0
 2N01NLj/j0SH9TnCRv6D3tyxM5DQDE0GYDLznABwMKTlQ9Txvlcnaih1O
 9uQOczg3Xoga7iBkwv7IjHAsI1PX2g1HJ8x/0Kt2KCsHE7AAkJ2VKZ5N5
 y5H4fgQb/oLrWLRUoVO5wFG4PCbGnaZdsLcSrzLihOLAKcUv7zUh5LSmA g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="382712471"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="382712471"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 02:53:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="825941359"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="825941359"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.35.20])
 ([10.93.35.20])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 02:53:29 -0700
Message-ID: <774272d3-8e73-4323-8772-533896894643@intel.com>
Date: Mon, 16 Oct 2023 17:53:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over virtio
 device
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20231010155937.GN3952@nvidia.com> <ZSY9Cv5/e3nfA7ux@infradead.org>
 <20231011021454-mutt-send-email-mst@kernel.org>
 <ZSZHzs38Q3oqyn+Q@infradead.org>
 <PH0PR12MB5481336B395F38E875ED11D8DCCCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c75bb669-76fe-ef12-817e-2a8b5f0b317b@intel.com>
 <20231012132749.GK3952@nvidia.com>
 <840d4c6f-4150-4818-a66c-1dbe1474b4c6@intel.com>
 <20231013094959-mutt-send-email-mst@kernel.org>
 <818c4212-9d9a-4775-80f3-c07e82057be8@intel.com>
 <20231016045050-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20231016045050-mutt-send-email-mst@kernel.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>
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



On 10/16/2023 4:52 PM, Michael S. Tsirkin wrote:
> On Mon, Oct 16, 2023 at 04:33:10PM +0800, Zhu, Lingshan wrote:
>>
>> On 10/13/2023 9:50 PM, Michael S. Tsirkin wrote:
>>> On Fri, Oct 13, 2023 at 06:28:34PM +0800, Zhu, Lingshan wrote:
>>>> On 10/12/2023 9:27 PM, Jason Gunthorpe wrote:
>>>>
>>>>       On Thu, Oct 12, 2023 at 06:29:47PM +0800, Zhu, Lingshan wrote:
>>>>
>>>>
>>>>           sorry for the late reply, we have discussed this for weeks in virtio mailing
>>>>           list. I have proposed a live migration solution which is a config space solution.
>>>>
>>>>       I'm sorry that can't be a serious proposal - config space can't do
>>>>       DMA, it is not suitable.
>>>>
>>>> config space only controls the live migration process and config the related
>>>> facilities.
>>>> We don't use config space to transfer data.
>>>>
>>>> The new added registers work like queue_enable or features.
>>>>
>>>> For example, we use DMA to report dirty pages and MMIO to fetch the dirty data.
>>>>
>>>> I remember in another thread you said:"you can't use DMA for any migration
>>>> flows"
>>>>
>>>> And I agree to that statement, so we use config space registers to control the
>>>> flow.
>>>>
>>>> Thanks,
>>>> Zhu Lingshan
>>>>
>>>>
>>>>       Jason
>>>>
>>> If you are using dma then I don't see what's wrong with admin vq.
>>> dma is all it does.
>> dma != admin vq,
> Well they share the same issue that they don't work for nesting
> because DMA can not be intercepted.
(hope this is not a spam to virtualization list and I try to keep this 
short)
only use dma for host memory access, e.g., dirty page bitmap, no need to 
intercepted.
>
>> and I think we have discussed many details in pros and cons
>> in admin vq live migration proposal in virtio-comment.
>> I am not sure we should span the discussions here, repeat them over again.
>>
>> Thanks
> Yea let's not.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
