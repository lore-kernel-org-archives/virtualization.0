Return-Path: <SRS0=Mdyx=DN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E424AC41604
	for <virtualization@archiver.kernel.org>; Tue,  6 Oct 2020 06:22:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B74F206DD
	for <virtualization@archiver.kernel.org>; Tue,  6 Oct 2020 06:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfhLJYnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B74F206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EFDEF86C66;
	Tue,  6 Oct 2020 06:22:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0TNA2sJWcGz1; Tue,  6 Oct 2020 06:22:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 798C486BB4;
	Tue,  6 Oct 2020 06:22:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C2D1C016F;
	Tue,  6 Oct 2020 06:22:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C16B4C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 06:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9E27B2011B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 06:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lipkt6B-EsqP
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 06:22:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 5654E2010D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 06:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601965343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cABuv5tFxr+o7caWDmev7YzIrHPEZqeTI2swVLejHzc=;
 b=BfhLJYnf8ukMkQocxyxef+lefAoQzXdoTTcmCn501GCBkLlNbXdc4Ec8RXa6hVvx6R1FLq
 wrLvf6BcqUCI6umKRh+0dvZO0uPy4uct5+6N6TFSsEpl0ZHCQHjsCB8/6EmD8aFUujEWbT
 XVOEWR5hcDDby3YOcqmHwb4DLjZLohA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-BpFC7IZfMJC1L5bnWxrCxw-1; Tue, 06 Oct 2020 02:22:21 -0400
X-MC-Unique: BpFC7IZfMJC1L5bnWxrCxw-1
Received: by mail-wr1-f71.google.com with SMTP id c6so3982039wrt.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Oct 2020 23:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cABuv5tFxr+o7caWDmev7YzIrHPEZqeTI2swVLejHzc=;
 b=o5fRNeasNmgsJTHGK+078a+Ff8OBdrRuxMUI9PKi/qVImqs4wnS/jzqEnh5BCW3/Cz
 OzXraDwQIqLskN0VW34ebbKB9rYWmaakRWKZiuNb2hn3JvC1x0sYvT5AiLqS2vE9YPRY
 5LtC7HakU3WAFTTNF9e22Y9oQuNIUbFMgf+4J3KDrVDbzjkL9kA2YKTG8ANov5Dd6zny
 jE5m1gcaJ08ysgLzPlRqU96sFvmZiU/diqzrMB58IeiEAhGiNp19kRVaws4e48Vwsa1R
 m/aexdmKBk6tSzxRNK25aQNtVfUYGKgj4kgUWrrYZHj84OMJjpPhWhWBlMT95ywv5LfM
 5MVA==
X-Gm-Message-State: AOAM532ntI8QJ0ZC7UVYF65f3I6URwBgs+Dw3JUAV9dJ/FqWFsUe6HfI
 bthTQRgrscmsbGA0U20wt5v8OYX+B0y/X2ybJdYQyaKbCy4/yN6v521U2w9rrUGRj9LkJY1Aoh9
 fatY1gt7LpXTjkHoM/wIEKuGfnRUYVg4Sx4k3FVFF/g==
X-Received: by 2002:a1c:6341:: with SMTP id x62mr2960289wmb.70.1601965339970; 
 Mon, 05 Oct 2020 23:22:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2gvNV1LSmLX/+VDO4Yf2Zjs3i0Rf5UDSyb4S9V6nUVLErBUxWwCSSzaYv4MAqhHcHl83azg==
X-Received: by 2002:a1c:6341:: with SMTP id x62mr2960267wmb.70.1601965339738; 
 Mon, 05 Oct 2020 23:22:19 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id g83sm2388409wmf.15.2020.10.05.23.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 23:22:18 -0700 (PDT)
Date: Tue, 6 Oct 2020 02:22:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <siwliu.kernel@gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: should keep avail_index despite device status
Message-ID: <20201006022133-mutt-send-email-mst@kernel.org>
References: <1601583511-15138-1-git-send-email-si-wei.liu@oracle.com>
 <CAPWQSg1y8uvpiwxxp_ONGFs8GeuOY09q3AShfLCmhv77ePma-Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPWQSg1y8uvpiwxxp_ONGFs8GeuOY09q3AShfLCmhv77ePma-Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Si-Wei Liu <si-wei.liu@oracle.com>,
 boris.ostrovsky@oracle.com, elic@nvidia.com
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

On Fri, Oct 02, 2020 at 01:17:00PM -0700, Si-Wei Liu wrote:
> + Eli.
> 
> On Thu, Oct 1, 2020 at 2:02 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >
> > A VM with mlx5 vDPA has below warnings while being reset:
> >
> > vhost VQ 0 ring restore failed: -1: Resource temporarily unavailable (11)
> > vhost VQ 1 ring restore failed: -1: Resource temporarily unavailable (11)
> >
> > We should allow userspace emulating the virtio device be
> > able to get to vq's avail_index, regardless of vDPA device
> > status. Save the index that was last seen when virtq was
> > stopped, so that userspace doesn't complain.
> >
> > Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Eli can you review this pls? I need to send a pull request to Linux by
tomorrow - do we want to include this?

> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 70676a6..74264e59 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -1133,15 +1133,17 @@ static void suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *m
> >         if (!mvq->initialized)
> >                 return;
> >
> > -       if (query_virtqueue(ndev, mvq, &attr)) {
> > -               mlx5_vdpa_warn(&ndev->mvdev, "failed to query virtqueue\n");
> > -               return;
> > -       }
> >         if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY)
> >                 return;
> >
> >         if (modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND))
> >                 mlx5_vdpa_warn(&ndev->mvdev, "modify to suspend failed\n");
> > +
> > +       if (query_virtqueue(ndev, mvq, &attr)) {
> > +               mlx5_vdpa_warn(&ndev->mvdev, "failed to query virtqueue\n");
> > +               return;
> > +       }
> > +       mvq->avail_idx = attr.available_index;
> >  }
> >
> >  static void suspend_vqs(struct mlx5_vdpa_net *ndev)
> > @@ -1411,8 +1413,14 @@ static int mlx5_vdpa_get_vq_state(struct vdpa_device *vdev, u16 idx, struct vdpa
> >         struct mlx5_virtq_attr attr;
> >         int err;
> >
> > -       if (!mvq->initialized)
> > -               return -EAGAIN;
> > +       /* If the virtq object was destroyed, use the value saved at
> > +        * the last minute of suspend_vq. This caters for userspace
> > +        * that cares about emulating the index after vq is stopped.
> > +        */
> > +       if (!mvq->initialized) {
> > +               state->avail_index = mvq->avail_idx;
> > +               return 0;
> > +       }
> >
> >         err = query_virtqueue(ndev, mvq, &attr);
> >         if (err) {
> > --
> > 1.8.3.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
