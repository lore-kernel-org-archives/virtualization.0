Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6623C43334
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 07:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AE818266C;
	Mon,  4 Jul 2022 07:00:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5AE818266C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M4fHphM/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YtWQajssMAM6; Mon,  4 Jul 2022 07:00:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B2C828261C;
	Mon,  4 Jul 2022 07:00:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2C828261C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8540BC0032;
	Mon,  4 Jul 2022 07:00:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D31B3C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 07:00:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5F2560774
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 07:00:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5F2560774
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=M4fHphM/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FhXYfAl5sZPV
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 07:00:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C35D060773
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C35D060773
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 07:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656918050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QKFiYOhVLexNLZAnyygH6JGx6im3hhRGTkcpFvcfiv0=;
 b=M4fHphM/2q+qW6AOPJSc5mh5jU9NR56MlYMu3kQ/tIrzh7zZOPd5vE+gKGlBvAlDfrguc5
 Ur0gPhwCEZVTyT10SSyMBp4rWtZlStTwDEsXo4VQw4UXSqmbFcXDq9R/k8LuHmfcQLBBgl
 Ebw6tGR9lFjBh4Cach60RQDv/xJc2n4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-s0NcbFZFNVaJg2ZlQloLoQ-1; Mon, 04 Jul 2022 03:00:49 -0400
X-MC-Unique: s0NcbFZFNVaJg2ZlQloLoQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 j16-20020adfa550000000b0021d63d200a8so529508wrb.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jul 2022 00:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QKFiYOhVLexNLZAnyygH6JGx6im3hhRGTkcpFvcfiv0=;
 b=3Kqyd+4/0F4188Rqpl2Nmjimyxqi3z1DzImQHmVXfrlf0/LD1TsqKEJ5+g/9Z05lsx
 5xDx26NR3TO0AuDqS9tWsb+hqbo4+ilhUYtHanoLnvJnz1KISJCOwsXQVbP/u2sDH3lA
 jSKi8TSUamUdiZVdIKbwSEAJCpdGrfEtfpye2sUTLOPYnC4qJh+PaLWybdut156CF2xt
 o31DJNto2j2rG9kVN/Lp/bi59mw+9WUrTVupj2KOR/xEHMA7zuXMv7Avm4GEmdPCRNuV
 9fySbhFWhHrlt7j74GpLELsbk2N5ndRdLhBgKCHFM9qVfFRMh3okDTuRNS3P1uLidQzM
 RjUw==
X-Gm-Message-State: AJIora+G1t4GjqNwskyEWXWkIXkL8B5EeBEktyIH3DuVxsdNLbDUBoGT
 lagJwq3EJJcVE+6OrxDTQk7hVjTCLzDBiOnYMq64t4xukQV2t2f4yzDgXSMCZQMCowIpatxCgZA
 NI8phcVsxzgELa3GH0TE+QbT13uhANVEMVL6CO34g/Q==
X-Received: by 2002:a5d:5050:0:b0:21b:a348:7c0 with SMTP id
 h16-20020a5d5050000000b0021ba34807c0mr24643667wrt.184.1656918048108; 
 Mon, 04 Jul 2022 00:00:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1spniD4B5iaafPVJ5gLTv4/pH5qJd/Sh/qNkdYesfjItgeUTWnDB2+innkMR9U68mUQU8qzzA==
X-Received: by 2002:a5d:5050:0:b0:21b:a348:7c0 with SMTP id
 h16-20020a5d5050000000b0021ba34807c0mr24643655wrt.184.1656918047895; 
 Mon, 04 Jul 2022 00:00:47 -0700 (PDT)
Received: from redhat.com ([2.55.3.188]) by smtp.gmail.com with ESMTPSA id
 o15-20020a05600c510f00b003971fc23185sm14891356wms.20.2022.07.04.00.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jul 2022 00:00:47 -0700 (PDT)
Date: Mon, 4 Jul 2022 03:00:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
Message-ID: <20220704025850-mutt-send-email-mst@kernel.org>
References: <20220629022223-mutt-send-email-mst@kernel.org>
 <CACGkMEuwvzkbPUSFueCOjit7pRJ81v3-W3SZD+7jQJN8btEFdg@mail.gmail.com>
 <20220629030600-mutt-send-email-mst@kernel.org>
 <CACGkMEvnUj622FyROUftifSB47wytPg0YAdVO7fdRQmCE+WuBg@mail.gmail.com>
 <20220629044514-mutt-send-email-mst@kernel.org>
 <CACGkMEsW02a1LeiWwUgHfVmDEnC8i49h1L7qHmeoLyJyRS6-zA@mail.gmail.com>
 <20220630043219-mutt-send-email-mst@kernel.org>
 <CACGkMEtgnHDEUOHQxqUFn2ngOpUGcVu4NSQBqfYYZRMPA2H2LQ@mail.gmail.com>
 <20220704021950-mutt-send-email-mst@kernel.org>
 <CACGkMEsVcmerW7xE01JvntnxkomxF5r4H2dQGDP8-xGNZJ87kw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsVcmerW7xE01JvntnxkomxF5r4H2dQGDP8-xGNZJ87kw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Mon, Jul 04, 2022 at 02:40:16PM +0800, Jason Wang wrote:
> On Mon, Jul 4, 2022 at 2:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 04, 2022 at 12:23:27PM +0800, Jason Wang wrote:
> > > > So if there are not examples of callbacks not ready after kick
> > > > then let us block callbacks until first kick. That is my idea.
> > >
> > > Ok, let me try. I need to drain my queue of fixes first.
> > >
> > > Thanks
> >
> > If we do find issues, another option is blocking callbacks until the
> > first add. A bit higher overhead as add is a more common operation
> > but it has even less of a chance to introduce regressions.
> 
> So I understand that the case of blocking until first kick but if we
> block until add it means for drivers:
> 
> virtqueue_add()
> virtio_device_ready()
> virtqueue_kick()
> 
> We probably enlarge the window in this case.
> 
> Thanks

Yes but I don't know whether any drivers call add before they are ready
to get a callback. The main thing with hardening is not to break
drivers. Primum non nocere and all that.


> >
> > > >
> > > >
> > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > >I couldn't ... except maybe bluetooth
> > > > > > > > > > > > > but that's just maintainer nacking fixes saying he'll fix it
> > > > > > > > > > > > > his way ...
> > > > > > > > > > > > >
> > > > > > > > > > > > > > And during remove(), we get another window:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > subsysrem_unregistration()
> > > > > > > > > > > > > > /* the window */
> > > > > > > > > > > > > > virtio_device_reset()
> > > > > > > > > > > > >
> > > > > > > > > > > > > Same here.
> > > > > > > > > > >
> > > > > > > > > > > Basically for the drivers that set driver_ok before registration,
> > > > > > > > > >
> > > > > > > > > > I don't see what does driver_ok have to do with it.
> > > > > > > > >
> > > > > > > > > I meant for those driver, in probe they do()
> > > > > > > > >
> > > > > > > > > virtio_device_ready()
> > > > > > > > > subsystem_register()
> > > > > > > > >
> > > > > > > > > In remove() they do
> > > > > > > > >
> > > > > > > > > subsystem_unregister()
> > > > > > > > > virtio_device_reset()
> > > > > > > > >
> > > > > > > > > for symmetry
> > > > > > > >
> > > > > > > > Let's leave remove alone for now. I am close to 100% sure we have *lots*
> > > > > > > > of issues around it, but while probe is unavoidable remove can be
> > > > > > > > avoided by blocking hotplug.
> > > > > > >
> > > > > > > Unbind can trigger this path as well.
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > so
> > > > > > > > > > > we have a lot:
> > > > > > > > > > >
> > > > > > > > > > > blk, net, mac80211_hwsim, scsi, vsock, bt, crypto, gpio, gpu, i2c,
> > > > > > > > > > > iommu, caif, pmem, input, mem
> > > > > > > > > > >
> > > > > > > > > > > So I think there's no easy way to harden the notification without
> > > > > > > > > > > auditing the driver one by one (especially considering the driver may
> > > > > > > > > > > use bh or workqueue). The problem is the notification hardening
> > > > > > > > > > > depends on a correct or race-free probe/remove. So we need to fix the
> > > > > > > > > > > issues in probe/remove then do the hardening on the notification.
> > > > > > > > > > >
> > > > > > > > > > > Thanks
> > > > > > > > > >
> > > > > > > > > > So if drivers kick but are not ready to get callbacks then let's fix
> > > > > > > > > > that first of all, these are racy with existing qemu even ignoring
> > > > > > > > > > spec compliance.
> > > > > > > > >
> > > > > > > > > Yes, (the patches I've posted so far exist even with a well-behaved device).
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > >
> > > > > > > > patches you posted deal with DRIVER_OK spec compliance.
> > > > > > > > I do not see patches for kicks before callbacks are ready to run.
> > > > > > >
> > > > > > > Yes.
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > MST
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
