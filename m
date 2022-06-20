Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFC3C43334
	for <virtualization@archiver.kernel.org>; Mon, 20 Jun 2022 09:25:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9866040AE0;
	Mon, 20 Jun 2022 09:25:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9866040AE0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CaYWiEGL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MdkKFDG69aqs; Mon, 20 Jun 2022 09:25:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2832E40AD0;
	Mon, 20 Jun 2022 09:25:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2832E40AD0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF201C0039;
	Mon, 20 Jun 2022 09:25:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3689C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 09:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6C9840AD6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 09:25:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B6C9840AD6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JvPJw9oqgmeE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 09:25:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F384640AD0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F384640AD0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 09:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655717144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Km8BdY6syMUyW+TQs1owXDRqFBk5bezOw4dqCatn4M=;
 b=CaYWiEGLQhWpwUrfi8fBtXI2PVXvvvVinulSqo1unUZQzLzBJhE8n/0fMCRjcb6E9aIZH5
 Qk2GAG2K5qgUHQ4SDGEVIKlvzmeqAGVbr+ZheH7stsosiAUWJFI1AlRYlqGcm6MPb5hQpn
 yfEyhVltUepmrXcOv6Nsn3eVYVzwfn0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-5Y8_F643O8uwTa5EBz1EtQ-1; Mon, 20 Jun 2022 05:25:41 -0400
X-MC-Unique: 5Y8_F643O8uwTa5EBz1EtQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 n5-20020a0565120ac500b0047da8df6b2cso5253890lfu.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 02:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3Km8BdY6syMUyW+TQs1owXDRqFBk5bezOw4dqCatn4M=;
 b=0rXw+5GjYQvhgMWkSjOZA3QEf7eB8vFv/hOwtf5kqziVRvlSb5NfC5x1CZMZindBEb
 uqjNQbTxprDAfnIYf5LBBdKxKHnG8dO0OQbP3YL+RMi/39HqOz7waEYAHeghk6Gtseaw
 sUHfc8WEjsE++2SWB+76k3Es2tIObwNT71RpVs6Q9okZsVPgW3tToREvfi6DEc+vkSll
 Ud8CWJmY3eqM9T82CUCAxrRHweXdOTH+/lwAiglVlotqwLd7t67y44r2tM+/6plKzoa9
 fnY6x10nq2KIwbEWJ6fsgBfqks3pMyv0+sxVD436OL0XL0JoDqgH2OVxazHMv0OglFuT
 mPsg==
X-Gm-Message-State: AJIora9ZDiPbecT2ksvwMSyeSvMqVmID8hUDQtse9qo+TiWfuKEfUo9H
 AQAGF5OlTESxtv4ZzwieFWF7xgobxE760UM/rE9aGvw8gH7WuFSuGudkBO8V1WxKFsPn/A6NcQB
 0HFah3lV3HHuEVhywL+ayFuw/5ru7qIfvZqnk5NY6NVpZKnXPUwbmiv0EpQ==
X-Received: by 2002:a2e:b014:0:b0:25a:6d17:c3c8 with SMTP id
 y20-20020a2eb014000000b0025a6d17c3c8mr2735618ljk.487.1655717139627; 
 Mon, 20 Jun 2022 02:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vBEi+n5krzXVaf2jd3wQPENci1goWGuntoOCdnba+ClrpW4vgwcFjgUeRTTbnzYI/3wnTN7jcATEGI3PJbBpg=
X-Received: by 2002:a2e:b014:0:b0:25a:6d17:c3c8 with SMTP id
 y20-20020a2eb014000000b0025a6d17c3c8mr2735606ljk.487.1655717139443; Mon, 20
 Jun 2022 02:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com>
 <20220616132725.50599-4-elic@nvidia.com>
 <CACGkMEsc+MCsRq6aA1vLXE3OJ0buX-0g73qaz72Px-ismfMKLA@mail.gmail.com>
 <CAJaqyWdnuX0KLu7j3M4ovtW=N5kFObgaU3z2hu4xoRXY5Fk+aQ@mail.gmail.com>
In-Reply-To: <CAJaqyWdnuX0KLu7j3M4ovtW=N5kFObgaU3z2hu4xoRXY5Fk+aQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Jun 2022 17:25:28 +0800
Message-ID: <CACGkMEsKzS==HQC8C-Pf+7T7rcsg0cHjXEw2tmhFrjjUCQy6UA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] vdpa/mlx5: Disable VLAN support to support live
 migration
To: Eugenio Perez Martin <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
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

On Mon, Jun 20, 2022 at 5:02 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Jun 20, 2022 at 10:48 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Jun 16, 2022 at 9:28 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Current qemu code does not support live migration for devices supporting
> > > VLAN. Disable it.
> >
> > This looks like a bug that we need to fix in Qemu.
> >
>
> Not a but, but a lack of a feature :). Each cvq command needs new code
> to inject it at the destination, and only set mac cmd is implemented
> at the moment. Only to start simple.

I think we don't need this in the formal patch? (Anyhow we could
disable ctrl vlan vic command line)

Thanks

>
> Thanks!
>
> > Thanks
> >
> > >
> > > Note: this patch is provided just to enable testing with current qemu.
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 34bd81cb697c..1568cfdf07e6 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -2172,7 +2172,6 @@ static u64 get_supported_features(struct mlx5_core_dev *mdev)
> > >         mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MQ);
> > >         mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
> > >         mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MTU);
> > > -       mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_CTRL_VLAN);
> > >
> > >         return mlx_vdpa_features;
> > >  }
> > > --
> > > 2.35.1
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
