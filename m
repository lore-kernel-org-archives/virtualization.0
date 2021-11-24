Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE757C433EF
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 02:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E36B8402D3;
	Wed, 24 Nov 2021 02:27:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GyaTiuNYJaW1; Wed, 24 Nov 2021 02:27:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 46B0F402CB;
	Wed, 24 Nov 2021 02:27:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F539C001E;
	Wed, 24 Nov 2021 02:27:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B0E1C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:27:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0286C402CE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:27:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CouT5HtNu9F7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:27:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 53427402CB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637720822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w6wNdt+sFuquhukKO+jtWJRr9FbN+vDA1Oai3GCKD8c=;
 b=BUMaLwrnQlcV6dlFmL8MEwfaK6QaPQtdzFLwoIgux/UsrNayO5gKl442lnGt9HRrvIoNDN
 KEozB5ohYPMI9vvrAfkhJ8KRhxrIXzLJTqtq1EfVhlSTLyJiNXqjAwqVrV/r3cZT92s91k
 L14EH4xqGeBveBB0TfxjgKccZdVMhHM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-2JUpwTiRPp6yzoQdwRgMew-1; Tue, 23 Nov 2021 21:26:58 -0500
X-MC-Unique: 2JUpwTiRPp6yzoQdwRgMew-1
Received: by mail-lj1-f199.google.com with SMTP id
 d20-20020a05651c111400b00218c6372b7eso268180ljo.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 18:26:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w6wNdt+sFuquhukKO+jtWJRr9FbN+vDA1Oai3GCKD8c=;
 b=hHiwbBJ3TPlbxUqu/axI5rdOvHXoOydBfuj7htPSzj4xMY3GTtOXQrQckMFyWTDLxK
 ii0MUHnE7glNVhspkA11MsAYfnojdjqJ/M4UU+lPqqMhkHUi2bwlZBgtwp93SyO23q+3
 NV2xVyyiMd9TKR9lhUlywhV0RSQOmo7C6plZx9PokrY8bMk1KQHUfVtufI8leaYu5k9A
 MX4Dm6bM0cZ3kuAQWfKsvb9kzzAQKoM8hZMJ7ahXsik4fVOcZE+ru/V8qB2HyAzezNOC
 Vgj/Bt09sOactL3LNOXZBNnKMKWE0qCHMHcXQ/cBKw920gqEv3drBJZeWqigcdvFiQBZ
 X+Vg==
X-Gm-Message-State: AOAM530gkapKm7TjnX1FwySALTsNJV8cnVNiVGxCixhIrisr4N+ciBNk
 jwr8t+puJ2AmsiIMxdKSWW6Pm54UKa+BwT/KwVTc40RlwLyX+OCCzfSJP/lDBMBNNznxFZZEHNO
 vm5hGgNieXnskGd8P0xs4mSuNhUo7baTrN4W9yndP+2PRRCnZn8Xq3GLAbA==
X-Received: by 2002:ac2:518b:: with SMTP id u11mr10402085lfi.498.1637720817336; 
 Tue, 23 Nov 2021 18:26:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylenekiMXHQQB/1dwxMBCcn0+BVsdWPasHqJoHJdCdf4uLiGHUVWfCNXtXxE0CDCGa7/Ua2UaOr1w18uyygTk=
X-Received: by 2002:ac2:518b:: with SMTP id u11mr10402056lfi.498.1637720817094; 
 Tue, 23 Nov 2021 18:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122212352.4a76232d.pasic@linux.ibm.com>
 <CACGkMEtmhwDEAvMuMhQEUB-b+=n713pVvjyct8QAqMUk1H-A-g@mail.gmail.com>
 <20211123055906-mutt-send-email-mst@kernel.org>
 <87zgpupcga.fsf@mpe.ellerman.id.au>
In-Reply-To: <87zgpupcga.fsf@mpe.ellerman.id.au>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Nov 2021 10:26:45 +0800
Message-ID: <CACGkMEteDZJVM8j5pir7_Hcn6Oq=tKbcg4DUiEQBGm5Kg9w30w@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
To: Michael Ellerman <mpe@ellerman.id.au>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kaplan, david" <david.kaplan@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, mcgrof@kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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

On Wed, Nov 24, 2021 at 9:30 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > On Tue, Nov 23, 2021 at 10:25:20AM +0800, Jason Wang wrote:
> >> On Tue, Nov 23, 2021 at 4:24 AM Halil Pasic <pasic@linux.ibm.com> wrote:
> >> >
> >> > On Mon, 22 Nov 2021 14:25:26 +0800
> >> > Jason Wang <jasowang@redhat.com> wrote:
> >> >
> >> > > I think the fixes are:
> >> > >
> >> > > 1) fixing the vhost vsock
> >> > > 2) use suppress_used_validation=true to let vsock driver to validate
> >> > > the in buffer length
> >> > > 3) probably a new feature so the driver can only enable the validation
> >> > > when the feature is enabled.
> >> >
> >> > I'm not sure, I would consider a F_DEV_Y_FIXED_BUG_X a perfectly good
> >> > feature. Frankly the set of such bugs is device implementation
> >> > specific and it makes little sense to specify a feature bit
> >> > that says the device implementation claims to adhere to some
> >> > aspect of the specification. Also what would be the semantic
> >> > of not negotiating F_DEV_Y_FIXED_BUG_X?
> >>
> >> Yes, I agree. Rethink of the feature bit, it seems unnecessary,
> >> especially considering the driver should not care about the used
> >> length for tx.
> >>
> >> >
> >> > On the other hand I see no other way to keep the validation
> >> > permanently enabled for fixed implementations, and get around the problem
> >> > with broken implementations. So we could have something like
> >> > VHOST_USED_LEN_STRICT.
> >>
> >> It's more about a choice of the driver's knowledge. For vsock TX it
> >> should be fine. If we introduce a parameter and disable it by default,
> >> it won't be very useful.
> >>
> >> >
> >> > Maybe, we can also think of 'warn and don't alter behavior' instead of
> >> > 'warn' and alter behavior. Or maybe even not having such checks on in
> >> > production, but only when testing.
> >>
> >> I think there's an agreement that virtio drivers need more hardening,
> >> that's why a lot of patches were merged. Especially considering the
> >> new requirements came from confidential computing, smart NIC and
> >> VDUSE. For virtio drivers, enabling the validation may help to
> >>
> >> 1) protect the driver from the buggy and malicious device
> >> 2) uncover the bugs of the devices (as vsock did, and probably rpmsg)
> >> 3) force the have a smart driver that can do the validation itself
> >> then we can finally remove the validation in the core
> >>
> >> So I'd like to keep it enabled.
> >>
> >> Thanks
> >
> > Let's see how far we can get. But yes, maybe we were too aggressive in
> > breaking things by default, a warning might be a better choice for a
> > couple of cycles.

Ok, considering we saw the issues with balloons I think I can post a
patch to use warn instead. I wonder if we need to taint the kernel in
this case.

>
> This series appears to break the virtio_balloon driver as well.
>
> The symptom is soft lockup warnings, eg:
>
>   INFO: task kworker/1:1:109 blocked for more than 614 seconds.
>         Not tainted 5.16.0-rc2-gcc-10.3.0 #21
>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>   task:kworker/1:1     state:D stack:12496 pid:  109 ppid:     2 flags:0x00000800
>   Workqueue: events_freezable update_balloon_size_func
>   Call Trace:
>   [c000000003cef7c0] [c000000003cef820] 0xc000000003cef820 (unreliable)
>   [c000000003cef9b0] [c00000000001e238] __switch_to+0x1e8/0x2f0
>   [c000000003cefa10] [c000000000f0a00c] __schedule+0x2cc/0xb50
>   [c000000003cefae0] [c000000000f0a8fc] schedule+0x6c/0x140
>   [c000000003cefb10] [c00000000095b6c4] tell_host+0xe4/0x130
>   [c000000003cefba0] [c00000000095d234] update_balloon_size_func+0x394/0x3f0
>   [c000000003cefc70] [c000000000178064] process_one_work+0x2c4/0x5b0
>   [c000000003cefd10] [c0000000001783f8] worker_thread+0xa8/0x640
>   [c000000003cefda0] [c000000000185444] kthread+0x1b4/0x1c0
>   [c000000003cefe10] [c00000000000cee4] ret_from_kernel_thread+0x5c/0x64
>
> Similar backtrace reported here by Luis:
>
>   https://lore.kernel.org/lkml/YY2duTi0wAyAKUTJ@bombadil.infradead.org/
>
> Bisect points to:
>
>   # first bad commit: [939779f5152d161b34f612af29e7dc1ac4472fcf] virtio_ring: validate used buffer length
>
> Adding suppress used validation to the virtio balloon driver "fixes" it, eg.
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index c22ff0117b46..a14b82ceebb2 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -1150,6 +1150,7 @@ static unsigned int features[] = {
>  };
>
>  static struct virtio_driver virtio_balloon_driver = {
> +       .suppress_used_validation = true,
>         .feature_table = features,
>         .feature_table_size = ARRAY_SIZE(features),
>         .driver.name =  KBUILD_MODNAME,

Looks good, we need a formal patch for this.

And we need fix Qemu as well which advertise non zero used length for
inflate/deflate queue:

static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
...
        virtqueue_push(vq, elem, offset);

Thanks

>
>
> cheers
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
