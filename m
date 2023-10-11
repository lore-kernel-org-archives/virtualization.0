Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C93CD6E4D
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 09:03:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 972D441731;
	Wed, 11 Oct 2023 09:03:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 972D441731
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XmBKIP5q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TgBtWYvu1Z7M; Wed, 11 Oct 2023 09:03:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7BE94416CA;
	Wed, 11 Oct 2023 09:03:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7BE94416CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53A4CC0039;
	Wed, 11 Oct 2023 09:03:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73BD2C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50EB641846
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:03:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50EB641846
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XmBKIP5q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8atMSgZlMGRD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:03:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0290841822
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:03:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0290841822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697015010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVGUPY1gdZbHt58HOpCldBJSSWMDzHFkqa4wNT8wG0E=;
 b=XmBKIP5qlJ/1qVXdpMzFXuh0ScZfZdJKinuX+trjGtDhvSxJdi6FwL6nAk8BK4w/WyDJVJ
 z88Hl433/5Hmj5t1eCQPWSL3e20i/Rc9oB7+sgiY/+pnOF2zMXQy/JXK3Ku6bZHMiesFPb
 VcTiQxA13VeXQWcjSKyUVUcq8ml3ZUA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-QybdiR_WMveG_CeJe8dFGw-1; Wed, 11 Oct 2023 05:03:27 -0400
X-MC-Unique: QybdiR_WMveG_CeJe8dFGw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe1521678fso50488275e9.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 02:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697015006; x=1697619806;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zVGUPY1gdZbHt58HOpCldBJSSWMDzHFkqa4wNT8wG0E=;
 b=KlDyD2Mh4xN8FAZHNuK9kI2AGtYZsPYM7iZijgjQClEiN9ypkQeVX0nfhWtn3SCXTN
 ZazyF13Wst1SdRy/8OgYA/ELqOR0tCexP2I49BIEQr3TSHH3rxLEMsXhgCfpDRw649hq
 ylhXbmNETu1OqvHEFW7P9JH0YmskEUGxd5WEYXSyPAhLxyuIQ43ZTWO3/BZjPI+mPofC
 Tbt1A8/TSYiABY7ROsi+xgC5ZM52xh/MYpy6cynogiveRSyZIL/9EiN1qXszNS8lys6A
 xaP9AVtr8Do5ETN6u9epi3FHLPH7Za3cxT4qPTECSdxy5nTDhRieGU/mRdMvhaDTSc8y
 qtBw==
X-Gm-Message-State: AOJu0YyEiFlbzehzFswg+fe44HQaKkefaFwPW+JtgqN6D/xrxKxafiLQ
 QCSx9uFpFYKevvvc1ljV0DoGjVswdYbv9K5PE+TW5FH0+2gEDiK1clmjUJlK+cpfs5orBXELRd4
 cWzmIMrnQobVNVnfo1mmmU2xhBIv2nivRL8jh2SXl6w==
X-Received: by 2002:a05:600c:3657:b0:405:7400:1e3d with SMTP id
 y23-20020a05600c365700b0040574001e3dmr17513919wmq.32.1697015006464; 
 Wed, 11 Oct 2023 02:03:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX6w6JbeuZyJP/TG/gVskCjwlS/apDbc7CnQOe2yP0D8FXGScPozhJqaEWfKxwSg5MAeMNgw==
X-Received: by 2002:a05:600c:3657:b0:405:7400:1e3d with SMTP id
 y23-20020a05600c365700b0040574001e3dmr17513892wmq.32.1697015006013; 
 Wed, 11 Oct 2023 02:03:26 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 4-20020a05600c228400b003fee53feab5sm16239233wmf.10.2023.10.11.02.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 02:03:25 -0700 (PDT)
Date: Wed, 11 Oct 2023 05:03:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231011050014-mutt-send-email-mst@kernel.org>
References: <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <8ea954ba-e966-0b87-b232-06ffd79db4e3@nvidia.com>
 <20231010115649-mutt-send-email-mst@kernel.org>
 <5d83d18a-0b5a-6221-e70d-32908d967715@nvidia.com>
 <20231010163914-mutt-send-email-mst@kernel.org>
 <f4247e59-19cd-0d6b-7728-dd1175c9d968@nvidia.com>
 <20231011035737-mutt-send-email-mst@kernel.org>
 <0ae3b963-f4fe-19c2-ea79-387a66e142ab@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <0ae3b963-f4fe-19c2-ea79-387a66e142ab@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 jiri@nvidia.com, leonro@nvidia.com
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Oct 11, 2023 at 11:58:11AM +0300, Yishai Hadas wrote:
> On 11/10/2023 11:02, Michael S. Tsirkin wrote:
> > On Wed, Oct 11, 2023 at 10:44:49AM +0300, Yishai Hadas wrote:
> > > On 10/10/2023 23:42, Michael S. Tsirkin wrote:
> > > > On Tue, Oct 10, 2023 at 07:09:08PM +0300, Yishai Hadas wrote:
> > > > > > > Assuming that we'll put each command inside virtio as the gen=
eric layer, we
> > > > > > > won't be able to call/use this API internally to get the PF a=
s of cyclic
> > > > > > > dependencies between the modules, link will fail.
> > > > I just mean:
> > > > virtio_admin_legacy_io_write(sruct pci_device *,  ....)
> > > > =

> > > > =

> > > > internally it starts from vf gets the pf (or vf itself or whatever
> > > > the transport is) sends command gets status returns.
> > > > =

> > > > what is cyclic here?
> > > > =

> > > virtio-pci depends on virtio [1].
> > > =

> > > If we put the commands in the generic layer as we expect it to be (i.=
e.
> > > virtio), then trying to call internally call for virtio_pci_vf_get_pf=
_dev()
> > > to get the PF from the VF will end-up by a linker cyclic error as of =
below
> > > [2].
> > > =

> > > As of that, someone can suggest to put the commands in virtio-pci, ho=
wever
> > > this will fully bypass the generic layer of virtio and future clients=
 won't
> > > be able to use it.
> > virtio_pci would get pci device.
> > virtio pci convers that to virtio device of owner + group member id and=
 calls virtio.
> =

> Do you suggest another set of exported symbols (i.e per command ) in virt=
io
> which will get the owner device + group member + the extra specific comma=
nd
> parameters ?
> =

> This will end-up duplicating the number of export symbols per command.

Or make them inline.
Or maybe actually even the specific commands should live inside virtio pci
they are pci specific after all.

> > no cycles and minimal transport specific code, right?
> =

> See my above note, if we may just call virtio without any further work on
> the command's input, than YES.
> =

> If so, virtio will prepare the command by setting the relevant SG lists a=
nd
> other data and finally will call:
> =

> vdev->config->exec_admin_cmd(vdev, cmd);
> =

> Was that your plan ?

is vdev the pf? then it won't support the transport where commands
are submitted through bar0 of vf itself.

> > =

> > > In addition, passing in the VF PCI pointer instead of the VF group me=
mber ID
> > > + the VIRTIO PF device, will require in the future to duplicate each =
command
> > > once we'll use SIOV devices.
> > I don't think anyone knows how will SIOV look. But shuffling
> > APIs around is not a big deal. We'll see.
> =

> As you are the maintainer it's up-to-you, just need to consider another
> further duplication here.
> =

> Yishai
> =

> > =

> > > Instead, we suggest the below API for the above example.
> > > =

> > > virtio_admin_legacy_io_write(virtio_device *virtio_dev,=A0 u64
> > > group_member_id,=A0 ....)
> > > =

> > > [1]
> > > [yishaih@reg-l-vrt-209 linux]$ modinfo virtio-pci
> > > filename: /lib/modules/6.6.0-rc2+/kernel/drivers/virtio/virtio_pci.ko
> > > version:=A0=A0=A0=A0=A0=A0=A0 1
> > > license:=A0=A0=A0=A0=A0=A0=A0 GPL
> > > description:=A0=A0=A0 virtio-pci
> > > author:=A0=A0=A0=A0=A0=A0=A0=A0 Anthony Liguori <aliguori@us.ibm.com>
> > > srcversion:=A0=A0=A0=A0 7355EAC9408D38891938391
> > > alias:=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci:v00001AF4d*sv*sd*bc*sc*i*
> > > depends: virtio_pci_modern_dev,virtio,virtio_ring,virtio_pci_legacy_d=
ev
> > > retpoline:=A0=A0=A0=A0=A0 Y
> > > intree:=A0=A0=A0=A0=A0=A0=A0=A0 Y
> > > name:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 virtio_pci
> > > vermagic:=A0=A0=A0=A0=A0=A0 6.6.0-rc2+ SMP preempt mod_unload modvers=
ions
> > > parm:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 force_legacy:Force legacy mode fo=
r transitional virtio 1
> > > devices (bool)
> > > =

> > > [2]
> > > =

> > > depmod: ERROR: Cycle detected: virtio -> virtio_pci -> virtio
> > > depmod: ERROR: Found 2 modules in dependency cycles!
> > > make[2]: *** [scripts/Makefile.modinst:128: depmod] Error 1
> > > make[1]: *** [/images/yishaih/src/kernel/linux/Makefile:1821:
> > > modules_install] Error 2
> > > =

> > > Yishai
> > virtio absolutely must not depend on virtio pci, it is used on
> > systems without pci at all.
> > =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
