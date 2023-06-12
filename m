Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC5BC7EE23
	for <virtualization@archiver.kernel.org>; Mon, 12 Jun 2023 06:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2E5FC40395;
	Mon, 12 Jun 2023 06:37:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E5FC40395
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KZMdNatW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OUh0deuylppS; Mon, 12 Jun 2023 06:37:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AC2AC40122;
	Mon, 12 Jun 2023 06:37:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC2AC40122
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80F51C007A;
	Mon, 12 Jun 2023 06:37:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15133C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 06:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF1DC82037
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 06:37:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF1DC82037
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KZMdNatW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7TGF-Xn2r3qp
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 06:37:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD54082030
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD54082030
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 06:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686551860; x=1718087860;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=qjXeWjtvfeQd7y85DZc8N94Mmx6iDFV0NSGJYoVQ0AQ=;
 b=KZMdNatWEem+URsdSGzVWiInpfes53JBDKA/u1scFC3rFfTQlZy+Vf59
 uK9d5tFigDAl3TaNWRqaklKmik3MQ1GvSyl+jq4zUgpRi6YjBk35RrAS8
 y+MO6/8/BfqTXZij5waW8f4S+9L0sSLqOal3lN4fsMtQPElpUCZz2hvgX
 OjB1Qr9FEQk/TPyhOvlXPwyP72aYP8q9EZzXoL0Uqp3tGvZmK7wwKkPop
 3lfbaJz9oaWh9X1+0rYkWuKl0/yb036KeclU8x35hUsUlLXaLZrrOBrF6
 qt1F08x0sFeiuFVEg5Rpz4DPXeAsBiUxYB/a1/ymVtjbKV7Cda6VBIuDr g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="423838908"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; d="scan'208";a="423838908"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2023 23:37:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="776233720"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; d="scan'208";a="776233720"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.255.31.36])
 ([10.255.31.36])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2023 23:37:38 -0700
Message-ID: <e8bea552-8d63-a3cb-b8fb-061ca0c57750@intel.com>
Date: Mon, 12 Jun 2023 14:37:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] vDPA/ifcvf: enable virtio-net on Intel F2000X-PL
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230609162200.875433-1-lingshan.zhu@intel.com>
 <20230609121512-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230609121512-mutt-send-email-mst@kernel.org>
Cc: virtualization@lists.linux-foundation.org
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



On 6/10/2023 12:15 AM, Michael S. Tsirkin wrote:
> On Sat, Jun 10, 2023 at 12:21:57AM +0800, Zhu Lingshan wrote:
>> Hi
>>
>> This series enables vDPA/ifcvf support for virtio-net devices
>> on Intel F2000X-PL Infrastructure Processing Unit.
>>
>> Please help review
>
> Hard trouble applying - which tree is this against?
Linus tree. I will rebase this series on your tree soon, linux-next branch,
with some minor improvements.

Thanks
>
>> Thanks!
>>
>> Zhu Lingshan (3):
>>    vDPA/ifcvf: dynamic allocate vq data stores
>>    vDPA/ifcvf: detect and report max allowed vq size
>>    vDPA/ifcvf: implement new accessors for vq_state
>>
>>   drivers/vdpa/ifcvf/ifcvf_base.c | 55 +++++++++++++++++++++++----------
>>   drivers/vdpa/ifcvf/ifcvf_base.h | 26 +++++++---------
>>   drivers/vdpa/ifcvf/ifcvf_main.c | 10 ++++--
>>   3 files changed, 58 insertions(+), 33 deletions(-)
>>
>> -- 
>> 2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
