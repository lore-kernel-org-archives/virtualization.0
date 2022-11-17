Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615C2C433FE
	for <virtualization@archiver.kernel.org>; Thu, 17 Nov 2022 03:37:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA8A760B55;
	Thu, 17 Nov 2022 03:37:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA8A760B55
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ajgCCdmp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9lmLiKvwaf4a; Thu, 17 Nov 2022 03:37:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5B3D460BAC;
	Thu, 17 Nov 2022 03:37:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B3D460BAC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B2B1C0033;
	Thu, 17 Nov 2022 03:37:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20194C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 03:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E65E3418BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 03:37:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E65E3418BF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ajgCCdmp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TKErjTccrvJ6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 03:37:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6FF44418BD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FF44418BD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 03:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668656219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xmYLCXkyyVFIcE0gAr+wWiSjCrLZItWun/jxW3cRp5Q=;
 b=ajgCCdmpfFW7FSmo2IbknRD4BRwZigSopGNFwuH5Awl9UfCAcMRMH8OnQwG3mqgOEL11mn
 ZSwRW+7tQdsfFCUNOWet6Vfwok7BSEsuPMGNI0Mjv/dCrzecE7yIsHv1oJac5Ky7xyk4gr
 609D9As4PVVjbGaghMPHeQ3njt/VosM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-317-NnMh_nh6NZmiqP2CLOe-CQ-1; Wed, 16 Nov 2022 22:36:58 -0500
X-MC-Unique: NnMh_nh6NZmiqP2CLOe-CQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 l12-20020a9d6a8c000000b0066c33f1649cso249116otq.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 19:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xmYLCXkyyVFIcE0gAr+wWiSjCrLZItWun/jxW3cRp5Q=;
 b=bebirS7Q1Ty6YJfLnisTq+csYn5P/dwSlH2R5L71LnDSjDz7uC7BdAtlk/kD2pKeJO
 BWYRGViSIqHz5YdVwtCfKxT9sNqE3TZ+bfDYqz5OIPFX4sUwAev8qCa6xamMagW355yY
 HGxRxvi/iy9tQD50FW68Mu+PXQr0pGl0IwCtDLc59La+oqG23WcNVQpsC8vva0Q0hj5q
 /15n2jqPmSPgS2aLVDhRAqPeOHk0ZRehOAv6yiFdZJxW3xQjyg4uaACpZjNam0ZtghVp
 lshNjiTWr+6qHnj3Ja1IugmXArkeWmxes1jNRMUclyJ7dctdm4Y6+AZ1Yz0l3BcP9PFF
 pihw==
X-Gm-Message-State: ANoB5pn2rl5DLPzCZzTZgJ/XIQ2BVshHK5ZTTRuCkjEhOptf53zHcrWl
 uXd8UqeP95p1UXlNjV5lxq8EoZmSwWjcTjsn9mcOsj7dI4cDGLvxvecgKTwCERSjS2Og219DrFG
 n725fERnoldSU0gO1q44VF5kBcsR3uRigPxYvtxpIUp9qOlB754keuGkqPg==
X-Received: by 2002:a05:6871:4410:b0:13b:ef13:b650 with SMTP id
 nd16-20020a056871441000b0013bef13b650mr325201oab.280.1668656217419; 
 Wed, 16 Nov 2022 19:36:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6DFNVJPchz24WlNsKBX8liM56MmEchJn9QR/GW98Qkw8fXTmqwFGrDyarEj+1et9lYCP2anoPSVtAQauzkeTk=
X-Received: by 2002:a05:6871:4410:b0:13b:ef13:b650 with SMTP id
 nd16-20020a056871441000b0013bef13b650mr325192oab.280.1668656217176; Wed, 16
 Nov 2022 19:36:57 -0800 (PST)
MIME-Version: 1.0
References: <CACycT3siOCZv+u+-Xcto9BEdY1c8t_ivw-DF73bmuLqBRxF7=A@mail.gmail.com>
In-Reply-To: <CACycT3siOCZv+u+-Xcto9BEdY1c8t_ivw-DF73bmuLqBRxF7=A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Nov 2022 11:36:45 +0800
Message-ID: <CACGkMEswaS_-pP2RpJGyVA2wmvVm3x4LD-MPrbvxQhAFgQYgAA@mail.gmail.com>
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

On Wed, Nov 16, 2022 at 3:46 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Wed, Nov 16, 2022 at 3:11 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Nov 15, 2022 at 10:49 AM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Mon, Nov 14, 2022 at 4:55 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Mon, Nov 14, 2022 at 4:20 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > On Mon, Nov 14, 2022 at 3:58 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Nov 14, 2022 at 3:16 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > > > >
> > > > > > > Add sysfs interface for each vduse virtqueue to setup
> > > > > > > irq affinity. This would be useful for performance
> > > > > > > tuning, e.g., mitigate the virtqueue lock contention
> > > > > > > in virtio block driver.
> > > > > >
> > > > > > Do we have any perforamnce numbers for this?
> > > > > >
> > > > >
> > > > > Almost 50% improvement (600k iops -> 900k iops) in the high iops
> > > > > workloads. I have mentioned it in the cover-letter.
> > > >
> > > > For some reason, I miss that.
> > > >
> > > > I also wonder if we can do this automatically, then there's no need to
> > > > play with sysfs which is kind of a burden for the management layer.
> > > >
> > >
> > > This is hard to do since vduse doesn't know which cpu should be bound
> > > for a certain virtqueue.
> >
> > Probably via the kick_vq()? It probably won't work when notification
> > is disabled. But we need to think a little bit more about this.
>
> Yes, another problem is that this way can only work when the cpu and
> virtqueue are 1:1 mapping. It's still hard to decide which cpu to bind
> in the N:1 mapping case.

This is the same situation as what you propose here. I think it would
be better to use cpumask instead of cpu id here.

>
> So I think it could be an optimization, but the sysfs interface is still needed.
>
> > Requiring management software to do ad-hoc running just for VDUSE
> > seems not easy.
> >
>
> I'm not sure. In the kubernetes environment, something like a CSI/CNI
> plugin can do it.

Only works when the process is bound to a specific cpu. If a process
is migrated to another CPU, it would be hard to track.

Thanks

>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
