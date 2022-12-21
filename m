Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19606C4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 03:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 892EB40B03;
	Wed, 21 Dec 2022 03:20:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 892EB40B03
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dzYUepbq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4ZvEY6uv5VGz; Wed, 21 Dec 2022 03:20:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 288B840104;
	Wed, 21 Dec 2022 03:20:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 288B840104
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E445CC007B;
	Wed, 21 Dec 2022 03:20:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1A2FC0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:20:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4CB9260D96
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:20:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4CB9260D96
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dzYUepbq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XqdJVeJ1x3hv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:20:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5583260A98
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5583260A98
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671592810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5PhGqrRUN76i46hBbm+WOniSm6R7Qnx8r/lonz443aM=;
 b=dzYUepbq2PQyqNaLowAWCHfgs4xU36IQY5SCJOBeEKHLG/A9tda8gJGJbjWJB7C+WvNBTK
 Hi+SuVpNApEsWzmxFKmG+fuXjOTbhBMg8sPaSFuiwriyizvdQoqeSFwUV4rEoa3PbcRkH5
 G/gSxg9CGqYwpyfjgh27pKXZaepL+GQ=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-12-VcFM9i5qNTiuHW-f_C2P5A-1; Tue, 20 Dec 2022 22:20:08 -0500
X-MC-Unique: VcFM9i5qNTiuHW-f_C2P5A-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-144a21f5c25so6260813fac.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 19:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5PhGqrRUN76i46hBbm+WOniSm6R7Qnx8r/lonz443aM=;
 b=baK52WpWxCp1CizR/e5mpU3xpF4wntrVAeX5XFiTS5HSs4fTmyvqoHlFCf4Y0F5NBJ
 JDM6ZOehgBB/B/3u0iBqW7kmlc1OPFmsFBTwknZdUTRtzvZ0ZkEhZyVye4wz0FtHJ8Mf
 4a2kzheS2XofscCgQ11qlS9s5TIXX8Wvjs/CuDaMQBI3MNrM9rHiRHLl7W6zgejIsrUz
 9NoK2JDSXA7iDAUKEn+Xjpr/al6xS53nhuQjKA3F+LSb3QLEZM85Fc6uR6AU/VQtY58R
 gFdlf0BSD8YN755KVGnHrUJ53Z/eufTyY+gmmMd5B4nJxBcIHWNLXPY2R43nsZlDTTug
 cczQ==
X-Gm-Message-State: AFqh2ko+B5rSWcb7xp7UOTiGc5LPq0RBCtSj76cNW3KKR6IILBEqUR/6
 j6WyvSJHaeuN9tscT2GJtf9jAEhUz/x0bEfkm7PO7ZD/DIwBmOmEvgl8yOINZK4bSFARoUS8w/i
 fmd18RC3FrocvtBNKgHUbbWAlrlGsTYIJTM7oPp4mrc9fri8YlLD2KAU+gQ==
X-Received: by 2002:a05:6870:3d97:b0:144:b22a:38d3 with SMTP id
 lm23-20020a0568703d9700b00144b22a38d3mr3045oab.280.1671592807445; 
 Tue, 20 Dec 2022 19:20:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu80Fp/m85ZH256zw4DWcN6YVHlXSSkapee7nTh0Y+wiR5jIND72HG+S30UfEDw5dpEf3RodR118oC3e4tZPrE=
X-Received: by 2002:a05:6870:3d97:b0:144:b22a:38d3 with SMTP id
 lm23-20020a0568703d9700b00144b22a38d3mr3040oab.280.1671592807260; Tue, 20 Dec
 2022 19:20:07 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-6-xieyongji@bytedance.com>
 <CACGkMEvkTJn7Hm5u=79nDNHQG_gakS3Cbvi=JpO38ndjHy_fog@mail.gmail.com>
 <CACycT3tyR0zTfTgE3BhL0GZqWAj2KDC0Q+tfm+rV=wbgHPOhFA@mail.gmail.com>
 <CACGkMEt1MkoxJQUixMsR8gVmTVUVoPh1CNo7GpbOyWGb3bzoPw@mail.gmail.com>
 <CACycT3vMktY1g57NhRMnAD0_F45MxpM=730reN-U_qqaN=daDg@mail.gmail.com>
In-Reply-To: <CACycT3vMktY1g57NhRMnAD0_F45MxpM=730reN-U_qqaN=daDg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 21 Dec 2022 11:19:56 +0800
Message-ID: <CACGkMEtw9eWGZ04gs0zKdnJks+AHQyKHWdqNdhCNBbiXsB9X+Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] vduse: Introduce bound workqueue for irq
 injection
To: Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>
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

On Tue, Dec 20, 2022 at 6:02 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Tue, Dec 20, 2022 at 2:28 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Dec 19, 2022 at 1:04 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Fri, Dec 16, 2022 at 12:02 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Mon, Dec 5, 2022 at 4:44 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > This introduces a bound workqueue to support running
> > > > > irq callback in a specified cpu.
> > > > >
> > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 29 ++++++++++++++++++++++-------
> > > > >  1 file changed, 22 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > index 37809bfcb7ef..d126f3e32a20 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -57,6 +57,7 @@ struct vduse_virtqueue {
> > > > >         struct vdpa_callback cb;
> > > > >         struct work_struct inject;
> > > > >         struct work_struct kick;
> > > > > +       int irq_effective_cpu;
> > > >
> > > > I wonder why it's a cpu number instead of a cpumask. The latter seems
> > > > more flexible, e.g when using NUMA.
> > > >
> > >
> > > This variable represents the CPU that runs the interrupt callback
> > > rather than CPU affinity.
> >
> > Ok, but for some reason it only gets updated when a new affinity is set?
> >
>
> Yes, since we don't use round-robin now. And if affinity is not set,
> we rollback to the default behavior (use un-bounded workqueue to run
> irq callback).
>
> > (Btw, I don't see how the code deals with cpu hotplug, do we need
> > cpuhot notifier?)
> >
>
> Currently the queue_work_on() can handle the cpu hotplug case, so I
> think we can simply check whether the CPU is online each time queuing
> the kwork, then update the affinity if needed.

Right.

Thanks

>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
