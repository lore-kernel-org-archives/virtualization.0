Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB78C7EE29
	for <virtualization@archiver.kernel.org>; Mon, 29 May 2023 10:42:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E533D41DDA;
	Mon, 29 May 2023 10:42:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E533D41DDA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eulVgr1/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sMRj4qYLmUGp; Mon, 29 May 2023 10:42:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EF8CE41DC7;
	Mon, 29 May 2023 10:42:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF8CE41DC7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF969C0035;
	Mon, 29 May 2023 10:42:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6FB6C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 10:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B9B936125E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 10:42:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9B936125E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eulVgr1/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id phC911Vt85BK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 10:42:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 47E3A60F72
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 47E3A60F72
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 10:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685356920; x=1716892920;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to;
 bh=kD1mGwaLNAVLpiG9M80ZZ2BmSLrlO1aoavXrpenp+3o=;
 b=eulVgr1/GULZCDyV6rsFQ9bHFdTmx5Du3h0XNICHlcDmPJT23m4LWZfg
 EPfpeszt2E2vvP04+WjiP1jobt2ONHPUsDSM7yz2/pZWX7LVMbu3ciVg2
 tLWs2eIyjytyFsablq7I2onO7uDc/75xkzNmwN0sqlF39RyVqz96govog
 z82QgnNfPC9wVjW2+xWDma5cHh3PndQGWLyMspxs3y9iwnC+CVwEdyY2N
 fQCTaKkiYE9Evfkg2PLj2M2odqfpNQLfeu5V2xPk/NLlfNGGepAYy6Dez
 xhthgHrRUSnWOlj+NA0tFDSObblhd7uA+5ptIIA+2n6W468pP1gQhc81a A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="382931560"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
 d="scan'208,217";a="382931560"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 03:41:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="656454147"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
 d="scan'208,217";a="656454147"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.249.175.23])
 ([10.249.175.23])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 03:41:57 -0700
Message-ID: <c7f98316-9aae-4d5e-b5ff-e9157d5923fe@intel.com>
Date: Mon, 29 May 2023 18:41:54 +0800
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
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230529060747-mutt-send-email-mst@kernel.org>
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
Content-Type: multipart/mixed; boundary="===============5835044557748597599=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.
--===============5835044557748597599==
Content-Type: multipart/alternative;
 boundary="------------9Fbd0DHMzd5bcgt71mfYiton"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------9Fbd0DHMzd5bcgt71mfYiton
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/29/2023 6:12 PM, Michael S. Tsirkin wrote:
> On Mon, May 29, 2023 at 04:07:42PM +0800, Zhu, Lingshan wrote:
>>
>> On 5/29/2023 2:38 PM, Michael S. Tsirkin wrote:
>>> On Mon, May 29, 2023 at 02:19:36PM +0800, Zhu, Lingshan wrote:
>>>> On 5/28/2023 7:28 PM, Michael S. Tsirkin wrote:
>>>>> On Sat, May 27, 2023 at 02:15:42AM +0800, Zhu Lingshan wrote:
>>>>>> Current virtio-net only probes a device with VIRITO_ID_NET == 1.
>>>>>>
>>>>>> For a modern-transtional virtio-net device which has a transtional
>>>>>> device id 0x1000 and acts as a modern device, current virtio-pci
>>>>>> modern driver will assign the sub-device-id to its mdev->id.device,
>>>>>> which may not be 0x1, this sub-device-id is up to the vendor.
>>>>>>
>>>>>> That means virtio-net driver doesn't probe a modern-transitonal
>>>>>> virtio-net with a sub-device-id other than 0x1, which is a bug.
>>>>> No, the bug is in the device. Legacy linux drivers always looked at
>>>>> sub device id (other OSes might differ). So it makes no sense
>>>>> for a transitional device to have sub-device-id other than 0x1.
>>>>> Don't have time to look at spec but I think you will find it there.
>>>> That is true for a software emulated transitional device,
>>>> because there is only "generation" of instance in the hypervisor,
>>>> that allowing it to ensure its sub-device-id always be 0x01,
>>>> and it fits VIRTIO_ID_NET.
>>>>
>>>> However, a vendor may produce multiple generations of transitional
>>>> hardware. The sub-device-id is up to the vendor, and it is the
>>>> only way to for a driver to identify a device, other IDs are all
>>>> fixed as 0x1af4, 0x1000 and 0x8086 for Intel.
>>> That is one of the issues with legacy virtio, yes.
>>>
>>>
>>>
>>>> So the sub-device-id has to be unique and differ from others, can not always
>>>> be 0x01.
>>> If you are trying to build a device and want to create a safe way to
>>> identify it without breaking legacy drivers, then
>>> VIRTIO_PCI_CAP_VENDOR_CFG has been designed for things like this.
>>> For example you can have:
>>>
>>> struct virtio_pci_vndr_data {
>>>           u8 cap_vndr;    /* Generic PCI field: PCI_CAP_ID_VNDR */
>>>           u8 cap_next;    /* Generic PCI field: next ptr. */
>>>           u8 cap_len;     /* Generic PCI field: capability length */
>>>           u8 cfg_type;    /* Identifies the structure. */
>>>           u16 vendor_id;  /* Identifies the vendor-specific format. */
>>>           u16 device_generation;  /* Device generation */
>>> };
>> This can be a solution for sure.
>>>> I propose this fix, all changes are for modern-transitional devices in
>>>> modern
>>>> code path, not for legacy nor legacy-transitional.
>>>>
>>>> Thanks
>>> But what good is this fix? If you just want the modern driver to bind
>>> and ignore legacy just create a modern device, you can play
>>> with subsystem id and vendor to your heart's content then.
>> Not sure who but there are some use-cases require
>> transnational devices than modern devices,
>> I don't like this neither.
>>> If you are using transitional then presumably you want
>>> legacy drives to bind, they will not bind if subsystem device
>>> id changes.
>> well actually it is a transitional device and act as a
>> modern device by default, so modern driver will probe.
>>
>> I think this fix is common and easy, just let virtio-net
>> probe transitional device id 0x1000 just like it probes
>> modern device id 0x1. This is a once for all fix.
>>
>> This fix only affects modern-transitional devices in modern code path,
>> legacy is untouched.
>>
>> Thanks
> The point of having transitional as opposed to modern is to allow
> legacy drivers. If you don't need legacy just use a non transitional
> device.
>
> Your device is out of spec:
>      Transitional devices MUST have the PCI Subsystem Device ID
>      matching the Virtio Device ID, as indicated in section \ref{sec:Device Types}.
OK, thanks for point this out. Since the spec says so, I assume 
transitional is almost legacy.

However the spec also says:
Transitional Device a device supporting both drivers conforming to this 
specification, and allowing legacy drivers.

The transitional devices have their own device id, like 0x1000 indicates 
it is a network device.

Then why the sub-device-id has to be 0x1 in the spec? Is it because we 
have the driver first?

Thanks


>
> So you will have to explain why the setup you are describing
> makes any sense at all before we consider this a fix.
>
>
>
>>>
>>>>>> Other types of devices also have similar issues, like virito-blk.
>>>>>>
>>>>>> I propose to fix this problem of modern-transitonal device
>>>>>> whith this solution, all in the modern code path:
>>>>>> 1) assign the device id to mdev->id.device
>>>>>> 2) add transitional device ids in the virtio-net(and others) probe table.
>>>>>>
>>>>>> Comments are welcome!
>>>>>>
>>>>>> Thanks!
>>>>>>
>>>>>> Signed-off-by: Zhu Lingshan<lingshan.zhu@intel.com>
>>>>>> ---
>>>>>>     drivers/net/virtio_net.c               | 1 +
>>>>>>     drivers/virtio/virtio_pci_modern_dev.c | 2 +-
>>>>>>     2 files changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>>> index 56ca1d270304..6b45d8602a6b 100644
>>>>>> --- a/drivers/net/virtio_net.c
>>>>>> +++ b/drivers/net/virtio_net.c
>>>>>> @@ -4250,6 +4250,7 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
>>>>>>     static struct virtio_device_id id_table[] = {
>>>>>>     	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
>>>>>> +	{ VIRTIO_TRANS_ID_NET, VIRTIO_DEV_ANY_ID },
>>>>>>     	{ 0 },
>>>>>>     };
>>>>>> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
>>>>>> index 869cb46bef96..80846e1195ce 100644
>>>>>> --- a/drivers/virtio/virtio_pci_modern_dev.c
>>>>>> +++ b/drivers/virtio/virtio_pci_modern_dev.c
>>>>>> @@ -229,7 +229,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>>>>>>     		/* Transitional devices: use the PCI subsystem device id as
>>>>>>     		 * virtio device id, same as legacy driver always did.
>>>>>>     		 */
>>>>>> -		mdev->id.device = pci_dev->subsystem_device;
>>>>>> +		mdev->id.device = pci_dev->device;
>>>>>>     	} else {
>>>>>>     		/* Modern devices: simply use PCI device id, but start from 0x1040. */
>>>>>>     		mdev->id.device = pci_dev->device - 0x1040;
>>>>>> -- 
>>>>>> 2.39.1

--------------9Fbd0DHMzd5bcgt71mfYiton
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <font face="monospace"><br>
      <br>
    </font>
    <div class="moz-cite-prefix"><font face="monospace">On 5/29/2023
        6:12 PM, Michael S. Tsirkin wrote:<br>
      </font></div>
    <blockquote type="cite"
      cite="mid:20230529060747-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">On Mon, May 29, 2023 at 04:07:42PM +0800, Zhu, Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

On 5/29/2023 2:38 PM, Michael S. Tsirkin wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Mon, May 29, 2023 at 02:19:36PM +0800, Zhu, Lingshan wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
On 5/28/2023 7:28 PM, Michael S. Tsirkin wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">On Sat, May 27, 2023 at 02:15:42AM +0800, Zhu Lingshan wrote:
</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">Current virtio-net only probes a device with VIRITO_ID_NET == 1.

For a modern-transtional virtio-net device which has a transtional
device id 0x1000 and acts as a modern device, current virtio-pci
modern driver will assign the sub-device-id to its mdev-&gt;id.device,
which may not be 0x1, this sub-device-id is up to the vendor.

That means virtio-net driver doesn't probe a modern-transitonal
virtio-net with a sub-device-id other than 0x1, which is a bug.
</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">No, the bug is in the device. Legacy linux drivers always looked at
sub device id (other OSes might differ). So it makes no sense
for a transitional device to have sub-device-id other than 0x1.
Don't have time to look at spec but I think you will find it there.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">That is true for a software emulated transitional device,
because there is only "generation" of instance in the hypervisor,
that allowing it to ensure its sub-device-id always be 0x01,
and it fits VIRTIO_ID_NET.

However, a vendor may produce multiple generations of transitional
hardware. The sub-device-id is up to the vendor, and it is the
only way to for a driver to identify a device, other IDs are all
fixed as 0x1af4, 0x1000 and 0x8086 for Intel.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">That is one of the issues with legacy virtio, yes.



</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">So the sub-device-id has to be unique and differ from others, can not always
be 0x01.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
If you are trying to build a device and want to create a safe way to
identify it without breaking legacy drivers, then
VIRTIO_PCI_CAP_VENDOR_CFG has been designed for things like this.
For example you can have:

struct virtio_pci_vndr_data {
         u8 cap_vndr;    /* Generic PCI field: PCI_CAP_ID_VNDR */
         u8 cap_next;    /* Generic PCI field: next ptr. */
         u8 cap_len;     /* Generic PCI field: capability length */
         u8 cfg_type;    /* Identifies the structure. */
         u16 vendor_id;  /* Identifies the vendor-specific format. */
         u16 device_generation;  /* Device generation */
};
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">This can be a solution for sure.
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">I propose this fix, all changes are for modern-transitional devices in
modern
code path, not for legacy nor legacy-transitional.

Thanks
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">But what good is this fix? If you just want the modern driver to bind
and ignore legacy just create a modern device, you can play
with subsystem id and vendor to your heart's content then.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Not sure who but there are some use-cases require
transnational devices than modern devices,
I don't like this neither.
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
If you are using transitional then presumably you want
legacy drives to bind, they will not bind if subsystem device
id changes.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">well actually it is a transitional device and act as a
modern device by default, so modern driver will probe.

I think this fix is common and easy, just let virtio-net
probe transitional device id 0x1000 just like it probes
modern device id 0x1. This is a once for all fix.

This fix only affects modern-transitional devices in modern code path,
legacy is untouched.

Thanks
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The point of having transitional as opposed to modern is to allow
legacy drivers. If you don't need legacy just use a non transitional
device.

Your device is out of spec:
    Transitional devices MUST have the PCI Subsystem Device ID
    matching the Virtio Device ID, as indicated in section \ref{sec:Device Types}.</pre>
    </blockquote>
    <font face="monospace">OK, thanks for point this out. Since the spec
      says so, I assume transitional is almost legacy.<br>
      <br>
      However the spec also says: </font><br>
    <font face="monospace"><span class="fontstyle0">Transitional Device
      </span><span class="fontstyle2">a device supporting both drivers
        conforming to this specification, and allowing legacy drivers.<br>
        <br>
        The transitional devices have their own device id, like 0x1000
        indicates it is a network device.<br>
        <br>
        Then why the sub-device-id has to be 0x1 in the spec? Is it
        because we have the driver first?<br>
        <br>
        Thanks</span> <br style=" font-style: normal; font-variant:
        normal; font-weight: normal; letter-spacing: normal;
        line-height: normal; orphans: 2; text-align: -webkit-auto;
        text-indent: 0px; text-transform: none; white-space: normal;
        widows: 2; word-spacing: 0px; -webkit-text-size-adjust: auto;
        -webkit-text-stroke-width: 0px; ">
       <br>
      <br>
    </font>
    <blockquote type="cite"
      cite="mid:20230529060747-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">

So you will have to explain why the setup you are describing
makes any sense at all before we consider this a fix.



</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">

</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">
</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">Other types of devices also have similar issues, like virito-blk.

I propose to fix this problem of modern-transitonal device
whith this solution, all in the modern code path:
1) assign the device id to mdev-&gt;id.device
2) add transitional device ids in the virtio-net(and others) probe table.

Comments are welcome!

Thanks!

Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a>
---
   drivers/net/virtio_net.c               | 1 +
   drivers/virtio/virtio_pci_modern_dev.c | 2 +-
   2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 56ca1d270304..6b45d8602a6b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4250,6 +4250,7 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
   static struct virtio_device_id id_table[] = {
   	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
+	{ VIRTIO_TRANS_ID_NET, VIRTIO_DEV_ANY_ID },
   	{ 0 },
   };
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 869cb46bef96..80846e1195ce 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -229,7 +229,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
   		/* Transitional devices: use the PCI subsystem device id as
   		 * virtio device id, same as legacy driver always did.
   		 */
-		mdev-&gt;id.device = pci_dev-&gt;subsystem_device;
+		mdev-&gt;id.device = pci_dev-&gt;device;
   	} else {
   		/* Modern devices: simply use PCI device id, but start from 0x1040. */
   		mdev-&gt;id.device = pci_dev-&gt;device - 0x1040;
-- 
2.39.1
</pre>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <font face="monospace"><br>
    </font>
  </body>
</html>

--------------9Fbd0DHMzd5bcgt71mfYiton--

--===============5835044557748597599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5835044557748597599==--
