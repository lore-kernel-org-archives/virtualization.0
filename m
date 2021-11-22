Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEA1C433F5
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 02:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6241B4017D;
	Mon, 22 Nov 2021 02:30:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XU8RQUt_EZW1; Mon, 22 Nov 2021 02:30:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0B12A400C1;
	Mon, 22 Nov 2021 02:30:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFC97C001E;
	Mon, 22 Nov 2021 02:30:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0259AC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 02:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E500B60705
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 02:30:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lKjl7CDnbrE4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 02:30:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8029D60699
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 02:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637548226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K8J69C4T28MX5CXE+qKZETHOoOB04HN3aASQmzfrRxc=;
 b=JoWGkfSmI12ICXJo8R2Dbs4M7WY9sDjKmsbyCeUOx2Q9MiwxIqOZZapVnTvMCcKSKMLlcg
 YLPNQw5Cv+WRRaH+5Y4Wn5lJ+bINI714+JUdxH0Gtv3tBjeEdTj+4QMqOaybaiJVYSkbGp
 zWV7Yl00Xn2SZApjRQb7vHtCEYJ9cnY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-eGTVDdpLNZWeb59wM4Leag-1; Sun, 21 Nov 2021 21:30:25 -0500
X-MC-Unique: eGTVDdpLNZWeb59wM4Leag-1
Received: by mail-lf1-f69.google.com with SMTP id
 c40-20020a05651223a800b004018e2f2512so11009084lfv.11
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 18:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K8J69C4T28MX5CXE+qKZETHOoOB04HN3aASQmzfrRxc=;
 b=3HitrKoyF4bbqrMxRYLN2MycCdSddiWD3rYiOAbnHKI7fBL89gHsyX5DqKEQuHjvVJ
 R0lo3SDhfkgFmzgHoHHhSACsmUZdO8u8QTMMCChHD4atEg19Glyntydm+Fh1Dof37+vH
 BHRnYb+GfZ2nlRZT559vea/0WB2QbdRs5VUo5zmWQc0J4hQM3Vblx88IGWLWIp6EEe2m
 Vc5zJsIhd/OQ/c7zFt6DLA8QYbhKfXQY0dEJD3rkm7YGavNFlri6Os8McDGBbtAc/rkI
 PIQ/MG1grqwsz7UoVQVVWRAdHK7PeWtrfxCrl3Hj77Nikxa6IazYyuzVXaNmtc6xSTZz
 VEWA==
X-Gm-Message-State: AOAM530uaUWfjkwF8Pr3BnKsdAw+6Go2+TlWSYniZhqpkZM/v0lPSPYG
 vwJRw/hUFGqFldyPLIjeQvwB0T6Ezx2ECvZ/Xyk3YoQJFczvgujHWfRRrlAbsPpogYdNi8fewaN
 l2J+hlwixMVeLBJD8M3vW44AQ0WWOU6t0eo8Hh6ahHYWyE4AweHbrbQmDgg==
X-Received: by 2002:a05:6512:2081:: with SMTP id
 t1mr54791910lfr.348.1637548223451; 
 Sun, 21 Nov 2021 18:30:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziUwTo3kWEgqPtsEbR+IMYwTtVDv7DT1lwX4gkd/A1Mo6t1MYqM7vicOxKf4fnehy+GetdDi/DHIf25WR5lJY=
X-Received: by 2002:a05:6512:2081:: with SMTP id
 t1mr54791888lfr.348.1637548223246; 
 Sun, 21 Nov 2021 18:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20211118055741.239639-1-elic@nvidia.com>
 <20211118055741.239639-2-elic@nvidia.com>
 <CACGkMEsDHKCTSHtLBp3Pr0wntgYzsSBNjCNjQjGkmk2iap80rg@mail.gmail.com>
 <PH0PR12MB548187F4DE8C789908839F9DDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548187F4DE8C789908839F9DDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Nov 2021 10:30:12 +0800
Message-ID: <CACGkMEssVx-quDa+c7wYAyB6a3j88EBAYTW+y8e_FcxW2mA1nQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: Add support for querying statistics
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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

On Fri, Nov 19, 2021 at 11:09 AM Parav Pandit <parav@nvidia.com> wrote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Friday, November 19, 2021 8:12 AM
> >
> > On Thu, Nov 18, 2021 at 1:58 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Add support for querying virtqueue statistics. Supported statistics are:
> > >
> > > Received_desc - number of descriptors received for the virtqueue
> > > completed_desc - number of descriptors completed for the virtqueue
> > >
> > > A new callback was added to vdpa_config_ops which provides the means
> > > for the vdpa driver to return statistics results.
> > >
> > > The interface allows for reading all the supported virtqueues,
> > > including the control virtqueue if it exists, by returning the next
> > > queue index to query.
> > >
> > > Examples:
> > > 1. Read statisitics for the virtqueue at index 1 $ vdpa dev stats show
> > > vdpa-a index 1
> > > vdpa-a:
> > > index 1 tx received_desc 21 completed_desc 21
> > >
> > > 2. Read statisitics for all the virtqueues vdpa dev stats show vdpa-a
> > > vdpa-a:
> > > index 0 rx received_desc 256 completed_desc 12 index 1 tx
> > > received_desc 21 completed_desc 21 index 2 ctrl received_desc 0
> > > completed_desc 0
> >
> > Adding Adrian and Laurent.
> >
> > It's quite useful but I think it's vendor specific statistics.
> These are vdpa device specific of Linux.
> And are very generic of the VQ for all device types.

The question is what happens if the parent doesn't implement those statistics.

>
> > I wonder if it's better
> > to use "vendor" prefix in the protocol, then we use this instead:
> >
> > vdpa dev vendor-stats show vdpa-a
> >
> May be. Lets evaluate if stats of this patch are generic enough or not.
>
> > Or if we want to make it standard is exposing virtio index better?
> >
> > qid 0 last_avail_idx X avail_idx Y last_used_idx M used_idx N
> >
> I did consider this option a while back. Shows indices are equally useful.
> I think we should show that as vq info, along with other VQ attributes (addr, len).

That may work but it looks to me the receiced_desc/completed_desc is
also per vq.

Another question is that is it more useful to use buffers instead of
descriptors? E.g how indirect descriptors are counted.

> $ vdpa dev show vq
>
> But showing indices are not less statistics and more current state of the queue.
> For example roll over of the indices won't cover absolute number of descriptors processed for the queue.
> And even if we make them u64 (not good), non_developer end user needs to keep using side calculator to count the delta.

How about exposing those raw indices via the protocol and letting the
vdpa tool calculate for us?

Thanks

>
> So I think useful q indices belong to q info.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
