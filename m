Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD435CD98F9
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 08:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 458E0416A8;
	Wed, 11 Oct 2023 08:02:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 458E0416A8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UmZ2gc3l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hTbkxpbTAprx; Wed, 11 Oct 2023 08:02:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 78C6040160;
	Wed, 11 Oct 2023 08:02:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 78C6040160
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42683C0039;
	Wed, 11 Oct 2023 08:02:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B041C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1930960FD9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:02:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1930960FD9
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UmZ2gc3l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CFOn8tcaH8PI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:02:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2339F60FD3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:02:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2339F60FD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697011373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x/5ZfCpKdUUub9YIdFLIytYqNrIyHV2luln8UTfMJzU=;
 b=UmZ2gc3l4hQIq9RaduhnV8ub0Dv8A1CzJ9rkSx/H8fdYx04xpVadxMEjVooN4uME/Y2vNA
 adQe8yglizC2+TPSeYFU9oETSvwtYO8EWCOcKpbClfTyAFxF0AbHeh8Fg3GJmUrki5ZMUm
 f8ER5HNU2jBHviwkLhZP01vU3klBAHc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-P8i07v1EOBiH1tUvrHGcfQ-1; Wed, 11 Oct 2023 04:02:49 -0400
X-MC-Unique: P8i07v1EOBiH1tUvrHGcfQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-327ab41de6cso4630770f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 01:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697011368; x=1697616168;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x/5ZfCpKdUUub9YIdFLIytYqNrIyHV2luln8UTfMJzU=;
 b=Jx1CFyp/Yj0oDRCIqYLtz5A41a95lJH5JC2yqy+yiy/avj/sH72eJD/f0qyiE7mQdM
 0Pb33KGKzWpPMII0M+LOlmaS3VQ9MW0W7reEdf+gHlRrzGdIaF8F+SBmQCVgY2fna0uA
 0bBpOv5YKy8Cb6NQvIgIWIC6hYvxTuZjUET9DFq9OARqPgdPPZ7buxAMRfXcRWCUvY7Z
 1T8WdFlos7yUEjdMI2pSd1vA8ImDlGsn9ntaJzUHsSOITnWWbyMm5rWxUwWRUQwPQ4z2
 VbBzKYtIfyrymLnjpDUFJXzT7nnAqVezkA+VfpRsVGRnwc6JAoZ+abkaO7MrlGw24vSo
 Cvsg==
X-Gm-Message-State: AOJu0Ywbx8FdpgTedIc6Ws6sxEulXWloOYQUPch9GYSfgprTTmYmgRIR
 Ze8NjW6XnSt05AqfR9leKQqEty2cPN4K6kPRFI4R66FrBrk17232ZljO+89k+p21PsBdFVcx8bi
 OglAuGupLe2vRYvVH8IY86XCa+JXCn/NPccOPUU0bvg==
X-Received: by 2002:a5d:40c6:0:b0:31f:dcbb:f81c with SMTP id
 b6-20020a5d40c6000000b0031fdcbbf81cmr16323207wrq.10.1697011368597; 
 Wed, 11 Oct 2023 01:02:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc+PtozieRIw6o+DBD1V6WfEFPILOnrN/s9ngTuOjBLapZuLH7txPYobLCVofwyoztZA2I/g==
X-Received: by 2002:a5d:40c6:0:b0:31f:dcbb:f81c with SMTP id
 b6-20020a5d40c6000000b0031fdcbbf81cmr16323179wrq.10.1697011368212; 
 Wed, 11 Oct 2023 01:02:48 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 c14-20020adfed8e000000b00317b0155502sm14626861wro.8.2023.10.11.01.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 01:02:47 -0700 (PDT)
Date: Wed, 11 Oct 2023 04:02:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231011035737-mutt-send-email-mst@kernel.org>
References: <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <8ea954ba-e966-0b87-b232-06ffd79db4e3@nvidia.com>
 <20231010115649-mutt-send-email-mst@kernel.org>
 <5d83d18a-0b5a-6221-e70d-32908d967715@nvidia.com>
 <20231010163914-mutt-send-email-mst@kernel.org>
 <f4247e59-19cd-0d6b-7728-dd1175c9d968@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <f4247e59-19cd-0d6b-7728-dd1175c9d968@nvidia.com>
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

On Wed, Oct 11, 2023 at 10:44:49AM +0300, Yishai Hadas wrote:
> On 10/10/2023 23:42, Michael S. Tsirkin wrote:
> > On Tue, Oct 10, 2023 at 07:09:08PM +0300, Yishai Hadas wrote:
> > > > > Assuming that we'll put each command inside virtio as the generic=
 layer, we
> > > > > won't be able to call/use this API internally to get the PF as of=
 cyclic
> > > > > dependencies between the modules, link will fail.
> > I just mean:
> > virtio_admin_legacy_io_write(sruct pci_device *,  ....)
> > =

> > =

> > internally it starts from vf gets the pf (or vf itself or whatever
> > the transport is) sends command gets status returns.
> > =

> > what is cyclic here?
> > =

> virtio-pci depends on virtio [1].
> =

> If we put the commands in the generic layer as we expect it to be (i.e.
> virtio), then trying to call internally call for virtio_pci_vf_get_pf_dev=
()
> to get the PF from the VF will end-up by a linker cyclic error as of below
> [2].
> =

> As of that, someone can suggest to put the commands in virtio-pci, however
> this will fully bypass the generic layer of virtio and future clients won=
't
> be able to use it.

virtio_pci would get pci device.
virtio pci convers that to virtio device of owner + group member id and cal=
ls virtio.

no cycles and minimal transport specific code, right?

> In addition, passing in the VF PCI pointer instead of the VF group member=
 ID
> + the VIRTIO PF device, will require in the future to duplicate each comm=
and
> once we'll use SIOV devices.

I don't think anyone knows how will SIOV look. But shuffling
APIs around is not a big deal. We'll see.

> Instead, we suggest the below API for the above example.
> =

> virtio_admin_legacy_io_write(virtio_device *virtio_dev,=A0 u64
> group_member_id,=A0 ....)
> =

> [1]

> [yishaih@reg-l-vrt-209 linux]$ modinfo virtio-pci
> filename: /lib/modules/6.6.0-rc2+/kernel/drivers/virtio/virtio_pci.ko
> version:=A0=A0=A0=A0=A0=A0=A0 1
> license:=A0=A0=A0=A0=A0=A0=A0 GPL
> description:=A0=A0=A0 virtio-pci
> author:=A0=A0=A0=A0=A0=A0=A0=A0 Anthony Liguori <aliguori@us.ibm.com>
> srcversion:=A0=A0=A0=A0 7355EAC9408D38891938391
> alias:=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci:v00001AF4d*sv*sd*bc*sc*i*
> depends: virtio_pci_modern_dev,virtio,virtio_ring,virtio_pci_legacy_dev
> retpoline:=A0=A0=A0=A0=A0 Y
> intree:=A0=A0=A0=A0=A0=A0=A0=A0 Y
> name:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 virtio_pci
> vermagic:=A0=A0=A0=A0=A0=A0 6.6.0-rc2+ SMP preempt mod_unload modversions
> parm:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 force_legacy:Force legacy mode for tr=
ansitional virtio 1
> devices (bool)
> =

> [2]
> =

> depmod: ERROR: Cycle detected: virtio -> virtio_pci -> virtio
> depmod: ERROR: Found 2 modules in dependency cycles!
> make[2]: *** [scripts/Makefile.modinst:128: depmod] Error 1
> make[1]: *** [/images/yishaih/src/kernel/linux/Makefile:1821:
> modules_install] Error 2
> =

> Yishai

virtio absolutely must not depend on virtio pci, it is used on
systems without pci at all.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
