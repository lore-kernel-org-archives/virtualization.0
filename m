Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21177CDB465
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 09:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 958D06FAD2;
	Thu, 19 Oct 2023 09:29:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 958D06FAD2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SOOnoIKF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KiMICwUHfE0G; Thu, 19 Oct 2023 09:29:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0A6256FA83;
	Thu, 19 Oct 2023 09:29:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A6256FA83
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4E69C0039;
	Thu, 19 Oct 2023 09:29:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4F05C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:29:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8CD0A6FAD2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:29:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8CD0A6FAD2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EVxdvhewpWt9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:29:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 418186FA83
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:29:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 418186FA83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697707772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mx3Pdx/5UxTV/mUBo8ksE0Th8GY1fEKYUtualo3AWr0=;
 b=SOOnoIKFAJsyS5gIH/CZOZD5elRC/AYVkHkt+28Gkeehz6FhiJXm2xwhGxcZECGb1vSxyE
 DdmJ9kSetbGs6oVCyYv1DsndSAF1xK33RG9uusNzKyWPCIrxk2Ld7U4YqUfHE4K9m5C4ls
 2BYJJyO9HyX1oEnN3IobhvqBJbtv3SM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-ur5B8zI7Nm6gSBI1eJdMew-1; Thu, 19 Oct 2023 05:29:27 -0400
X-MC-Unique: ur5B8zI7Nm6gSBI1eJdMew-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b97f1b493dso565765266b.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 02:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697707767; x=1698312567;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mx3Pdx/5UxTV/mUBo8ksE0Th8GY1fEKYUtualo3AWr0=;
 b=cQdHLbDBpgbeXgS9dcE0uG3vEL/d9iP/gsiFdEfHE7WolC/8TMB2bmmKKQed+/vsX8
 qSy6LAc6KAGRxv7oTZxOTb1vvbYaQdva7odN7+7EX+BBGr0+soeQHzjKXRMfShtJHWM1
 Jsx0cyyZJwkiPrVC9UoTx4RIDu8oKFlmVFosEWf5/Nq9mhUBvOzDlmfOeTKki5p6JkIU
 E6UbKMLh9x9VIZiuzaTKLedIs4VONA+JGj5qLPyDi7S+/0KJIwT/NOm6fO8uJBQi19sP
 LBgymuJll908Gk23Qu9tT49+Ur6ScYKGm7UJwNtpqupcdltMeP5BS2efGwhfJBWW7C5f
 JkWg==
X-Gm-Message-State: AOJu0YyeveXggR4G7iH86OVKLYNayynKk824pzvejvV5cPBeEtw+7xu2
 io7I4bInbdpD7osKizgSXVTysyDrHvtVNN6bGfvV9fdFxeeZgBej0Oa/42uTPkEUAxuuwV8+1p+
 FR6pbfTVO1h4P4YGVQdcn61KATJLBCQpUimP1D+VMrQ==
X-Received: by 2002:a17:906:fe45:b0:9b2:ba73:65c9 with SMTP id
 wz5-20020a170906fe4500b009b2ba7365c9mr1152550ejb.51.1697707766766; 
 Thu, 19 Oct 2023 02:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzy+4e2qL/a0tcDC4Rk0nRYhr0TQQFYprqC2F+Xh8rwsGxecveMhL7mCqTov1hFoMvwsjj0Q==
X-Received: by 2002:a17:906:fe45:b0:9b2:ba73:65c9 with SMTP id
 wz5-20020a170906fe4500b009b2ba7365c9mr1152537ejb.51.1697707766395; 
 Thu, 19 Oct 2023 02:29:26 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it.
 [87.12.185.56]) by smtp.gmail.com with ESMTPSA id
 c8-20020a17090603c800b0098ec690e6d7sm3193334eja.73.2023.10.19.02.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 02:29:25 -0700 (PDT)
Date: Thu, 19 Oct 2023 11:29:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [RFC v2 PATCH] vdpa_sim: implement .reset_map support
Message-ID: <tqjrjw64l7pqphaagskys4zmkknkv46w7fxojic75b5dwbtq7m@dgq3xgryqz6f>
References: <1697605893-30313-1-git-send-email-si-wei.liu@oracle.com>
 <becui44lhdptriz4ds7r2b22kazofwo7i44rydacjssnwb7mrq@f6sa74zjhlfp>
 <171a1147-2099-46da-81f1-fc953e9410e2@oracle.com>
MIME-Version: 1.0
In-Reply-To: <171a1147-2099-46da-81f1-fc953e9410e2@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Oct 18, 2023 at 04:47:48PM -0700, Si-Wei Liu wrote:
>
>
>On 10/18/2023 1:05 AM, Stefano Garzarella wrote:
>>On Tue, Oct 17, 2023 at 10:11:33PM -0700, Si-Wei Liu wrote:
>>>RFC only. Not tested on vdpa-sim-blk with user virtual address.
>>>Works fine with vdpa-sim-net which uses physical address to map.
>>>
>>>This patch is based on top of [1].
>>>
>>>[1] https://lore.kernel.org/virtualization/1696928580-7520-1-git-send-em=
ail-si-wei.liu@oracle.com/
>>>
>>>Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>
>>>---
>>>RFC v2:
>>>=A0- initialize iotlb to passthrough mode in device add
>>
>>I tested this version and I didn't see any issue ;-)
>Great, thank you so much for your help on testing my patch, Stefano!

You're welcome :-)

>Just for my own interest/curiosity, currently there's no vhost-vdpa =

>backend client implemented for vdpa-sim-blk

Yep, we developed libblkio [1]. libblkio exposes common API to access =

block devices in userspace. It supports several drivers.
The one useful for this use case is `virtio-blk-vhost-vdpa`. Here [2] =

some examples on how to use the libblkio test suite with the =

vdpa-sim-blk.

Since QEMU 7.2, it supports libblkio drivers, so you can use the =

following options to attach a vdpa-blk device to a VM:

   -blockdev node-name=3Ddrive_src1,driver=3Dvirtio-blk-vhost-vdpa,path=3D/=
dev/vhost-vdpa-0,cache.direct=3Don \
   -device virtio-blk-pci,id=3Dsrc1,bootindex=3D2,drive=3Ddrive_src1 \

For now only what we called slow-path [3][4] is supported, since the VQs =

are not directly exposed to the guest, but QEMU allocates other VQs =

(similar to shadow VQs for net) to support live-migration and QEMU =

storage features. Fast-path is on the agenda, but on pause for now.

>or any vdpa block device in userspace as yet, correct? =


Do you mean with VDUSE?
In this case, yes, qemu-storage-daemon supports it, and can implement a =

virtio-blk in user space, exposing a disk image thorough VDUSE.

There is an example in libblkio as well [5] on how to start it.

>So there was no test specific to vhost-vdpa that needs to be exercised, =

>right?
>

I hope I answered above :-)
This reminded me that I need to write a blog post with all this =

information, I hope to do that soon!

Stefano

[1] https://gitlab.com/libblkio/libblkio
[2] https://gitlab.com/libblkio/libblkio/-/blob/main/tests/meson.build?ref_=
type=3Dheads#L42
[3] https://kvmforum2022.sched.com/event/15jK5/qemu-storage-daemon-and-libb=
lkio-exploring-new-shores-for-the-qemu-block-layer-kevin-wolf-stefano-garza=
rella-red-hat
[4] https://kvmforum2021.sched.com/event/ke3a/vdpa-blk-unified-hardware-and=
-software-offload-for-virtio-blk-stefano-garzarella-red-hat
[5] https://gitlab.com/libblkio/libblkio/-/blob/main/tests/meson.build?ref_=
type=3Dheads#L58

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
