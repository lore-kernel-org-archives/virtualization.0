Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9F7C77B7E
	for <virtualization@archiver.kernel.org>; Mon, 29 May 2023 12:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80B62821D9;
	Mon, 29 May 2023 12:04:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 80B62821D9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I/suywss
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BthBPulDND6Z; Mon, 29 May 2023 12:04:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D1AB2821B1;
	Mon, 29 May 2023 12:04:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1AB2821B1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5D04C0036;
	Mon, 29 May 2023 12:04:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADCC0C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 12:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86A75418DE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 12:04:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86A75418DE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I/suywss
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vYAXB5_ff3SK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 12:04:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E559418D8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E559418D8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 12:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685361860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vSY3PcxD3TeMGgAc2tUPu9HgVzPlmmXOGu959c7nkCI=;
 b=I/suywssbWP1Xssc+OwtdsDRongisUIL4FCsZ7X/80ux5kzVrRHmX/tIWu0nXXKwo6/eax
 6mCkmww90ryGPhT3lLue2PChQXXjWFlJqPOYJDHKXSXwLRiWJATRrOmbQbcITuolZ5uZsm
 L43Hhpwf9FBUp5Rcp+SV3auhhMXnycI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-i-XvVIwJPxSQNWI99P66xA-1; Mon, 29 May 2023 08:04:19 -0400
X-MC-Unique: i-XvVIwJPxSQNWI99P66xA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30a64dbb2adso1206454f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 05:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685361857; x=1687953857;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vSY3PcxD3TeMGgAc2tUPu9HgVzPlmmXOGu959c7nkCI=;
 b=RMZEBSKhvUfFI7bw6trhfVdEDHdYWFOCa+ENW16IL8Oe4fB11PShDye4AMigVHnZMP
 6UammpHcO1qVYWaZ+ktf/fJ5QMo2gY9ay9tOZU7B1mgp11E9GcCjn6tj3TQ0bgG7fx2c
 QJ1PrXwi0djIjZHic1vzZUp3fyiIiDQxh/JCHgM+aOSrV6qUE7/5D4cU5333Zj7O1NQb
 OfuGMwH6ty/liq0KzzoqZsxFYfzWlgd+Bcc7/wD4zuVt+LFsUXfnzGJQu0gi/3jVRX8f
 kk2WkTbs3LFgqA8w6sx2gxWIAZhy4/1lh5FfowM3FrsMGo2HgHsXXRTj2fkEIEUqYtI9
 dVog==
X-Gm-Message-State: AC+VfDx2fDEjmAQiJksjXBwbz6BsqrNjXjr5RwmXRhX+SSPo+gtR2nM9
 4FbbHT+0RPrMSh4nOzpx+SneAXfXKuO3MiWSPuTTqfXCxQGrB19JqwRHPrLF+WrA/xTx9BRFHB2
 j35Nnbd52AMb/L4PKQssdh5C8UxUDDeIMalCaIJbb0Q==
X-Received: by 2002:adf:fcc2:0:b0:306:3352:5ba3 with SMTP id
 f2-20020adffcc2000000b0030633525ba3mr10155536wrs.25.1685361856977; 
 Mon, 29 May 2023 05:04:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6iSVI6Bb5EHVSP/qjC3sodWJBw8lIG9nowoB/NE3iRBa5nPxEiEW2mBnsUJBS7Owt1TzRCNQ==
X-Received: by 2002:adf:fcc2:0:b0:306:3352:5ba3 with SMTP id
 f2-20020adffcc2000000b0030633525ba3mr10155518wrs.25.1685361856648; 
 Mon, 29 May 2023 05:04:16 -0700 (PDT)
Received: from redhat.com ([2.52.146.27]) by smtp.gmail.com with ESMTPSA id
 g14-20020a5d46ce000000b0030ae93bd196sm4079695wrs.21.2023.05.29.05.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 05:04:15 -0700 (PDT)
Date: Mon, 29 May 2023 08:04:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [RFC] virtio-net: support modern-transtional devices
Message-ID: <20230529075126-mutt-send-email-mst@kernel.org>
References: <20230526181542.364412-1-lingshan.zhu@intel.com>
 <20230528071851-mutt-send-email-mst@kernel.org>
 <2cc16de1-5eee-705a-a7ec-440157041ee6@intel.com>
 <20230529022940-mutt-send-email-mst@kernel.org>
 <5d1de4a4-7314-3218-a054-5bccf608729f@intel.com>
 <20230529060747-mutt-send-email-mst@kernel.org>
 <c7f98316-9aae-4d5e-b5ff-e9157d5923fe@intel.com>
MIME-Version: 1.0
In-Reply-To: <c7f98316-9aae-4d5e-b5ff-e9157d5923fe@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, May 29, 2023 at 06:41:54PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 5/29/2023 6:12 PM, Michael S. Tsirkin wrote:
> 
>     On Mon, May 29, 2023 at 04:07:42PM +0800, Zhu, Lingshan wrote:
> 
> 
>         On 5/29/2023 2:38 PM, Michael S. Tsirkin wrote:
> 
>             On Mon, May 29, 2023 at 02:19:36PM +0800, Zhu, Lingshan wrote:
> 
>                 On 5/28/2023 7:28 PM, Michael S. Tsirkin wrote:
> 
>                     On Sat, May 27, 2023 at 02:15:42AM +0800, Zhu Lingshan wrote:
> 
>                         Current virtio-net only probes a device with VIRITO_ID_NET == 1.
> 
>                         For a modern-transtional virtio-net device which has a transtional
>                         device id 0x1000 and acts as a modern device, current virtio-pci
>                         modern driver will assign the sub-device-id to its mdev->id.device,
>                         which may not be 0x1, this sub-device-id is up to the vendor.
> 
>                         That means virtio-net driver doesn't probe a modern-transitonal
>                         virtio-net with a sub-device-id other than 0x1, which is a bug.
> 
>                     No, the bug is in the device. Legacy linux drivers always looked at
>                     sub device id (other OSes might differ). So it makes no sense
>                     for a transitional device to have sub-device-id other than 0x1.
>                     Don't have time to look at spec but I think you will find it there.
> 
>                 That is true for a software emulated transitional device,
>                 because there is only "generation" of instance in the hypervisor,
>                 that allowing it to ensure its sub-device-id always be 0x01,
>                 and it fits VIRTIO_ID_NET.
> 
>                 However, a vendor may produce multiple generations of transitional
>                 hardware. The sub-device-id is up to the vendor, and it is the
>                 only way to for a driver to identify a device, other IDs are all
>                 fixed as 0x1af4, 0x1000 and 0x8086 for Intel.
> 
>             That is one of the issues with legacy virtio, yes.
> 
> 
> 
> 
>                 So the sub-device-id has to be unique and differ from others, can not always
>                 be 0x01.
> 
>             If you are trying to build a device and want to create a safe way to
>             identify it without breaking legacy drivers, then
>             VIRTIO_PCI_CAP_VENDOR_CFG has been designed for things like this.
>             For example you can have:
> 
>             struct virtio_pci_vndr_data {
>                      u8 cap_vndr;    /* Generic PCI field: PCI_CAP_ID_VNDR */
>                      u8 cap_next;    /* Generic PCI field: next ptr. */
>                      u8 cap_len;     /* Generic PCI field: capability length */
>                      u8 cfg_type;    /* Identifies the structure. */
>                      u16 vendor_id;  /* Identifies the vendor-specific format. */
>                      u16 device_generation;  /* Device generation */
>             };
> 
>         This can be a solution for sure.
> 
>                 I propose this fix, all changes are for modern-transitional devices in
>                 modern
>                 code path, not for legacy nor legacy-transitional.
> 
>                 Thanks
> 
>             But what good is this fix? If you just want the modern driver to bind
>             and ignore legacy just create a modern device, you can play
>             with subsystem id and vendor to your heart's content then.
> 
>         Not sure who but there are some use-cases require
>         transnational devices than modern devices,
>         I don't like this neither.
> 
>             If you are using transitional then presumably you want
>             legacy drives to bind, they will not bind if subsystem device
>             id changes.
> 
>         well actually it is a transitional device and act as a
>         modern device by default, so modern driver will probe.
> 
>         I think this fix is common and easy, just let virtio-net
>         probe transitional device id 0x1000 just like it probes
>         modern device id 0x1. This is a once for all fix.
> 
>         This fix only affects modern-transitional devices in modern code path,
>         legacy is untouched.
> 
>         Thanks
> 
>     The point of having transitional as opposed to modern is to allow
>     legacy drivers. If you don't need legacy just use a non transitional
>     device.
> 
>     Your device is out of spec:
>         Transitional devices MUST have the PCI Subsystem Device ID
>         matching the Virtio Device ID, as indicated in section \ref{sec:Device Types}.
> 
> OK, thanks for point this out. Since the spec says so, I assume transitional is
> almost legacy.
> 
> However the spec also says:
> Transitional Device a device supporting both drivers conforming to this
> specification, and allowing legacy drivers.
> 
> The transitional devices have their own device id, like 0x1000 indicates it is
> a network device.
> 
> Then why the sub-device-id has to be 0x1 in the spec? Is it because we have the
> driver first?
> 
> Thanks

yes, for example windows drivers:

	PCI\VEN_1AF4&DEV_1000&SUBSYS_0001_INX_SUBSYS_VENDOR_ID&REV_00

Rusty originally thought drivers can ignore device id completely, and
just use subsystem id. Something something ... a maze of twisty abstractions ...
but it turned out it does not work e.g. for windows.

> 
> 
> 
>     So you will have to explain why the setup you are describing
>     makes any sense at all before we consider this a fix.
> 
> 
> 
> 
> 
> 
>                         Other types of devices also have similar issues, like virito-blk.
> 
>                         I propose to fix this problem of modern-transitonal device
>                         whith this solution, all in the modern code path:
>                         1) assign the device id to mdev->id.device
>                         2) add transitional device ids in the virtio-net(and others) probe table.
> 
>                         Comments are welcome!
> 
>                         Thanks!
> 
>                         Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>                         ---
>                            drivers/net/virtio_net.c               | 1 +
>                            drivers/virtio/virtio_pci_modern_dev.c | 2 +-
>                            2 files changed, 2 insertions(+), 1 deletion(-)
> 
>                         diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>                         index 56ca1d270304..6b45d8602a6b 100644
>                         --- a/drivers/net/virtio_net.c
>                         +++ b/drivers/net/virtio_net.c
>                         @@ -4250,6 +4250,7 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
>                            static struct virtio_device_id id_table[] = {
>                                 { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
>                         +       { VIRTIO_TRANS_ID_NET, VIRTIO_DEV_ANY_ID },
>                                 { 0 },
>                            };
>                         diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
>                         index 869cb46bef96..80846e1195ce 100644
>                         --- a/drivers/virtio/virtio_pci_modern_dev.c
>                         +++ b/drivers/virtio/virtio_pci_modern_dev.c
>                         @@ -229,7 +229,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>                                         /* Transitional devices: use the PCI subsystem device id as
>                                          * virtio device id, same as legacy driver always did.
>                                          */
>                         -               mdev->id.device = pci_dev->subsystem_device;
>                         +               mdev->id.device = pci_dev->device;
>                                 } else {
>                                         /* Modern devices: simply use PCI device id, but start from 0x1040. */
>                                         mdev->id.device = pci_dev->device - 0x1040;
>                         --
>                         2.39.1
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
