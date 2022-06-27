Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351CCC43334
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 02:30:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A30928194A;
	Mon, 27 Jun 2022 02:30:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A30928194A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HGm2JiA0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MuU76zZJ5lpg; Mon, 27 Jun 2022 02:30:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2AC0B81926;
	Mon, 27 Jun 2022 02:30:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2AC0B81926
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E03B8C007A;
	Mon, 27 Jun 2022 02:30:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD5E8C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 02:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0D4060C0B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 02:30:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A0D4060C0B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HGm2JiA0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HVNXrfSzl0yN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 02:30:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 535086079E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 535086079E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 02:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656297017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8P6kEog96p9rV6KMm+7lR+irC0+Mtj1M8Nzsctab+8w=;
 b=HGm2JiA023/euYLaTFh4DatJHXRTIpSjDWFpOTdk7izrzI0ekzw4yFKfC4GouMu6Y9bNHL
 6vtcjQG9bOOO8qvnl5nv2gsUH1N49QaaFh8cGiyQNb0ebwPdTtvHIw1l4Jrh/HJ5mOrZnj
 2G1bLvpCYju4EQ47a6lwV8GvRkT+Ya4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-56p2I1qdPHC7HRjL29Fbhw-1; Sun, 26 Jun 2022 22:30:16 -0400
X-MC-Unique: 56p2I1qdPHC7HRjL29Fbhw-1
Received: by mail-lf1-f69.google.com with SMTP id
 cf10-20020a056512280a00b0047f5a295656so3987695lfb.15
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 19:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8P6kEog96p9rV6KMm+7lR+irC0+Mtj1M8Nzsctab+8w=;
 b=kmqjfSXCB/8JDVjzZcycUWRSKmarLtB0cuCf1dWa2+GqX+zvUWXn1rl1zF/eJkjn0g
 6ZkajZS/ztiGib+LNO38z9ilnK3PrvPRcMS8PB9uBiDzIeDc38OJNQO6irmAGb4haLUH
 NNPxFKetIqVQikKEiAU0KXLhduU7H3S5hYdgsDRdFwpXgCU4ZNIsZmdNmJHeg8L9hpHr
 2hgd+BiSjM6B2oM2vFou8UO+dsisLiB2r4eXQSncldXxSAd9bnYPHVHO+vmHk3yA/+yG
 TfTOUG3BDNmAlcdN1cEc4J2HyyyrZVZtkSRNNcaPs/am4rj9tZrNHRuaGQ0NhxnB36tI
 BWaQ==
X-Gm-Message-State: AJIora8iC+i4+DKbI31iaaU2+ZjrSqepSg9BGxlVmiiLWLFTtwt2CSTe
 PP7t5qCSeBHcc9yQvtg9gNf7RHczaSkOqWEiwI71/bt71gbFxqVlw4L+fB+KEQneSELkTlBY0rr
 or775pO/DyadR8BVitUriud2Va+kly61JwtluKF9PG/YE3tqIir7V8mUMYw==
X-Received: by 2002:a05:6512:22c3:b0:47f:704b:3820 with SMTP id
 g3-20020a05651222c300b0047f704b3820mr6802745lfu.411.1656297014752; 
 Sun, 26 Jun 2022 19:30:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vihl7W4zbQFQ2ouUnfKabk1IX98Txdk8CYcQQ+eQfhlyohv3NGiMcnCeltVb+Lj1YXnvH3UF3uQbu22+LqqY0=
X-Received: by 2002:a05:6512:22c3:b0:47f:704b:3820 with SMTP id
 g3-20020a05651222c300b0047f704b3820mr6802734lfu.411.1656297014531; Sun, 26
 Jun 2022 19:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <64c567bc77c4fbe7bfe37467cc1c89d24a45c37a.camel@decadent.org.uk>
 <402bb9b5-7d6e-ed69-8b66-3ebefd80ff15@redhat.com>
 <CACGkMEs45CCniTjbxr3OThdbG=Q4nGrm_11LLDfR4rRLetSx0A@mail.gmail.com>
 <a1a127d144d65937c5543c142e69213c9b8d2d40.camel@decadent.org.uk>
 <20220624051309-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220624051309-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Jun 2022 10:30:03 +0800
Message-ID: <CACGkMEt4LaXnv2=yaiuhHOCF1VyZuwmi20CtqHEGsS0fFViFOA@mail.gmail.com>
Subject: Re: virtio_balloon regression in 5.19-rc3
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: debian-kernel@lists.debian.org,
 virtualization <virtualization@lists.linux-foundation.org>,
 Ben Hutchings <ben@decadent.org.uk>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
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

On Fri, Jun 24, 2022 at 5:14 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jun 21, 2022 at 06:10:00PM +0200, Ben Hutchings wrote:
> > On Tue, 2022-06-21 at 17:34 +0800, Jason Wang wrote:
> > > On Tue, Jun 21, 2022 at 5:24 PM David Hildenbrand <david@redhat.com> wrote:
> > > >
> > > > On 20.06.22 20:49, Ben Hutchings wrote:
> > > > > I've tested a 5.19-rc3 kernel on top of QEMU/KVM with machine type
> > > > > pc-q35-5.2.  It has a virtio balloon device defined in libvirt as:
> > > > >
> > > > >     <memballoon model="virtio">
> > > > >       <address type="pci" domain="0x0000" bus="0x05" slot="0x00" function="0x0"/>
> > > > >     </memballoon>
> > > > >
> > > > > but the virtio_balloon driver fails to bind to it:
> > > > >
> > > > >     virtio_balloon virtio4: init_vqs: add stat_vq failed
> > > > >     virtio_balloon: probe of virtio4 failed with error -5
> > > > >
> > > >
> > > > Hmm, I don't see any recent changes to drivers/virtio/virtio_balloon.c
> > > >
> > > > virtqueue_add_outbuf() fails with -EIO if I'm not wrong. That's the
> > > > first call of virtqueue_add_outbuf() when virtio_balloon initializes.
> > > >
> > > >
> > > > Maybe something in generic virtio code changed?
> > >
> > > Yes, we introduced the IRQ hardening. That could be the root cause and
> > > we've received lots of reports so we decide to disable it by default.
> > >
> > > Ben, could you please try this patch: (and make sure
> > > CONFIG_VIRTIO_HARDEN_NOTIFICATION is not set)
> > >
> > > https://lore.kernel.org/lkml/20220620024158.2505-1-jasowang@redhat.com/T/
> >
> > Yes, that patch fixes the regression for me.
> >
> > Ben.
>
>
> Jason are you going to fix balloon to call device_ready before
> registering device with linux?

I'm working on the fix, (spot various bugs during review).

Thanks

> > --
> > Ben Hutchings
> > Any smoothly functioning technology is indistinguishable
> > from a rigged demo.
>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
