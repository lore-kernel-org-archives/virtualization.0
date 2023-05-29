Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039C7C77B7E
	for <virtualization@archiver.kernel.org>; Mon, 29 May 2023 13:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56261611C4;
	Mon, 29 May 2023 13:37:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56261611C4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HmC8uX6a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p45rLddxVUEp; Mon, 29 May 2023 13:37:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 62D96611C5;
	Mon, 29 May 2023 13:37:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62D96611C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BA29C0036;
	Mon, 29 May 2023 13:37:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D237C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 13:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F6B741E79
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 13:36:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F6B741E79
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HmC8uX6a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UxV-wX-1IeKg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 13:36:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2B1741E78
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B2B1741E78
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 13:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685367415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bzh9A8M0vJwDYppDvlklsx4Xl4QFZAY4l1dpaMpcu44=;
 b=HmC8uX6aHRw72pmZsV6Byh2e+j0fUKN25wjSqlEcW7CssjjoiBRpuMrb32LNni9Q5pphN/
 RHv2aA2OPPhfUhXrpjDysHstoiU6f///uIx5K5GYOaartvoseqlzEWY1upiVoaL4YhjNyl
 nqRDy+TGwLWcV7k/k0M6BZhquyk2DII=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-mhFepLQuMKap53FusPJQig-1; Mon, 29 May 2023 09:36:54 -0400
X-MC-Unique: mhFepLQuMKap53FusPJQig-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f61408d926so12089365e9.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 06:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685367413; x=1687959413;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzh9A8M0vJwDYppDvlklsx4Xl4QFZAY4l1dpaMpcu44=;
 b=YU9Cy3hKwuyzu243J9SpbuNlCM641L0SP2fqp7jTui5JwE7uQG/XA6IqvhSqFktL5y
 KTARPhBt7PJdYt0a6lCn/s6zxoUyVO367iLwwXqGfRYvoaBW/zlrwA0kaZ6Q3XryZhkq
 /Rk1Oy5ibfNZUhz9fxaHl2daJoxS80lo/01NX2yZxG0kvn/CgJMQX5htYuiAAidYCT36
 aetN/4NHiQyzYNOuFKV/exzJqiDthHwkt5E6SpS0kesfXyeVIRt0Wh4rVT8u/s6HOKQW
 +ZdRelSUu9/pF/A5VdDVysUdBkjHiEs5LC9N4B17J4nK4qO2O0uPM3YupxuynhEtthec
 Rf9A==
X-Gm-Message-State: AC+VfDxz0FoR8A+8P3Wb66Y2bOx9Q9e397N0xCXgEDDY5t2cjdnZWwih
 /InxWhkMUJkTKIjo2CxDxoTkmSbyr5Q4jPz/r9GYL7yeAyZiqqb7d8W4JkTj3QBWncsWmD+XD+T
 qUPvvw6DY49loN55hrsyHP4zdWT0o9DHbUjeN6ChVAQ==
X-Received: by 2002:a05:600c:214f:b0:3f6:97e:b45d with SMTP id
 v15-20020a05600c214f00b003f6097eb45dmr9233039wml.24.1685367413168; 
 Mon, 29 May 2023 06:36:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ62NQN37SbJYhbhNIc4MyDYnH2m3A8GyVWK1jlpMpO7yRlIPyDv1lwAqcfGv/qjHiQ4diDjTQ==
X-Received: by 2002:a05:600c:214f:b0:3f6:97e:b45d with SMTP id
 v15-20020a05600c214f00b003f6097eb45dmr9233027wml.24.1685367412793; 
 Mon, 29 May 2023 06:36:52 -0700 (PDT)
Received: from redhat.com ([2.52.146.27]) by smtp.gmail.com with ESMTPSA id
 f13-20020a7bcd0d000000b003f60d0eef36sm17980839wmj.48.2023.05.29.06.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 06:36:51 -0700 (PDT)
Date: Mon, 29 May 2023 09:36:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [RFC] virtio-net: support modern-transtional devices
Message-ID: <20230529092516-mutt-send-email-mst@kernel.org>
References: <20230526181542.364412-1-lingshan.zhu@intel.com>
 <20230528071851-mutt-send-email-mst@kernel.org>
 <2cc16de1-5eee-705a-a7ec-440157041ee6@intel.com>
 <20230529022940-mutt-send-email-mst@kernel.org>
 <5d1de4a4-7314-3218-a054-5bccf608729f@intel.com>
 <20230529060747-mutt-send-email-mst@kernel.org>
 <c7f98316-9aae-4d5e-b5ff-e9157d5923fe@intel.com>
 <20230529075126-mutt-send-email-mst@kernel.org>
 <1935fdf6-2296-8d29-6ffd-b76ef65cb1e2@intel.com>
MIME-Version: 1.0
In-Reply-To: <1935fdf6-2296-8d29-6ffd-b76ef65cb1e2@intel.com>
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

On Mon, May 29, 2023 at 09:13:09PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 5/29/2023 8:04 PM, Michael S. Tsirkin wrote:
> > On Mon, May 29, 2023 at 06:41:54PM +0800, Zhu, Lingshan wrote:
> > > 
> > > On 5/29/2023 6:12 PM, Michael S. Tsirkin wrote:
> > > 
> > >      On Mon, May 29, 2023 at 04:07:42PM +0800, Zhu, Lingshan wrote:
> > > 
> > > 
> > >          On 5/29/2023 2:38 PM, Michael S. Tsirkin wrote:
> > > 
> > >              On Mon, May 29, 2023 at 02:19:36PM +0800, Zhu, Lingshan wrote:
> > > 
> > >                  On 5/28/2023 7:28 PM, Michael S. Tsirkin wrote:
> > > 
> > >                      On Sat, May 27, 2023 at 02:15:42AM +0800, Zhu Lingshan wrote:
> > > 
> > >                          Current virtio-net only probes a device with VIRITO_ID_NET == 1.
> > > 
> > >                          For a modern-transtional virtio-net device which has a transtional
> > >                          device id 0x1000 and acts as a modern device, current virtio-pci
> > >                          modern driver will assign the sub-device-id to its mdev->id.device,
> > >                          which may not be 0x1, this sub-device-id is up to the vendor.
> > > 
> > >                          That means virtio-net driver doesn't probe a modern-transitonal
> > >                          virtio-net with a sub-device-id other than 0x1, which is a bug.
> > > 
> > >                      No, the bug is in the device. Legacy linux drivers always looked at
> > >                      sub device id (other OSes might differ). So it makes no sense
> > >                      for a transitional device to have sub-device-id other than 0x1.
> > >                      Don't have time to look at spec but I think you will find it there.
> > > 
> > >                  That is true for a software emulated transitional device,
> > >                  because there is only "generation" of instance in the hypervisor,
> > >                  that allowing it to ensure its sub-device-id always be 0x01,
> > >                  and it fits VIRTIO_ID_NET.
> > > 
> > >                  However, a vendor may produce multiple generations of transitional
> > >                  hardware. The sub-device-id is up to the vendor, and it is the
> > >                  only way to for a driver to identify a device, other IDs are all
> > >                  fixed as 0x1af4, 0x1000 and 0x8086 for Intel.
> > > 
> > >              That is one of the issues with legacy virtio, yes.
> > > 
> > > 
> > > 
> > > 
> > >                  So the sub-device-id has to be unique and differ from others, can not always
> > >                  be 0x01.
> > > 
> > >              If you are trying to build a device and want to create a safe way to
> > >              identify it without breaking legacy drivers, then
> > >              VIRTIO_PCI_CAP_VENDOR_CFG has been designed for things like this.
> > >              For example you can have:
> > > 
> > >              struct virtio_pci_vndr_data {
> > >                       u8 cap_vndr;    /* Generic PCI field: PCI_CAP_ID_VNDR */
> > >                       u8 cap_next;    /* Generic PCI field: next ptr. */
> > >                       u8 cap_len;     /* Generic PCI field: capability length */
> > >                       u8 cfg_type;    /* Identifies the structure. */
> > >                       u16 vendor_id;  /* Identifies the vendor-specific format. */
> > >                       u16 device_generation;  /* Device generation */
> > >              };
> > > 
> > >          This can be a solution for sure.
> > > 
> > >                  I propose this fix, all changes are for modern-transitional devices in
> > >                  modern
> > >                  code path, not for legacy nor legacy-transitional.
> > > 
> > >                  Thanks
> > > 
> > >              But what good is this fix? If you just want the modern driver to bind
> > >              and ignore legacy just create a modern device, you can play
> > >              with subsystem id and vendor to your heart's content then.
> > > 
> > >          Not sure who but there are some use-cases require
> > >          transnational devices than modern devices,
> > >          I don't like this neither.
> > > 
> > >              If you are using transitional then presumably you want
> > >              legacy drives to bind, they will not bind if subsystem device
> > >              id changes.
> > > 
> > >          well actually it is a transitional device and act as a
> > >          modern device by default, so modern driver will probe.
> > > 
> > >          I think this fix is common and easy, just let virtio-net
> > >          probe transitional device id 0x1000 just like it probes
> > >          modern device id 0x1. This is a once for all fix.
> > > 
> > >          This fix only affects modern-transitional devices in modern code path,
> > >          legacy is untouched.
> > > 
> > >          Thanks
> > > 
> > >      The point of having transitional as opposed to modern is to allow
> > >      legacy drivers. If you don't need legacy just use a non transitional
> > >      device.
> > > 
> > >      Your device is out of spec:
> > >          Transitional devices MUST have the PCI Subsystem Device ID
> > >          matching the Virtio Device ID, as indicated in section \ref{sec:Device Types}.
> > > 
> > > OK, thanks for point this out. Since the spec says so, I assume transitional is
> > > almost legacy.
> > > 
> > > However the spec also says:
> > > Transitional Device a device supporting both drivers conforming to this
> > > specification, and allowing legacy drivers.
> > > 
> > > The transitional devices have their own device id, like 0x1000 indicates it is
> > > a network device.
> > > 
> > > Then why the sub-device-id has to be 0x1 in the spec? Is it because we have the
> > > driver first?
> > > 
> > > Thanks
> > yes, for example windows drivers:
> > 
> > 	PCI\VEN_1AF4&DEV_1000&SUBSYS_0001_INX_SUBSYS_VENDOR_ID&REV_00
> > 
> > Rusty originally thought drivers can ignore device id completely, and
> > just use subsystem id. Something something ... a maze of twisty abstractions ...
> > but it turned out it does not work e.g. for windows.
> If so I think it is beyond our control to fix this issue in Windows,

Well it's under our control and we did change it, what we can't change
is history and installed guests. It's easier to find ways that do
not break them than to break them and then try and fix them.

> thus we
> can
> not change the spec about transitional sub-device-id.
> 
> I think I can only let it be so. I can try the vendor cap instead.
> 
> Thanks

Sounds good.

> > 
> > > 
> > > 
> > >      So you will have to explain why the setup you are describing
> > >      makes any sense at all before we consider this a fix.
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > >                          Other types of devices also have similar issues, like virito-blk.
> > > 
> > >                          I propose to fix this problem of modern-transitonal device
> > >                          whith this solution, all in the modern code path:
> > >                          1) assign the device id to mdev->id.device
> > >                          2) add transitional device ids in the virtio-net(and others) probe table.
> > > 
> > >                          Comments are welcome!
> > > 
> > >                          Thanks!
> > > 
> > >                          Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > >                          ---
> > >                             drivers/net/virtio_net.c               | 1 +
> > >                             drivers/virtio/virtio_pci_modern_dev.c | 2 +-
> > >                             2 files changed, 2 insertions(+), 1 deletion(-)
> > > 
> > >                          diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > >                          index 56ca1d270304..6b45d8602a6b 100644
> > >                          --- a/drivers/net/virtio_net.c
> > >                          +++ b/drivers/net/virtio_net.c
> > >                          @@ -4250,6 +4250,7 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
> > >                             static struct virtio_device_id id_table[] = {
> > >                                  { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> > >                          +       { VIRTIO_TRANS_ID_NET, VIRTIO_DEV_ANY_ID },
> > >                                  { 0 },
> > >                             };
> > >                          diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > >                          index 869cb46bef96..80846e1195ce 100644
> > >                          --- a/drivers/virtio/virtio_pci_modern_dev.c
> > >                          +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > >                          @@ -229,7 +229,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
> > >                                          /* Transitional devices: use the PCI subsystem device id as
> > >                                           * virtio device id, same as legacy driver always did.
> > >                                           */
> > >                          -               mdev->id.device = pci_dev->subsystem_device;
> > >                          +               mdev->id.device = pci_dev->device;
> > >                                  } else {
> > >                                          /* Modern devices: simply use PCI device id, but start from 0x1040. */
> > >                                          mdev->id.device = pci_dev->device - 0x1040;
> > >                          --
> > >                          2.39.1
> > > 
> > > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
