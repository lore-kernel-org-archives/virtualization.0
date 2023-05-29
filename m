Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB47C77B7E
	for <virtualization@archiver.kernel.org>; Mon, 29 May 2023 06:38:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E7BC60864;
	Mon, 29 May 2023 06:38:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E7BC60864
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hrtREV7Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oEiGF9rWG-Rp; Mon, 29 May 2023 06:38:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 96B2360585;
	Mon, 29 May 2023 06:38:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96B2360585
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54547C0036;
	Mon, 29 May 2023 06:38:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7053FC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 06:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 373BC611F5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 06:38:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 373BC611F5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id isVWb3Ovr5yj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 06:38:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 44889611EA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 44889611EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 06:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685342304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RI5hJOTq4N2wMQlP6tTCKbxSGVyeko2WAKgEBpQbDAk=;
 b=hrtREV7Y3Et/gyomu+RMvyx4m1d2t//tgA9A1grtTGNaUFgnE89Q0aTHmEkbfSGULCnm4L
 Vuia8UoSpsxYrPohcDQiEp+ONrRUUWdUQj+BBl3PqRdGZiSGL3hKsDu58NOzmL6bQMwAhV
 YLJ1+VT04itw9e7u41afHLGAlpC8D/s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-RPz0nXAMOM6SdBR5BTauiw-1; Mon, 29 May 2023 02:38:22 -0400
X-MC-Unique: RPz0nXAMOM6SdBR5BTauiw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3079c6648e3so1773703f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 23:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685342301; x=1687934301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RI5hJOTq4N2wMQlP6tTCKbxSGVyeko2WAKgEBpQbDAk=;
 b=ZTmo26688BaqUVF7259Li+cPc7i/98f3LHKfGJmwn8pk+X5v9K4brAnJrX135CCMgU
 uZyhxHMphqzBwHo1/FKXHZ77sY94JO9Obu2PqhRmreL5CnIg0GKyDfsDurLK4DviA5DN
 UdrEEb41kNt0lUj7yjMce3XNhoF6MCp7OYPZfmImzw18YCMrQX+8q7UggmXbg0OUcN6e
 iduqbFg1SmZxotzG3kGQafTg0GqSteTUK6Qu4Wj4gDJRsu/VOluE+7fFD7G8cYNkeYpm
 aPG+T5WKUbAQ8YligdUEtd+ehKF6hhBDrrTex1n6tK2SMvNWs6MJxfIaup0amVNM1fG0
 S05Q==
X-Gm-Message-State: AC+VfDyH1MiPU0RfOzu94dGdx9IKI/xqCYp2LJC93op2EYC4xF/Xw7BY
 bPgx/2QPY79C14mXmoNM0iGzEOVema9oeBXB2XS4GkxULwepJ6Z/cETBdUp039yxb/nvPCFci/2
 4NmzHOh7LylsJvdDk8OXizBVSR6GdKOqkQ7KVJjmn0Q==
X-Received: by 2002:adf:f24f:0:b0:306:2db9:cc26 with SMTP id
 b15-20020adff24f000000b003062db9cc26mr8328159wrp.25.1685342301190; 
 Sun, 28 May 2023 23:38:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lawXTsfvCz27zIJkOB9RlOKuzGSttD1jEG7QgP7HbZjY7UL8PH+aIRQuAsfoXze43fSSSeg==
X-Received: by 2002:adf:f24f:0:b0:306:2db9:cc26 with SMTP id
 b15-20020adff24f000000b003062db9cc26mr8328150wrp.25.1685342300806; 
 Sun, 28 May 2023 23:38:20 -0700 (PDT)
Received: from redhat.com ([2.52.146.27]) by smtp.gmail.com with ESMTPSA id
 b14-20020adff90e000000b00307972e46fasm12452742wrr.107.2023.05.28.23.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 23:38:20 -0700 (PDT)
Date: Mon, 29 May 2023 02:38:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [RFC] virtio-net: support modern-transtional devices
Message-ID: <20230529022940-mutt-send-email-mst@kernel.org>
References: <20230526181542.364412-1-lingshan.zhu@intel.com>
 <20230528071851-mutt-send-email-mst@kernel.org>
 <2cc16de1-5eee-705a-a7ec-440157041ee6@intel.com>
MIME-Version: 1.0
In-Reply-To: <2cc16de1-5eee-705a-a7ec-440157041ee6@intel.com>
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

On Mon, May 29, 2023 at 02:19:36PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 5/28/2023 7:28 PM, Michael S. Tsirkin wrote:
> > On Sat, May 27, 2023 at 02:15:42AM +0800, Zhu Lingshan wrote:
> > > Current virtio-net only probes a device with VIRITO_ID_NET == 1.
> > > 
> > > For a modern-transtional virtio-net device which has a transtional
> > > device id 0x1000 and acts as a modern device, current virtio-pci
> > > modern driver will assign the sub-device-id to its mdev->id.device,
> > > which may not be 0x1, this sub-device-id is up to the vendor.
> > > 
> > > That means virtio-net driver doesn't probe a modern-transitonal
> > > virtio-net with a sub-device-id other than 0x1, which is a bug.
> > No, the bug is in the device. Legacy linux drivers always looked at
> > sub device id (other OSes might differ). So it makes no sense
> > for a transitional device to have sub-device-id other than 0x1.
> > Don't have time to look at spec but I think you will find it there.
> That is true for a software emulated transitional device,
> because there is only "generation" of instance in the hypervisor,
> that allowing it to ensure its sub-device-id always be 0x01,
> and it fits VIRTIO_ID_NET.
> 
> However, a vendor may produce multiple generations of transitional
> hardware. The sub-device-id is up to the vendor, and it is the
> only way to for a driver to identify a device, other IDs are all
> fixed as 0x1af4, 0x1000 and 0x8086 for Intel.

That is one of the issues with legacy virtio, yes.



> So the sub-device-id has to be unique and differ from others, can not always
> be 0x01.


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



> I propose this fix, all changes are for modern-transitional devices in
> modern
> code path, not for legacy nor legacy-transitional.
> 
> Thanks

But what good is this fix? If you just want the modern driver to bind
and ignore legacy just create a modern device, you can play
with subsystem id and vendor to your heart's content then.

If you are using transitional then presumably you want
legacy drives to bind, they will not bind if subsystem device
id changes.


> > 
> > 
> > > Other types of devices also have similar issues, like virito-blk.
> > > 
> > > I propose to fix this problem of modern-transitonal device
> > > whith this solution, all in the modern code path:
> > > 1) assign the device id to mdev->id.device
> > > 2) add transitional device ids in the virtio-net(and others) probe table.
> > > 
> > > Comments are welcome!
> > > 
> > > Thanks!
> > > 
> > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > ---
> > >   drivers/net/virtio_net.c               | 1 +
> > >   drivers/virtio/virtio_pci_modern_dev.c | 2 +-
> > >   2 files changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 56ca1d270304..6b45d8602a6b 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -4250,6 +4250,7 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
> > >   static struct virtio_device_id id_table[] = {
> > >   	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> > > +	{ VIRTIO_TRANS_ID_NET, VIRTIO_DEV_ANY_ID },
> > >   	{ 0 },
> > >   };
> > > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > > index 869cb46bef96..80846e1195ce 100644
> > > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > > @@ -229,7 +229,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
> > >   		/* Transitional devices: use the PCI subsystem device id as
> > >   		 * virtio device id, same as legacy driver always did.
> > >   		 */
> > > -		mdev->id.device = pci_dev->subsystem_device;
> > > +		mdev->id.device = pci_dev->device;
> > >   	} else {
> > >   		/* Modern devices: simply use PCI device id, but start from 0x1040. */
> > >   		mdev->id.device = pci_dev->device - 0x1040;
> > > -- 
> > > 2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
