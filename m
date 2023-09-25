Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC884CD54BF
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 19:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53BE541B34;
	Mon, 25 Sep 2023 19:44:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53BE541B34
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NLnkxabK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xYXQb8gjoiUh; Mon, 25 Sep 2023 19:44:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7483641701;
	Mon, 25 Sep 2023 19:44:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7483641701
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C6D8C0039;
	Mon, 25 Sep 2023 19:44:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEC82C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 19:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73B1741910
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 19:44:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73B1741910
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ukATy7xOlkED
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 19:44:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C6C941701
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 19:44:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C6C941701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695671061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMU7NywJrh4BHVnQGkVt0mklZf13jbuE4bUSz+J1lQE=;
 b=NLnkxabKmhjOSfjk2RV71bqRVP9aZVhne1EzaqQHEsg84OsbBx4flCAnB735aesZbxtqi/
 H6ssGqiwiXizK4xkoJfp/+O2sQyS4FSm6M3k7+rbTITisNnYTZx/7aQYzs+1EGwrnU1eYO
 QqM3wJzaVVs1N6DyHiqEGNn2Z94zptY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-bmdCntw3Ok-qVKTbXSDMHQ-1; Mon, 25 Sep 2023 15:44:20 -0400
X-MC-Unique: bmdCntw3Ok-qVKTbXSDMHQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65b23c40cefso1559296d6.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 12:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695671060; x=1696275860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMU7NywJrh4BHVnQGkVt0mklZf13jbuE4bUSz+J1lQE=;
 b=XKWAtdd0eUtxon9W6J9AnDvi62L5sIpUtiyEBZHHYDgWU+0c6fzn1PXIBkeKnsnQad
 20czEPPqbtAdlxwUVk/gXaosuKUrbjfGehRPdqI8FF4e3+RgX1WlrShe6c0+E7dH7qNY
 +9P5v2R0xWMm3bLUlRopOFbSJs262tpRlW+dwkpEMsqJJyQSW3Fa7sQXhAckEnT/4RHk
 OcekfC77y/+IEciK/hA7n4jTpvKyqxmOTbltxilkHkGylcivexgYbEtW8En0TTyePE/B
 rw/rKOVssOo6hjeYqojl/dzV8w9sTLRmmK6ZHhO6ianEP8IxAGfSDbI51X4qbv0jUMsd
 5nIA==
X-Gm-Message-State: AOJu0Yy+2HrHZLmwoW4A3qMaOqmN1QDAkgJ630RIohzbjE5rjcjH99X+
 eAwB6ZQAlv3jk/jfVwawTdt0PPplqJ7oUrTEx1iHGE8OHzksjQ2wtHWiFdRIA/WqKh1NG7ejjsf
 pDygiPaFD0DdhVMCZARjyg9NVxWsACADBqXsG8OJUqw==
X-Received: by 2002:a05:6214:a6a:b0:64f:8bdd:873 with SMTP id
 ef10-20020a0562140a6a00b0064f8bdd0873mr5673210qvb.3.1695671059713; 
 Mon, 25 Sep 2023 12:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYX8cA2PPH5EQkqPiWRhZGZHOiNwBRCVFzgp1zyu4+jxBhcQLtJrqiGkExxjeSX5H+a8qrtA==
X-Received: by 2002:a05:6214:a6a:b0:64f:8bdd:873 with SMTP id
 ef10-20020a0562140a6a00b0064f8bdd0873mr5673190qvb.3.1695671059308; 
 Mon, 25 Sep 2023 12:44:19 -0700 (PDT)
Received: from redhat.com ([185.184.228.174]) by smtp.gmail.com with ESMTPSA id
 q8-20020a0cf5c8000000b006589375b888sm4363894qvm.67.2023.09.25.12.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 12:44:18 -0700 (PDT)
Date: Mon, 25 Sep 2023 15:44:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230925143708-mutt-send-email-mst@kernel.org>
References: <20230921101509-mutt-send-email-mst@kernel.org>
 <20230921164139.GP13733@nvidia.com>
 <20230921124331-mutt-send-email-mst@kernel.org>
 <20230921183926.GV13733@nvidia.com>
 <20230921150448-mutt-send-email-mst@kernel.org>
 <20230921194946.GX13733@nvidia.com>
 <CACGkMEvMP05yTNGE5dBA2-M0qX-GXFcdGho7_T5NR6kAEq9FNg@mail.gmail.com>
 <20230922121132.GK13733@nvidia.com>
 <CACGkMEsxgYERbyOPU33jTQuPDLUur5jv033CQgK9oJLW+ueG8w@mail.gmail.com>
 <20230925122607.GW13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230925122607.GW13733@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

On Mon, Sep 25, 2023 at 09:26:07AM -0300, Jason Gunthorpe wrote:
> > > So, as I keep saying, in this scenario the goal is no mediation in the
> > > hypervisor.
> > 
> > That's pretty fine, but I don't think trapping + relying is not
> > mediation. Does it really matter what happens after trapping?
> 
> It is not mediation in the sense that the kernel driver does not in
> any way make decisions on the behavior of the device. It simply
> transforms an IO operation into a device command and relays it to the
> device. The device still fully controls its own behavior.
> 
> VDPA is very different from this. You might call them both mediation,
> sure, but then you need another word to describe the additional
> changes VPDA is doing.

Sorry about hijacking the thread a little bit, but could you
call out some of the changes that are the most problematic
for you?

> > > It is pointless, everything you think you need to do there
> > > is actually already being done in the DPU.
> > 
> > Well, migration or even Qemu could be offloaded to DPU as well. If
> > that's the direction that's pretty fine.
> 
> That's silly, of course qemu/kvm can't run in the DPU.
> 
> However, we can empty qemu and the hypervisor out so all it does is
> run kvm and run vfio. In this model the DPU does all the OVS, storage,
> "VPDA", etc. qemu is just a passive relay of the DPU PCI functions
> into VM's vPCI functions.
> 
> So, everything VDPA was doing in the environment is migrated into the
> DPU.
> 
> In this model the DPU is an extension of the hypervisor/qemu
> environment and we shift code from x86 side to arm side to increase
> security, save power and increase total system performance.
> 
> Jason

I think I begin to understand. On the DPU you have some virtio
devices but also some non-virtio devices.  So you have to
use VFIO to talk to the DPU. Reusing VFIO to talk to virtio
devices too, simplifies things for you. If guests will see
vendor-specific devices from the DPU anyway, it will be impossible
to migrate such guests away from the DPU so the cross-vendor
migration capability is less important in this use-case.
Is this a good summary?


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
