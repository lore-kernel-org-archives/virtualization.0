Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD3EC4332F
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 04:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 21080402E5;
	Thu, 29 Dec 2022 04:25:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21080402E5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QY8xc8eM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Reo2jtPsZqX; Thu, 29 Dec 2022 04:25:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 725C940122;
	Thu, 29 Dec 2022 04:25:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 725C940122
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47972C0033;
	Thu, 29 Dec 2022 04:25:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFA67C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 04:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82D4140133
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 04:25:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82D4140133
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QY8xc8eM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b0hnpOQmgtAW
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 04:25:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81EC1400FB
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 81EC1400FB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 04:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1672287938; x=1703823938;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=BJXoitm0I+6z4KjMNlveJ7bNygZWeR+fU9YE1uEI6uQ=;
 b=QY8xc8eMIcNA/VCm3/X/XazKZnQhqDfCMgikDAYFQqBCwJQ/aV5AfhGF
 N+sGQTwPh8l/V10wHl1Sw/mD8sASJIOQVgUGG05mx4zXeZ23K5mX4j+oj
 PhRR+tM8smVj2gFcj2JzAYrZ1r732vyzYkqWAi8E7IM9t+v9vrTfwQGyl
 n18kiR9kYuxEqiaE/jSiflZR0I4Yt1lpouMjGjeKHHKsFTGAL08cwiTaS
 S4JIw93yUwDSeoZCRZA9FN5LvZXEZkylmq7FualFqbD81hHMRtf/fxtmJ
 5KFMEE7rB2hPLo0AjTiZ6QLy7ivBbnaCVQ2VC0LFRGmGKaa2Su8p5sINV A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="304478161"
X-IronPort-AV: E=Sophos;i="5.96,282,1665471600"; d="scan'208";a="304478161"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Dec 2022 20:25:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="760843758"
X-IronPort-AV: E=Sophos;i="5.96,282,1665471600"; d="scan'208";a="760843758"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.254.211.143])
 ([10.254.211.143])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Dec 2022 20:25:35 -0800
Message-ID: <65fe4913-0f05-6b52-191e-d28628dcf2eb@intel.com>
Date: Thu, 29 Dec 2022 12:25:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH] vdpa: ifcvf: Do proper cleanup if IFCVF init fails
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, Tanmay Bhushan <007047221b@gmail.com>
References: <772e9fe133f21fa78fb98a2ebe8969efbbd58e3c.camel@gmail.com>
 <CACGkMEv-DradKs+k7AT50jTxO7S3DX-hJf0EQpsUp7WZii49nw@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEv-DradKs+k7AT50jTxO7S3DX-hJf0EQpsUp7WZii49nw@mail.gmail.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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



On 12/28/2022 2:58 PM, Jason Wang wrote:
> On Wed, Dec 28, 2022 at 5:15 AM Tanmay Bhushan <007047221b@gmail.com> wrote:
>>  From 7eae04667ddaac8baa4812d48ef2c942cedef946 Mon Sep 17 00:00:00 2001
>> From: Tanmay Bhushan <007047221b@gmail.com>
>> Date: Tue, 27 Dec 2022 22:02:16 +0100
>> Subject: [PATCH] vdpa: ifcvf: Do proper cleanup if IFCVF init fails
>>
>> ifcvf_mgmt_dev leaks memory if it is not freed before
>> returning. Call is made to correct return statement
>> so memory does not leak. ifcvf_init_hw does not take
>> care of this so it is needed to do it here.
>>
>> Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
Acked-by: Zhu Lingshan <lingshan.zhu@intel.com>

Thanks
>
>> ---
>>   drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c
>> b/drivers/vdpa/ifcvf/ifcvf_main.c
>> index f9c0044c6442..44b29289aa19 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
>> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>> @@ -849,7 +849,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const
>> struct pci_device_id *id)
>>          ret = ifcvf_init_hw(vf, pdev);
>>          if (ret) {
>>                  IFCVF_ERR(pdev, "Failed to init IFCVF hw\n");
>> -               return ret;
>> +               goto err;
>>          }
>>
>>          for (i = 0; i < vf->nr_vring; i++)
>> --
>> 2.34.1
>>
>>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
