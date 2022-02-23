Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51E0C433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 02:05:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BB8B60EFE;
	Wed, 23 Feb 2022 02:05:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TjvcxunttP_z; Wed, 23 Feb 2022 02:05:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DD17E60EE0;
	Wed, 23 Feb 2022 02:05:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B800EC0021;
	Wed, 23 Feb 2022 02:05:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9554C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:05:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 880AA40579
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:05:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T4ZLboe9SDRa
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:05:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46C9240260
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645581938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=buzVwsZLq0iXCXG61A4X5ZxneH6xdRKfjx8nNyDkCvI=;
 b=cIetYfuO9rSn6/bGTS60k5vlBauMydOO5z44wz6sxB97P6el4sIPEe/+j6eAmjfwKffP9N
 8Xik957slOp0SZKEwjR+9HRP9omcP+1lAy5+lolxBKfsh6fSZ4LDUzvasImWE9P0nRLQ6n
 kJ1ATY5aY96suI5/8b/EKNJyw6EXLJQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-CO8PRPojPUm9AB0wacTE0Q-1; Tue, 22 Feb 2022 21:05:34 -0500
X-MC-Unique: CO8PRPojPUm9AB0wacTE0Q-1
Received: by mail-lj1-f200.google.com with SMTP id
 q21-20020a2eb4b5000000b002463ddac45bso4323583ljm.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 18:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=buzVwsZLq0iXCXG61A4X5ZxneH6xdRKfjx8nNyDkCvI=;
 b=tVLlSRrl3S0xRnSQRNkF9dSDeiboxWzboVtMH8CYRxIk7RNgglHC8FBEj9wxAZpyS2
 DMyE0n7o/+gDHP8SjNSAEApUnsCYY1SjoA16+svEspSlJf8k3nwWcY+4mcFGjMpnnMXg
 2NqlUy55Uzcc92lMMBgmzLjV9aJP3aDFe0ufdzjGHsiLg6jKS4w3fAHDa83ecNkc0/TV
 cMmf11C1ZrYbIP+IX5+ciWuJPWR07xLZfn6kwr01Cdjn24HIzLJeE0ivpy190UgFwNvI
 yM3e+n14bSfEYhpGIcvdvPam5F8hVy/dH3f8xJPYhz/8QJsYXBpYsWoRVu3YydeMnCA9
 O95A==
X-Gm-Message-State: AOAM530OzokGoVtpotvpXSpjZC3bMf3pLoQ9fwACITBd9gBmAYmdOwt2
 txJLSzl7i0w7f70aQDktgJN8+HO+6hoNeGZKW4bLdPilCv/1s1X1WApNJ1Sn4VlQ4E9CW4Iu7yo
 gwDMudfRWre600XKtaQYl8XS+64EmMJqLqhnfoVupR5x8YXkr9NcJ0eFRxg==
X-Received: by 2002:ac2:5f68:0:b0:438:6751:6b83 with SMTP id
 c8-20020ac25f68000000b0043867516b83mr18922168lfc.376.1645581933073; 
 Tue, 22 Feb 2022 18:05:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAHX+x2jwWdLU2x8SL6Qst3i9MqySV/buhDdfIJdvq9F0y/5J2MvOgBJXvw97jTjnOtyWiXmfjF5o4Wdrm/Uk=
X-Received: by 2002:ac2:5f68:0:b0:438:6751:6b83 with SMTP id
 c8-20020ac25f68000000b0043867516b83mr18922150lfc.376.1645581932830; Tue, 22
 Feb 2022 18:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20220221195303.13560-1-mail@anirudhrb.com>
 <CACGkMEvLE=kV4PxJLRjdSyKArU+MRx6b_mbLGZHSUgoAAZ+-Fg@mail.gmail.com>
 <YhRtQEWBF0kqWMsI@anirudhrb.com>
 <CACGkMEvd7ETC_ANyrOSAVz_i64xqpYYazmm=+39E51=DMRFXdw@mail.gmail.com>
 <20220222090511-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220222090511-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Feb 2022 10:05:21 +0800
Message-ID: <CACGkMEu9mxo8sqPuymXzEOJbv8=fKq7TAScV2yrCM-bMozPibA@mail.gmail.com>
Subject: Re: [PATCH] vhost: validate range size before adding to iotlb
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Anirudh Rayabharam <mail@anirudhrb.com>,
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

On Tue, Feb 22, 2022 at 11:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Feb 22, 2022 at 03:11:07PM +0800, Jason Wang wrote:
> > On Tue, Feb 22, 2022 at 12:57 PM Anirudh Rayabharam <mail@anirudhrb.com> wrote:
> > >
> > > On Tue, Feb 22, 2022 at 10:50:20AM +0800, Jason Wang wrote:
> > > > On Tue, Feb 22, 2022 at 3:53 AM Anirudh Rayabharam <mail@anirudhrb.com> wrote:
> > > > >
> > > > > In vhost_iotlb_add_range_ctx(), validate the range size is non-zero
> > > > > before proceeding with adding it to the iotlb.
> > > > >
> > > > > Range size can overflow to 0 when start is 0 and last is (2^64 - 1).
> > > > > One instance where it can happen is when userspace sends an IOTLB
> > > > > message with iova=size=uaddr=0 (vhost_process_iotlb_msg). So, an
> > > > > entry with size = 0, start = 0, last = (2^64 - 1) ends up in the
> > > > > iotlb. Next time a packet is sent, iotlb_access_ok() loops
> > > > > indefinitely due to that erroneous entry:
> > > > >
> > > > >         Call Trace:
> > > > >          <TASK>
> > > > >          iotlb_access_ok+0x21b/0x3e0 drivers/vhost/vhost.c:1340
> > > > >          vq_meta_prefetch+0xbc/0x280 drivers/vhost/vhost.c:1366
> > > > >          vhost_transport_do_send_pkt+0xe0/0xfd0 drivers/vhost/vsock.c:104
> > > > >          vhost_worker+0x23d/0x3d0 drivers/vhost/vhost.c:372
> > > > >          kthread+0x2e9/0x3a0 kernel/kthread.c:377
> > > > >          ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > > > >          </TASK>
> > > > >
> > > > > Reported by syzbot at:
> > > > >         https://syzkaller.appspot.com/bug?extid=0abd373e2e50d704db87
> > > > >
> > > > > Reported-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
> > > > > Tested-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
> > > > > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > > > > ---
> > > > >  drivers/vhost/iotlb.c | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
> > > > > index 670d56c879e5..b9de74bd2f9c 100644
> > > > > --- a/drivers/vhost/iotlb.c
> > > > > +++ b/drivers/vhost/iotlb.c
> > > > > @@ -53,8 +53,10 @@ int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
> > > > >                               void *opaque)
> > > > >  {
> > > > >         struct vhost_iotlb_map *map;
> > > > > +       u64 size = last - start + 1;
> > > > >
> > > > > -       if (last < start)
> > > > > +       // size can overflow to 0 when start is 0 and last is (2^64 - 1).
> > > > > +       if (last < start || size == 0)
> > > > >                 return -EFAULT;
> > > >
> > > > I'd move this check to vhost_chr_iter_write(), then for the device who
> > > > has its own msg handler (e.g vDPA) can benefit from it as well.
> > >
> > > Thanks for reviewing!
> > >
> > > I kept the check here thinking that all devices would benefit from it
> > > because they would need to call vhost_iotlb_add_range() to add an entry
> > > to the iotlb. Isn't that correct?
> >
> > Correct for now but not for the future, it's not guaranteed that the
> > per device iotlb message handler will use vhost iotlb.
> >
> > But I agree that we probably don't need to care about it too much now.
> >
> > > Do you see any other benefit in moving
> > > it to vhost_chr_iter_write()?
> > >
> > > One concern I have is that if we move it out some future caller to
> > > vhost_iotlb_add_range() might forget to handle this case.
> >
> > Yes.
> >
> > Rethink the whole fix, we're basically rejecting [0, ULONG_MAX] range
> > which seems a little bit odd.
>
> Well, I guess ideally we'd split this up as two entries - this kind of
> thing is after all one of the reasons we initially used first,last as
> the API - as opposed to first,size.
>
> Anirudh, could you do it like this instead of rejecting?
>
>
> > I wonder if it's better to just remove
> > the map->size. Having a quick glance at the the user, I don't see any
> > blocker for this.
> >
> > Thanks
>
> I think it's possible but won't solve the bug by itself, and we'd need
> to review and fix all users - a high chance of introducing
> another regression. And I think there's value of fitting under the
> stable rule of 100 lines with context.
> So sure, but let's fix the bug first.

Ok, I agree.

Thanks

>
>
>
> > >
> > > Thanks!
> > >
> > >         - Anirudh.
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > >         if (iotlb->limit &&
> > > > > @@ -69,7 +71,7 @@ int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
> > > > >                 return -ENOMEM;
> > > > >
> > > > >         map->start = start;
> > > > > -       map->size = last - start + 1;
> > > > > +       map->size = size;
> > > > >         map->last = last;
> > > > >         map->addr = addr;
> > > > >         map->perm = perm;
> > > > > --
> > > > > 2.35.1
> > > > >
> > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
