Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA11C43334
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 06:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C437D40914;
	Mon,  4 Jul 2022 06:40:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C437D40914
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fRc97Avx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sfzUXrzmFpmy; Mon,  4 Jul 2022 06:40:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A625C408D7;
	Mon,  4 Jul 2022 06:40:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A625C408D7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CE5EC0032;
	Mon,  4 Jul 2022 06:40:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 935FCC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 06:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6794C82564
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 06:40:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6794C82564
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fRc97Avx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KfXer8G0AFmD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 06:40:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 91B318250B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91B318250B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 06:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656916832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qMOEw4DkVDPn98Rjv4lUmJsvQgI5ankcWzzn5AvogbY=;
 b=fRc97Avx0vlQCuaDvdA24A4EgeEtH+yhFyqTNNaWMB1R551s1jXTy32Y8gZ+/QDtXVf0h/
 BOOSSvK6cJYbuuG61NTh5j5+kYPab0QmOkVKIyCejDloneUdcWs5q3+3eDWbH2Ch1I+xFT
 TB6Ie3/+EobGlUs3m/dZEwMMzbq5ga4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-XFfBkG2vO12673plgmIwCw-1; Mon, 04 Jul 2022 02:40:29 -0400
X-MC-Unique: XFfBkG2vO12673plgmIwCw-1
Received: by mail-lj1-f199.google.com with SMTP id
 y16-20020a2e95d0000000b0025a70d22a16so2449679ljh.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 03 Jul 2022 23:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qMOEw4DkVDPn98Rjv4lUmJsvQgI5ankcWzzn5AvogbY=;
 b=RbaW00IpsUm6ryLsHUH7HG4uzstfDG17TYm3fgtzjt4VlU+cI1X5D2YpMFxCZeayEX
 n/NAg1yDZcfVEh1xqn8euQvVfcn6+O+pFW5LmYceBZX5OAXWfa9uA0fY5nrKQPAUo/qV
 V2WfVrdb0BxphQy8tcNg5oWM4qxKDnkgX/yiFWH5cB0EpoKYZ0YOOlYNoL975/ZqZnfE
 YLcHywx1ogXaeCEUmsAKIOQFUZtEqKRz3H51vJEuqNaZuthYV0kkhijPpz2qnpK/XtLi
 rC3NHW+RjSNCYPfhVsw48rBxdsy2ve7S3JvMKBIVLLqah66Kcm8OZTj3/DLnUS4tm2GV
 vYEA==
X-Gm-Message-State: AJIora8x5+eEZlvr82Ff3ckiBjx4jw8Xm+U13GBpTgkIisa9FxUyptob
 At37ptnWSBpEZlSR7ZV46j4y8l3rMWG5YyfuNFXV1eAWWqxBBy+0OS5zjWK/FWv2TuI1xE4+B2G
 d06j3MDP5hITQD8eEZX/peM36ueDf8MRDUhCzXqbFyCHwnjUHAZGrt19cTg==
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr16831244lfa.124.1656916827639; 
 Sun, 03 Jul 2022 23:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sppZhtxMRB1b8yVzweWY5H/6xxlxkDGQ6ZEQ0ZTAxznZHDFs4TDHotunAxKLZpFvYHKvkNwdjwao4UXuarT50=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr16831229lfa.124.1656916827448; Sun, 03
 Jul 2022 23:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEsC4A+3WejLSOZoH3enXtai=+JyRNbxcpzK4vODYzhaFw@mail.gmail.com>
 <CACGkMEvu0D0XD7udz0ebVjNM0h5+K9Rjd-5ed=PY_+-aduzG2g@mail.gmail.com>
 <20220629022223-mutt-send-email-mst@kernel.org>
 <CACGkMEuwvzkbPUSFueCOjit7pRJ81v3-W3SZD+7jQJN8btEFdg@mail.gmail.com>
 <20220629030600-mutt-send-email-mst@kernel.org>
 <CACGkMEvnUj622FyROUftifSB47wytPg0YAdVO7fdRQmCE+WuBg@mail.gmail.com>
 <20220629044514-mutt-send-email-mst@kernel.org>
 <CACGkMEsW02a1LeiWwUgHfVmDEnC8i49h1L7qHmeoLyJyRS6-zA@mail.gmail.com>
 <20220630043219-mutt-send-email-mst@kernel.org>
 <CACGkMEtgnHDEUOHQxqUFn2ngOpUGcVu4NSQBqfYYZRMPA2H2LQ@mail.gmail.com>
 <20220704021950-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220704021950-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 4 Jul 2022 14:40:16 +0800
Message-ID: <CACGkMEsVcmerW7xE01JvntnxkomxF5r4H2dQGDP8-xGNZJ87kw@mail.gmail.com>
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Ben Hutchings <ben@decadent.org.uk>
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

On Mon, Jul 4, 2022 at 2:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jul 04, 2022 at 12:23:27PM +0800, Jason Wang wrote:
> > > So if there are not examples of callbacks not ready after kick
> > > then let us block callbacks until first kick. That is my idea.
> >
> > Ok, let me try. I need to drain my queue of fixes first.
> >
> > Thanks
>
> If we do find issues, another option is blocking callbacks until the
> first add. A bit higher overhead as add is a more common operation
> but it has even less of a chance to introduce regressions.

So I understand that the case of blocking until first kick but if we
block until add it means for drivers:

virtqueue_add()
virtio_device_ready()
virtqueue_kick()

We probably enlarge the window in this case.

Thanks

>
> > >
> > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > >I couldn't ... except maybe bluetooth
> > > > > > > > > > > > but that's just maintainer nacking fixes saying he'll fix it
> > > > > > > > > > > > his way ...
> > > > > > > > > > > >
> > > > > > > > > > > > > And during remove(), we get another window:
> > > > > > > > > > > > >
> > > > > > > > > > > > > subsysrem_unregistration()
> > > > > > > > > > > > > /* the window */
> > > > > > > > > > > > > virtio_device_reset()
> > > > > > > > > > > >
> > > > > > > > > > > > Same here.
> > > > > > > > > >
> > > > > > > > > > Basically for the drivers that set driver_ok before registration,
> > > > > > > > >
> > > > > > > > > I don't see what does driver_ok have to do with it.
> > > > > > > >
> > > > > > > > I meant for those driver, in probe they do()
> > > > > > > >
> > > > > > > > virtio_device_ready()
> > > > > > > > subsystem_register()
> > > > > > > >
> > > > > > > > In remove() they do
> > > > > > > >
> > > > > > > > subsystem_unregister()
> > > > > > > > virtio_device_reset()
> > > > > > > >
> > > > > > > > for symmetry
> > > > > > >
> > > > > > > Let's leave remove alone for now. I am close to 100% sure we have *lots*
> > > > > > > of issues around it, but while probe is unavoidable remove can be
> > > > > > > avoided by blocking hotplug.
> > > > > >
> > > > > > Unbind can trigger this path as well.
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > > so
> > > > > > > > > > we have a lot:
> > > > > > > > > >
> > > > > > > > > > blk, net, mac80211_hwsim, scsi, vsock, bt, crypto, gpio, gpu, i2c,
> > > > > > > > > > iommu, caif, pmem, input, mem
> > > > > > > > > >
> > > > > > > > > > So I think there's no easy way to harden the notification without
> > > > > > > > > > auditing the driver one by one (especially considering the driver may
> > > > > > > > > > use bh or workqueue). The problem is the notification hardening
> > > > > > > > > > depends on a correct or race-free probe/remove. So we need to fix the
> > > > > > > > > > issues in probe/remove then do the hardening on the notification.
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > > So if drivers kick but are not ready to get callbacks then let's fix
> > > > > > > > > that first of all, these are racy with existing qemu even ignoring
> > > > > > > > > spec compliance.
> > > > > > > >
> > > > > > > > Yes, (the patches I've posted so far exist even with a well-behaved device).
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > > patches you posted deal with DRIVER_OK spec compliance.
> > > > > > > I do not see patches for kicks before callbacks are ready to run.
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > MST
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
