Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57166C433F5
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 04:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0737D60D65;
	Thu, 12 May 2022 04:00:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GCS1qTqi2Qic; Thu, 12 May 2022 04:00:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8BE8D60C09;
	Thu, 12 May 2022 04:00:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B31AC0032;
	Thu, 12 May 2022 04:00:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D641AC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB1DB60C09
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:00:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iP_6UF69dAIA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:00:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 75C2160BDD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652328017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0yIW+FCVbr8CXXVh1W3iI6fl8unJyJ1RtUEfSeN4cPk=;
 b=azZ9KNo3BX/8Dcj9bVWC45k3gEmiq6zSd+mWJnC/7mo+Q4Z0eRkL0wbwEnBVC908G7T1ou
 yju+OQZna+TVPTJvuy1Mm8jV3lwpHFVSoMbHpMjd4U68iKoe9rFrFU+voVbOPhmi6fmYrO
 al/8CsaoX5KXXDsZCnDTEkTrUQOyWK4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-7TzjpwLHN4eGdvAdErRzLg-1; Thu, 12 May 2022 00:00:15 -0400
X-MC-Unique: 7TzjpwLHN4eGdvAdErRzLg-1
Received: by mail-lj1-f200.google.com with SMTP id
 j20-20020a2e8014000000b00250baa159ceso1183203ljg.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 21:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0yIW+FCVbr8CXXVh1W3iI6fl8unJyJ1RtUEfSeN4cPk=;
 b=7MtgnmOsf9GN8KKiSp1U11C2p1L+mSC+kx37LnDL4esMwnF/HfTIU3RokxehSioTgi
 NbEMKi6y8wyZdFTfdvEJDdKUue3F5fErvXRqzvl49CSCsNqFlPnTMQCpy6bqJspSnfsM
 tZ6owYb7Uatrogmwk/EtpN/9YpMtBoZVkKvxKMGiBsB4JpMnsi02M7CHE3BNhiNt/L4q
 bdq+AbSPAfF5ijxacvpmPS4RVlPoYtptYnOIby4qV9jooxPsfvorOZsBODdJzN/pUcgo
 iIeMa2JJNHxlkeHZxdMkGWYQ4j0obYSEA30gWPrwVEhDosJfZnJW00Z34mrltQdVa7xh
 j7Zg==
X-Gm-Message-State: AOAM530JunTCXOqOrkW/mm+yWzVhmgZ0oXFepyoO6zB7YmqsXbYwXzVA
 Km5UlfrWpvgm7LTx2uESAD3CG/NueF81HFhW8jqaBkbaEBfrQZkj0FHIqP4oP/GohfR9BQSkoQ7
 o8B++yx2sS+jeYekJWv+BBeSeZv0zXriIQZcQbsLvh+HrYYDWfa/8VYA/sA==
X-Received: by 2002:a2e:9698:0:b0:24f:14da:6a59 with SMTP id
 q24-20020a2e9698000000b0024f14da6a59mr19906507lji.73.1652328014036; 
 Wed, 11 May 2022 21:00:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2GzW/3WPRn1Qv4igS+/R9CCZvErkegv99KElnGdENDPHIBP+wS3vT7MpzelxhY8a+3fXbyute2TqaNhiPRRU=
X-Received: by 2002:a2e:9698:0:b0:24f:14da:6a59 with SMTP id
 q24-20020a2e9698000000b0024f14da6a59mr19906495lji.73.1652328013826; Wed, 11
 May 2022 21:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaqyWcbqzvtyHcU3t1TF7Mqm2_sBX57rN8S6hHB8NXxgi=tyQ@mail.gmail.com>
In-Reply-To: <CAJaqyWcbqzvtyHcU3t1TF7Mqm2_sBX57rN8S6hHB8NXxgi=tyQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 May 2022 12:00:02 +0800
Message-ID: <CACGkMEtPn7u0vd4MHuNJBGHbzx5E11NEU4Zh1Dr8C07eEsO0vQ@mail.gmail.com>
Subject: Re: About restoring the state in vhost-vdpa device
To: Eugenio Perez Martin <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
 virtio-networking@redhat.com, qemu-level <qemu-devel@nongnu.org>,
 Gautam Dawar <gdawar@xilinx.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <elic@nvidia.com>
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

On Thu, May 12, 2022 at 3:44 AM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> This is a proposal to restore the state of the vhost-vdpa device at
> the destination after a live migration. It uses as many available
> features both from the device and from qemu as possible so we keep the
> communication simple and speed up the merging process.

When we finalize the design, we can formalize it in kernel Documentation/

>
> # Initializing a vhost-vdpa device.
>
> Without the context of live migration, the steps to initialize the
> device from vhost-vdpa at qemu starting are:
> 1) [vhost] Open the vdpa device, Using simply open()
> 2) [vhost+virtio] Get device features. These are expected not to
> change in the device's lifetime, so we can save them. Qemu issues a
> VHOST_GET_FEATURES ioctl and vdpa forwards to the backend driver using
> get_device_features() callback.

For "virtio" do you mean it's an action that is defined in the spec?

> 3) [vhost+virtio] Get its max_queue_pairs if _F_MQ and _F_CTRL_VQ.
> These are obtained using VHOST_VDPA_GET_CONFIG, and that request is
> forwarded to the device using get_config. QEMU expects the device to
> not change it in its lifetime.
> 4) [vhost] Vdpa set status (_S_ACKNOLEDGE, _S_DRIVER). Still no
> FEATURES_OK or DRIVER_OK. The ioctl is VHOST_VDPA_SET_STATUS, and the
> vdpa backend driver callback is set_status.
>
> These are the steps used to initialize the device in qemu terminology,
> taking away some redundancies to make it simpler.
>
> Now the driver sends the FEATURES_OK and the DRIVER_OK, and qemu
> detects it, so it *starts* the device.
>
> # Starting a vhost-vdpa device
>
> At virtio_net_vhost_status we have two important variables here:
> int cvq = _F_CTRL_VQ ? 1 : 0;
> int queue_pairs = _F_CTRL_VQ && _F_MQ ? (max_queue_pairs of step 3) : 0;
>
> Now identification of the cvq index. Qemu *know* that the device will
> expose it at the last queue (max_queue_pairs*2) if _F_MQ has been
> acknowledged by the guest's driver or 2 if not. It cannot depend on
> any data sent to the device via cvq, because we couldn't get its
> command status on a change.
>
> Now we start the vhost device. The workflow is currently:
>
> 5) [virtio+vhost] The first step is to send the acknowledgement of the
> Virtio features and vhost/vdpa backend features to the device, so it
> knows how to configure itself. This is done using the same calls as
> step 4 with these feature bits added.
> 6) [virtio] Set the size, base, addr, kick and call fd for each queue
> (SET_VRING_ADDR, SET_VRING_NUM, ...; and forwarded with
> set_vq_address, set_vq_state, ...)
> 7) [vdpa] Send host notifiers and *send SET_VRING_ENABLE = 1* for each
> queue. This is done using ioctl VHOST_VDPA_SET_VRING_ENABLE, and
> forwarded to the vdpa backend using set_vq_ready callback.
> 8) [virtio + vdpa] Send memory translations & set DRIVER_OK.
>
> If we follow the current workflow, the device is allowed now to start
> receiving only on vq pair 0, since we've still not set the multi queue
> pair. This could cause the guest to receive packets in unexpected
> queues, breaking RSS.
>
> # Proposal
>
> Our proposal diverge in step 7: Instead of enabling *all* the
> virtqueues, only enable the CVQ. After that, send the DRIVER_OK and
> queue all the control commands to restore the device status (MQ, RSS,
> ...). Once all of them have been acknowledged ("device", or emulated
> cvq in host vdpa backend driver, has used all cvq buffers, enable
> (SET_VRING_ENABLE, set_vq_ready) all other queues.
>
> Everything needed for this is already implemented in the kernel as far
> as I see, there is only a small modification in qemu needed. Thus
> achieving the restoring of the device state without creating
> maintenance burden.

Yes, one of the major motivations is to try to reuse the existing APIs
as much as possible as a start. It doesn't mean we can't invent new
API, but having a dedicated save/restore uAPI looks fine. But it looks
more like a work that needs to be finalized in the virtio spec
otherwise we may end up with code that is hard to maintain.

Thanks

>
> A lot of optimizations can be applied on top without the need to add
> stuff to the migration protocol or vDPA uAPI, like the pre-warming of
> the vdpa queues or adding more capabilities to the emulated CVQ.
>
> Other optimizations like applying the state out of band can also be
> added so they can run in parallel with the migration, but that
> requires a bigger change in qemu migration protocol making us lose
> focus on achieving at least the basic device migration in my opinion.
>
> Thoughts?
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
