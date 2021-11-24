Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C86C433EF
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 07:59:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A1D0606A7;
	Wed, 24 Nov 2021 07:59:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iZ_DxY-zv9c6; Wed, 24 Nov 2021 07:59:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 049566066A;
	Wed, 24 Nov 2021 07:59:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4DF3C002E;
	Wed, 24 Nov 2021 07:59:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D395DC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 07:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B077B40117
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 07:59:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hvqZGSqRDPjl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 07:59:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 606E540003
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 07:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637740769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zbTufz8OFP7qKoRtu/NjowzzXK6S9MoWsY0AWUWHcJM=;
 b=OWHbcw+qHzw0mQzFyQFFulGAhMtoOnN1X49DG2BwKw0XOnESjLbK6Ru+U8OI4eX7DxL5al
 calhl65NJOZMtCx0eeJ9oVGfrdd6vadin+QVBx/yK7IY15KSm7dSP3KyE/EJKW7MMPMxxv
 jncUERzh2siD5dLtOpWoAxKANUgOJ0o=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-4KCSddUqMTiPMaP-nt6xuQ-1; Wed, 24 Nov 2021 02:59:25 -0500
X-MC-Unique: 4KCSddUqMTiPMaP-nt6xuQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 bp10-20020a056512158a00b0040376f60e35so1009688lfb.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 23:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zbTufz8OFP7qKoRtu/NjowzzXK6S9MoWsY0AWUWHcJM=;
 b=jueY98Aq7y8xr9UoeXyAURfXBDFjtfUeN95bn+IJ76uvj/0Y5cUDYIvq/C83FYDsLg
 h7pJnpfvPsUVRMReX7ygm3wicog4e5yKBapi4utZutTNf0ORN/AW6t6hC8Td7SX4ku74
 hi3RgdDJGmo3NJkKrJF4R1orx7M//5kC0GfvvMclwd6Itxsv/6t1c0ApxG3JwQlAW38h
 +n7SLQL15+AbTYLeww0Tj0U4zEPST2plv6ctRGolavfMavwQ2Jq+DwwU/z1qlNn40V5N
 w5NwZjY7b7wERqVA9DTygSG/ad1pQGMS8AAo6rs0/Gf42faUjSCD/ukCAJp9dqm93Ci5
 2C5A==
X-Gm-Message-State: AOAM5307y1bqaVlH98ZzLUX8ouAD1weBYd3s7BpqTPbY81Jx1MPY3t+c
 4xNHWrr/5WpT1at22NAvebVvv8ABgqRQJmUT+hS74bP3+mhmwj1sLsph7d+lu69GRBrGq86U7QX
 W2X4krVES1A0nj6BFvuQiv0Up6oft0Iv7Vxo9pUBLN0XXqUggCz+VvLB85Q==
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr13066155ljp.307.1637740764104; 
 Tue, 23 Nov 2021 23:59:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxCYPQbhK06q1h26nGEUCn/uUI2+8f3XezlXAIGXlRb/G9RCVVmQgxujGCsPJG3BDoNVR/bded9uvTVwaoO+8=
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr13066106ljp.307.1637740763785; 
 Tue, 23 Nov 2021 23:59:23 -0800 (PST)
MIME-Version: 1.0
References: <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122212352.4a76232d.pasic@linux.ibm.com>
 <CACGkMEtmhwDEAvMuMhQEUB-b+=n713pVvjyct8QAqMUk1H-A-g@mail.gmail.com>
 <20211123055906-mutt-send-email-mst@kernel.org>
 <87zgpupcga.fsf@mpe.ellerman.id.au>
 <CACGkMEteDZJVM8j5pir7_Hcn6Oq=tKbcg4DUiEQBGm5Kg9w30w@mail.gmail.com>
 <CACGkMEs086P=qfMieMQ3wPhcarsdO++iRTwVHtN-4cgKLm8opA@mail.gmail.com>
 <20211124022101-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211124022101-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Nov 2021 15:59:12 +0800
Message-ID: <CACGkMEsn8xbdEgrCwCWpGz7u=NoX-yADotCaeB2oNbZy_u9iOQ@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kaplan, david" <david.kaplan@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Michael Ellerman <mpe@ellerman.id.au>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, mcgrof@kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Wed, Nov 24, 2021 at 3:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Nov 24, 2021 at 10:33:28AM +0800, Jason Wang wrote:
> > On Wed, Nov 24, 2021 at 10:26 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Wed, Nov 24, 2021 at 9:30 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > > >
> > > > "Michael S. Tsirkin" <mst@redhat.com> writes:
> > > > > On Tue, Nov 23, 2021 at 10:25:20AM +0800, Jason Wang wrote:
> > > > >> On Tue, Nov 23, 2021 at 4:24 AM Halil Pasic <pasic@linux.ibm.com> wrote:
> > > > >> >
> > > > >> > On Mon, 22 Nov 2021 14:25:26 +0800
> > > > >> > Jason Wang <jasowang@redhat.com> wrote:
> > > > >> >
> > > > >> > > I think the fixes are:
> > > > >> > >
> > > > >> > > 1) fixing the vhost vsock
> > > > >> > > 2) use suppress_used_validation=true to let vsock driver to validate
> > > > >> > > the in buffer length
> > > > >> > > 3) probably a new feature so the driver can only enable the validation
> > > > >> > > when the feature is enabled.
> > > > >> >
> > > > >> > I'm not sure, I would consider a F_DEV_Y_FIXED_BUG_X a perfectly good
> > > > >> > feature. Frankly the set of such bugs is device implementation
> > > > >> > specific and it makes little sense to specify a feature bit
> > > > >> > that says the device implementation claims to adhere to some
> > > > >> > aspect of the specification. Also what would be the semantic
> > > > >> > of not negotiating F_DEV_Y_FIXED_BUG_X?
> > > > >>
> > > > >> Yes, I agree. Rethink of the feature bit, it seems unnecessary,
> > > > >> especially considering the driver should not care about the used
> > > > >> length for tx.
> > > > >>
> > > > >> >
> > > > >> > On the other hand I see no other way to keep the validation
> > > > >> > permanently enabled for fixed implementations, and get around the problem
> > > > >> > with broken implementations. So we could have something like
> > > > >> > VHOST_USED_LEN_STRICT.
> > > > >>
> > > > >> It's more about a choice of the driver's knowledge. For vsock TX it
> > > > >> should be fine. If we introduce a parameter and disable it by default,
> > > > >> it won't be very useful.
> > > > >>
> > > > >> >
> > > > >> > Maybe, we can also think of 'warn and don't alter behavior' instead of
> > > > >> > 'warn' and alter behavior. Or maybe even not having such checks on in
> > > > >> > production, but only when testing.
> > > > >>
> > > > >> I think there's an agreement that virtio drivers need more hardening,
> > > > >> that's why a lot of patches were merged. Especially considering the
> > > > >> new requirements came from confidential computing, smart NIC and
> > > > >> VDUSE. For virtio drivers, enabling the validation may help to
> > > > >>
> > > > >> 1) protect the driver from the buggy and malicious device
> > > > >> 2) uncover the bugs of the devices (as vsock did, and probably rpmsg)
> > > > >> 3) force the have a smart driver that can do the validation itself
> > > > >> then we can finally remove the validation in the core
> > > > >>
> > > > >> So I'd like to keep it enabled.
> > > > >>
> > > > >> Thanks
> > > > >
> > > > > Let's see how far we can get. But yes, maybe we were too aggressive in
> > > > > breaking things by default, a warning might be a better choice for a
> > > > > couple of cycles.
> > >
> > > Ok, considering we saw the issues with balloons I think I can post a
> > > patch to use warn instead. I wonder if we need to taint the kernel in
> > > this case.
> >
> > Rethink this, consider we still have some time, I tend to convert the
> > drivers to validate the length by themselves. Does this make sense?
> >
> > Thanks
>
> That's separate but let's stop crashing guests for people ASAP.

Ok, will post a patch soon.

Thanks

>
>
> > >
> > > >
> > > > This series appears to break the virtio_balloon driver as well.
> > > >
> > > > The symptom is soft lockup warnings, eg:
> > > >
> > > >   INFO: task kworker/1:1:109 blocked for more than 614 seconds.
> > > >         Not tainted 5.16.0-rc2-gcc-10.3.0 #21
> > > >   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > >   task:kworker/1:1     state:D stack:12496 pid:  109 ppid:     2 flags:0x00000800
> > > >   Workqueue: events_freezable update_balloon_size_func
> > > >   Call Trace:
> > > >   [c000000003cef7c0] [c000000003cef820] 0xc000000003cef820 (unreliable)
> > > >   [c000000003cef9b0] [c00000000001e238] __switch_to+0x1e8/0x2f0
> > > >   [c000000003cefa10] [c000000000f0a00c] __schedule+0x2cc/0xb50
> > > >   [c000000003cefae0] [c000000000f0a8fc] schedule+0x6c/0x140
> > > >   [c000000003cefb10] [c00000000095b6c4] tell_host+0xe4/0x130
> > > >   [c000000003cefba0] [c00000000095d234] update_balloon_size_func+0x394/0x3f0
> > > >   [c000000003cefc70] [c000000000178064] process_one_work+0x2c4/0x5b0
> > > >   [c000000003cefd10] [c0000000001783f8] worker_thread+0xa8/0x640
> > > >   [c000000003cefda0] [c000000000185444] kthread+0x1b4/0x1c0
> > > >   [c000000003cefe10] [c00000000000cee4] ret_from_kernel_thread+0x5c/0x64
> > > >
> > > > Similar backtrace reported here by Luis:
> > > >
> > > >   https://lore.kernel.org/lkml/YY2duTi0wAyAKUTJ@bombadil.infradead.org/
> > > >
> > > > Bisect points to:
> > > >
> > > >   # first bad commit: [939779f5152d161b34f612af29e7dc1ac4472fcf] virtio_ring: validate used buffer length
> > > >
> > > > Adding suppress used validation to the virtio balloon driver "fixes" it, eg.
> > > >
> > > > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > > > index c22ff0117b46..a14b82ceebb2 100644
> > > > --- a/drivers/virtio/virtio_balloon.c
> > > > +++ b/drivers/virtio/virtio_balloon.c
> > > > @@ -1150,6 +1150,7 @@ static unsigned int features[] = {
> > > >  };
> > > >
> > > >  static struct virtio_driver virtio_balloon_driver = {
> > > > +       .suppress_used_validation = true,
> > > >         .feature_table = features,
> > > >         .feature_table_size = ARRAY_SIZE(features),
> > > >         .driver.name =  KBUILD_MODNAME,
> > >
> > > Looks good, we need a formal patch for this.
> > >
> > > And we need fix Qemu as well which advertise non zero used length for
> > > inflate/deflate queue:
> > >
> > > static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> > > ...
> > >         virtqueue_push(vq, elem, offset);
> > >
> > > Thanks
> > >
> > > >
> > > >
> > > > cheers
> > > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
