Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D2CECAAD3
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 07:47:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2428C40475;
	Wed,  7 Sep 2022 07:47:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2428C40475
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OaqBFTGE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C8kmeZCr2bve; Wed,  7 Sep 2022 07:47:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3A0D44048F;
	Wed,  7 Sep 2022 07:47:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A0D44048F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E38ABC0032;
	Wed,  7 Sep 2022 07:47:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8554BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 07:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5DE7140533
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 07:47:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5DE7140533
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ecv_0SzWlqUq
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 07:47:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 457CD4048F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 457CD4048F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 07:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662536824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nsmvzDdU873IEoh1AjpLdUk0IkH22pk9o0ERO+Ke0Qs=;
 b=OaqBFTGE871PslXddGnEnYnLUuK0/M8zyYgmuSQRInea1FdXWYYiifSHNgt4Mls9KRMAvx
 qUmvt9z3FFheh39EH+S2O3+GImjGOkEosa9tAg8Us8/Q0s49mLW+ZqFDrXSv0J8bn5xUOV
 zgHMicCuZcD/rsMKaD61M3XIh8ztdRU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-312-AxP98VuHPLOKKruM_Mk7DA-1; Wed, 07 Sep 2022 03:47:01 -0400
X-MC-Unique: AxP98VuHPLOKKruM_Mk7DA-1
Received: by mail-ed1-f70.google.com with SMTP id
 q18-20020a056402519200b0043dd2ff50feso9084172edd.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 00:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=nsmvzDdU873IEoh1AjpLdUk0IkH22pk9o0ERO+Ke0Qs=;
 b=tZwtXIfQ7TMWQyfCUxp99f5h4I8W6c6pgLbMPk9f8wueacyUfVUO9bp67/VD2E6c3H
 jahgnYlKgUxuIDrivbiWFceX3Fq+VNN18VrHGf9J4VrFypVyMNfDsB/c1zqP1Cazm6I+
 U1dQCcMe5V/zTDNoRVECyn+FHasqtlAivjeYEF+6H+4eh/pwwBRT9PZldJ5xMVR864Ou
 nVESMq1IpRFKayw6PyvQgPAFZ/qhQSLJDgzJkQFQwhk5JwvkiCTHDm+/cVfdaO33dsAs
 Yf1NuEtTspQ3wuW4GMGfJL0aj67DXiAuMkXwEMGLIlQkQhiSju47zUBL4JTYvZkBs6V3
 sGAQ==
X-Gm-Message-State: ACgBeo3lnPWhdlF46h9SZgyHFhR6pqf1Tne+GTK6FS7oe9H8s2LishpJ
 1x+BXLuTKzdEft9z1Xj/7OLUMOYb1Qe0mSDFz00hhkpqAL5YZNMhaFnyXVtxutfSRMqKgqVgu6Q
 OxEE+8NUM2VqN24ggWaSuaWV6m6KFUgJzKCWMZ81dqA==
X-Received: by 2002:a17:907:75ea:b0:73d:daa0:3cbe with SMTP id
 jz10-20020a17090775ea00b0073ddaa03cbemr1456174ejc.662.1662536820005; 
 Wed, 07 Sep 2022 00:47:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR53nL8cnG0zY4L4+T4oecAyIfM8opFTzrBVui+uiS85jZRfT6dg9G8YzC/sl54kdM02S1/TMA==
X-Received: by 2002:a17:907:75ea:b0:73d:daa0:3cbe with SMTP id
 jz10-20020a17090775ea00b0073ddaa03cbemr1456158ejc.662.1662536819797; 
 Wed, 07 Sep 2022 00:46:59 -0700 (PDT)
Received: from redhat.com ([2.52.135.118]) by smtp.gmail.com with ESMTPSA id
 b9-20020a1709063ca900b0073c82539183sm8022689ejh.91.2022.09.07.00.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 00:46:59 -0700 (PDT)
Date: Wed, 7 Sep 2022 03:46:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command
 waiting loop
Message-ID: <20220907034407-mutt-send-email-mst@kernel.org>
References: <20220905045341.66191-1-jasowang@redhat.com>
 <20220905031405-mutt-send-email-mst@kernel.org>
 <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com>
 <056ba905a2579903a372258383afdf6579767ad0.camel@redhat.com>
 <CACGkMEuiDqqOEKUWRN9LvQKv8Jz4mi3aSZMwbhUsJkZp=C-0RQ@mail.gmail.com>
 <c9180ac41b00543e3531a343afae8f5bdca64d8d.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c9180ac41b00543e3531a343afae8f5bdca64d8d.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Gautam Dawar <gautam.dawar@xilinx.com>, davem <davem@davemloft.net>
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

On Wed, Sep 07, 2022 at 09:07:20AM +0200, Paolo Abeni wrote:
> On Wed, 2022-09-07 at 10:09 +0800, Jason Wang wrote:
> > On Tue, Sep 6, 2022 at 6:56 PM Paolo Abeni <pabeni@redhat.com> wrote:
> > > 
> > > On Mon, 2022-09-05 at 15:49 +0800, Jason Wang wrote:
> > > > On Mon, Sep 5, 2022 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > 
> > > > > On Mon, Sep 05, 2022 at 12:53:41PM +0800, Jason Wang wrote:
> > > > > > Adding cond_resched() to the command waiting loop for a better
> > > > > > co-operation with the scheduler. This allows to give CPU a breath to
> > > > > > run other task(workqueue) instead of busy looping when preemption is
> > > > > > not allowed.
> > > > > > 
> > > > > > What's more important. This is a must for some vDPA parent to work
> > > > > > since control virtqueue is emulated via a workqueue for those parents.
> > > > > > 
> > > > > > Fixes: bda324fd037a ("vdpasim: control virtqueue support")
> > > > > 
> > > > > That's a weird commit to fix. so it fixes the simulator?
> > > > 
> > > > Yes, since the simulator is using a workqueue to handle control virtueue.
> > > 
> > > Uhmm... touching a driver for a simulator's sake looks a little weird.
> > 
> > Simulator is not the only one that is using a workqueue (but should be
> > the first).
> > 
> > I can see  that the mlx5 vDPA driver is using a workqueue as well (see
> > mlx5_vdpa_kick_vq()).
> > 
> > And in the case of VDUSE, it needs to wait for the response from the
> > userspace, this means cond_resched() is probably a must for the case
> > like UP.
> > 
> > > 
> > > Additionally, if the bug is vdpasim, I think it's better to try to
> > > solve it there, if possible.
> > > 
> > > Looking at vdpasim_net_work() and vdpasim_blk_work() it looks like
> > > neither needs a process context, so perhaps you could rework it to run
> > > the work_fn() directly from vdpasim_kick_vq(), at least for the control
> > > virtqueue?
> > 
> > It's possible (but require some rework on the simulator core). But
> > considering we have other similar use cases, it looks better to solve
> > it in the virtio-net driver.
> 
> I see.
> 
> > Additionally, this may have better behaviour when using for the buggy
> > hardware (e.g the control virtqueue takes too long to respond). We may
> > consider switching to use interrupt/sleep in the future (but not
> > suitable for -net).
> 
> Agreed. Possibly a timeout could be useful, too.
> 
> Cheers,
> 
> Paolo


Hmm timeouts are kind of arbitrary.
regular drivers basically derive them from hardware
behaviour but with a generic driver like virtio it's harder.
I guess we could add timeout as a config field, have
device make a promise to the driver.

Making the wait interruptible seems more reasonable.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
