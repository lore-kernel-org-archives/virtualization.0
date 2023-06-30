Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03DBEB64D7
	for <virtualization@archiver.kernel.org>; Fri, 30 Jun 2023 09:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4408E41F43;
	Fri, 30 Jun 2023 09:04:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4408E41F43
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J7MCIKJt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6DprKvABfFuf; Fri, 30 Jun 2023 09:04:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F916404EE;
	Fri, 30 Jun 2023 09:04:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F916404EE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1F8DC0072;
	Fri, 30 Jun 2023 09:04:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 488E3C0037
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 09:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 551454190C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 09:04:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 551454190C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=J7MCIKJt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wq71tW6fMk4U
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 09:04:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A19CE41905
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A19CE41905
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 09:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688115857; x=1719651857;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=486JHenMkrUu3ckj/agpZn4KD7m/EpRQ1NAQyqEUXkk=;
 b=J7MCIKJtfdQB2qYX1lBH5SjfAOQm3wtXi8CzmQlj3yhk/nsakoz5bYg6
 YnM+ZB5MIqN5RhRHvoInx0jMFUJFE7j5JehcfOQ+4ixElMpQnjZmG/kgO
 NC3NHE2jQ5GRzazCsBK2bTS/igWDcSaaZ2uzYMji+qPT3+4HIBtktUp3I
 j6vl7s8oVUpCwqHxz4fNIlO7pIGZ9d0zYXYVqywo4WBTdwavQyJyOVvoW
 YU2+JDpAH9/SUJt0sPlBKWX7sVrruBlA96kGeoO2ghz/1AocTOqdBoOAz
 YDgZCzr9Cjm9WbSUiisY15E+j4e0EUyP89iHsBACUctMv30fdOHSIOI6t A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="342690438"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="342690438"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 02:04:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="1048149883"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="1048149883"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.249.169.9])
 ([10.249.169.9])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 02:04:15 -0700
Message-ID: <5f6dc902-cb41-8538-3fb3-42c9c358ed8b@intel.com>
Date: Fri, 30 Jun 2023 17:04:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH] vp_vdpa: synchronize irq when free irq
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230630103656.345870-1-lingshan.zhu@intel.com>
 <20230630043342-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230630043342-mutt-send-email-mst@kernel.org>
Cc: Cindy Lu <lulu@redhat.com>, virtualization@lists.linux-foundation.org
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



On 6/30/2023 4:34 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 30, 2023 at 06:36:56PM +0800, Zhu Lingshan wrote:
>> This commits synchronizes irqs when free them
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> Tested-by: Cindy Lu <lulu@redhat.com>
>> ---
>>   drivers/vdpa/virtio_pci/vp_vdpa.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>> index 281287fae89f..d8ee3e68cd2d 100644
>> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>> @@ -116,6 +116,7 @@ static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
>>   	for (i = 0; i < vp_vdpa->queues; i++) {
>>   		if (vp_vdpa->vring[i].irq != VIRTIO_MSI_NO_VECTOR) {
>>   			vp_modern_queue_vector(mdev, i, VIRTIO_MSI_NO_VECTOR);
>> +			synchronize_irq(vp_vdpa->vring[i].irq);
>>   			devm_free_irq(&pdev->dev, vp_vdpa->vring[i].irq,
>>   				      &vp_vdpa->vring[i]);
>>   			vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
>> @@ -124,6 +125,7 @@ static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
>>   
>>   	if (vp_vdpa->config_irq != VIRTIO_MSI_NO_VECTOR) {
>>   		vp_modern_config_vector(mdev, VIRTIO_MSI_NO_VECTOR);
>> +		synchronize_irq(vp_vdpa->config_irq);
>>   		devm_free_irq(&pdev->dev, vp_vdpa->config_irq, vp_vdpa);
>>   		vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
>
> Weird, doesn't free_irq synchronize automatically?
Oh, I see free_irq calls __syncronize_hardirq internally

Thanks
>
>>   	}
>> -- 
>> 2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
