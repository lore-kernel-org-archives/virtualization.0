Return-Path: <SRS0=qgkY=OM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79EEC433F5
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 06:39:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E871611B0
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 06:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E871611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EB4C40280;
	Wed, 22 Sep 2021 06:39:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e666d1RPcQsX; Wed, 22 Sep 2021 06:39:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A603D40267;
	Wed, 22 Sep 2021 06:39:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FDC6C0011;
	Wed, 22 Sep 2021 06:39:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 430F9C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 06:39:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1927960A57
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 06:39:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9BOB7d10kFXJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 06:39:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A30F60839
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 06:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632292753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JcotAE6FAtZHKmMELnUOw/NlhguyLycRPN4KuvENKhc=;
 b=TMYn8QxKuTBI/tytiwrVwlxcH3igboWMaKr/6K8fwCMkzdo5ElhQTRfACEulOMGYnS+Ohh
 85NJ/YMcy11ab7qRDmy30JvlVVv1Hf+vVWUECylTXAOMkZLGNgqjU3SJ7boB0ORpVm67ER
 pAFMKQmvTFRRkSptJ4uWHBjHtDLRYis=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-9HpujQytO-uuuEcsfbELiA-1; Wed, 22 Sep 2021 02:39:10 -0400
X-MC-Unique: 9HpujQytO-uuuEcsfbELiA-1
Received: by mail-wr1-f72.google.com with SMTP id
 f11-20020adfc98b000000b0015fedc2a8d4so1219669wrh.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 23:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JcotAE6FAtZHKmMELnUOw/NlhguyLycRPN4KuvENKhc=;
 b=RCTZGYtj3dSSrYXX7G+tiopMk4zzInSIBQPnk4zhxbrknLedYfO/VDcdxAscTEfJ/S
 1BF93x3379SkxQCOY3m43b5qsIkfwSHWijOkj1wW9Y5aG/JcCY9KQfOLrDYAhGYgjZ8r
 /4WdfmsB/sFO83Dr5PL8u3+hbieRS9+r4+xfZEw8Vicya/Z8G8+i2jyEJ4CxEy5u5c5X
 fnBaDjJjDaYObMLiBrIfDr2nbKN+4R9l+UxNxuV3Mas7HkRIyf1OZQHMe3EAi+kf28IM
 VfL/UG0kLlVMboPVSFqUvl6d7yVU5lwilIH4AgBkO+SUEYlm4PjloErpulO40f5SKsqC
 V/fQ==
X-Gm-Message-State: AOAM530E0ZthGh4NB6sWfAIs+H/svt5jmmt4kANZ1SsVjx36nxm+7bZq
 B/dbCj+1SvpmAB4YOy8b9hrg9otwOEALT7PCnvg2H43360UdoSDcHs9PtyBJYMPakvg6CrH5mRk
 GAAnDA8ULnkJalh6VUjHV7ccpNXpyo1CGvFbeDOsuvg==
X-Received: by 2002:a5d:6841:: with SMTP id o1mr39682530wrw.39.1632292749296; 
 Tue, 21 Sep 2021 23:39:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUJ7kcbvr+vICvkPEaDq3ruju79fFkgKr2zxuvzDsmd9Ctg+Iatfl0RN9OtD/w1ZRGL2nOaQ==
X-Received: by 2002:a5d:6841:: with SMTP id o1mr39682511wrw.39.1632292749028; 
 Tue, 21 Sep 2021 23:39:09 -0700 (PDT)
Received: from redhat.com ([2.55.11.56])
 by smtp.gmail.com with ESMTPSA id j23sm1099917wmo.14.2021.09.21.23.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 23:39:08 -0700 (PDT)
Date: Wed, 22 Sep 2021 02:39:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: Use of uninitialized memory with CONFIG_HW_RANDOM_VIRTIO
Message-ID: <20210922023846-mutt-send-email-mst@kernel.org>
References: <CAG_fn=WwQ29akxY1Eq=N_=HCF3t7z+T2obh9aRVUDFy1FSA3-Q@mail.gmail.com>
 <20210819165742-mutt-send-email-mst@kernel.org>
 <d0d232ab-5222-5eef-60de-e8cc0f2a0791@redhat.com>
 <CAG_fn=Um3Up2VyGOC0ezJ51N8AWZfGcWz+98cvwpBrJkby3+NA@mail.gmail.com>
 <639bbb70-eca8-97c5-7faa-8563e594d67a@redhat.com>
 <CAG_fn=VGU5A+JDC9mqksLbHHjHEJ6RSB9Ce2WVF9ysAHd=RWKg@mail.gmail.com>
 <e4ecab9b-1d09-069f-1ef1-d8d5a3499826@redhat.com>
 <20210916185802-mutt-send-email-mst@kernel.org>
 <b3569868-f9fd-438e-2d18-984ff1689432@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b3569868-f9fd-438e-2d18-984ff1689432@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: amit@kernel.org, rusty@rustcorp.com.au,
 virtualization@lists.linux-foundation.org,
 syzkaller <syzkaller@googlegroups.com>,
 Alexander Potapenko <glider@google.com>, akong@redhat.com,
 Dmitriy Vyukov <dvyukov@google.com>
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

On Fri, Sep 17, 2021 at 02:57:02PM +0200, Laurent Vivier wrote:
> On 17/09/2021 00:58, Michael S. Tsirkin wrote:
> > On Thu, Sep 16, 2021 at 10:52:59AM +0200, Laurent Vivier wrote:
> > > On 13/09/2021 10:25, Alexander Potapenko wrote:
> > > > Hi Laurent,
> > > > 
> > > > I took the latest kernel (5.15-rc1,
> > > > 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f) and a slightly modified
> > > > config from syzbot (see attached)
> > > > The latter has a lot of unnecessary debug checks, but those should not
> > > > affect the RNG.
> > > > 
> > > > You then need to apply the following patch to the kernel:
> > > > 
> > > > ====================================================
> > > > diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> > > > index a3db27916256d..a4cba9f0ff8cb 100644
> > > > --- a/drivers/char/hw_random/core.c
> > > > +++ b/drivers/char/hw_random/core.c
> > > > @@ -433,8 +433,11 @@ static int hwrng_fillfn(void *unused)
> > > >                   if (IS_ERR(rng) || !rng)
> > > >                           break;
> > > >                   mutex_lock(&reading_mutex);
> > > > +               memset(rng_fillbuf, 'A', rng_buffer_size());
> > > > +               rng_fillbuf[rng_buffer_size()-1] = 0;
> > > >                   rc = rng_get_data(rng, rng_fillbuf,
> > > >                                     rng_buffer_size(), 1);
> > > > +               pr_err("rng_fillbuf: %s\n", rng_fillbuf);
> > > >                   mutex_unlock(&reading_mutex);
> > > >                   put_rng(rng);
> > > >                   if (rc <= 0) {
> > > > ====================================================
> > > > 
> > > > and run the kernel under QEMU.
> > > > 
> > > > On my machine I'm seeing the following output:
> > > > 
> > > > $ cat log | strings | grep rng_fillbuf
> > > > [    4.901931][  T897] rng_fillbuf:
> > > > AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
> > > > [    4.903104][  T897] rng_fillbuf: >
> > > > [    4.903641][  T897] rng_fillbuf:
> > > > [    4.904846][  T897] rng_fillbuf: ?
> > > > [    4.913442][  T897] rng_fillbuf: [
> > > > 
> > > > , which denotes that the first call to rng_get_data() leaves
> > > > rng_fillbuf uninitialized.
> > > 
> > > 
> > > Thank you for the detailed steps.
> > > 
> > > The problem happens because we mix two different buffers:
> > > - in add_early_randomness() we provide rng_buffer but don't wait it is full (see [1])
> > > - in hwrng_fillfn() we provide rng_fillbuf, and we wait data here, but we
> > > received the signal from QEMU that there are data, but these data are in
> > > rng_buffer while we expect them in rng_fillbuf.
> > > 
> > > There are several ways to fix/workaround that:
> > > 
> > > 1- ignore the read when wait=0 :
> > > 
> > > diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> > > index a90001e02bf7..8466d76566fd 100644
> > > --- a/drivers/char/hw_random/virtio-rng.c
> > > +++ b/drivers/char/hw_random/virtio-rng.c
> > > @@ -59,15 +59,15 @@ static int virtio_read(struct hwrng *rng, void *buf,
> > > size_t size, bool wait)
> > >          if (vi->hwrng_removed)
> > >                  return -ENODEV;
> > > 
> > > +       if (!wait)
> > > +               return 0;
> > > +
> > >          if (!vi->busy) {
> > >                  vi->busy = true;
> > >                  reinit_completion(&vi->have_data);
> > >                  register_buffer(vi, buf, size);
> > >          }
> > > 
> > > -       if (!wait)
> > > -               return 0;
> > > -
> > >          ret = wait_for_completion_killable(&vi->have_data);
> > >          if (ret < 0)
> > >                  return ret;
> > > 
> > > 
> > > 2- Use an internal intermediate buffer in virtio-rng, at a cost of a copy,
> > >     I have some patches (somewhere) I can refresh to do that.
> > > 
> > > 3- modify hw_random/core.c to use only one buffer
> > > 
> > > Thanks,
> > > Laurent
> > > 
> > > [1] 78887832e765 ("hwrng: core - don't wait on add_early_randomness()")
> > 
> > 4. actually differentiate between the two
> > using the pointer returned by get_buf.
> 
> Even if it can help I think we should avoid to keep mixing buffers.
> 
> For instance, if we submit a buffer with wait=0, the caller can re-use or
> release the memory while it is queued in the queue of the device.
> 
> Moreover, what to do if buffers differ?
> 
> Wait and use the data in the previous buffer (that can be corrupted by the
> submitter in-between)?
> 
> Or wait and drop, and wait again with the new buffer?
> 
> BTW, I found my patches that introduce an internal buffer in virtio-rng (solution 2):
> 
> https://github.com/vivier/linux/commits/virtio-rng
> 
> Thanks,
> Laurent

Pls go ahead and post them!

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
