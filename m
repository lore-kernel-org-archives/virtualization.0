Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47AFC433F5
	for <virtualization@archiver.kernel.org>; Wed, 12 Jan 2022 02:38:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D56460EA7;
	Wed, 12 Jan 2022 02:38:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v7zjV7C87dRO; Wed, 12 Jan 2022 02:38:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0A2D560D6B;
	Wed, 12 Jan 2022 02:38:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7C09C002F;
	Wed, 12 Jan 2022 02:38:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1821C001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B215583F10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:38:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K1xcDHDQwQrE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:38:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1C7EB829FD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641955132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V7wBQ6/y8v8Pbe8bphOeqToT6Pta2d8c2AvTNBh3pnY=;
 b=XOufPeZGkNDvCwHQbsvDZnOJMLImwYf2FB21uOKs6xwIRApXPw0E1p+2jVLZtAz+rMmsDA
 t83wUvl3uOAohHU0MFmZyrtOfssuUoCjccTz237PMzoQiwuLE/tZz7EprFYJLmL8UuWZhW
 ioYjzTQKqDi2vYvYIIKmDZHtd149Z6s=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-ekHiJbIgP-WQucJwjfktBA-1; Tue, 11 Jan 2022 21:38:51 -0500
X-MC-Unique: ekHiJbIgP-WQucJwjfktBA-1
Received: by mail-lf1-f69.google.com with SMTP id
 d25-20020a194f19000000b0042b469bd916so627406lfb.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 18:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V7wBQ6/y8v8Pbe8bphOeqToT6Pta2d8c2AvTNBh3pnY=;
 b=DCpPviLrlzEOADNoNehE6n7e+XMzbLCgEkkgG3+M/23RXdtQc4fO2wn/VXd0Y5eT6r
 vxOF65BUMTqWYsmTPmSabQSY0PlKjkGoi9Q7jgqWdGWN6UIizMZdjQTJHOPhCQRC/2tJ
 hubUpP64pqc3AFLxQjaewUD+e+MzB4LbIycHiv7o0VUEVeGxerXrqaSFxr2wIMMsUes2
 N9ympBTk4hYRpGY3kszfhy3d2a0BPLCofff5iCMTVZ8J5VcEaEln+RbIK9inhdpPS0+z
 04FaPKUrTQm9CfXXjVwMHTjVBOBcOj8RcQT2UhzP9bwRhDF4+tZFnBQL8U6pLH5iA0ys
 6Y5A==
X-Gm-Message-State: AOAM533rlwmYFo/exdLRqhTHWNHWxV7TQx8gvLTUGxWx2N5l8embS+qW
 /SfPySxGvov2rD0jNKhcI21OhlbFcsyCkEbGeBo6bxCPP5svTB9Ikqr6qenthyG6e8Yt/dJRe40
 ec0qATSzYZcDoO6kBDNWD48geVE7uEuBXwkpA+y4rAW8a4LZYkg8fdkjbOw==
X-Received: by 2002:a05:6512:3d24:: with SMTP id
 d36mr3424968lfv.481.1641955129476; 
 Tue, 11 Jan 2022 18:38:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1zxtwQvam7h8sVQV4Lh1Si1FlHIphcnrg1u959jGJhDTgb5wYwYFRvQTDXd/a5RoZqZ6h5VCM+QpHqgKzjLI=
X-Received: by 2002:a05:6512:3d24:: with SMTP id
 d36mr3424955lfv.481.1641955129325; 
 Tue, 11 Jan 2022 18:38:49 -0800 (PST)
MIME-Version: 1.0
References: <20220111072253.101884-1-elic@nvidia.com>
 <00619365-173b-bd2c-3a9f-c6d7084631fb@oracle.com>
 <20220111070943-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220111070943-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jan 2022 10:38:37 +0800
Message-ID: <CACGkMEt5d70rempLzzYSMDKXVj9TE5kftPgH5r+PN+Hs7LXG+w@mail.gmail.com>
Subject: Re: [PATCH 2/4] vdpa/mlx5: Fix is_index_valid() to refer to features
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Eli Cohen <elic@nvidia.com>
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

On Tue, Jan 11, 2022 at 8:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jan 11, 2022 at 01:31:28AM -0800, Si-Wei Liu wrote:
> >
> >
> > On 1/10/2022 11:22 PM, Eli Cohen wrote:
> > > Make sure the decision whether an index received trough a callback is
> > > valid or not consults the negotiated features.
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
> >
> > Is there more for this series? Subject says there're 4 patches in total?
>
> OK so with this + 1/4 are we OK with v7 of the big patchset now?
> I'm kind of beginning to worry it's rushed ...
> Jason?

With Eli's new series [PATCH 0/4] Fixes to confing max virtqueues series

We are almost fine, Siwei promise to post other minor issues if necessary.

Thanks

>
>
> > > ---
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++++---
> > >   1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index d1ff65065fb1..9eacfdb48434 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -133,10 +133,14 @@ struct mlx5_vdpa_virtqueue {
> > >   static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
> > >   {
> > > -   if (unlikely(idx > mvdev->max_idx))
> > > -           return false;
> > > +   if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> > > +           if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > > +                   return idx < 2;
> > > +           else
> > > +                   return idx < 3;
> > > +   }
> > > -   return true;
> > > +   return idx <= mvdev->max_idx;
> > >   }
> > >   struct mlx5_vdpa_net {
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
