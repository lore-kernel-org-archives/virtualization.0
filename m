Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE65C77B7A
	for <virtualization@archiver.kernel.org>; Mon, 29 May 2023 13:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 354A6410A6;
	Mon, 29 May 2023 13:13:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 354A6410A6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S3auanqd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8cA9nUNKdVt5; Mon, 29 May 2023 13:13:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1DBCC40902;
	Mon, 29 May 2023 13:13:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1DBCC40902
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8A12C0036;
	Mon, 29 May 2023 13:13:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 329FDC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 13:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52C7A40902
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 13:13:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52C7A40902
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x-OZBjAWrU9c
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 13:13:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02C0140230
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02C0140230
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 13:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685365994; x=1716901994;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=dKvOD+xBrrpviC8xLZCWB19JNYnm86fNTYCfwSf0i4E=;
 b=S3auanqdYmhDXnPjSiLl06tBXW52V4AB0m8F4+8B92dIr9DKLnFtd5dr
 yBCtWUXgYXqbqYC06PYmCYhPjScBBoK/TAiJMpoZHPKgqhzTXQ82Lbd+o
 q2CqpW8YLPKFf/4YzBCwvz70hKX2Dc674W+fNDvAOffrm+pZ2YaxDLjhV
 JCOXd7tTt7mFGlLIzIoVSzR70QW7Wutsbkm/KdekN5DeXmnfhOzObOfDP
 nr4by7NkE5gKSxUvHyijGBrsL+XZ5sOkd4EVIN8fq4pAHNCOvEe0esAst
 4H41Nitra+2VdCUNqogLwZTIz4juijfOqUomWsO36qWoRofzWsJ7M0Th6 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="441058377"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="441058377"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 06:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="683582648"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="683582648"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.249.175.23])
 ([10.249.175.23])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 06:13:11 -0700
Message-ID: <1935fdf6-2296-8d29-6ffd-b76ef65cb1e2@intel.com>
Date: Mon, 29 May 2023 21:13:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC] virtio-net: support modern-transtional devices
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230526181542.364412-1-lingshan.zhu@intel.com>
 <20230528071851-mutt-send-email-mst@kernel.org>
 <2cc16de1-5eee-705a-a7ec-440157041ee6@intel.com>
 <20230529022940-mutt-send-email-mst@kernel.org>
 <5d1de4a4-7314-3218-a054-5bccf608729f@intel.com>
 <20230529060747-mutt-send-email-mst@kernel.org>
 <c7f98316-9aae-4d5e-b5ff-e9157d5923fe@intel.com>
 <20230529075126-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230529075126-mutt-send-email-mst@kernel.org>
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



On 5/29/2023 8:04 PM, Michael S. Tsirkin wrote:
> On Mon, May 29, 2023 at 06:41:54PM +0800, Zhu, Lingshan wrote:
>>
>> On 5/29/2023 6:12 PM, Michael S. Tsirkin wrote:
>>
>>      On Mon, May 29, 2023 at 04:07:42PM +0800, Zhu, Lingshan wrote:
>>
>>
>>          On 5/29/2023 2:38 PM, Michael S. Tsirkin wrote:
>>
>>              On Mon, May 29, 2023 at 02:19:36PM +0800, Zhu, Lingshan wrote:
>>
>>                  On 5/28/2023 7:28 PM, Michael S. Tsirkin wrote:
>>
>>                      On Sat, May 27, 2023 at 02:15:42AM +0800, Zhu Lingshan wrote:
>>
>>                          Current virtio-net only probes a device with VIRITO_ID_NET == 1.
>>
>>                          For a modern-transtional virtio-net device which has a transtional
>>                          device id 0x1000 and acts as a modern device, current virtio-pci
>>                          modern driver will assign the sub-device-id to its mdev->id.device,
>>                          which may not be 0x1, this sub-device-id is up to the vendor.
>>
>>                          That means virtio-net driver doesn't probe a modern-transitonal
>>                          virtio-net with a sub-device-id other than 0x1, which is a bug.
>>
>>                      No, the bug is in the device. Legacy linux drivers always looked at
>>                      sub device id (other OSes might differ). So it makes no sense
>>                      for a transitional device to have sub-device-id other than 0x1.
>>                      Don't have time to look at spec but I think you will find it there.
>>
>>                  That is true for a software emulated transitional device,
>>                  because there is only "generation" of instance in the hypervisor,
>>                  that allowing it to ensure its sub-device-id always be 0x01,
>>                  and it fits VIRTIO_ID_NET.
>>
>>                  However, a vendor may produce multiple generations of transitional
>>                  hardware. The sub-device-id is up to the vendor, and it is the
>>                  only way to for a driver to identify a device, other IDs are all
>>                  fixed as 0x1af4, 0x1000 and 0x8086 for Intel.
>>
>>              That is one of the issues with legacy virtio, yes.
>>
>>
>>
>>
>>                  So the sub-device-id has to be unique and differ from others, can not always
>>                  be 0x01.
>>
>>              If you are trying to build a device and want to create a safe way to
>>              identify it without breaking legacy drivers, then
>>              VIRTIO_PCI_CAP_VENDOR_CFG has been designed for things like this.
>>              For example you can have:
>>
>>              struct virtio_pci_vndr_data {
>>                       u8 cap_vndr;    /* Generic PCI field: PCI_CAP_ID_VNDR */
>>                       u8 cap_next;    /* Generic PCI field: next ptr. */
>>                       u8 cap_len;     /* Generic PCI field: capability length */
>>                       u8 cfg_type;    /* Identifies the structure. */
>>                       u16 vendor_id;  /* Identifies the vendor-specific format. */
>>                       u16 device_generation;  /* Device generation */
>>              };
>>
>>          This can be a solution for sure.
>>
>>                  I propose this fix, all changes are for modern-transitional devices in
>>                  modern
>>                  code path, not for legacy nor legacy-transitional.
>>
>>                  Thanks
>>
>>              But what good is this fix? If you just want the modern driver to bind
>>              and ignore legacy just create a modern device, you can play
>>              with subsystem id and vendor to your heart's content then.
>>
>>          Not sure who but there are some use-cases require
>>          transnational devices than modern devices,
>>          I don't like this neither.
>>
>>              If you are using transitional then presumably you want
>>              legacy drives to bind, they will not bind if subsystem device
>>              id changes.
>>
>>          well actually it is a transitional device and act as a
>>          modern device by default, so modern driver will probe.
>>
>>          I think this fix is common and easy, just let virtio-net
>>          probe transitional device id 0x1000 just like it probes
>>          modern device id 0x1. This is a once for all fix.
>>
>>          This fix only affects modern-transitional devices in modern code path,
>>          legacy is untouched.
>>
>>          Thanks
>>
>>      The point of having transitional as opposed to modern is to allow
>>      legacy drivers. If you don't need legacy just use a non transitional
>>      device.
>>
>>      Your device is out of spec:
>>          Transitional devices MUST have the PCI Subsystem Device ID
>>          matching the Virtio Device ID, as indicated in section \ref{sec:Device Types}.
>>
>> OK, thanks for point this out. Since the spec says so, I assume transitional is
>> almost legacy.
>>
>> However the spec also says:
>> Transitional Device a device supporting both drivers conforming to this
>> specification, and allowing legacy drivers.
>>
>> The transitional devices have their own device id, like 0x1000 indicates it is
>> a network device.
>>
>> Then why the sub-device-id has to be 0x1 in the spec? Is it because we have the
>> driver first?
>>
>> Thanks
> yes, for example windows drivers:
>
> 	PCI\VEN_1AF4&DEV_1000&SUBSYS_0001_INX_SUBSYS_VENDOR_ID&REV_00
>
> Rusty originally thought drivers can ignore device id completely, and
> just use subsystem id. Something something ... a maze of twisty abstractions ...
> but it turned out it does not work e.g. for windows.
If so I think it is beyond our control to fix this issue in Windows, 
thus we can
not change the spec about transitional sub-device-id.

I think I can only let it be so. I can try the vendor cap instead.

Thanks
>
>>
>>
>>      So you will have to explain why the setup you are describing
>>      makes any sense at all before we consider this a fix.
>>
>>
>>
>>
>>
>>
>>                          Other types of devices also have similar issues, like virito-blk.
>>
>>                          I propose to fix this problem of modern-transitonal device
>>                          whith this solution, all in the modern code path:
>>                          1) assign the device id to mdev->id.device
>>                          2) add transitional device ids in the virtio-net(and others) probe table.
>>
>>                          Comments are welcome!
>>
>>                          Thanks!
>>
>>                          Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>                          ---
>>                             drivers/net/virtio_net.c               | 1 +
>>                             drivers/virtio/virtio_pci_modern_dev.c | 2 +-
>>                             2 files changed, 2 insertions(+), 1 deletion(-)
>>
>>                          diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>                          index 56ca1d270304..6b45d8602a6b 100644
>>                          --- a/drivers/net/virtio_net.c
>>                          +++ b/drivers/net/virtio_net.c
>>                          @@ -4250,6 +4250,7 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
>>                             static struct virtio_device_id id_table[] = {
>>                                  { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
>>                          +       { VIRTIO_TRANS_ID_NET, VIRTIO_DEV_ANY_ID },
>>                                  { 0 },
>>                             };
>>                          diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
>>                          index 869cb46bef96..80846e1195ce 100644
>>                          --- a/drivers/virtio/virtio_pci_modern_dev.c
>>                          +++ b/drivers/virtio/virtio_pci_modern_dev.c
>>                          @@ -229,7 +229,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>>                                          /* Transitional devices: use the PCI subsystem device id as
>>                                           * virtio device id, same as legacy driver always did.
>>                                           */
>>                          -               mdev->id.device = pci_dev->subsystem_device;
>>                          +               mdev->id.device = pci_dev->device;
>>                                  } else {
>>                                          /* Modern devices: simply use PCI device id, but start from 0x1040. */
>>                                          mdev->id.device = pci_dev->device - 0x1040;
>>                          --
>>                          2.39.1
>>
>>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
