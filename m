Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE552C43334
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 06:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 605C34099C;
	Mon,  4 Jul 2022 06:22:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 605C34099C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h3lsq+Xq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tTNQtJMqMLzz; Mon,  4 Jul 2022 06:22:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 613DF40992;
	Mon,  4 Jul 2022 06:22:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 613DF40992
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 402D4C0032;
	Mon,  4 Jul 2022 06:22:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B26BEC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 06:22:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2AFA7402F6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 06:22:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2AFA7402F6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=h3lsq+Xq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rtPLRGHTQAqQ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 06:22:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC6B5400F6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC6B5400F6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 06:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656915733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w4yN5Zty763Hq+nXi9QxVE0HKoTohjtCixEdlzzySCo=;
 b=h3lsq+Xq4IIZOZtHsYN6DX07wJofeyn0GurRN/ONoKaUyJv/uV1b3j5BGsHn+e7hKLnt8Y
 jxUMQ2nAmdnAd+adx8o+TXbzBRR3xNaaf80KJZ5ROIeqImeGOa+8N4GPqDM181h1o3MgDv
 emRst/WxSToSZ3Zzb35t1QgGLStSrdI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-N4Z3Ec_mPaSRlB_vz3e0Vg-1; Mon, 04 Jul 2022 02:22:12 -0400
X-MC-Unique: N4Z3Ec_mPaSRlB_vz3e0Vg-1
Received: by mail-wm1-f70.google.com with SMTP id
 r4-20020a1c4404000000b003a02fa133ceso3638981wma.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 03 Jul 2022 23:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=w4yN5Zty763Hq+nXi9QxVE0HKoTohjtCixEdlzzySCo=;
 b=1c17IDccMRvqgWKBpd1RNrbCfYJQit8tCoS55+IwPxY0cLbpGe4SPmTdrE7X6E/LKa
 KN27zxYOzYrgMoipuX3tCsW/l8eiMA2KBEH32TrCDfnsXJf6daLWL3faexT3IFl4iG+6
 ++6Xza4e/5JGugrH1VXHPaoWnSFNFclpavymn2Mcd5G0CkIGvIlkLC/yeQ3jDOix8PHg
 6lVX7XfQVrXerYPSJO7HZ9Sc0SNEX1zZlKRFzYvwYiWEYRkS5ItUT7D/2mc4IzbAtwZ6
 qIPuyLGaNz4tk97i+VjxnqdbcmLiWMztilgOEViSVNnMTIfqe0fNFYunZGPLawazY497
 EH5A==
X-Gm-Message-State: AJIora83oE1FJJpwwotFf//q/qPF+QxTNo6Cs6+YsSWElLGDjXNLwpU1
 vANq+Ut05SUHY69ihz7/anJzb9ZaMfJt2XQ3LcSA/lHQ7f/rXEuS4idSEtxBuJLMZ7/zUjIkVnb
 FgMJ1AwuN2xcjA2blsAAF1yGIjHJ7NQ4v2WGjr33Xcg==
X-Received: by 2002:a5d:4387:0:b0:21d:6983:13fc with SMTP id
 i7-20020a5d4387000000b0021d698313fcmr3928712wrq.696.1656915730996; 
 Sun, 03 Jul 2022 23:22:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v5n38T2ZOszfGvZ5G4OUbtnwwbSZSx7PamIw2e0xfqqOoITQOPCURZq3WhZI490y8B9npKeQ==
X-Received: by 2002:a5d:4387:0:b0:21d:6983:13fc with SMTP id
 i7-20020a5d4387000000b0021d698313fcmr3928689wrq.696.1656915730781; 
 Sun, 03 Jul 2022 23:22:10 -0700 (PDT)
Received: from redhat.com ([2.55.3.188]) by smtp.gmail.com with ESMTPSA id
 g3-20020a05600c140300b0039c96b97359sm18771641wmi.37.2022.07.03.23.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Jul 2022 23:22:09 -0700 (PDT)
Date: Mon, 4 Jul 2022 02:22:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
Message-ID: <20220704021950-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
In-Reply-To: <CACGkMEtgnHDEUOHQxqUFn2ngOpUGcVu4NSQBqfYYZRMPA2H2LQ@mail.gmail.com>
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

On Mon, Jul 04, 2022 at 12:23:27PM +0800, Jason Wang wrote:
> > So if there are not examples of callbacks not ready after kick
> > then let us block callbacks until first kick. That is my idea.
> 
> Ok, let me try. I need to drain my queue of fixes first.
> 
> Thanks

If we do find issues, another option is blocking callbacks until the
first add. A bit higher overhead as add is a more common operation
but it has even less of a chance to introduce regressions.

> >
> >
> > > >
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >I couldn't ... except maybe bluetooth
> > > > > > > > > > > but that's just maintainer nacking fixes saying he'll fix it
> > > > > > > > > > > his way ...
> > > > > > > > > > >
> > > > > > > > > > > > And during remove(), we get another window:
> > > > > > > > > > > >
> > > > > > > > > > > > subsysrem_unregistration()
> > > > > > > > > > > > /* the window */
> > > > > > > > > > > > virtio_device_reset()
> > > > > > > > > > >
> > > > > > > > > > > Same here.
> > > > > > > > >
> > > > > > > > > Basically for the drivers that set driver_ok before registration,
> > > > > > > >
> > > > > > > > I don't see what does driver_ok have to do with it.
> > > > > > >
> > > > > > > I meant for those driver, in probe they do()
> > > > > > >
> > > > > > > virtio_device_ready()
> > > > > > > subsystem_register()
> > > > > > >
> > > > > > > In remove() they do
> > > > > > >
> > > > > > > subsystem_unregister()
> > > > > > > virtio_device_reset()
> > > > > > >
> > > > > > > for symmetry
> > > > > >
> > > > > > Let's leave remove alone for now. I am close to 100% sure we have *lots*
> > > > > > of issues around it, but while probe is unavoidable remove can be
> > > > > > avoided by blocking hotplug.
> > > > >
> > > > > Unbind can trigger this path as well.
> > > > >
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > > > so
> > > > > > > > > we have a lot:
> > > > > > > > >
> > > > > > > > > blk, net, mac80211_hwsim, scsi, vsock, bt, crypto, gpio, gpu, i2c,
> > > > > > > > > iommu, caif, pmem, input, mem
> > > > > > > > >
> > > > > > > > > So I think there's no easy way to harden the notification without
> > > > > > > > > auditing the driver one by one (especially considering the driver may
> > > > > > > > > use bh or workqueue). The problem is the notification hardening
> > > > > > > > > depends on a correct or race-free probe/remove. So we need to fix the
> > > > > > > > > issues in probe/remove then do the hardening on the notification.
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > >
> > > > > > > > So if drivers kick but are not ready to get callbacks then let's fix
> > > > > > > > that first of all, these are racy with existing qemu even ignoring
> > > > > > > > spec compliance.
> > > > > > >
> > > > > > > Yes, (the patches I've posted so far exist even with a well-behaved device).
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > patches you posted deal with DRIVER_OK spec compliance.
> > > > > > I do not see patches for kicks before callbacks are ready to run.
> > > > >
> > > > > Yes.
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > MST
> > > > > > > >
> > > > > >
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
