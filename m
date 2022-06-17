Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F6EC43334
	for <virtualization@archiver.kernel.org>; Fri, 17 Jun 2022 03:15:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A57C4840CD;
	Fri, 17 Jun 2022 03:15:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A57C4840CD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FpGlBWWr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AojkGXu1_eZl; Fri, 17 Jun 2022 03:15:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0FB638405D;
	Fri, 17 Jun 2022 03:15:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FB638405D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3FBDC0032;
	Fri, 17 Jun 2022 03:15:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B768EC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 03:15:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B96A60EF8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 03:15:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B96A60EF8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FpGlBWWr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kzoEk5z_vzYz
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 03:15:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F284607C7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F284607C7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 03:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655435705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zyXdUs74Sn1gokvnhKFxRwfNZUQVkLFJThbXXT8GKOo=;
 b=FpGlBWWrV1qfjPPvo3gQvmv/oFAqtoyoS3Tv/qymj6piv4j491bd+Gxqtnge8Y/tdiW/zN
 32KSs9k0pSkFFkt6Yo4LDJpkVwy9Krap/TWNZaw/1yJvDc0aMvbdBPzMNTBCs+osV+y+Sh
 QtQ/be8q4276AvwQDpIBv6WOljpBWX0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-TLfDA1SyNpy0US8QozxU9A-1; Thu, 16 Jun 2022 23:15:03 -0400
X-MC-Unique: TLfDA1SyNpy0US8QozxU9A-1
Received: by mail-lj1-f198.google.com with SMTP id
 m14-20020a2e97ce000000b002556f5f731dso403274ljj.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 20:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zyXdUs74Sn1gokvnhKFxRwfNZUQVkLFJThbXXT8GKOo=;
 b=T+d5m4KJjVxbxND/56Kp+zXjI5XIJxEu3ZT0q3+b+GjJBB2ksIBdAAdu2P/NP0nSQt
 gkAnduCIUJLk3tg744yJ7Op5/rCUPQp+C+w/4IPUAAgRRsyeqTVMdPBeHgX568z+4L89
 lGxBXpBmp2rspYkTY51nJPuftcsJr83uOJ2ssqgtesszkBBoUTZhGIY5IaXktRhh+YgG
 +bRLzt1RhmiUTwNJIFWY2/u17f5JkFTwr6UPMoCYllj3ZIk3m231Mg9fyNu4LAvkpoT9
 /K14UHaC22R+rYbmQpi08GsaTfzETv5N9CnFzUo4IcHOcN3Bm+splXggsfZRcihYKlAq
 U8Fw==
X-Gm-Message-State: AJIora+SE4FARDFX1N5OZDusoSRRf++/ksvnyhBHLjeIsSGF0xURdN40
 SDdRA2Y9ee1OG21hlPe9cHJNEJeW6WtWkB4+/WjlpBnkS0TZtTIiANccnyz345cOBG1/srW0dhT
 YoiRXL9Xd27Q0laGqq/IsWDLlNjU2p52OAxL0z+rAukJU1FoBJftnyG5khg==
X-Received: by 2002:a19:4352:0:b0:479:5d1:3fef with SMTP id
 m18-20020a194352000000b0047905d13fefmr4339505lfj.411.1655435701800; 
 Thu, 16 Jun 2022 20:15:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vrhZSavPJtlgCcYBizs4v7LLbX7WbLjH0ir+NVgTVj79Hn7OdCFvYsSXLKV5EDBsPKindEevKRIpCVFBpp9dE=
X-Received: by 2002:a19:4352:0:b0:479:5d1:3fef with SMTP id
 m18-20020a194352000000b0047905d13fefmr4339489lfj.411.1655435701522; Thu, 16
 Jun 2022 20:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEs05ZisiPW+7H6Omp80MzmZWZCpc1mf5Vd99C3H-KUtgA@mail.gmail.com>
 <20220613041416-mutt-send-email-mst@kernel.org>
 <CACGkMEsT_fWdPxN1cTWOX=vu-ntp3Xo4j46-ZKALeSXr7DmJFQ@mail.gmail.com>
 <20220613045606-mutt-send-email-mst@kernel.org>
 <CACGkMEtAQck7Nr6SP_pD0MGT3njnwZSyT=xPyYzUU3c5GNNM_w@mail.gmail.com>
 <CACGkMEvUFJkC=mnvL2PSH6-3RMcJUk84f-9X46JVcj2vTAr4SQ@mail.gmail.com>
 <20220613052644-mutt-send-email-mst@kernel.org>
 <CACGkMEstGvhETXThuwO+tLVBuRgQb8uC_6DdAM8ZxOi5UKBRbg@mail.gmail.com>
 <Yqi7UhasBDPKCpuV@e120937-lin>
 <CACGkMEv2A7ZHQTrdg9H=xZScAf2DE=Dguaz60ykd4KQGNLrn2Q@mail.gmail.com>
 <YqojyHuocSoZ0v/Y@e120937-lin>
In-Reply-To: <YqojyHuocSoZ0v/Y@e120937-lin>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Jun 2022 11:14:50 +0800
Message-ID: <CACGkMEsdhCx8mmGn+axjM-+Psep4jVN2zzbBQhjW3y6gvHXxXQ@mail.gmail.com>
Subject: Re: [PATCH V6 8/9] virtio: harden vring IRQ
To: Cristian Marussi <cristian.marussi@arm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Vineeth Vijayan <vneethv@linux.ibm.com>, Cindy Lu <lulu@redhat.com>,
 Marc Zyngier <maz@kernel.org>, Halil Pasic <pasic@linux.ibm.com>,
 eperezma <eperezma@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-s390@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 virtualization <virtualization@lists.linux-foundation.org>,
 conghui.chen@intel.com, pankaj.gupta.linux@gmail.com,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev <netdev@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Peter Oberparleiter <oberpar@linux.ibm.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, sudeep.holla@arm.com
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

On Thu, Jun 16, 2022 at 2:24 AM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> On Wed, Jun 15, 2022 at 09:41:18AM +0800, Jason Wang wrote:
> > On Wed, Jun 15, 2022 at 12:46 AM Cristian Marussi
> > <cristian.marussi@arm.com> wrote:
>
> Hi Jason,
>
> > >
> > > On Tue, Jun 14, 2022 at 03:40:21PM +0800, Jason Wang wrote:
> > > > On Mon, Jun 13, 2022 at 5:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > >
>
> [snip]
>
> > > >
> > > > >  arm_scmi
> > > >
> > > > It looks to me the singleton device could be used by SCMI immediately after
> > > >
> > > >         /* Ensure initialized scmi_vdev is visible */
> > > >         smp_store_mb(scmi_vdev, vdev);
> > > >
> > > > So we probably need to do virtio_device_ready() before that. It has an
> > > > optional rx queue but the filling is done after the above assignment,
> > > > so it's safe. And the callback looks safe is a callback is triggered
> > > > after virtio_device_ready() buy before the above assignment.
> > > >
> > >
> > > I wanted to give it a go at this series testing it on the context of
> > > SCMI but it does not apply
> > >
> > > - not on a v5.18:
> > >
> > > 17:33 $ git rebase -i v5.18
> > > 17:33 $ git am ./v6_20220527_jasowang_rework_on_the_irq_hardening_of_virtio.mbx
> > > Applying: virtio: use virtio_device_ready() in virtio_device_restore()
> > > Applying: virtio: use virtio_reset_device() when possible
> > > Applying: virtio: introduce config op to synchronize vring callbacks
> > > Applying: virtio-pci: implement synchronize_cbs()
> > > Applying: virtio-mmio: implement synchronize_cbs()
> > > error: patch failed: drivers/virtio/virtio_mmio.c:345
> > > error: drivers/virtio/virtio_mmio.c: patch does not apply
> > > Patch failed at 0005 virtio-mmio: implement synchronize_cbs()
> > >
> > > - neither on a v5.19-rc2:
> > >
> > > 17:33 $ git rebase -i v5.19-rc2
> > > 17:35 $ git am ./v6_20220527_jasowang_rework_on_the_irq_hardening_of_virtio.mbx
> > > Applying: virtio: use virtio_device_ready() in virtio_device_restore()
> > > error: patch failed: drivers/virtio/virtio.c:526
> > > error: drivers/virtio/virtio.c: patch does not apply
> > > Patch failed at 0001 virtio: use virtio_device_ready() in
> > > virtio_device_restore()
> > > hint: Use 'git am --show-current-patch=diff' to see the failed patch
> > > When you have resolved this problem, run "git am --continue".
> > >
> > > ... what I should take as base ?
> >
> > It should have already been included in rc2, so there's no need to
> > apply patch manually.
> >
>
> I tested this series as included in v5.19-rc2 (WITHOUT adding a virtio_device_ready
> in SCMI virtio as you mentioned above ... if I got it right) and I have NOT seen any
> issue around SCMI virtio using my usual test setup (using both SCMI vqueues).
>
> No anomalies even when using SCMI virtio in atomic/polling mode.
>
> Adding a virtio_device_ready() at the end of the SCMI virtio probe()
> works fine either, it does not make any difference in my setup.
> (both using QEMU and kvmtool with this latter NOT supporting
>  virtio_V1...not sure if it makes a difference but I thought was worth
>  mentioning)

Thanks a lot for the testing.

We want to prevent malicious hypervisors from attacking us. So more questions:

Assuming we do:

virtio_device_ready();
/* Ensure initialized scmi_vdev is visible */
smp_store_mb(scmi_vdev, vdev);

This means we allow the callbacks (scmi_vio_complete) to be called
before smp_store_mb(). We need to make sure the callbacks are robust.
And this looks fine since we have the check of
scmi_vio_channel_acquire() and if the notification is called before
smp_store_mb(), the acquire will fail.

If we put virtio_device_ready() after smp_store_mb() like:

/* Ensure initialized scmi_vdev is visible */
smp_store_mb(scmi_vdev, vdev);
virtio_device_ready();

If I understand correctly, there will be a race since the SCMI may try
to use the device before virtio_device_ready(), this violates the
virtio spec somehow.

Thanks

>
> Thanks,
> Cristian
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
