Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC8BC433FE
	for <virtualization@archiver.kernel.org>; Thu, 17 Nov 2022 06:07:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4AA0B402E8;
	Thu, 17 Nov 2022 06:07:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4AA0B402E8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NwkgXqwb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zvz-mIQNKkYK; Thu, 17 Nov 2022 06:07:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8413D400D2;
	Thu, 17 Nov 2022 06:07:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8413D400D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 456DCC0033;
	Thu, 17 Nov 2022 06:07:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E465DC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 06:07:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0BC841882
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 06:07:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0BC841882
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NwkgXqwb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5GQh5X4-F0tJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 06:07:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7757941875
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7757941875
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 06:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668665269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Uiwxy2Bg5D/PJhtpuo6mm85OKB9Y0TNbeDy36T2jm4=;
 b=NwkgXqwb3S+Nj5hTuKy5nph5hGIH8tymcvB1KCA/HwfD6CyaFvaV5kuwEHIA9mYdCXPVKD
 nv+yOHp9+xs6CrCXw3I8jsQAYnYhG92TbPGtEvbx7AbbF4H8uqfenGWjxUTMaKnxF1OH4f
 UomMEwEzQ+eZbDglzlRYf9DXkZFi4XY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-537-zg1AtuK6Ma-5maN48bcb6g-1; Thu, 17 Nov 2022 01:07:47 -0500
X-MC-Unique: zg1AtuK6Ma-5maN48bcb6g-1
Received: by mail-ot1-f70.google.com with SMTP id
 l12-20020a9d6a8c000000b0066c33f1649cso379378otq.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 22:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Uiwxy2Bg5D/PJhtpuo6mm85OKB9Y0TNbeDy36T2jm4=;
 b=HjMujYbsNB61QVHqETrMqC+vcQZ5ogWPO9neJymQIjiImIQOkIwVityRH4zBm6oZwz
 AsiKaGayuF6JZ3PIrUo2LwqEdMSuGscCy0EbxfuWaNUHaRbPTz3egmrw+pVl8YPOLv7G
 0SpJ5fgO2FjaHlV6bcinRoyrWAv6SFmJb/T6uOHCgBCepCzGkghMk5QKyeW3Fv4xJgiI
 B/QOUSsF0oEh1OGcqjPgy6prSr0TKKW3uLgyqFrHcqMckdMgQ2JbNJK+n3lHYapJVKnD
 Hg5Y5G3NqkuQEg8NUhpk3+DhgJ7zVCxN+SUHrNDNC6KonJpKQDQbMH72fnXs5DtyvUaA
 9SOQ==
X-Gm-Message-State: ANoB5pmm8hwjXYdy5bZh9IY3exXQktPCM8MDerW//ccSfyO8Fxm4Det5
 jzQOXKs1GFeIFcP3jjCp27eqyt2y888ZCFNmZcbTwasuCHsl6FOYHaI78aX60Yh3kAsiUMdkFgG
 VUXVmGmWK5HmCuPTw5EWwy6Cno9ko+toyEgbNPe7uqLpb5qjsyxV1ZFOVSA==
X-Received: by 2002:a05:6870:1e83:b0:132:7b3:29ac with SMTP id
 pb3-20020a0568701e8300b0013207b329acmr3492076oab.35.1668665266886; 
 Wed, 16 Nov 2022 22:07:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7OutnfWV0eqHmwODjhhKjAhzqcJKuddppkVnYzbMUx/Dnz5yB0AunsxIWw6qRwHiUBRn8U5jW7EiH0O6O3e2U=
X-Received: by 2002:a05:6870:1e83:b0:132:7b3:29ac with SMTP id
 pb3-20020a0568701e8300b0013207b329acmr3492072oab.35.1668665266630; Wed, 16
 Nov 2022 22:07:46 -0800 (PST)
MIME-Version: 1.0
References: <CACycT3siOCZv+u+-Xcto9BEdY1c8t_ivw-DF73bmuLqBRxF7=A@mail.gmail.com>
 <CACGkMEswaS_-pP2RpJGyVA2wmvVm3x4LD-MPrbvxQhAFgQYgAA@mail.gmail.com>
 <CACycT3vPyEuQcJEEPJE2Dv-49f=w8xLoOXsoLb5Fjtx9uqQoyQ@mail.gmail.com>
In-Reply-To: <CACycT3vPyEuQcJEEPJE2Dv-49f=w8xLoOXsoLb5Fjtx9uqQoyQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Nov 2022 14:07:35 +0800
Message-ID: <CACGkMEtML=-HA2uUdRVw0Pim3Dj2P5m=3K+s-Q9rUf-Xw24-wQ@mail.gmail.com>
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

On Thu, Nov 17, 2022 at 1:48 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Thu, Nov 17, 2022 at 11:37 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, Nov 16, 2022 at 3:46 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Wed, Nov 16, 2022 at 3:11 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Tue, Nov 15, 2022 at 10:49 AM Yongji Xie <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > On Mon, Nov 14, 2022 at 4:55 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Nov 14, 2022 at 4:20 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > > > > > >
> > > > > > > On Mon, Nov 14, 2022 at 3:58 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Nov 14, 2022 at 3:16 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > > > > > >
> > > > > > > > > Add sysfs interface for each vduse virtqueue to setup
> > > > > > > > > irq affinity. This would be useful for performance
> > > > > > > > > tuning, e.g., mitigate the virtqueue lock contention
> > > > > > > > > in virtio block driver.
> > > > > > > >
> > > > > > > > Do we have any perforamnce numbers for this?
> > > > > > > >
> > > > > > >
> > > > > > > Almost 50% improvement (600k iops -> 900k iops) in the high iops
> > > > > > > workloads. I have mentioned it in the cover-letter.
> > > > > >
> > > > > > For some reason, I miss that.
> > > > > >
> > > > > > I also wonder if we can do this automatically, then there's no need to
> > > > > > play with sysfs which is kind of a burden for the management layer.
> > > > > >
> > > > >
> > > > > This is hard to do since vduse doesn't know which cpu should be bound
> > > > > for a certain virtqueue.
> > > >
> > > > Probably via the kick_vq()? It probably won't work when notification
> > > > is disabled. But we need to think a little bit more about this.
> > >
> > > Yes, another problem is that this way can only work when the cpu and
> > > virtqueue are 1:1 mapping. It's still hard to decide which cpu to bind
> > > in the N:1 mapping case.
> >
> > This is the same situation as what you propose here. I think it would
> > be better to use cpumask instead of cpu id here.
> >
>
> If so, we need to know which cpu to bind for one virtqueue. Do you
> mean using the cpu who kicks the virtqueue?

I meant you're using:

         int irq_affinity;

This seems to assume that the callback can only be delivered to a
specific cpu. It would make more sense to use cpumask_t. This may have
broader use cases.

>
> > >
> > > So I think it could be an optimization, but the sysfs interface is still needed.
> > >
> > > > Requiring management software to do ad-hoc running just for VDUSE
> > > > seems not easy.
> > > >
> > >
> > > I'm not sure. In the kubernetes environment, something like a CSI/CNI
> > > plugin can do it.
> >
> > Only works when the process is bound to a specific cpu. If a process
> > is migrated to another CPU, it would be hard to track.
> >
>
> OK, I see. Seems like there's no good way to handle this case.

Yes, using cpumask_t might improve things a little bit.

> Maybe
> it's better to leave it as it is.

It would be better to think of an automatic method to do this as
affinity managed irq used by virtio-pci (not sure how hard it is
though).

Thanks

>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
