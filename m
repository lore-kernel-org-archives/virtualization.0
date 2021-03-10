Return-Path: <SRS0=SHSW=II=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10EAC433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 09:19:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA4664FC4
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 09:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA4664FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 854954EBBF;
	Wed, 10 Mar 2021 09:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A9W-OTfOWMJC; Wed, 10 Mar 2021 09:19:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5C394C714;
	Wed, 10 Mar 2021 09:19:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4829C000B;
	Wed, 10 Mar 2021 09:19:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C0AFC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 09:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A904431A8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 09:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yj2q6uMt2JzI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 09:19:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7760B4314A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 09:19:01 +0000 (UTC)
IronPort-SDR: niEyaqLFVO+16l7POvEpqO7oHNjfB2yqaiEJoNiO6l3DhbjZvOSBbs7MoTRvBGwqkfv2Gzx81v
 YxVdM2G9GtDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="188463792"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; d="scan'208";a="188463792"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 01:18:59 -0800
IronPort-SDR: 3SQeGb6qVk/JXIFBpTBhsixVs6Ms5FHTq2xKv43bmaBsEk8ce2r73YPpVhpUYTp/0cb51jdicP
 lStqBXDOO4MA==
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; d="scan'208";a="410115347"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.249.172.47])
 ([10.249.172.47])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 01:18:58 -0800
Subject: Re: [PATCH V3 4/6] vDPA/ifcvf: remove the version number string
To: virtualization@lists.linux-foundation.org
References: <20210310090052.4762-1-lingshan.zhu@intel.com>
 <20210310090052.4762-5-lingshan.zhu@intel.com> <YEiOWd9jXHnw4b11@unreal>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <ae40b64b-bbac-553c-2cd4-98a96904ccf5@linux.intel.com>
Date: Wed, 10 Mar 2021 17:18:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YEiOWd9jXHnw4b11@unreal>
Content-Language: en-US
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

Thanks Leon, I will include your ROB if there is a V4.

On 3/10/2021 5:16 PM, Leon Romanovsky wrote:
> On Wed, Mar 10, 2021 at 05:00:50PM +0800, Zhu Lingshan wrote:
>> This commit removes the version number string, using kernel
>> version is enough.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>>   drivers/vdpa/ifcvf/ifcvf_main.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
> I already added my ROB, but will add again.
>
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
