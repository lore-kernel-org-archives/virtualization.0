Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DC4C4332F
	for <virtualization@archiver.kernel.org>; Fri, 18 Nov 2022 07:23:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 79E244037C;
	Fri, 18 Nov 2022 07:23:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 79E244037C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HgoyqJD9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CvsQRvpTADP3; Fri, 18 Nov 2022 07:23:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E45A2404DF;
	Fri, 18 Nov 2022 07:23:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E45A2404DF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBFCEC0033;
	Fri, 18 Nov 2022 07:23:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A883C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Nov 2022 07:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0ACEC81ECA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Nov 2022 07:23:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0ACEC81ECA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HgoyqJD9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7unryF_s67pc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Nov 2022 07:23:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DF8F81E3A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DF8F81E3A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Nov 2022 07:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668756194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0fY/EGE7z+UU3b51GGsNE3F0C8UKBqrMFySncCd5+nI=;
 b=HgoyqJD9pQ5VABJy5OORvOXAgb9liVnIRNVrt62vlc+ZVtV+0QfpK1fDwVKVi8i1ogu41+
 ANMtLsD940JMawp57WD2l4YHXYYeDuya3V6oT401057vlvwYJJZXuz0ECiJC0B77d7hzrw
 KfHtuyI6NYfBrqCdZOa13iPK9ol2OTk=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-297-MhHfd03WORel04YetHBdEw-1; Fri, 18 Nov 2022 02:23:12 -0500
X-MC-Unique: MhHfd03WORel04YetHBdEw-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-14261bd9123so1796312fac.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 23:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0fY/EGE7z+UU3b51GGsNE3F0C8UKBqrMFySncCd5+nI=;
 b=VXDxunX2XjwG9PR4PMdQdxRfGCzaine6qpIenS5msb8DljMOCFOjTQzvK+zpDC81bN
 4Gswul7dK6z1GOfZmuL7hpsCpkqFAgVctOYZR+JdS7RUPTIUQJSBnGHqlP6/Tyb/WdiV
 n6pg+k+qDLL1KEvQuvttT5jYJpjhi6Vk+tpg/Yb//kVCiAcWL81ugviD0GFDydJr1c2d
 ssl64zE2DB47yIBLAMg+i35Swl7Q0r2pwyJKzUe/NMvWjpIIH0nka/bK2CYonP7NwxOg
 nL3peRAR0GsrLw0TTjCxvwjnnAyn6Nug/PH3PnvizvzKYpe4uVntV9JmVN4C4hZpUpqH
 JIxQ==
X-Gm-Message-State: ANoB5pl1p22Cg6yebVDaF8c7JRT38s0i9nxhlo9paAmmv6n987XG+PDX
 0xHgAncQR5wBNrkN6QNbBIN9uFJzLPBtnIxoLeFCd/yeIVKWyR4HG8fyFoPwRTct50joORUNWH2
 YHVmo7IYM+HF2vslmDyW7BdpWq+F5Uh6U47U7ccCYHaRWTRzmjc2NPhbm0Q==
X-Received: by 2002:a05:6871:4410:b0:13b:ef13:b650 with SMTP id
 nd16-20020a056871441000b0013bef13b650mr3198002oab.280.1668756191759; 
 Thu, 17 Nov 2022 23:23:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7dyI5ilNzYUklCsivy+yicvdzxUWM9YxH4hJpK2YHgWIC0h/Bgb9C6p3irM3uTHGEk1r+hjs9D1RRx7rnF65s=
X-Received: by 2002:a05:6871:4410:b0:13b:ef13:b650 with SMTP id
 nd16-20020a056871441000b0013bef13b650mr3197994oab.280.1668756191543; Thu, 17
 Nov 2022 23:23:11 -0800 (PST)
MIME-Version: 1.0
References: <CACycT3siOCZv+u+-Xcto9BEdY1c8t_ivw-DF73bmuLqBRxF7=A@mail.gmail.com>
 <CACGkMEswaS_-pP2RpJGyVA2wmvVm3x4LD-MPrbvxQhAFgQYgAA@mail.gmail.com>
 <CACycT3vPyEuQcJEEPJE2Dv-49f=w8xLoOXsoLb5Fjtx9uqQoyQ@mail.gmail.com>
 <CACGkMEtML=-HA2uUdRVw0Pim3Dj2P5m=3K+s-Q9rUf-Xw24-wQ@mail.gmail.com>
 <CACycT3uH-OPZ9BUR1OnXmY8Lx0vhYTq=Gb3S9i6thGApa5GHFQ@mail.gmail.com>
In-Reply-To: <CACycT3uH-OPZ9BUR1OnXmY8Lx0vhYTq=Gb3S9i6thGApa5GHFQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Nov 2022 15:23:00 +0800
Message-ID: <CACGkMEu24GpYq2-2=vkRF-4Bd2zEy2L_1a=ZzU72tGS3KsqAng@mail.gmail.com>
Subject: Re: [PATCH 3/6] vduse: Add sysfs interface for irq affinity setup
To: Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Thu, Nov 17, 2022 at 4:54 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Thu, Nov 17, 2022 at 2:07 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Nov 17, 2022 at 1:48 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Thu, Nov 17, 2022 at 11:37 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Wed, Nov 16, 2022 at 3:46 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > On Wed, Nov 16, 2022 at 3:11 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Nov 15, 2022 at 10:49 AM Yongji Xie <xieyongji@bytedance.com> wrote:
> > > > > > >
> > > > > > > On Mon, Nov 14, 2022 at 4:55 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Nov 14, 2022 at 4:20 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Nov 14, 2022 at 3:58 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Nov 14, 2022 at 3:16 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Add sysfs interface for each vduse virtqueue to setup
> > > > > > > > > > > irq affinity. This would be useful for performance
> > > > > > > > > > > tuning, e.g., mitigate the virtqueue lock contention
> > > > > > > > > > > in virtio block driver.
> > > > > > > > > >
> > > > > > > > > > Do we have any perforamnce numbers for this?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Almost 50% improvement (600k iops -> 900k iops) in the high iops
> > > > > > > > > workloads. I have mentioned it in the cover-letter.
> > > > > > > >
> > > > > > > > For some reason, I miss that.
> > > > > > > >
> > > > > > > > I also wonder if we can do this automatically, then there's no need to
> > > > > > > > play with sysfs which is kind of a burden for the management layer.
> > > > > > > >
> > > > > > >
> > > > > > > This is hard to do since vduse doesn't know which cpu should be bound
> > > > > > > for a certain virtqueue.
> > > > > >
> > > > > > Probably via the kick_vq()? It probably won't work when notification
> > > > > > is disabled. But we need to think a little bit more about this.
> > > > >
> > > > > Yes, another problem is that this way can only work when the cpu and
> > > > > virtqueue are 1:1 mapping. It's still hard to decide which cpu to bind
> > > > > in the N:1 mapping case.
> > > >
> > > > This is the same situation as what you propose here. I think it would
> > > > be better to use cpumask instead of cpu id here.
> > > >
> > >
> > > If so, we need to know which cpu to bind for one virtqueue. Do you
> > > mean using the cpu who kicks the virtqueue?
> >
> > I meant you're using:
> >
> >          int irq_affinity;
> >
> > This seems to assume that the callback can only be delivered to a
> > specific cpu. It would make more sense to use cpumask_t. This may have
> > broader use cases.
> >
>
> Yes, I see. I meant we need to know how to choose the cpu to run the
> irq callback if we use cpumask_t, e.g., round-robin or choosing the
> cpu who kicked the virtqueue before.
>
> > >
> > > > >
> > > > > So I think it could be an optimization, but the sysfs interface is still needed.
> > > > >
> > > > > > Requiring management software to do ad-hoc running just for VDUSE
> > > > > > seems not easy.
> > > > > >
> > > > >
> > > > > I'm not sure. In the kubernetes environment, something like a CSI/CNI
> > > > > plugin can do it.
> > > >
> > > > Only works when the process is bound to a specific cpu. If a process
> > > > is migrated to another CPU, it would be hard to track.
> > > >
> > >
> > > OK, I see. Seems like there's no good way to handle this case.
> >
> > Yes, using cpumask_t might improve things a little bit.
> >
> > > Maybe
> > > it's better to leave it as it is.
> >
> > It would be better to think of an automatic method to do this as
> > affinity managed irq used by virtio-pci (not sure how hard it is
> > though).
> >
>
> Do you mean making use of .set_vq_affinity and .get_vq_affinity callbacks?

This works for net but not block.

I know little about block but looks like block is using affinity
descriptor to allow blk mq to do proper irq steering. Maybe we can do
something the same.

Thanks

>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
