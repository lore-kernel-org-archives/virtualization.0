Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E8FC77B7A
	for <virtualization@archiver.kernel.org>; Mon, 29 May 2023 10:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F85041A60;
	Mon, 29 May 2023 10:13:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F85041A60
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VqzrN842
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MLyPBdu5u97S; Mon, 29 May 2023 10:13:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CD61241918;
	Mon, 29 May 2023 10:12:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD61241918
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4C90C0035;
	Mon, 29 May 2023 10:12:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA0C0C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 10:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9012E41921
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 10:12:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9012E41921
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sq-ami8yunXA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 10:12:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A8DE41918
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A8DE41918
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 10:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685355176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CmhHgXI8gSG9QJG11kjAZcZavVYlhcXoe+H7Gf4YMjU=;
 b=VqzrN8425PzS81PUdwENr3BzzyDn6tHF5hkP+dAZHMN4qNYFDzduf7al9CyzPW4Gm5KGaO
 PvS4313ChzWUaDkubwnGHBpWLE+mf74UPVQaLqqnpbc/g046BGx3EPJsYyKqWkvMQS3m3n
 mOd6+YBCMZW2bkphcm3xjnwFizeyNm0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-965ON6XJPIewngyajx6eww-1; Mon, 29 May 2023 06:12:54 -0400
X-MC-Unique: 965ON6XJPIewngyajx6eww-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f6cc1997fdso11364175e9.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 03:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685355173; x=1687947173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmhHgXI8gSG9QJG11kjAZcZavVYlhcXoe+H7Gf4YMjU=;
 b=DfGPasNGvqPYg/B45KhaPKdxDUAUuo5Fs6qutKiGDcdiDOhtwVk9BiUzdJ9YEOET94
 vepHi68kMZGr7i3TPotDU3XjDCa79D1xXy46fp1Q7n84/3Ob0o1dERrWDQ3JKwcEBUhw
 kTIX1pN7AINKb03tNZSPV3KM6OcX6fZHvdef8z1lNOW+MiuM/Lpq7Uo8M9tOR0fivCHG
 Q3cRGFk0CmLtDwHGgRO+13IBtx5f+CyH3fnlWYNioTclc3WKtdLij2TPy4UZ/lJMBxic
 FEvJmrIYzbmFHnIXCMAQXphVxhXC/LhqXptWrMRsderyzFVmojiJAu83XRinvg73RdSS
 N5jg==
X-Gm-Message-State: AC+VfDxaE1xs9OpC9UEhHBHhwZnZ8b7+2fIaMWED3UKU7Fd8oXGucxCD
 joe+CcmoKUOge4HixppmBJpyzTZMr9BLXmSNHpnENfcDfkqxRQ54Ibd4jgAEE9L699Vmn/lm3Iz
 FNNtrBYIvDC1aVGRKMZobDqGnzITVYUl0f/U+s6ZnWA==
X-Received: by 2002:a1c:6a09:0:b0:3f6:48e:92ca with SMTP id
 f9-20020a1c6a09000000b003f6048e92camr8272346wmc.39.1685355173085; 
 Mon, 29 May 2023 03:12:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78wVECPW2OgN3DjaMiMtbv8Mx6xQPyRW8Jf1zyKAYN7SsJZrw/0yQ0g2wji9nQW9t4Jv2lUw==
X-Received: by 2002:a1c:6a09:0:b0:3f6:48e:92ca with SMTP id
 f9-20020a1c6a09000000b003f6048e92camr8272328wmc.39.1685355172713; 
 Mon, 29 May 2023 03:12:52 -0700 (PDT)
Received: from redhat.com ([2.52.146.27]) by smtp.gmail.com with ESMTPSA id
 f8-20020a1c6a08000000b003f41bb52834sm17478128wmc.38.2023.05.29.03.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 03:12:52 -0700 (PDT)
Date: Mon, 29 May 2023 06:12:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [RFC] virtio-net: support modern-transtional devices
Message-ID: <20230529060747-mutt-send-email-mst@kernel.org>
References: <20230526181542.364412-1-lingshan.zhu@intel.com>
 <20230528071851-mutt-send-email-mst@kernel.org>
 <2cc16de1-5eee-705a-a7ec-440157041ee6@intel.com>
 <20230529022940-mutt-send-email-mst@kernel.org>
 <5d1de4a4-7314-3218-a054-5bccf608729f@intel.com>
MIME-Version: 1.0
In-Reply-To: <5d1de4a4-7314-3218-a054-5bccf608729f@intel.com>
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

On Mon, May 29, 2023 at 04:07:42PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 5/29/2023 2:38 PM, Michael S. Tsirkin wrote:
> > On Mon, May 29, 2023 at 02:19:36PM +0800, Zhu, Lingshan wrote:
> > > 
> > > On 5/28/2023 7:28 PM, Michael S. Tsirkin wrote:
> > > > On Sat, May 27, 2023 at 02:15:42AM +0800, Zhu Lingshan wrote:
> > > > > Current virtio-net only probes a device with VIRITO_ID_NET == 1.
> > > > > 
> > > > > For a modern-transtional virtio-net device which has a transtional
> > > > > device id 0x1000 and acts as a modern device, current virtio-pci
> > > > > modern driver will assign the sub-device-id to its mdev->id.device,
> > > > > which may not be 0x1, this sub-device-id is up to the vendor.
> > > > > 
> > > > > That means virtio-net driver doesn't probe a modern-transitonal
> > > > > virtio-net with a sub-device-id other than 0x1, which is a bug.
> > > > No, the bug is in the device. Legacy linux drivers always looked at
> > > > sub device id (other OSes might differ). So it makes no sense
> > > > for a transitional device to have sub-device-id other than 0x1.
> > > > Don't have time to look at spec but I think you will find it there.
> > > That is true for a software emulated transitional device,
> > > because there is only "generation" of instance in the hypervisor,
> > > that allowing it to ensure its sub-device-id always be 0x01,
> > > and it fits VIRTIO_ID_NET.
> > > 
> > > However, a vendor may produce multiple generations of transitional
> > > hardware. The sub-device-id is up to the vendor, and it is the
> > > only way to for a driver to identify a device, other IDs are all
> > > fixed as 0x1af4, 0x1000 and 0x8086 for Intel.
> > That is one of the issues with legacy virtio, yes.
> > 
> > 
> > 
> > > So the sub-device-id has to be unique and differ from others, can not always
> > > be 0x01.
> > 
> > If you are trying to build a device and want to create a safe way to
> > identify it without breaking legacy drivers, then
> > VIRTIO_PCI_CAP_VENDOR_CFG has been designed for things like this.
> > For example you can have:
> > 
> > struct virtio_pci_vndr_data {
> >          u8 cap_vndr;    /* Generic PCI field: PCI_CAP_ID_VNDR */
> >          u8 cap_next;    /* Generic PCI field: next ptr. */
> >          u8 cap_len;     /* Generic PCI field: capability length */
> >          u8 cfg_type;    /* Identifies the structure. */
> >          u16 vendor_id;  /* Identifies the vendor-specific format. */
> >          u16 device_generation;  /* Device generation */
> > };
> This can be a solution for sure.
> > 
> > > I propose this fix, all changes are for modern-transitional devices in
> > > modern
> > > code path, not for legacy nor legacy-transitional.
> > > 
> > > Thanks
> > But what good is this fix? If you just want the modern driver to bind
> > and ignore legacy just create a modern device, you can play
> > with subsystem id and vendor to your heart's content then.
> Not sure who but there are some use-cases require
> transnational devices than modern devices,
> I don't like this neither.
> > 
> > If you are using transitional then presumably you want
> > legacy drives to bind, they will not bind if subsystem device
> > id changes.
> well actually it is a transitional device and act as a
> modern device by default, so modern driver will probe.
> 
> I think this fix is common and easy, just let virtio-net
> probe transitional device id 0x1000 just like it probes
> modern device id 0x1. This is a once for all fix.
> 
> This fix only affects modern-transitional devices in modern code path,
> legacy is untouched.
> 
> Thanks

The point of having transitional as opposed to modern is to allow
legacy drivers. If you don't need legacy just use a non transitional
device.

Your device is out of spec:
    Transitional devices MUST have the PCI Subsystem Device ID
    matching the Virtio Device ID, as indicated in section \ref{sec:Device Types}.

So you will have to explain why the setup you are describing
makes any sense at all before we consider this a fix.



> > 
> > 
> > > > 
> > > > > Other types of devices also have similar issues, like virito-blk.
> > > > > 
> > > > > I propose to fix this problem of modern-transitonal device
> > > > > whith this solution, all in the modern code path:
> > > > > 1) assign the device id to mdev->id.device
> > > > > 2) add transitional device ids in the virtio-net(and others) probe table.
> > > > > 
> > > > > Comments are welcome!
> > > > > 
> > > > > Thanks!
> > > > > 
> > > > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > > > ---
> > > > >    drivers/net/virtio_net.c               | 1 +
> > > > >    drivers/virtio/virtio_pci_modern_dev.c | 2 +-
> > > > >    2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 56ca1d270304..6b45d8602a6b 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -4250,6 +4250,7 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
> > > > >    static struct virtio_device_id id_table[] = {
> > > > >    	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> > > > > +	{ VIRTIO_TRANS_ID_NET, VIRTIO_DEV_ANY_ID },
> > > > >    	{ 0 },
> > > > >    };
> > > > > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > > > > index 869cb46bef96..80846e1195ce 100644
> > > > > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > > > > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > > > > @@ -229,7 +229,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
> > > > >    		/* Transitional devices: use the PCI subsystem device id as
> > > > >    		 * virtio device id, same as legacy driver always did.
> > > > >    		 */
> > > > > -		mdev->id.device = pci_dev->subsystem_device;
> > > > > +		mdev->id.device = pci_dev->device;
> > > > >    	} else {
> > > > >    		/* Modern devices: simply use PCI device id, but start from 0x1040. */
> > > > >    		mdev->id.device = pci_dev->device - 0x1040;
> > > > > -- 
> > > > > 2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
