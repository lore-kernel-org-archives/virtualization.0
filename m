Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CD6C433EF
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 08:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3FFF608D8;
	Thu, 24 Mar 2022 08:20:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7w_YobygiLd7; Thu, 24 Mar 2022 08:20:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5C27B607C0;
	Thu, 24 Mar 2022 08:20:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33217C001A;
	Thu, 24 Mar 2022 08:20:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CE7CC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F02EE608D8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:20:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N3kmLkVYN7Im
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:20:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AA375607C0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648110050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WqYtQSBegGxeYkN/lgul0x/vukAzbn7E8fW29poebx4=;
 b=Tn2afSK5wGKTIB8M4cWfjLn3Uh/U4UueWp3yqzruF70vrE8E4INcyemKhCBIr3i0z+gkyd
 dmonLC9FfoJJFPgWyRSIugV7LrL7x5PyAKeU5puFRa+UUq5m+gc453Bu0ePsEYYCbZWryt
 pZXMMTlw+Q2wgIz3I8haFNvimVasgN0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-1pLR0w53NOyqHPF4JP2A5Q-1; Thu, 24 Mar 2022 04:20:47 -0400
X-MC-Unique: 1pLR0w53NOyqHPF4JP2A5Q-1
Received: by mail-lj1-f200.google.com with SMTP id
 q5-20020a2e9145000000b002497bf0eaa1so1525275ljg.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 01:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WqYtQSBegGxeYkN/lgul0x/vukAzbn7E8fW29poebx4=;
 b=dhCNIj1COIVHMmkS3ibi/zdprAPJqqIVilAjWUdwsWmJFfoNOjeo9PVjzi0gA/+1gz
 jd+K+nUBp+xtnJq9iRarJ5zhF5AqWjLJRpbDQ8hCKThbROoGAi+aPwaejsK57M5t5i/d
 k4woZLeslBJhsdQ2Rb2UFxHJLOvpdwT6bmAJP0+SSvqReB+T/VDZ18LYMzOL9ypEp8/x
 jSmvdSRVfoEZPRRqmCZUObiGqX7EOvGly8cJEc2NMOG8Iw1cU+j0DrQa3QyBtoGkgALd
 S8LkI65dSyEwWov0BjD6Qcroee4dgpH4rxEzymSgx3UUyOQceCqXwTrKfJx3T0SXWGWa
 RmLQ==
X-Gm-Message-State: AOAM532uNRH2QG98wj+QYuXQCufLTZIBod7Yy+FAhDwcBfK+IpS0Cnkm
 59cd1rEGV3iGlaa6aQTl3Z8QUHz8dA5gYhBIjt3qKjgZnlaCyIEIaYFOdg1bsYV2HTwB5M403Wq
 QGy2gLCGFXTLYk3Z7nzvoT3ffYm7WNsl8w0nNV119rf+uTjblMm+oEcS3KA==
X-Received: by 2002:a05:6512:108a:b0:448:756a:f5fb with SMTP id
 j10-20020a056512108a00b00448756af5fbmr3005738lfg.587.1648110046269; 
 Thu, 24 Mar 2022 01:20:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfT0Xe23zFs2/wV2CRifK0H0/uU7lnCg6gAd91jtsZiI045kyG5D8Pur9xXbLwQeiPG1qsVOPoSkmKIloAQqY=
X-Received: by 2002:a05:6512:108a:b0:448:756a:f5fb with SMTP id
 j10-20020a056512108a00b00448756af5fbmr3005727lfg.587.1648110046028; Thu, 24
 Mar 2022 01:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220321060429.10457-1-jasowang@redhat.com>
 <20220321085317.3148-1-hdanton@sina.com>
 <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
 <CACGkMEvLqox3QZxpxeQdrjBnM6zRr_wGfddoN45RUSsZEOe=bQ@mail.gmail.com>
 <20220321123420.3207-1-hdanton@sina.com>
 <CACGkMEt-PRCsBQ+EJVGeWGikJfLk-0M1dRPMqnp9YC5R4HYAjQ@mail.gmail.com>
 <20220324005345.3623-1-hdanton@sina.com>
 <20220324060419.3682-1-hdanton@sina.com>
 <20220324021428-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220324021428-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 24 Mar 2022 16:20:34 +0800
Message-ID: <CACGkMEuD-9cHmZotAwdLSecmBtWhBS0qxhSKfZ84e9_wS4E4EQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Hillf Danton <hdanton@sina.com>, Eli Cohen <elic@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, Mar 24, 2022 at 2:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Mar 24, 2022 at 02:04:19PM +0800, Hillf Danton wrote:
> > On Thu, 24 Mar 2022 10:34:09 +0800 Jason Wang wrote:
> > > On Thu, Mar 24, 2022 at 8:54 AM Hillf Danton <hdanton@sina.com> wrote:
> > > >
> > > > On Tue, 22 Mar 2022 09:59:14 +0800 Jason Wang wrote:
> > > > >
> > > > > Yes, there will be no "infinite" loop, but since the loop is triggered
> > > > > by userspace. It looks to me it will delay the flush/drain of the
> > > > > workqueue forever which is still suboptimal.
> > > >
> > > > Usually it is barely possible to shoot two birds using a stone.
> > > >
> > > > Given the "forever", I am inclined to not running faster, hehe, though
> > > > another cobble is to add another line in the loop checking if mvdev is
> > > > unregistered, and for example make mvdev->cvq unready before destroying
> > > > workqueue.
> > > >
> > > > static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
> > > > {
> > > >         struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
> > > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> > > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > >
> > > >         mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> > > >         destroy_workqueue(mvdev->wq);
> > > >         _vdpa_unregister_device(dev);
> > > >         mgtdev->ndev = NULL;
> > > > }
> > > >
> > >
> > > Yes, so we had
> > >
> > > 1) using a quota for re-requeue
> > > 2) using something like
> > >
> > > while (READ_ONCE(cvq->ready)) {
> > >         ...
> > >         cond_resched();
> > > }
> > >
> > > There should not be too much difference except we need to use
> > > cancel_work_sync() instead of flush_work for 1).
> > >
> > > I would keep the code as is but if you stick I can change.
> >
> > No Sir I would not - I am simply not a fan of work requeue.
> >
> > Hillf
>
> I think I agree - requeue adds latency spikes under heavy load -
> unfortunately, not measured by netperf but still important
> for latency sensitive workloads. Checking a flag is cheaper.

Just spot another possible issue.

The workqueue will be used by another work to update the carrier
(event_handler()). Using cond_resched() may still have unfair issue
which blocks the carrier update for infinite time,

Thanks

>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
