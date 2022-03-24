Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFAAC433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 12:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AC16843E9;
	Thu, 24 Mar 2022 12:03:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7wV5K4Z8NRSS; Thu, 24 Mar 2022 12:03:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0BF5284329;
	Thu, 24 Mar 2022 12:03:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBA10C0012;
	Thu, 24 Mar 2022 12:03:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 833AAC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 12:03:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 629C684341
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 12:03:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HcxP7Imc5MrI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 12:03:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn
 [202.108.3.166])
 by smtp1.osuosl.org (Postfix) with SMTP id A229B843FC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 12:03:05 +0000 (UTC)
Received: from unknown (HELO localhost.localdomain)([114.249.57.134])
 by sina.com (172.16.97.23) with ESMTP
 id 623C5DC300018575; Thu, 24 Mar 2022 20:02:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 14035254919537
From: Hillf Danton <hdanton@sina.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
Date: Thu, 24 Mar 2022 20:02:17 +0800
Message-Id: <20220324120217.3746-1-hdanton@sina.com>
In-Reply-To: <CACGkMEuD-9cHmZotAwdLSecmBtWhBS0qxhSKfZ84e9_wS4E4EQ@mail.gmail.com>
References: <20220321060429.10457-1-jasowang@redhat.com>
 <20220321085317.3148-1-hdanton@sina.com>
 <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
 <CACGkMEvLqox3QZxpxeQdrjBnM6zRr_wGfddoN45RUSsZEOe=bQ@mail.gmail.com>
 <20220321123420.3207-1-hdanton@sina.com>
 <CACGkMEt-PRCsBQ+EJVGeWGikJfLk-0M1dRPMqnp9YC5R4HYAjQ@mail.gmail.com>
 <20220324005345.3623-1-hdanton@sina.com>
 <20220324060419.3682-1-hdanton@sina.com>
 <20220324021428-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Cc: Eli Cohen <elic@nvidia.com>,
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

On Thu, 24 Mar 2022 16:20:34 +0800 Jason Wang wrote:
> On Thu, Mar 24, 2022 at 2:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Thu, Mar 24, 2022 at 02:04:19PM +0800, Hillf Danton wrote:
> > > On Thu, 24 Mar 2022 10:34:09 +0800 Jason Wang wrote:
> > > > On Thu, Mar 24, 2022 at 8:54 AM Hillf Danton <hdanton@sina.com> wrote:
> > > > >
> > > > > On Tue, 22 Mar 2022 09:59:14 +0800 Jason Wang wrote:
> > > > > >
> > > > > > Yes, there will be no "infinite" loop, but since the loop is triggered
> > > > > > by userspace. It looks to me it will delay the flush/drain of the
> > > > > > workqueue forever which is still suboptimal.
> > > > >
> > > > > Usually it is barely possible to shoot two birds using a stone.
> > > > >
> > > > > Given the "forever", I am inclined to not running faster, hehe, though
> > > > > another cobble is to add another line in the loop checking if mvdev is
> > > > > unregistered, and for example make mvdev->cvq unready before destroying
> > > > > workqueue.
> > > > >
> > > > > static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
> > > > > {
> > > > >         struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
> > > > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> > > > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > >
> > > > >         mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> > > > >         destroy_workqueue(mvdev->wq);
> > > > >         _vdpa_unregister_device(dev);
> > > > >         mgtdev->ndev = NULL;
> > > > > }
> > > > >
> > > >
> > > > Yes, so we had
> > > >
> > > > 1) using a quota for re-requeue
> > > > 2) using something like
> > > >
> > > > while (READ_ONCE(cvq->ready)) {
> > > >         ...
> > > >         cond_resched();
> > > > }
> > > >
> > > > There should not be too much difference except we need to use
> > > > cancel_work_sync() instead of flush_work for 1).
> > > >
> > > > I would keep the code as is but if you stick I can change.
> > >
> > > No Sir I would not - I am simply not a fan of work requeue.
> > >
> > > Hillf
> >
> > I think I agree - requeue adds latency spikes under heavy load -
> > unfortunately, not measured by netperf but still important
> > for latency sensitive workloads. Checking a flag is cheaper.
> 
> Just spot another possible issue.
> 
> The workqueue will be used by another work to update the carrier
> (event_handler()). Using cond_resched() may still have unfair issue
> which blocks the carrier update for infinite time,

Then would you please specify the reason why mvdev->wq is single
threaded? Given requeue, the serialization of the two works is not
strong. Otherwise unbound WQ that can process works in parallel is
a cure to the unfairness above.

Thanks
Hillf
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
