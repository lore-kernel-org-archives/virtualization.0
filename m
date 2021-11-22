Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED22C433EF
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 09:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45A5E80EFD;
	Mon, 22 Nov 2021 09:32:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gP7fmuJdTQ0w; Mon, 22 Nov 2021 09:32:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0EF9680E09;
	Mon, 22 Nov 2021 09:32:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9CBFC001E;
	Mon, 22 Nov 2021 09:32:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2965DC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 09:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F0DB8607EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 09:32:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nmwHK2k-rYqf
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 09:32:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E36906065D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 09:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637573523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wEGAPIyjfJ/xAaTU9Mpo8ee/Y5CpbkmYFZxubTpkolo=;
 b=DnOAJ6acNnKPMq/lSj9Ig4MR+v7FF/9hynZxnJ7Rzm3eXtoD8k9LI3EcwDiFlqGLQELOYF
 eW5+xEfOBXTOWFB3D0mNzizeRtyqsmpBHDotaZw+I3KMyigWxusFVmF7m0QKLWhxfB7avL
 0Q6giwYr9r9gsNxVNK0T93ueqXFHj+E=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-nKdJhzLvP36ruN5tg5k8pQ-1; Mon, 22 Nov 2021 04:32:02 -0500
X-MC-Unique: nKdJhzLvP36ruN5tg5k8pQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 c14-20020a056512104e00b004036d17f91bso11769709lfb.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 01:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wEGAPIyjfJ/xAaTU9Mpo8ee/Y5CpbkmYFZxubTpkolo=;
 b=IYNo10/FlFASodWbbVG5PJAjIIaad/YQCnz2b5gcVG8b7Qw0s8MeQIa15/8cx8hgBT
 N23xX/jviFUR+Vwi94MaH5f7oxjbN6kpnvI6Xgehg0kADxLU/MagGA8Rj0EmiQex20PW
 3DS1ElX3XwPNKi8/XeZ4MM5/dJ96NqXrHZ/+9kSPd+EU7697GCT0iCykNuX2ziDwttE1
 lX3PEVgO1rmK1GTDZNQZz3sRzG9ajJ8/vGf/IX05BuAWB2kxutuj/JiNAj/048vXy7LR
 DWZUJMaxzzNev68nEv7xjTueWhyxTvDhDcKLTpViomxp6CcE6GUleOfCAaHzYAwReLqE
 n0Vw==
X-Gm-Message-State: AOAM530mz9qgMstKFCr4C8pzGaxV79V6nPfJZUq+X4n4NYW6vEHjjVWL
 UaIaLScHIZLN64c1XpbIlOyP0w2lhK4ZiYfTBREVwggjWHF+9Tc9LTiOgPpwdmzXg6756eXUsF/
 R6hr1iTmuu3WDIv9OdqZE1OCbU3hL8VveS3du3QQPqcsyopRkqMZV2LTVwQ==
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr56916928lfe.84.1637573520785; 
 Mon, 22 Nov 2021 01:32:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5+sLpM+j3uHRqnfTpnPsJ7FvGfJAv1+vc5Poi/B8qPk0z7tgPfqKJRovv9i6mo6SVzUkVIQ6VoWf5OVPQpr0=
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr56916897lfe.84.1637573520444; 
 Mon, 22 Nov 2021 01:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20211118055741.239639-1-elic@nvidia.com>
 <20211118055741.239639-2-elic@nvidia.com>
 <CACGkMEsDHKCTSHtLBp3Pr0wntgYzsSBNjCNjQjGkmk2iap80rg@mail.gmail.com>
 <PH0PR12MB548187F4DE8C789908839F9DDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEssVx-quDa+c7wYAyB6a3j88EBAYTW+y8e_FcxW2mA1nQ@mail.gmail.com>
 <20211122075615.GB74340@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEs0mCKV4iF=O7Psxip38tL5iiu92Kzj_LqLgTqXV-M+NA@mail.gmail.com>
 <20211122090755.GA75489@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211122090755.GA75489@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Nov 2021 17:31:49 +0800
Message-ID: <CACGkMEtMB78O7K5E+dV6M7_K3U1fOV_8Q7pArD05THVWszjZKg@mail.gmail.com>
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

On Mon, Nov 22, 2021 at 5:08 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Mon, Nov 22, 2021 at 04:07:24PM +0800, Jason Wang wrote:
> > On Mon, Nov 22, 2021 at 3:56 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > On Mon, Nov 22, 2021 at 10:30:12AM +0800, Jason Wang wrote:
> > > > On Fri, Nov 19, 2021 at 11:09 AM Parav Pandit <parav@nvidia.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > Sent: Friday, November 19, 2021 8:12 AM
> > > > > >
> > > > > > On Thu, Nov 18, 2021 at 1:58 PM Eli Cohen <elic@nvidia.com> wrote:
> > > > > > >
> > > > > > > Add support for querying virtqueue statistics. Supported statistics are:
> > > > > > >
> > > > > > > Received_desc - number of descriptors received for the virtqueue
> > > > > > > completed_desc - number of descriptors completed for the virtqueue
> > > > > > >
> > > > > > > A new callback was added to vdpa_config_ops which provides the means
> > > > > > > for the vdpa driver to return statistics results.
> > > > > > >
> > > > > > > The interface allows for reading all the supported virtqueues,
> > > > > > > including the control virtqueue if it exists, by returning the next
> > > > > > > queue index to query.
> > > > > > >
> > > > > > > Examples:
> > > > > > > 1. Read statisitics for the virtqueue at index 1 $ vdpa dev stats show
> > > > > > > vdpa-a index 1
> > > > > > > vdpa-a:
> > > > > > > index 1 tx received_desc 21 completed_desc 21
> > > > > > >
> > > > > > > 2. Read statisitics for all the virtqueues vdpa dev stats show vdpa-a
> > > > > > > vdpa-a:
> > > > > > > index 0 rx received_desc 256 completed_desc 12 index 1 tx
> > > > > > > received_desc 21 completed_desc 21 index 2 ctrl received_desc 0
> > > > > > > completed_desc 0
> > > > > >
> > > > > > Adding Adrian and Laurent.
> > > > > >
> > > > > > It's quite useful but I think it's vendor specific statistics.
> > > > > These are vdpa device specific of Linux.
> > > > > And are very generic of the VQ for all device types.
> > > >
> > > > The question is what happens if the parent doesn't implement those statistics.
> > > >
> > >
> > > Are you suggesting that some parents may support reporting a subeset of
> > > the fields and we should maybe indicate what is actually reported?
> >
> > It's an open question. E.g do we want a stable API for the those
> > statistics counter? If yes, it's better to not to let the parents to
> > report a subset but then it forces the exact same counters to be
> > supported by other vendors. If not, it should be fine. For any case, I
> > think it's simpler to start with "vendor-stats" and we can switch it
> > to a standard way if it was agreed by every vendor.
> >
>
> received and completed descriptors are very basic and I assume any
> vendor would support those.

At least it was not supported by virtio.

> If we go with vendor stats, how can we
> communicate the information to userspace? Currenlty we use netlink
> attributes defined to pass this information.

It can be done exactly as what have been done in the patch, we can
document it as vendor stats.

>
> > >
> > > > >
> > > > > > I wonder if it's better
> > > > > > to use "vendor" prefix in the protocol, then we use this instead:
> > > > > >
> > > > > > vdpa dev vendor-stats show vdpa-a
> > > > > >
> > > > > May be. Lets evaluate if stats of this patch are generic enough or not.
> > > > >
> > > > > > Or if we want to make it standard is exposing virtio index better?
> > > > > >
> > > > > > qid 0 last_avail_idx X avail_idx Y last_used_idx M used_idx N
> > > > > >
> > > > > I did consider this option a while back. Shows indices are equally useful.
> > > > > I think we should show that as vq info, along with other VQ attributes (addr, len).
> > > >
> > > > That may work but it looks to me the receiced_desc/completed_desc is
> > > > also per vq.
> > > >
> > > > Another question is that is it more useful to use buffers instead of
> > > > descriptors? E.g how indirect descriptors are counted.
> > > >
> > >
> > > I think it's descriptors so indirect descriptors are counted once but I
> > > need to verify that.
> > >
> > > > > $ vdpa dev show vq
> > > > >
> > > > > But showing indices are not less statistics and more current state of the queue.
> > > > > For example roll over of the indices won't cover absolute number of descriptors processed for the queue.
> > > > > And even if we make them u64 (not good), non_developer end user needs to keep using side calculator to count the delta.
> > > >
> > > > How about exposing those raw indices via the protocol and letting the
> > > > vdpa tool calculate for us?
> > > >
> > >
> > > counters are 16 bit per the virtio spec so I don't know how you could
> > > handle rolover without losing information.
> >
> > So at most 1 rollover I guess. So it's not hard by comparing the
> > indices. E.g the if last_avil_idx(device avail idx) > avail_idx, we
> > know there's one?
> >
>
> I am not sure I am following you. You do query twice. You can never know
> how many rounds the virtqueue has gone through so the information is
> useless.

Ok, I think I get you. So I wonder if it's more useful to use device
specific counters. For networking, it could be packets send/received
etc.

Thanks

>
> > Thanks
> >
> > >
> > > > Thanks
> > > >
> > > > >
> > > > > So I think useful q indices belong to q info.
> > > > >
> > > >
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
