Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1129C433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 15:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8024981BC6;
	Tue, 22 Feb 2022 15:02:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FF1ImgNkmDrD; Tue, 22 Feb 2022 15:02:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CEFC781BB4;
	Tue, 22 Feb 2022 15:02:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A04DFC0021;
	Tue, 22 Feb 2022 15:02:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79438C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 15:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6136E60B71
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 15:02:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V_HxRRL9ZDfR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 15:02:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5BE1F60B6A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 15:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645542158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rdi/qxR3vXLdPYSOnT7lLR4Cj8YvfdXVSXReKwN9fr0=;
 b=B4RXh2GflujhOpqtaW4gvtYFTe01ObjyiUXlK2//SZwcbGiqE29Np9Gs2HpX+3nyCjnRiv
 ZaISquR01lxzJxsuZRo8ObO9QyTM8MOJAgBgRxuGLmzMdgyg90puA1K44pt4jkBcOHabvz
 IuM1+JMDZsbyTRyx1yX6zCPaiyWtv8A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-N3rkVGsIPZaOjQisHJSZbQ-1; Tue, 22 Feb 2022 10:02:36 -0500
X-MC-Unique: N3rkVGsIPZaOjQisHJSZbQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 r9-20020a05640251c900b00412d54ea618so6368052edd.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rdi/qxR3vXLdPYSOnT7lLR4Cj8YvfdXVSXReKwN9fr0=;
 b=fkmK291WnVTVg5+j7AnIiFbR3SEQI6c+z6H25QAG6OEdJ5Q5emBeh+U64lmSw3kdMO
 8URQGjS8dnTg9kXthjmT2tesU24XKvxdQnGEBBLL1fgPvLk4/J7b+MAZaMND5yVj14A6
 PSN1YeoMYBVHXpwoMzV/D9C3EIaVg/JCCcfs01YVcnMLS/JR6kR/Nan2rvw2X7JCc970
 YmVpqnyx1ryQBqyuSJtY1LC0DLAr9hLKE3W1SC1dhS+dZOz4M6npYjxuSr3y7l7k2aR1
 ToMMnwlqehQaVkmap+YksP9AMkC0N1nYyIz628M2U+kmqzAzBD+CRiebxl7LDmG8/CQP
 Yr5A==
X-Gm-Message-State: AOAM5337DMLPHQUYO0z6F2mYYAuC1HUzYCL6mf5K5yYfo0JJBlGSNvys
 KAm+EWQPnDPsBMzjLU/2wqvTH7zn8n5i5Szv4Y2skv2RwfLUE6iMdxWg/+QnGh5Z/kfdipSae5G
 5/0t5YiNo5QKLmpR8GU2iDRxcnisJXlqZbVWTM1O2SA==
X-Received: by 2002:a17:906:2991:b0:6cf:1fd4:39a3 with SMTP id
 x17-20020a170906299100b006cf1fd439a3mr19565085eje.21.1645542153505; 
 Tue, 22 Feb 2022 07:02:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfs/vKQLHNEKKWfGdfWtjrGEHBFte8MvKz5Y50OjDrG513NxeN/Cw3t2XJvu4U4AxkMg15eQ==
X-Received: by 2002:a17:906:2991:b0:6cf:1fd4:39a3 with SMTP id
 x17-20020a170906299100b006cf1fd439a3mr19565062eje.21.1645542153204; 
 Tue, 22 Feb 2022 07:02:33 -0800 (PST)
Received: from redhat.com ([2.55.129.240])
 by smtp.gmail.com with ESMTPSA id q16sm5998109ejc.21.2022.02.22.07.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 07:02:32 -0800 (PST)
Date: Tue, 22 Feb 2022 10:02:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost: validate range size before adding to iotlb
Message-ID: <20220222090511-mutt-send-email-mst@kernel.org>
References: <20220221195303.13560-1-mail@anirudhrb.com>
 <CACGkMEvLE=kV4PxJLRjdSyKArU+MRx6b_mbLGZHSUgoAAZ+-Fg@mail.gmail.com>
 <YhRtQEWBF0kqWMsI@anirudhrb.com>
 <CACGkMEvd7ETC_ANyrOSAVz_i64xqpYYazmm=+39E51=DMRFXdw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvd7ETC_ANyrOSAVz_i64xqpYYazmm=+39E51=DMRFXdw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Tue, Feb 22, 2022 at 03:11:07PM +0800, Jason Wang wrote:
> On Tue, Feb 22, 2022 at 12:57 PM Anirudh Rayabharam <mail@anirudhrb.com> wrote:
> >
> > On Tue, Feb 22, 2022 at 10:50:20AM +0800, Jason Wang wrote:
> > > On Tue, Feb 22, 2022 at 3:53 AM Anirudh Rayabharam <mail@anirudhrb.com> wrote:
> > > >
> > > > In vhost_iotlb_add_range_ctx(), validate the range size is non-zero
> > > > before proceeding with adding it to the iotlb.
> > > >
> > > > Range size can overflow to 0 when start is 0 and last is (2^64 - 1).
> > > > One instance where it can happen is when userspace sends an IOTLB
> > > > message with iova=size=uaddr=0 (vhost_process_iotlb_msg). So, an
> > > > entry with size = 0, start = 0, last = (2^64 - 1) ends up in the
> > > > iotlb. Next time a packet is sent, iotlb_access_ok() loops
> > > > indefinitely due to that erroneous entry:
> > > >
> > > >         Call Trace:
> > > >          <TASK>
> > > >          iotlb_access_ok+0x21b/0x3e0 drivers/vhost/vhost.c:1340
> > > >          vq_meta_prefetch+0xbc/0x280 drivers/vhost/vhost.c:1366
> > > >          vhost_transport_do_send_pkt+0xe0/0xfd0 drivers/vhost/vsock.c:104
> > > >          vhost_worker+0x23d/0x3d0 drivers/vhost/vhost.c:372
> > > >          kthread+0x2e9/0x3a0 kernel/kthread.c:377
> > > >          ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > > >          </TASK>
> > > >
> > > > Reported by syzbot at:
> > > >         https://syzkaller.appspot.com/bug?extid=0abd373e2e50d704db87
> > > >
> > > > Reported-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
> > > > Tested-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
> > > > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > > > ---
> > > >  drivers/vhost/iotlb.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
> > > > index 670d56c879e5..b9de74bd2f9c 100644
> > > > --- a/drivers/vhost/iotlb.c
> > > > +++ b/drivers/vhost/iotlb.c
> > > > @@ -53,8 +53,10 @@ int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
> > > >                               void *opaque)
> > > >  {
> > > >         struct vhost_iotlb_map *map;
> > > > +       u64 size = last - start + 1;
> > > >
> > > > -       if (last < start)
> > > > +       // size can overflow to 0 when start is 0 and last is (2^64 - 1).
> > > > +       if (last < start || size == 0)
> > > >                 return -EFAULT;
> > >
> > > I'd move this check to vhost_chr_iter_write(), then for the device who
> > > has its own msg handler (e.g vDPA) can benefit from it as well.
> >
> > Thanks for reviewing!
> >
> > I kept the check here thinking that all devices would benefit from it
> > because they would need to call vhost_iotlb_add_range() to add an entry
> > to the iotlb. Isn't that correct?
> 
> Correct for now but not for the future, it's not guaranteed that the
> per device iotlb message handler will use vhost iotlb.
> 
> But I agree that we probably don't need to care about it too much now.
> 
> > Do you see any other benefit in moving
> > it to vhost_chr_iter_write()?
> >
> > One concern I have is that if we move it out some future caller to
> > vhost_iotlb_add_range() might forget to handle this case.
> 
> Yes.
> 
> Rethink the whole fix, we're basically rejecting [0, ULONG_MAX] range
> which seems a little bit odd.

Well, I guess ideally we'd split this up as two entries - this kind of
thing is after all one of the reasons we initially used first,last as
the API - as opposed to first,size.

Anirudh, could you do it like this instead of rejecting?


> I wonder if it's better to just remove
> the map->size. Having a quick glance at the the user, I don't see any
> blocker for this.
> 
> Thanks

I think it's possible but won't solve the bug by itself, and we'd need
to review and fix all users - a high chance of introducing
another regression. And I think there's value of fitting under the
stable rule of 100 lines with context.
So sure, but let's fix the bug first.



> >
> > Thanks!
> >
> >         - Anirudh.
> >
> > >
> > > Thanks
> > >
> > > >
> > > >         if (iotlb->limit &&
> > > > @@ -69,7 +71,7 @@ int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
> > > >                 return -ENOMEM;
> > > >
> > > >         map->start = start;
> > > > -       map->size = last - start + 1;
> > > > +       map->size = size;
> > > >         map->last = last;
> > > >         map->addr = addr;
> > > >         map->perm = perm;
> > > > --
> > > > 2.35.1
> > > >
> > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
