Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E696C433EF
	for <virtualization@archiver.kernel.org>; Fri, 25 Mar 2022 07:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1641840529;
	Fri, 25 Mar 2022 07:53:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i5620ke1Et38; Fri, 25 Mar 2022 07:53:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 15E0B40491;
	Fri, 25 Mar 2022 07:53:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBFEEC002C;
	Fri, 25 Mar 2022 07:53:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C4AAC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 07:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5BE7D409C1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 07:53:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NENHG-wATEJS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 07:53:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 754B040977
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 07:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648194803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5n657RBxJ9u00nOhcNkzlNKfY65Y8K8C3fIfane0FAY=;
 b=d05VTF+FjoOI02PvK8/2YgDUen5exbnUCN2meT+af2VHWRH1YkvjPQm1gHoQg9+PM42fBc
 0PY9TBbIi5628LtLWGgovbE4lezQJvs/9EuY6xC8K5lVF4ao8pqPb2+1c0LH4un0Gd6VZw
 oa8YlgWDBXZX1/JEwhCv8w2xQvzc3M4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-grOa8nYpOAmSplXtXRQrpA-1; Fri, 25 Mar 2022 03:53:22 -0400
X-MC-Unique: grOa8nYpOAmSplXtXRQrpA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-2e696b18eb4so55045127b3.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 00:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5n657RBxJ9u00nOhcNkzlNKfY65Y8K8C3fIfane0FAY=;
 b=eikrSgfBV1uIVIzOqGytgGjF+EKVQDbprN6Sbdbb9hnu5c8Ssa61PglGC0Cfvh+LLK
 fuB1FUuz9BDflynBEtNJEQaHBKQWtaBJNwzGt+1psovvOeXQIlCmLjMTaKg602Kueg+o
 CgTkUKTsEkWN0YOVPSkQcfFcGPQF0Eghd+3B7xKD+LDJJXPWdQFJIVYBhmURo6IrR4Gb
 iTX8mfDMwTTYcZsMTRj/Sb515TMoBN+UDHAw9XaALlVt1gGSwG3UG+6RN02wL0gEw+gv
 EBOG+AqNRCPn5ehTJ6Uz+/KSe7PaRWwBxSnLld8hDQwrWxRTguda7HtT7Q6sAXhMRufV
 9u8w==
X-Gm-Message-State: AOAM530pj5W2cMjurTUFuN7xxlFTnu8U3l6G7NLetA6K/8O6W5FvEBak
 pwxSiH65ZgrSuBeSbPXGURQu8asMJQcyLmt146bLsMMlaI/RihwTHqqcMSLS7QHHcjcpC08ROrG
 zD9hGRV2+pbGkV50nCyiBVN12mbj0Eu/U6TyAUDrZO+edBV1B80R3kDeJMw==
X-Received: by 2002:a81:5309:0:b0:2e6:dcfc:8665 with SMTP id
 h9-20020a815309000000b002e6dcfc8665mr3622392ywb.501.1648194801635; 
 Fri, 25 Mar 2022 00:53:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmokIvXmKspUJ2XeJF0/jBSJruMy179rTqZKTL6cIZ4H6J/1wbUXc0klpacsy7hUtWtbrlErv8Oe9qQqGJRng=
X-Received: by 2002:a81:5309:0:b0:2e6:dcfc:8665 with SMTP id
 h9-20020a815309000000b002e6dcfc8665mr3622382ywb.501.1648194801467; Fri, 25
 Mar 2022 00:53:21 -0700 (PDT)
MIME-Version: 1.0
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
 <20220325024324-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220325024324-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 25 Mar 2022 15:53:09 +0800
Message-ID: <CACGkMEvie2Zx9OnwOydguCiLMw71vKB1HmqX0uD9LuWPAakRRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Fri, Mar 25, 2022 at 2:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Mar 25, 2022 at 11:22:25AM +0800, Jason Wang wrote:
> > On Thu, Mar 24, 2022 at 8:24 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Hillf Danton <hdanton@sina.com>
> > > > Sent: Thursday, March 24, 2022 2:02 PM
> > > > To: Jason Wang <jasowang@redhat.com>
> > > > Cc: Eli Cohen <elic@nvidia.com>; Michael S. Tsirkin <mst@redhat.com>; virtualization <virtualization@lists.linux-foundation.org>; linux-
> > > > kernel <linux-kernel@vger.kernel.org>
> > > > Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
> > > >
> > > > On Thu, 24 Mar 2022 16:20:34 +0800 Jason Wang wrote:
> > > > > On Thu, Mar 24, 2022 at 2:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > On Thu, Mar 24, 2022 at 02:04:19PM +0800, Hillf Danton wrote:
> > > > > > > On Thu, 24 Mar 2022 10:34:09 +0800 Jason Wang wrote:
> > > > > > > > On Thu, Mar 24, 2022 at 8:54 AM Hillf Danton <hdanton@sina.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, 22 Mar 2022 09:59:14 +0800 Jason Wang wrote:
> > > > > > > > > >
> > > > > > > > > > Yes, there will be no "infinite" loop, but since the loop is triggered
> > > > > > > > > > by userspace. It looks to me it will delay the flush/drain of the
> > > > > > > > > > workqueue forever which is still suboptimal.
> > > > > > > > >
> > > > > > > > > Usually it is barely possible to shoot two birds using a stone.
> > > > > > > > >
> > > > > > > > > Given the "forever", I am inclined to not running faster, hehe, though
> > > > > > > > > another cobble is to add another line in the loop checking if mvdev is
> > > > > > > > > unregistered, and for example make mvdev->cvq unready before destroying
> > > > > > > > > workqueue.
> > > > > > > > >
> > > > > > > > > static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
> > > > > > > > > {
> > > > > > > > >         struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
> > > > > > > > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> > > > > > > > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > > > > > >
> > > > > > > > >         mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> > > > > > > > >         destroy_workqueue(mvdev->wq);
> > > > > > > > >         _vdpa_unregister_device(dev);
> > > > > > > > >         mgtdev->ndev = NULL;
> > > > > > > > > }
> > > > > > > > >
> > > > > > > >
> > > > > > > > Yes, so we had
> > > > > > > >
> > > > > > > > 1) using a quota for re-requeue
> > > > > > > > 2) using something like
> > > > > > > >
> > > > > > > > while (READ_ONCE(cvq->ready)) {
> > > > > > > >         ...
> > > > > > > >         cond_resched();
> > > > > > > > }
> > > > > > > >
> > > > > > > > There should not be too much difference except we need to use
> > > > > > > > cancel_work_sync() instead of flush_work for 1).
> > > > > > > >
> > > > > > > > I would keep the code as is but if you stick I can change.
> > > > > > >
> > > > > > > No Sir I would not - I am simply not a fan of work requeue.
> > > > > > >
> > > > > > > Hillf
> > > > > >
> > > > > > I think I agree - requeue adds latency spikes under heavy load -
> > > > > > unfortunately, not measured by netperf but still important
> > > > > > for latency sensitive workloads. Checking a flag is cheaper.
> > > > >
> > > > > Just spot another possible issue.
> > > > >
> > > > > The workqueue will be used by another work to update the carrier
> > > > > (event_handler()). Using cond_resched() may still have unfair issue
> > > > > which blocks the carrier update for infinite time,
> > > >
> > > > Then would you please specify the reason why mvdev->wq is single
> > > > threaded?
> >
> > I didn't see a reason why it needs to be a single threaded (ordered).
> >
> > > Given requeue, the serialization of the two works is not
> > > > strong. Otherwise unbound WQ that can process works in parallel is
> > > > a cure to the unfairness above.
> >
> > Yes, and we probably don't want a per device workqueue but a per
> > module one. Or simply use the system_wq one.
> >
> > > >
> > >
> > > I think the proposed patch can still be used with quota equal to one.
> > > That would guarantee fairness.
> > > This is not performance critical and a single workqueue should be enough.
> >
> > Yes, but both Hillf and Michael don't like requeuing. So my plan is
> >
> > 1) send patch 2 first since it's a hard requirement for the next RHEL release
> > 2) a series to fix this hogging issue by
> > 2.1) switch to use a per module workqueue
> > 2.2) READ_ONCE(cvq->ready) + cond_resched()
> >
> > Thanks
>
> Actually if we don't care about speed here then requeing with quota of 1
> is fine, in that we don't have a quota at all, we just always requeue
> instead of a loop.
>
> It's the mix of requeue and a loop that I consider confusing.

Ok, Hillf, does this make sense for you? We want the issue to be fixed
soon, it's near to our product release.

Thanks

>
>
> > >
> > > > Thanks
> > > > Hillf
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
