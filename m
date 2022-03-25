Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B54FC433EF
	for <virtualization@archiver.kernel.org>; Fri, 25 Mar 2022 03:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E27C941CBD;
	Fri, 25 Mar 2022 03:22:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C0tObib3IgES; Fri, 25 Mar 2022 03:22:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6F01441CBB;
	Fri, 25 Mar 2022 03:22:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D40EC001A;
	Fri, 25 Mar 2022 03:22:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB7DFC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 03:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A69BB41CBC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 03:22:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3VmuK1HRp6HU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 03:22:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 961EF41CBB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 03:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648178559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/vrdVLbvl2FEAzCSgs81TCush7rfFjcGSogkgzqSOFQ=;
 b=BQWlxb2dLId70aMu+twHHlXYq3xSZuy32F9ijlLOla7IZ609vnk0cvcBd2CJQYIQcRpCrH
 85Pru2NNdx0hOktBhNQIcyk5d81OsdqWWY6fnG1FPM1E23toUoIRlt4Vgfmv3rxanTT9S+
 WaG9Df7IHu1s/woudVXOv1F3l9OZBhk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-0PZYf75AN6Gu_X65_0WIEQ-1; Thu, 24 Mar 2022 23:22:38 -0400
X-MC-Unique: 0PZYf75AN6Gu_X65_0WIEQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 n9-20020a2e82c9000000b002435af2e8b9so2482471ljh.20
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 20:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/vrdVLbvl2FEAzCSgs81TCush7rfFjcGSogkgzqSOFQ=;
 b=0QG4ECrn9NxKxkA1hdVG+Ubx7GHrVEdLOKbvCceOGlnOoGXGX1xZ0STtaoQ276Y/JU
 lFRbWS0F7Y1gdHfDfh2AxghEIs95cCQOaQeHz+eB46RvVpm2GOZA1Wdd/+ON5QTHhEuO
 CGVTWNtJK/eJoPGD3aLo+xHjvip+hQebpOkSXTOsDBjJWlQI5tNvo/bmsBhiBAzefE+9
 G4vwzrY+OiizYkcJglvlMFd0sad3tJ9Dm5hQ3RE38vZYU0ABXu9W0N9oQoHXUeeEqS3j
 2zSGtdiFOa52FpaNNIMElsqbDvIvVHnZtWCHy3HinSWGXIpwI88Rccb1OkoMQKpMxx5M
 4aBw==
X-Gm-Message-State: AOAM533umJsixR5tu7c3Qk32LWquAQqn1mIxehi7M4hYUFvBJ3Ka2hF1
 +WK0tG6abaD4J8A9KHqkKfxpVn6Bvzvx4TjYqfgXOMdqvLUKCyt+gvez1Ct+sl+bTxWtgVkYJBr
 o6RwB8waS4LgUF6e4MsOsELVS3vkCVY43rd8bz4/+ipTSu/CVjE7XK9OzJg==
X-Received: by 2002:a2e:54d:0:b0:249:8213:f970 with SMTP id
 74-20020a2e054d000000b002498213f970mr6574821ljf.315.1648178556704; 
 Thu, 24 Mar 2022 20:22:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoJVK7eltqcdR+KmXpacgd9LreAh6Ima8MArEeG8LkLLC6mQ188NZuNbMkJ5BgGWOcV2QOmDDFSOezocc8Xdw=
X-Received: by 2002:a2e:54d:0:b0:249:8213:f970 with SMTP id
 74-20020a2e054d000000b002498213f970mr6574806ljf.315.1648178556380; Thu, 24
 Mar 2022 20:22:36 -0700 (PDT)
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
 <20220324120217.3746-1-hdanton@sina.com>
 <DM8PR12MB54004034A8A5DA1D2B6EA8D1AB199@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54004034A8A5DA1D2B6EA8D1AB199@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 25 Mar 2022 11:22:25 +0800
Message-ID: <CACGkMEtVUqJcS1W2p1U9RCjQqQOSREu1J9zjmw37TbPBNqq7tA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Hillf Danton <hdanton@sina.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
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

On Thu, Mar 24, 2022 at 8:24 PM Eli Cohen <elic@nvidia.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Hillf Danton <hdanton@sina.com>
> > Sent: Thursday, March 24, 2022 2:02 PM
> > To: Jason Wang <jasowang@redhat.com>
> > Cc: Eli Cohen <elic@nvidia.com>; Michael S. Tsirkin <mst@redhat.com>; virtualization <virtualization@lists.linux-foundation.org>; linux-
> > kernel <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
> >
> > On Thu, 24 Mar 2022 16:20:34 +0800 Jason Wang wrote:
> > > On Thu, Mar 24, 2022 at 2:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > On Thu, Mar 24, 2022 at 02:04:19PM +0800, Hillf Danton wrote:
> > > > > On Thu, 24 Mar 2022 10:34:09 +0800 Jason Wang wrote:
> > > > > > On Thu, Mar 24, 2022 at 8:54 AM Hillf Danton <hdanton@sina.com> wrote:
> > > > > > >
> > > > > > > On Tue, 22 Mar 2022 09:59:14 +0800 Jason Wang wrote:
> > > > > > > >
> > > > > > > > Yes, there will be no "infinite" loop, but since the loop is triggered
> > > > > > > > by userspace. It looks to me it will delay the flush/drain of the
> > > > > > > > workqueue forever which is still suboptimal.
> > > > > > >
> > > > > > > Usually it is barely possible to shoot two birds using a stone.
> > > > > > >
> > > > > > > Given the "forever", I am inclined to not running faster, hehe, though
> > > > > > > another cobble is to add another line in the loop checking if mvdev is
> > > > > > > unregistered, and for example make mvdev->cvq unready before destroying
> > > > > > > workqueue.
> > > > > > >
> > > > > > > static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
> > > > > > > {
> > > > > > >         struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
> > > > > > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> > > > > > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > > > >
> > > > > > >         mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> > > > > > >         destroy_workqueue(mvdev->wq);
> > > > > > >         _vdpa_unregister_device(dev);
> > > > > > >         mgtdev->ndev = NULL;
> > > > > > > }
> > > > > > >
> > > > > >
> > > > > > Yes, so we had
> > > > > >
> > > > > > 1) using a quota for re-requeue
> > > > > > 2) using something like
> > > > > >
> > > > > > while (READ_ONCE(cvq->ready)) {
> > > > > >         ...
> > > > > >         cond_resched();
> > > > > > }
> > > > > >
> > > > > > There should not be too much difference except we need to use
> > > > > > cancel_work_sync() instead of flush_work for 1).
> > > > > >
> > > > > > I would keep the code as is but if you stick I can change.
> > > > >
> > > > > No Sir I would not - I am simply not a fan of work requeue.
> > > > >
> > > > > Hillf
> > > >
> > > > I think I agree - requeue adds latency spikes under heavy load -
> > > > unfortunately, not measured by netperf but still important
> > > > for latency sensitive workloads. Checking a flag is cheaper.
> > >
> > > Just spot another possible issue.
> > >
> > > The workqueue will be used by another work to update the carrier
> > > (event_handler()). Using cond_resched() may still have unfair issue
> > > which blocks the carrier update for infinite time,
> >
> > Then would you please specify the reason why mvdev->wq is single
> > threaded?

I didn't see a reason why it needs to be a single threaded (ordered).

> Given requeue, the serialization of the two works is not
> > strong. Otherwise unbound WQ that can process works in parallel is
> > a cure to the unfairness above.

Yes, and we probably don't want a per device workqueue but a per
module one. Or simply use the system_wq one.

> >
>
> I think the proposed patch can still be used with quota equal to one.
> That would guarantee fairness.
> This is not performance critical and a single workqueue should be enough.

Yes, but both Hillf and Michael don't like requeuing. So my plan is

1) send patch 2 first since it's a hard requirement for the next RHEL release
2) a series to fix this hogging issue by
2.1) switch to use a per module workqueue
2.2) READ_ONCE(cvq->ready) + cond_resched()

Thanks

>
> > Thanks
> > Hillf
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
