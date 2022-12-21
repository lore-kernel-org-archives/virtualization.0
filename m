Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE817C4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 06:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 671F9607F9;
	Wed, 21 Dec 2022 06:49:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 671F9607F9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B1D97BhZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KIxYpGrvl6jY; Wed, 21 Dec 2022 06:49:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 13F6E60743;
	Wed, 21 Dec 2022 06:49:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 13F6E60743
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E96D4C0077;
	Wed, 21 Dec 2022 06:49:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39338C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE4B981FEF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:49:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE4B981FEF
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=B1D97BhZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0CGBXOTbZOq8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:49:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F95081F97
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F95081F97
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671605343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+/4TAy3lxZDNq7ujOJb9FKrW+iCRhzmTxD7N7cv0eCg=;
 b=B1D97BhZQDFKR8JAuyPvYLnVRK106GoqHRZAeN17fouSFRzqSPjVx3+Qm20r7f3KcsKRAn
 E/7/jYGuuq1hXvGiTMudg8cohrnE0o1OBY6/hfTjBkByMVrwLsLIRdrSG3UbrnWFLZ0KOv
 Zejcce3bj4tn1sdZKGJxr7LtkP9aZxo=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-mr38Plu-ODOAZyHCtbn_mA-1; Wed, 21 Dec 2022 01:48:52 -0500
X-MC-Unique: mr38Plu-ODOAZyHCtbn_mA-1
Received: by mail-oo1-f72.google.com with SMTP id
 g6-20020a4a6b06000000b0049d1e5cd0cfso6530790ooc.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 22:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+/4TAy3lxZDNq7ujOJb9FKrW+iCRhzmTxD7N7cv0eCg=;
 b=J6tnVpu6g1c/5jeSvIbGFEc3WWGPYTsqAzbAwTrAvBexlMQN9CRXe3mWp3n4x0zyDi
 FINveh4xPsq/BL19Wz2PkZG6ca/xI/HJIpvbENVQVLUT2719V6d+nasoMKb8JQ/JLqho
 fRf84qMkXm+Tb97aCjYChnlgeibhUCrveopHsQSIqNFGDlbJO3BxlQeqB4tNTyeQtCTq
 89AbaI03RdS5oI7qIRH46QScMa3fuQLs1FUUjSNLeWvBR+8GMhFFk8xD1zc0c3wHyste
 1l0YgTv0r8y+9qRHc4wGxMAaPMNkZtklW/QsFCwCJIkj63eqO9YYfbrosGW8zJsAhbz/
 5bQg==
X-Gm-Message-State: AFqh2kqeb8x8GteiKaZNSkC12aZTdGlSgvMk1tFlPGDZjS5Cah0WwOAN
 CY2+dO3bXXtyOdlkorv8GIw+NuMB128OgvCbZQ2KuwAx2mjpvz4lD1GMrxnHVsf+iG/uzdv1Vul
 icM1fVttl2eibAhtsYnKG5VIFduqOzmPk7MOqs5TxbW2VZDmLZ+FpY1l7hQ==
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr29062oah.35.1671605331305; 
 Tue, 20 Dec 2022 22:48:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu80udxD6YrnxsV720q5HV+2HR8kMLdfBS0FZI0RkgPvpsYJe396SNLloD8Y2DlUjugZ1aCdXjvrEHubwRFXk0=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr29055oah.35.1671605331053; Tue, 20 Dec
 2022 22:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20221220140205.795115-1-lulu@redhat.com>
 <CACGkMEuJuUrA220XgHDOruK-aHWSfJ6mTaqNVQCAcOsPEwV91A@mail.gmail.com>
 <20221221013359-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221221013359-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 21 Dec 2022 14:48:40 +0800
Message-ID: <CACGkMEuXPoR_yp3ZC7XH4TZ8NdL21kWtJaxq22+VU7RQG13f8Q@mail.gmail.com>
Subject: Re: [PATCH] vhost_vdpa: fix the compile issue in commit 881ac7d2314f
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Wed, Dec 21, 2022 at 2:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Dec 21, 2022 at 11:23:09AM +0800, Jason Wang wrote:
> > On Tue, Dec 20, 2022 at 10:02 PM Cindy Lu <lulu@redhat.com> wrote:
> > >
> > > The input of  vhost_vdpa_iotlb_unmap() was changed in 881ac7d2314f,
> > > But some function was not changed while calling this function.
> > > Add this change
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 881ac7d2314f ("vhost_vdpa: fix the crash in unmap a large memory")
> >
> > Is this commit merged into Linus tree?
> >
> > Btw, Michael, I'd expect there's a respin of the patch so maybe Cindy
> > can squash the fix into the new version?
> >
> > Thanks
>
> Thanks, I fixed it myself already. Why do you want a respin?

For some reason I miss v4, so it should be fine.

Thanks

> That will mean trouble as the fixed patch is now being tested.
>
>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vhost/vdpa.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index 46ce35bea705..ec32f785dfde 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -66,8 +66,8 @@ static DEFINE_IDA(vhost_vdpa_ida);
> > >  static dev_t vhost_vdpa_major;
> > >
> > >  static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v,
> > > -                                  struct vhost_iotlb *iotlb,
> > > -                                  u64 start, u64 last);
> > > +                                  struct vhost_iotlb *iotlb, u64 start,
> > > +                                  u64 last, u32 asid);
> > >
> > >  static inline u32 iotlb_to_asid(struct vhost_iotlb *iotlb)
> > >  {
> > > @@ -139,7 +139,7 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
> > >                 return -EINVAL;
> > >
> > >         hlist_del(&as->hash_link);
> > > -       vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1);
> > > +       vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
> > >         kfree(as);
> > >
> > >         return 0;
> > > --
> > > 2.34.3
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
