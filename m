Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5054DCDB465
	for <virtualization@archiver.kernel.org>; Mon, 16 Oct 2023 08:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B40F581F20;
	Mon, 16 Oct 2023 08:33:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B40F581F20
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z2NZwGdC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mNsJFmFLvsET; Mon, 16 Oct 2023 08:33:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E275381F1F;
	Mon, 16 Oct 2023 08:33:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E275381F1F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B96AEC0039;
	Mon, 16 Oct 2023 08:33:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DC12C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 08:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B20781F20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 08:33:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B20781F20
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e48xWVVea1B3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 08:33:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1377781F18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 08:33:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1377781F18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697445197; x=1728981197;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=agsCH6CLFzy7WE5OXx+c69Oob0sNJ20hmEq/QR+OWM8=;
 b=Z2NZwGdC4x56OoUBdO86y1BPuy/T8QCdvkZvkVqK2eyp1iOEgac+NGQ0
 N3h72ABn43V99lOyZtLIufHfgPyKSsbIfI0qzSp01wmgoaF0q6fORdXaR
 PMb1+SmXcPVXulmTlk+/vdalVMDd+XaBRleyr0AjBApK7mFD/IWI1+RdP
 1ouEEJehmhu+CccFEHQzuZPmt9HsJ3tHfr1DrsBzzxBWzecZSAx6GOgBz
 jmE4BU/GV94fzuCwpwiBCryHMkp6wL4UEQ6m7rM5Qeh3JtlCMmlXEI1ve
 4RM7vzhfooM0ydhF/LEdFx3l/ZlITCEQU3NkZ4HBNHdpQvmzu8QasSsS5 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="416545391"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; d="scan'208";a="416545391"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:33:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="872004377"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; d="scan'208";a="872004377"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.35.20])
 ([10.93.35.20])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:33:13 -0700
Message-ID: <818c4212-9d9a-4775-80f3-c07e82057be8@intel.com>
Date: Mon, 16 Oct 2023 16:33:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over virtio
 device
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <20231010155937.GN3952@nvidia.com> <ZSY9Cv5/e3nfA7ux@infradead.org>
 <20231011021454-mutt-send-email-mst@kernel.org>
 <ZSZHzs38Q3oqyn+Q@infradead.org>
 <PH0PR12MB5481336B395F38E875ED11D8DCCCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c75bb669-76fe-ef12-817e-2a8b5f0b317b@intel.com>
 <20231012132749.GK3952@nvidia.com>
 <840d4c6f-4150-4818-a66c-1dbe1474b4c6@intel.com>
 <20231013094959-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20231013094959-mutt-send-email-mst@kernel.org>
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



On 10/13/2023 9:50 PM, Michael S. Tsirkin wrote:
> On Fri, Oct 13, 2023 at 06:28:34PM +0800, Zhu, Lingshan wrote:
>>
>> On 10/12/2023 9:27 PM, Jason Gunthorpe wrote:
>>
>>      On Thu, Oct 12, 2023 at 06:29:47PM +0800, Zhu, Lingshan wrote:
>>
>>
>>          sorry for the late reply, we have discussed this for weeks in virtio mailing
>>          list. I have proposed a live migration solution which is a config space solution.
>>
>>      I'm sorry that can't be a serious proposal - config space can't do
>>      DMA, it is not suitable.
>>
>> config space only controls the live migration process and config the related
>> facilities.
>> We don't use config space to transfer data.
>>
>> The new added registers work like queue_enable or features.
>>
>> For example, we use DMA to report dirty pages and MMIO to fetch the dirty data.
>>
>> I remember in another thread you said:"you can't use DMA for any migration
>> flows"
>>
>> And I agree to that statement, so we use config space registers to control the
>> flow.
>>
>> Thanks,
>> Zhu Lingshan
>>
>>
>>      Jason
>>
> If you are using dma then I don't see what's wrong with admin vq.
> dma is all it does.
dma != admin vq,

and I think we have discussed many details in pros and cons
in admin vq live migration proposal in virtio-comment.
I am not sure we should span the discussions here, repeat them over again.

Thanks
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
