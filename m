Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79746C433EF
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 06:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 05AD0405AB;
	Thu, 24 Mar 2022 06:17:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NpoPi_hYKDtA; Thu, 24 Mar 2022 06:17:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 63EBF40128;
	Thu, 24 Mar 2022 06:17:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 246CCC001A;
	Thu, 24 Mar 2022 06:17:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBB86C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 06:17:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA263419B6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 06:17:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1uSwk7hXRLRu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 06:17:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD71E41859
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 06:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648102633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53m2WvLnFOrK1vOidSiYVGB20NoBpxGzjS+etvQOv60=;
 b=d41sCl3uZsksV0+5+BARY1WPCVSQB7cGbW/mqnk3yk6Y4ChCOabMvk4TNoFH5EAAQiInYp
 wzHzpQVyCkeePJFLi95oelr/iREGV1FYjLQ5YO+gQsMiXPhDK3qmYKD6ruBfFUhk3swC9i
 oPv2DB7ApElMS4S4nW3STESholEUiDU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-zhe2rThHPGqFoMLeBb3ATA-1; Thu, 24 Mar 2022 02:17:12 -0400
X-MC-Unique: zhe2rThHPGqFoMLeBb3ATA-1
Received: by mail-wr1-f72.google.com with SMTP id
 f18-20020adf9f52000000b00203d86759beso1324788wrg.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 23:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=53m2WvLnFOrK1vOidSiYVGB20NoBpxGzjS+etvQOv60=;
 b=dH+4lP+EmiickLbuIEqLV32ZK7vxH0ZWaF9aREf2akB+ssPi4J8iy1TF5lHitBsUF4
 Ej0JcKDNsklk0XrDcs3U19I+Yn47W3lhbGzufmDxkynQGmW99fHARcLYpKsxflOAocpE
 hPnLMrcLJjgtgxwVpzOd1x4R38agje2m3LxaKA0xQSZAC6i3Irhdt4d4tFZHWs5CJxn5
 n7t1jivrzPpkIDW3fxgj6JqWB8xOO7QbtbOhThsfJEcykS7D/SF1RFJyhRaXI9CgM1uV
 KxfpQi6RhN4RJDjTfLH2uZvaz+plSFXRiwYkXaJrChDSMtDpzrr1eYVW+kyWjg94ESRl
 ttOA==
X-Gm-Message-State: AOAM530Th0GLHcXwKoMYDrkfa6tNTcrlDlPOiRFlI9TIthn4E8dItlxI
 XqryhpfLBBw3CF9lo3Im8ypoR6plR2+Id5/ERK0UYbb9UP8jw5hVWbksfMOUo9s/MRi6nke7j9W
 uWHDP3/t5TMXuXKjGwLLuVWsPV/BtvBXRU/KyXVh3kQ==
X-Received: by 2002:a7b:c74c:0:b0:38c:7645:9896 with SMTP id
 w12-20020a7bc74c000000b0038c76459896mr3188750wmk.83.1648102631080; 
 Wed, 23 Mar 2022 23:17:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNpbpIY6OFcNpNhBfa3hiIGIN9fKrPWqwXIYUh7bV8cTPJDX41Bs0bYRwnNyk/WLWFPbVQhg==
X-Received: by 2002:a7b:c74c:0:b0:38c:7645:9896 with SMTP id
 w12-20020a7bc74c000000b0038c76459896mr3188730wmk.83.1648102630825; 
 Wed, 23 Mar 2022 23:17:10 -0700 (PDT)
Received: from redhat.com ([2.55.151.118]) by smtp.gmail.com with ESMTPSA id
 m41-20020a05600c3b2900b0038cd120f9c9sm510521wms.0.2022.03.23.23.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 23:17:09 -0700 (PDT)
Date: Thu, 24 Mar 2022 02:17:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
Message-ID: <20220324021428-mutt-send-email-mst@kernel.org>
References: <20220321060429.10457-1-jasowang@redhat.com>
 <20220321085317.3148-1-hdanton@sina.com>
 <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
 <CACGkMEvLqox3QZxpxeQdrjBnM6zRr_wGfddoN45RUSsZEOe=bQ@mail.gmail.com>
 <20220321123420.3207-1-hdanton@sina.com>
 <CACGkMEt-PRCsBQ+EJVGeWGikJfLk-0M1dRPMqnp9YC5R4HYAjQ@mail.gmail.com>
 <20220324005345.3623-1-hdanton@sina.com>
 <20220324060419.3682-1-hdanton@sina.com>
MIME-Version: 1.0
In-Reply-To: <20220324060419.3682-1-hdanton@sina.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Eli Cohen <elic@nvidia.com>,
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

On Thu, Mar 24, 2022 at 02:04:19PM +0800, Hillf Danton wrote:
> On Thu, 24 Mar 2022 10:34:09 +0800 Jason Wang wrote:
> > On Thu, Mar 24, 2022 at 8:54 AM Hillf Danton <hdanton@sina.com> wrote:
> > >
> > > On Tue, 22 Mar 2022 09:59:14 +0800 Jason Wang wrote:
> > > >
> > > > Yes, there will be no "infinite" loop, but since the loop is triggered
> > > > by userspace. It looks to me it will delay the flush/drain of the
> > > > workqueue forever which is still suboptimal.
> > >
> > > Usually it is barely possible to shoot two birds using a stone.
> > >
> > > Given the "forever", I am inclined to not running faster, hehe, though
> > > another cobble is to add another line in the loop checking if mvdev is
> > > unregistered, and for example make mvdev->cvq unready before destroying
> > > workqueue.
> > >
> > > static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
> > > {
> > >         struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
> > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > >
> > >         mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> > >         destroy_workqueue(mvdev->wq);
> > >         _vdpa_unregister_device(dev);
> > >         mgtdev->ndev = NULL;
> > > }
> > >
> > 
> > Yes, so we had
> > 
> > 1) using a quota for re-requeue
> > 2) using something like
> > 
> > while (READ_ONCE(cvq->ready)) {
> >         ...
> >         cond_resched();
> > }
> > 
> > There should not be too much difference except we need to use
> > cancel_work_sync() instead of flush_work for 1).
> > 
> > I would keep the code as is but if you stick I can change.
> 
> No Sir I would not - I am simply not a fan of work requeue.
> 
> Hillf

I think I agree - requeue adds latency spikes under heavy load -
unfortunately, not measured by netperf but still important
for latency sensitive workloads. Checking a flag is cheaper.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
