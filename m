Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B78BC433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 07:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27DCD81452;
	Tue, 22 Feb 2022 07:11:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dlMNvFp3GoMe; Tue, 22 Feb 2022 07:11:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BD276813EC;
	Tue, 22 Feb 2022 07:11:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BE6FC001A;
	Tue, 22 Feb 2022 07:11:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AC87C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:11:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 44DF481445
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:11:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LfhN7EOaTWQU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:11:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43EEE813EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645513884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7FSv/oEcapgvDoGQHzrlqg4yIRZgWGWLxeotDRNQuUU=;
 b=hKrlRQ5rMrR3gBJNryn6OUypj+Xai/i9lGDUETp2dLT8uDryxjoOtbeMdwAZdgR+gWkCy9
 Ddae4oTrvqKZNrf+8eIlayCGRSb2j+cTMfsWibYsxsasuf7fHGZ3F5OppHH3zyy7DKz1HG
 q4g49IIA1d7HccT1KYAR/lZquiNtoIg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-t9L6wT8eMU2S06Z7uIwK6Q-1; Tue, 22 Feb 2022 02:11:20 -0500
X-MC-Unique: t9L6wT8eMU2S06Z7uIwK6Q-1
Received: by mail-lj1-f199.google.com with SMTP id
 j17-20020a2e8011000000b002463682ffd5so3344178ljg.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 23:11:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7FSv/oEcapgvDoGQHzrlqg4yIRZgWGWLxeotDRNQuUU=;
 b=imlPvaXVRPFjRX55HrSsdK8vxmGwAToJlt5AfcSUBEg3N54jdzIhEHFt7yEAI63rDd
 J507kn9dIjGL9GEgo4rt+QoPMl2RKyIisSJkbBR/4V8hTIlcpGVtyJ7c/8NXtlv9mleQ
 dmbi6byRgVsNtkqikR/R0N/AsOd/t8PC5113p56djZULVrUWQyk4IRHwAvs/ke79B/Ma
 D8wONFr+uROxG8oHYJGWMrx+SHjIgoy3vlZWIN55KrnlOv/Wu7T9n1ojb88/VVX8MiXZ
 lO9Lcm6B9GEWqh9a0D1zNh0WqVx65xJTpA8XCpK3WF6Xb1ezlZv59ykBwaIgbs5/vvZa
 iaig==
X-Gm-Message-State: AOAM530Uh6q/LK39XK95ck9Ad5vQRPB89cj2HOGPeb5sCDsPpNlRXKvu
 Nb/innCUXYGkfIZ0tmt0RNZCYGwe7D3J9F6ydFrQ5Jnljz8sNyO7aQT9g8Zu+wV565aet8ATW3m
 BCSQL3z1bDqJtmrWQRZXQ17Jpgm8u6plj6B5+PZO9aKFhXxucoVY3ju/ghQ==
X-Received: by 2002:ac2:5dc9:0:b0:443:5db1:244c with SMTP id
 x9-20020ac25dc9000000b004435db1244cmr16719968lfq.84.1645513878928; 
 Mon, 21 Feb 2022 23:11:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbMuAz/ix+dLAdMFMBvTxo0FVkU9ZlLpWgMVrgQgKR6osYaULNGWxhsEVLNufI0L2GR59y4OsFjZ9jVzrG5K8=
X-Received: by 2002:ac2:5dc9:0:b0:443:5db1:244c with SMTP id
 x9-20020ac25dc9000000b004435db1244cmr16719955lfq.84.1645513878661; Mon, 21
 Feb 2022 23:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20220221195303.13560-1-mail@anirudhrb.com>
 <CACGkMEvLE=kV4PxJLRjdSyKArU+MRx6b_mbLGZHSUgoAAZ+-Fg@mail.gmail.com>
 <YhRtQEWBF0kqWMsI@anirudhrb.com>
In-Reply-To: <YhRtQEWBF0kqWMsI@anirudhrb.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Feb 2022 15:11:07 +0800
Message-ID: <CACGkMEvd7ETC_ANyrOSAVz_i64xqpYYazmm=+39E51=DMRFXdw@mail.gmail.com>
Subject: Re: [PATCH] vhost: validate range size before adding to iotlb
To: Anirudh Rayabharam <mail@anirudhrb.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
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

On Tue, Feb 22, 2022 at 12:57 PM Anirudh Rayabharam <mail@anirudhrb.com> wrote:
>
> On Tue, Feb 22, 2022 at 10:50:20AM +0800, Jason Wang wrote:
> > On Tue, Feb 22, 2022 at 3:53 AM Anirudh Rayabharam <mail@anirudhrb.com> wrote:
> > >
> > > In vhost_iotlb_add_range_ctx(), validate the range size is non-zero
> > > before proceeding with adding it to the iotlb.
> > >
> > > Range size can overflow to 0 when start is 0 and last is (2^64 - 1).
> > > One instance where it can happen is when userspace sends an IOTLB
> > > message with iova=size=uaddr=0 (vhost_process_iotlb_msg). So, an
> > > entry with size = 0, start = 0, last = (2^64 - 1) ends up in the
> > > iotlb. Next time a packet is sent, iotlb_access_ok() loops
> > > indefinitely due to that erroneous entry:
> > >
> > >         Call Trace:
> > >          <TASK>
> > >          iotlb_access_ok+0x21b/0x3e0 drivers/vhost/vhost.c:1340
> > >          vq_meta_prefetch+0xbc/0x280 drivers/vhost/vhost.c:1366
> > >          vhost_transport_do_send_pkt+0xe0/0xfd0 drivers/vhost/vsock.c:104
> > >          vhost_worker+0x23d/0x3d0 drivers/vhost/vhost.c:372
> > >          kthread+0x2e9/0x3a0 kernel/kthread.c:377
> > >          ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > >          </TASK>
> > >
> > > Reported by syzbot at:
> > >         https://syzkaller.appspot.com/bug?extid=0abd373e2e50d704db87
> > >
> > > Reported-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
> > > Tested-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
> > > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > > ---
> > >  drivers/vhost/iotlb.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
> > > index 670d56c879e5..b9de74bd2f9c 100644
> > > --- a/drivers/vhost/iotlb.c
> > > +++ b/drivers/vhost/iotlb.c
> > > @@ -53,8 +53,10 @@ int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
> > >                               void *opaque)
> > >  {
> > >         struct vhost_iotlb_map *map;
> > > +       u64 size = last - start + 1;
> > >
> > > -       if (last < start)
> > > +       // size can overflow to 0 when start is 0 and last is (2^64 - 1).
> > > +       if (last < start || size == 0)
> > >                 return -EFAULT;
> >
> > I'd move this check to vhost_chr_iter_write(), then for the device who
> > has its own msg handler (e.g vDPA) can benefit from it as well.
>
> Thanks for reviewing!
>
> I kept the check here thinking that all devices would benefit from it
> because they would need to call vhost_iotlb_add_range() to add an entry
> to the iotlb. Isn't that correct?

Correct for now but not for the future, it's not guaranteed that the
per device iotlb message handler will use vhost iotlb.

But I agree that we probably don't need to care about it too much now.

> Do you see any other benefit in moving
> it to vhost_chr_iter_write()?
>
> One concern I have is that if we move it out some future caller to
> vhost_iotlb_add_range() might forget to handle this case.

Yes.

Rethink the whole fix, we're basically rejecting [0, ULONG_MAX] range
which seems a little bit odd. I wonder if it's better to just remove
the map->size. Having a quick glance at the the user, I don't see any
blocker for this.

Thanks

>
> Thanks!
>
>         - Anirudh.
>
> >
> > Thanks
> >
> > >
> > >         if (iotlb->limit &&
> > > @@ -69,7 +71,7 @@ int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
> > >                 return -ENOMEM;
> > >
> > >         map->start = start;
> > > -       map->size = last - start + 1;
> > > +       map->size = size;
> > >         map->last = last;
> > >         map->addr = addr;
> > >         map->perm = perm;
> > > --
> > > 2.35.1
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
