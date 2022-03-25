Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2EBC433F5
	for <virtualization@archiver.kernel.org>; Fri, 25 Mar 2022 06:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD7A284480;
	Fri, 25 Mar 2022 06:45:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jub8GyAK1VOM; Fri, 25 Mar 2022 06:45:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5CE728442A;
	Fri, 25 Mar 2022 06:45:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DB0FC002F;
	Fri, 25 Mar 2022 06:45:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A73FC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 06:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 010F684480
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 06:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K1_HO0AqUvqt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 06:45:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F0D48442A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 06:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648190732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Ps+162FjCw1COHBRdJjTCL/Gy1wv1H2La87XaBnoPc=;
 b=G36hYBfP2njIxQrHCV50DGTZ7fUiQ66J66Gqs+3ak27eVOMAnGHUpZmgybMQ0pg0tqO6J5
 CCM7mjahOoQZ0Yt8ltOQEllG6+4U569SbG0NjmYumykoUmlQ2XgBKUvIT9jh3r+nRT8k71
 VFha4D/1vHcLmrmnt6LkgLN9WxJWifs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-Q9JWYqgoMWGh8BnK4XDt_w-1; Fri, 25 Mar 2022 02:45:30 -0400
X-MC-Unique: Q9JWYqgoMWGh8BnK4XDt_w-1
Received: by mail-wr1-f72.google.com with SMTP id
 j67-20020adf9149000000b00203e6b7d151so2386742wrj.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 23:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/Ps+162FjCw1COHBRdJjTCL/Gy1wv1H2La87XaBnoPc=;
 b=ULjtWtbq5yR1Zp+t0nxInYG3ZBTd1gaDZm2GZj7xHNSSOtq5cR3JsL48yqYIbNGGG+
 PHligqPxEkyRS9/s8KJo4518OETSPiquOE+KtA7NtuTxXSJG7DJtdwuwNJrBcefMWWKD
 jxApm/jRt7xZf1JIe2B5rqeeXEO4cUeJWyz1BImkwMzEiAXfo0m9LnOWMFHxSbLw7ESi
 spQ65lHALUtcfFIeKwJVZ/glx4gBmEdVe1X48GZ3l5PgiLeB4I6laWUR4T3mi7KGt+vJ
 Eq0In8qggj5xAElEZaS7BgL2yBBQwC7CpFRa0izIjScUQxuGoCVZ2NbFlk2or/Id3MDH
 inLQ==
X-Gm-Message-State: AOAM531Y57+t9oS3XKs3cNzSU1zXPE4nheWgIf2wbzYQF3S9Rb599yc9
 JmT6Zjq5oqI9lXNtg69gzmhO2EGL7aYhIp4Y/J/2zzB3AW9X6m4c22bHLWU7/ozVrQX1LqqD2Er
 /hLO70DpPBEw7OjExYTPytsMD3UxZaI5CYtj80RU4KQ==
X-Received: by 2002:a05:600c:6020:b0:38c:d24c:5fbf with SMTP id
 az32-20020a05600c602000b0038cd24c5fbfmr5990678wmb.18.1648190729745; 
 Thu, 24 Mar 2022 23:45:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCwwJ6vWbOVZe1BgwFRqeurkuzU2qwLOIN+1N59iBZ6Ho6QaMdgMF2gkk8YkYOr/nNxfLfIQ==
X-Received: by 2002:a05:600c:6020:b0:38c:d24c:5fbf with SMTP id
 az32-20020a05600c602000b0038cd24c5fbfmr5990669wmb.18.1648190729557; 
 Thu, 24 Mar 2022 23:45:29 -0700 (PDT)
Received: from redhat.com ([2.55.151.118]) by smtp.gmail.com with ESMTPSA id
 i9-20020a5d5849000000b002058631cfacsm4455201wrf.61.2022.03.24.23.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Mar 2022 23:45:28 -0700 (PDT)
Date: Fri, 25 Mar 2022 02:45:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
Message-ID: <20220325024324-mutt-send-email-mst@kernel.org>
References: <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
 <CACGkMEvLqox3QZxpxeQdrjBnM6zRr_wGfddoN45RUSsZEOe=bQ@mail.gmail.com>
 <20220321123420.3207-1-hdanton@sina.com>
 <CACGkMEt-PRCsBQ+EJVGeWGikJfLk-0M1dRPMqnp9YC5R4HYAjQ@mail.gmail.com>
 <20220324005345.3623-1-hdanton@sina.com>
 <20220324060419.3682-1-hdanton@sina.com>
 <20220324021428-mutt-send-email-mst@kernel.org>
 <20220324120217.3746-1-hdanton@sina.com>
 <DM8PR12MB54004034A8A5DA1D2B6EA8D1AB199@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEtVUqJcS1W2p1U9RCjQqQOSREu1J9zjmw37TbPBNqq7tA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtVUqJcS1W2p1U9RCjQqQOSREu1J9zjmw37TbPBNqq7tA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Eli Cohen <elic@nvidia.com>,
 Hillf Danton <hdanton@sina.com>,
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

On Fri, Mar 25, 2022 at 11:22:25AM +0800, Jason Wang wrote:
> On Thu, Mar 24, 2022 at 8:24 PM Eli Cohen <elic@nvidia.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Hillf Danton <hdanton@sina.com>
> > > Sent: Thursday, March 24, 2022 2:02 PM
> > > To: Jason Wang <jasowang@redhat.com>
> > > Cc: Eli Cohen <elic@nvidia.com>; Michael S. Tsirkin <mst@redhat.com>; virtualization <virtualization@lists.linux-foundation.org>; linux-
> > > kernel <linux-kernel@vger.kernel.org>
> > > Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
> > >
> > > On Thu, 24 Mar 2022 16:20:34 +0800 Jason Wang wrote:
> > > > On Thu, Mar 24, 2022 at 2:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > On Thu, Mar 24, 2022 at 02:04:19PM +0800, Hillf Danton wrote:
> > > > > > On Thu, 24 Mar 2022 10:34:09 +0800 Jason Wang wrote:
> > > > > > > On Thu, Mar 24, 2022 at 8:54 AM Hillf Danton <hdanton@sina.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, 22 Mar 2022 09:59:14 +0800 Jason Wang wrote:
> > > > > > > > >
> > > > > > > > > Yes, there will be no "infinite" loop, but since the loop is triggered
> > > > > > > > > by userspace. It looks to me it will delay the flush/drain of the
> > > > > > > > > workqueue forever which is still suboptimal.
> > > > > > > >
> > > > > > > > Usually it is barely possible to shoot two birds using a stone.
> > > > > > > >
> > > > > > > > Given the "forever", I am inclined to not running faster, hehe, though
> > > > > > > > another cobble is to add another line in the loop checking if mvdev is
> > > > > > > > unregistered, and for example make mvdev->cvq unready before destroying
> > > > > > > > workqueue.
> > > > > > > >
> > > > > > > > static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
> > > > > > > > {
> > > > > > > >         struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
> > > > > > > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> > > > > > > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > > > > >
> > > > > > > >         mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> > > > > > > >         destroy_workqueue(mvdev->wq);
> > > > > > > >         _vdpa_unregister_device(dev);
> > > > > > > >         mgtdev->ndev = NULL;
> > > > > > > > }
> > > > > > > >
> > > > > > >
> > > > > > > Yes, so we had
> > > > > > >
> > > > > > > 1) using a quota for re-requeue
> > > > > > > 2) using something like
> > > > > > >
> > > > > > > while (READ_ONCE(cvq->ready)) {
> > > > > > >         ...
> > > > > > >         cond_resched();
> > > > > > > }
> > > > > > >
> > > > > > > There should not be too much difference except we need to use
> > > > > > > cancel_work_sync() instead of flush_work for 1).
> > > > > > >
> > > > > > > I would keep the code as is but if you stick I can change.
> > > > > >
> > > > > > No Sir I would not - I am simply not a fan of work requeue.
> > > > > >
> > > > > > Hillf
> > > > >
> > > > > I think I agree - requeue adds latency spikes under heavy load -
> > > > > unfortunately, not measured by netperf but still important
> > > > > for latency sensitive workloads. Checking a flag is cheaper.
> > > >
> > > > Just spot another possible issue.
> > > >
> > > > The workqueue will be used by another work to update the carrier
> > > > (event_handler()). Using cond_resched() may still have unfair issue
> > > > which blocks the carrier update for infinite time,
> > >
> > > Then would you please specify the reason why mvdev->wq is single
> > > threaded?
> 
> I didn't see a reason why it needs to be a single threaded (ordered).
> 
> > Given requeue, the serialization of the two works is not
> > > strong. Otherwise unbound WQ that can process works in parallel is
> > > a cure to the unfairness above.
> 
> Yes, and we probably don't want a per device workqueue but a per
> module one. Or simply use the system_wq one.
> 
> > >
> >
> > I think the proposed patch can still be used with quota equal to one.
> > That would guarantee fairness.
> > This is not performance critical and a single workqueue should be enough.
> 
> Yes, but both Hillf and Michael don't like requeuing. So my plan is
> 
> 1) send patch 2 first since it's a hard requirement for the next RHEL release
> 2) a series to fix this hogging issue by
> 2.1) switch to use a per module workqueue
> 2.2) READ_ONCE(cvq->ready) + cond_resched()
> 
> Thanks

Actually if we don't care about speed here then requeing with quota of 1
is fine, in that we don't have a quota at all, we just always requeue
instead of a loop.

It's the mix of requeue and a loop that I consider confusing.


> >
> > > Thanks
> > > Hillf
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
