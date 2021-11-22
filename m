Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F4EC433EF
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 08:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 71919403F0;
	Mon, 22 Nov 2021 08:08:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3TTh6KLdTx3a; Mon, 22 Nov 2021 08:08:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C351E40281;
	Mon, 22 Nov 2021 08:08:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FBC8C001E;
	Mon, 22 Nov 2021 08:08:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67A7FC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 08:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 53AA3607EE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 08:08:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e5RPjV_gXMKx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 08:08:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65043607FA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 08:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637568487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=marOGgaflTz9vqznflgNCVjDR/kDctc0gqYEoHNPnzI=;
 b=hx2HMeqQLlkKtLv1LkNfqCYVA7Q8AkVD/cqSb9/LVr+SO5G92m/5x4enCxpAhUhFLUFyrc
 EkoxzU/CXAoILowzzobgJJWDVOk/Rz+XvyJ0t0lnTIHMOkKaxg534IcWrzIj6sTaS6JT/x
 In+RFqdBiV6GSjVuplCdZlVmPvQ1wA8=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-305-FdVJOip0ONaR2sre0gdSiw-1; Mon, 22 Nov 2021 03:07:36 -0500
X-MC-Unique: FdVJOip0ONaR2sre0gdSiw-1
Received: by mail-yb1-f198.google.com with SMTP id
 v7-20020a25ab87000000b005c2130838beso27147547ybi.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 00:07:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=marOGgaflTz9vqznflgNCVjDR/kDctc0gqYEoHNPnzI=;
 b=mZI3npg6nnOymBymXLi5yvDg3foMIYBs+0p6IYgkYs0t93vvReMi3PDkg9/AJVTOQr
 qNw5vDBbWbNofgviDTMWZYWFUKcA86dI+bFHgo3kMzF5dMJVuYs5N6goMGiaZeabnt2e
 82pehq3slzZn9PaVqjkI+YcopeIHqlS388HB1aKrdWs8xNZiehLuSBaTIKuxGj3dcAVs
 VQ1C4SBk93EDF7yThDV2LnVJo+ECidiu6GgROa36rR0LmBb5GEFBBP1zQd1OKveZ8mqI
 eiwgIOCaVVAmWUyIcAiQfgrHT3gpq9O6BKtCvGYaSRyBMmNIRf/c0ze3I8Gq9WAdKY+V
 k4eA==
X-Gm-Message-State: AOAM532ac5Qf4zqlg4+sbzz/m4tQ0KG3/yr8geEHieXNSk4vdVyTXdDt
 5OClhyiZnf/uNjls9Lzl60CiyyQv0sF/4BzasHpFqgl+tGxcTiyWlcciK5TNx4tJRucLQabMePT
 Z4mpEruw+7OcY182/BSrQcsLKJmZInViwLQf//E8vdHkPkLhY37wDR6Z0hg==
X-Received: by 2002:a05:6902:701:: with SMTP id
 k1mr1698269ybt.71.1637568455545; 
 Mon, 22 Nov 2021 00:07:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHFX4t8EPra/AqTFrWQ/QnHdeOHCq5RQpO0NKlN3TWf2GXwfXzrnlDUDl4AsDUWumP+PQRDGnGhLzO0OT2FIo=
X-Received: by 2002:a05:6902:701:: with SMTP id
 k1mr1698218ybt.71.1637568455261; 
 Mon, 22 Nov 2021 00:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20211118055741.239639-1-elic@nvidia.com>
 <20211118055741.239639-2-elic@nvidia.com>
 <CACGkMEsDHKCTSHtLBp3Pr0wntgYzsSBNjCNjQjGkmk2iap80rg@mail.gmail.com>
 <PH0PR12MB548187F4DE8C789908839F9DDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEssVx-quDa+c7wYAyB6a3j88EBAYTW+y8e_FcxW2mA1nQ@mail.gmail.com>
 <20211122075615.GB74340@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211122075615.GB74340@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Nov 2021 16:07:24 +0800
Message-ID: <CACGkMEs0mCKV4iF=O7Psxip38tL5iiu92Kzj_LqLgTqXV-M+NA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: Add support for querying statistics
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>
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

On Mon, Nov 22, 2021 at 3:56 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Mon, Nov 22, 2021 at 10:30:12AM +0800, Jason Wang wrote:
> > On Fri, Nov 19, 2021 at 11:09 AM Parav Pandit <parav@nvidia.com> wrote:
> > >
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Friday, November 19, 2021 8:12 AM
> > > >
> > > > On Thu, Nov 18, 2021 at 1:58 PM Eli Cohen <elic@nvidia.com> wrote:
> > > > >
> > > > > Add support for querying virtqueue statistics. Supported statistics are:
> > > > >
> > > > > Received_desc - number of descriptors received for the virtqueue
> > > > > completed_desc - number of descriptors completed for the virtqueue
> > > > >
> > > > > A new callback was added to vdpa_config_ops which provides the means
> > > > > for the vdpa driver to return statistics results.
> > > > >
> > > > > The interface allows for reading all the supported virtqueues,
> > > > > including the control virtqueue if it exists, by returning the next
> > > > > queue index to query.
> > > > >
> > > > > Examples:
> > > > > 1. Read statisitics for the virtqueue at index 1 $ vdpa dev stats show
> > > > > vdpa-a index 1
> > > > > vdpa-a:
> > > > > index 1 tx received_desc 21 completed_desc 21
> > > > >
> > > > > 2. Read statisitics for all the virtqueues vdpa dev stats show vdpa-a
> > > > > vdpa-a:
> > > > > index 0 rx received_desc 256 completed_desc 12 index 1 tx
> > > > > received_desc 21 completed_desc 21 index 2 ctrl received_desc 0
> > > > > completed_desc 0
> > > >
> > > > Adding Adrian and Laurent.
> > > >
> > > > It's quite useful but I think it's vendor specific statistics.
> > > These are vdpa device specific of Linux.
> > > And are very generic of the VQ for all device types.
> >
> > The question is what happens if the parent doesn't implement those statistics.
> >
>
> Are you suggesting that some parents may support reporting a subeset of
> the fields and we should maybe indicate what is actually reported?

It's an open question. E.g do we want a stable API for the those
statistics counter? If yes, it's better to not to let the parents to
report a subset but then it forces the exact same counters to be
supported by other vendors. If not, it should be fine. For any case, I
think it's simpler to start with "vendor-stats" and we can switch it
to a standard way if it was agreed by every vendor.

>
> > >
> > > > I wonder if it's better
> > > > to use "vendor" prefix in the protocol, then we use this instead:
> > > >
> > > > vdpa dev vendor-stats show vdpa-a
> > > >
> > > May be. Lets evaluate if stats of this patch are generic enough or not.
> > >
> > > > Or if we want to make it standard is exposing virtio index better?
> > > >
> > > > qid 0 last_avail_idx X avail_idx Y last_used_idx M used_idx N
> > > >
> > > I did consider this option a while back. Shows indices are equally useful.
> > > I think we should show that as vq info, along with other VQ attributes (addr, len).
> >
> > That may work but it looks to me the receiced_desc/completed_desc is
> > also per vq.
> >
> > Another question is that is it more useful to use buffers instead of
> > descriptors? E.g how indirect descriptors are counted.
> >
>
> I think it's descriptors so indirect descriptors are counted once but I
> need to verify that.
>
> > > $ vdpa dev show vq
> > >
> > > But showing indices are not less statistics and more current state of the queue.
> > > For example roll over of the indices won't cover absolute number of descriptors processed for the queue.
> > > And even if we make them u64 (not good), non_developer end user needs to keep using side calculator to count the delta.
> >
> > How about exposing those raw indices via the protocol and letting the
> > vdpa tool calculate for us?
> >
>
> counters are 16 bit per the virtio spec so I don't know how you could
> handle rolover without losing information.

So at most 1 rollover I guess. So it's not hard by comparing the
indices. E.g the if last_avil_idx(device avail idx) > avail_idx, we
know there's one?

Thanks

>
> > Thanks
> >
> > >
> > > So I think useful q indices belong to q info.
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
