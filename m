Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592EBC77B7A
	for <virtualization@archiver.kernel.org>; Mon, 29 May 2023 06:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B859C832D8;
	Mon, 29 May 2023 06:19:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B859C832D8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dkwVjnBm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5vYJlFJ3uw49; Mon, 29 May 2023 06:19:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2FE5182FA9;
	Mon, 29 May 2023 06:19:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2FE5182FA9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1117AC0036;
	Mon, 29 May 2023 06:19:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C02BC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 06:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 207E4611E5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 06:19:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 207E4611E5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dkwVjnBm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JS1MOTvo2mvB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 06:19:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31AAC60D95
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31AAC60D95
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 06:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685341194; x=1716877194;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=C1zsOYASo0VHI+92Q7yYT/O7dXoa2AamYLNGZg+TEsY=;
 b=dkwVjnBmmt4iHc6Fw9wunBwkynxMZdZrSQVT/b6gECNbw/h6+8Hol3X9
 RtccH8k8SLpjQc0acrmmtSP/+mWvd3wPdaud1HCpsJ2Rvp/s6ri/u+TfY
 mtpE/2/i2a5AWpoxsEoY34XAkXwfSwM9ZWLYcLdu1gUeif4+loiGjrwzF
 KzshbBOp85sLCAjATAtCAHWp+2fxhutIP9e8OjB9iQtVlpL8Nvs/Ju5VC
 Xr3tYRzCRvKkULx6NZbySmhTq6t6+0oBZRx6fhjwSoo6yb3vAKFcTHwMM
 eUscnXYLFwBokAv4J0L4kvIYzh8M9YqX8p7J8bqF2PdObpBy2AKbsVXyw Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="354644979"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; d="scan'208";a="354644979"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2023 23:19:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="705940193"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; d="scan'208";a="705940193"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.249.175.23])
 ([10.249.175.23])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2023 23:19:39 -0700
Message-ID: <2cc16de1-5eee-705a-a7ec-440157041ee6@intel.com>
Date: Mon, 29 May 2023 14:19:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC] virtio-net: support modern-transtional devices
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230526181542.364412-1-lingshan.zhu@intel.com>
 <20230528071851-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230528071851-mutt-send-email-mst@kernel.org>
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



On 5/28/2023 7:28 PM, Michael S. Tsirkin wrote:
> On Sat, May 27, 2023 at 02:15:42AM +0800, Zhu Lingshan wrote:
>> Current virtio-net only probes a device with VIRITO_ID_NET == 1.
>>
>> For a modern-transtional virtio-net device which has a transtional
>> device id 0x1000 and acts as a modern device, current virtio-pci
>> modern driver will assign the sub-device-id to its mdev->id.device,
>> which may not be 0x1, this sub-device-id is up to the vendor.
>>
>> That means virtio-net driver doesn't probe a modern-transitonal
>> virtio-net with a sub-device-id other than 0x1, which is a bug.
> No, the bug is in the device. Legacy linux drivers always looked at
> sub device id (other OSes might differ). So it makes no sense
> for a transitional device to have sub-device-id other than 0x1.
> Don't have time to look at spec but I think you will find it there.
That is true for a software emulated transitional device,
because there is only "generation" of instance in the hypervisor,
that allowing it to ensure its sub-device-id always be 0x01,
and it fits VIRTIO_ID_NET.

However, a vendor may produce multiple generations of transitional
hardware. The sub-device-id is up to the vendor, and it is the
only way to for a driver to identify a device, other IDs are all
fixed as 0x1af4, 0x1000 and 0x8086 for Intel.

So the sub-device-id has to be unique and differ from others, can not 
always be 0x01.

I propose this fix, all changes are for modern-transitional devices in 
modern
code path, not for legacy nor legacy-transitional.

Thanks

>
>
>> Other types of devices also have similar issues, like virito-blk.
>>
>> I propose to fix this problem of modern-transitonal device
>> whith this solution, all in the modern code path:
>> 1) assign the device id to mdev->id.device
>> 2) add transitional device ids in the virtio-net(and others) probe table.
>>
>> Comments are welcome!
>>
>> Thanks!
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>>   drivers/net/virtio_net.c               | 1 +
>>   drivers/virtio/virtio_pci_modern_dev.c | 2 +-
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 56ca1d270304..6b45d8602a6b 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -4250,6 +4250,7 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
>>   
>>   static struct virtio_device_id id_table[] = {
>>   	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
>> +	{ VIRTIO_TRANS_ID_NET, VIRTIO_DEV_ANY_ID },
>>   	{ 0 },
>>   };
>>   
>> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
>> index 869cb46bef96..80846e1195ce 100644
>> --- a/drivers/virtio/virtio_pci_modern_dev.c
>> +++ b/drivers/virtio/virtio_pci_modern_dev.c
>> @@ -229,7 +229,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>>   		/* Transitional devices: use the PCI subsystem device id as
>>   		 * virtio device id, same as legacy driver always did.
>>   		 */
>> -		mdev->id.device = pci_dev->subsystem_device;
>> +		mdev->id.device = pci_dev->device;
>>   	} else {
>>   		/* Modern devices: simply use PCI device id, but start from 0x1040. */
>>   		mdev->id.device = pci_dev->device - 0x1040;
>> -- 
>> 2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
