Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA2CC7EE2E
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 18:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A627E401CC;
	Thu,  8 Jun 2023 18:35:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A627E401CC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hwQbDVor
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c3_DgPenRTGZ; Thu,  8 Jun 2023 18:35:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E3B2417D5;
	Thu,  8 Jun 2023 18:35:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E3B2417D5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77859C0037;
	Thu,  8 Jun 2023 18:35:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CADFEC0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 18:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E4EF42029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 18:35:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E4EF42029
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hwQbDVor
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oGCcxAXj9UOh
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 18:35:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA3F842025
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA3F842025
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 18:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686249310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2bQcHG+zKEW1dxMHjPekLRCcGESsdy0BSM0jY0k8Cc=;
 b=hwQbDVor8XKgG0xx9aQDhZP8Df6yB4shQMbuQLYMpled/0iEBo6ijoCCrmB3evySB6GqTL
 w7QYs6YI3m/v8qsHLPzyJ/DBxPS2soBbTkKWWXMvdwXyTzLLlcqhApZd1kMBzpWTLldegc
 ciXYxS2oT/jtZH16MDKsUDSKqg9FkLo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-JyPu3deaN4-_uk3VMQ1R5g-1; Thu, 08 Jun 2023 14:35:09 -0400
X-MC-Unique: JyPu3deaN4-_uk3VMQ1R5g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30c5d31b567so420865f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 11:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686249308; x=1688841308;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a2bQcHG+zKEW1dxMHjPekLRCcGESsdy0BSM0jY0k8Cc=;
 b=DOX1/D5rd4ZHo4VpmtP1vvPIOAWYT27vMFxRVufmACl/PPRC0BZ6C9KMWSTGskm0+Y
 V2C+cZ31RLGcwB3kO0JxKbcA0noqx3+fWx4ctAVmo+nrxrIGRPbdM9T+xLpnjOUCopb8
 Tm4Q5NXBI+eL1fjhYpJL1/rnlk1U/+GvGUzpVRDgNoWjZ38xNc7RtAnF8DQolT0Gc3MR
 QaK6H8Kbis8wOV7ZbdR7e+c28XpyqC+OXTdvnwHmj9wo7Bxfj62XuRKFFaHExq0DzN3J
 gyylwjGIyTuU0QKex6aka8sXscnXo0vv5kqt3m8M+FXsVNTt8zlvdUwFYXfyhdcI5FQC
 +3Bg==
X-Gm-Message-State: AC+VfDzG763895WUQpM5PO+6omob8Upccr2/SAK0LjVWQT4Yo4BkjWr5
 gyONvJSrXE1D4jfxS+hyHPjflMuaxOnrYM0lSESF4a1INe65Z3Mq2ftmUXfH5A4kPJxbRxiaUxb
 Biwv3FqTMeQLrzNIx2kWoW+IzKrX1NrtMUN3RzR93Bg==
X-Received: by 2002:a5d:408b:0:b0:30a:e675:7e92 with SMTP id
 o11-20020a5d408b000000b0030ae6757e92mr6996784wrp.24.1686249307974; 
 Thu, 08 Jun 2023 11:35:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ebde3/2zvOHcahGfGkNtXLeveVr4UNWK45EvEkw55IL0kPC4bYFpc4NDrXh0K7WqjuxGaMQ==
X-Received: by 2002:a5d:408b:0:b0:30a:e675:7e92 with SMTP id
 o11-20020a5d408b000000b0030ae6757e92mr6996773wrp.24.1686249307738; 
 Thu, 08 Jun 2023 11:35:07 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 t18-20020adfeb92000000b003093a412310sm2249080wrn.92.2023.06.08.11.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 11:35:07 -0700 (PDT)
Date: Thu, 8 Jun 2023 14:35:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Support interrupt bypassing
Message-ID: <20230608143457-mutt-send-email-mst@kernel.org>
References: <20230607190007.290505-1-dtatulea@nvidia.com>
 <118eac3c96665e3eac3397eef127606200f4aa50.camel@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <118eac3c96665e3eac3397eef127606200f4aa50.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Eli Cohen <elic@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Jun 08, 2023 at 04:25:55PM +0000, Dragos Tatulea wrote:
> On Wed, 2023-06-07 at 22:00 +0300, Dragos Tatulea via Virtualization wrot=
e:
> > From: Eli Cohen <elic@nvidia.com>
> > =

> > Add support for generation of interrupts from the device directly to the
> > VM to the VCPU thus avoiding the overhead on the host CPU.
> > =

> > When supported, the driver will attempt to allocate vectors for each
> > data virtqueue. If a vector for a virtqueue cannot be provided it will
> > use the QP mode where notifications go through the driver.
> > =

> > In addition, we add a shutdown callback to make sure allocated
> > interrupts are released in case of shutdown to allow clean shutdown.
> > =

> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> > =

> Just realized that this patch should have been marked as a v3. Let me kno=
w if I
> should resend it.

no need.

> > ---
> > =A0drivers/vdpa/mlx5/net/mlx5_vnet.c | 165 ++++++++++++++++++++++++++++=
--
> > =A0drivers/vdpa/mlx5/net/mlx5_vnet.h |=A0 15 +++
> > =A02 files changed, 171 insertions(+), 9 deletions(-)
> > =

> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 279ac6a558d2..9138ef2fb2c8 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -83,6 +83,7 @@ struct mlx5_vq_restore_info {
> > =A0=A0=A0=A0=A0=A0=A0=A0u64 driver_addr;
> > =A0=A0=A0=A0=A0=A0=A0=A0u16 avail_index;
> > =A0=A0=A0=A0=A0=A0=A0=A0u16 used_index;
> > +=A0=A0=A0=A0=A0=A0=A0struct msi_map map;
> > =A0=A0=A0=A0=A0=A0=A0=A0bool ready;
> > =A0=A0=A0=A0=A0=A0=A0=A0bool restore;
> > =A0};
> > @@ -118,6 +119,7 @@ struct mlx5_vdpa_virtqueue {
> > =A0=A0=A0=A0=A0=A0=A0=A0u16 avail_idx;
> > =A0=A0=A0=A0=A0=A0=A0=A0u16 used_idx;
> > =A0=A0=A0=A0=A0=A0=A0=A0int fw_state;
> > +=A0=A0=A0=A0=A0=A0=A0struct msi_map map;
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0/* keep last in the struct */
> > =A0=A0=A0=A0=A0=A0=A0=A0struct mlx5_vq_restore_info ri;
> > @@ -808,6 +810,13 @@ static bool counters_supported(const struct mlx5_v=
dpa_dev
> > *mvdev)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT_ULL(MLX5_OBJ_TYPE_VIRTIO=
_Q_COUNTERS);
> > =A0}
> > =A0
> > +static bool msix_mode_supported(struct mlx5_vdpa_dev *mvdev)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0return MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, e=
vent_mode) &
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1 << MLX5_VIRTIO_Q_EVENT=
_MODE_MSIX_MODE) &&
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pci_msix_can_alloc_dyn(mv=
dev->mdev->pdev);
> > +}
> > +
> > =A0static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct
> > mlx5_vdpa_virtqueue *mvq)
> > =A0{
> > =A0=A0=A0=A0=A0=A0=A0=A0int inlen =3D MLX5_ST_SZ_BYTES(create_virtio_ne=
t_q_in);
> > @@ -849,9 +858,15 @@ static int create_virtqueue(struct mlx5_vdpa_net *=
ndev,
> > struct mlx5_vdpa_virtque
> > =A0=A0=A0=A0=A0=A0=A0=A0if (vq_is_tx(mvq->index))
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0MLX5_SET(virtio_net_q_o=
bject, obj_context, tisn_or_qpn, ndev-
> > >res.tisn);
> > =A0
> > -=A0=A0=A0=A0=A0=A0=A0MLX5_SET(virtio_q, vq_ctx, event_mode,
> > MLX5_VIRTIO_Q_EVENT_MODE_QP_MODE);
> > +=A0=A0=A0=A0=A0=A0=A0if (mvq->map.virq) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0MLX5_SET(virtio_q, vq_ctx=
, event_mode,
> > MLX5_VIRTIO_Q_EVENT_MODE_MSIX_MODE);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0MLX5_SET(virtio_q, vq_ctx=
, event_qpn_or_msix, mvq->map.index);
> > +=A0=A0=A0=A0=A0=A0=A0} else {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0MLX5_SET(virtio_q, vq_ctx=
, event_mode,
> > MLX5_VIRTIO_Q_EVENT_MODE_QP_MODE);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0MLX5_SET(virtio_q, vq_ctx=
, event_qpn_or_msix, mvq-
> > >fwqp.mqp.qpn);
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +
> > =A0=A0=A0=A0=A0=A0=A0=A0MLX5_SET(virtio_q, vq_ctx, queue_index, mvq->in=
dex);
> > -=A0=A0=A0=A0=A0=A0=A0MLX5_SET(virtio_q, vq_ctx, event_qpn_or_msix, mvq=
->fwqp.mqp.qpn);
> > =A0=A0=A0=A0=A0=A0=A0=A0MLX5_SET(virtio_q, vq_ctx, queue_size, mvq->num=
_ent);
> > =A0=A0=A0=A0=A0=A0=A0=A0MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 !!(ndev->mvdev.actual_=
features &
> > BIT_ULL(VIRTIO_F_VERSION_1)));
> > @@ -1194,6 +1209,56 @@ static void counter_set_dealloc(struct mlx5_vdpa=
_net
> > *ndev, struct mlx5_vdpa_vir
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mlx5_vdpa_warn(&ndev->m=
vdev, "dealloc counter set 0x%x\n",
> > mvq->counter_set_id);
> > =A0}
> > =A0
> > +static irqreturn_t mlx5_vdpa_int_handler(int irq, void *priv)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0struct vdpa_callback *cb =3D priv;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (cb->callback)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return cb->callback(cb->p=
rivate);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0return IRQ_HANDLED;
> > +}
> > +
> > +static void alloc_vector(struct mlx5_vdpa_net *ndev,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
struct mlx5_vdpa_virtqueue *mvq)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0struct mlx5_vdpa_irq_pool *irqp =3D &ndev->irqp;
> > +=A0=A0=A0=A0=A0=A0=A0struct mlx5_vdpa_irq_pool_entry *ent;
> > +=A0=A0=A0=A0=A0=A0=A0int err;
> > +=A0=A0=A0=A0=A0=A0=A0int i;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0for (i =3D 0; i < irqp->num_ent; i++) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ent =3D &irqp->entries[i];
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!ent->used) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0s=
nprintf(ent->name, MLX5_VDPA_IRQ_NAME_LEN, "%s-vq-
> > %d",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 dev_name(&ndev->mvdev.vdev.dev), mvq->index);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0e=
nt->dev_id =3D &ndev->event_cbs[mvq->index];
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0e=
rr =3D request_irq(ent->map.virq,
> > mlx5_vdpa_int_handler, 0,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ent->name, ent->dev_id);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0i=
f (err)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0return;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0e=
nt->used =3D true;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0m=
vq->map =3D ent->map;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r=
eturn;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +}
> > +
> > +static void dealloc_vector(struct mlx5_vdpa_net *ndev,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 struct mlx5_vdpa_virtqueue *mvq)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0struct mlx5_vdpa_irq_pool *irqp =3D &ndev->irqp;
> > +=A0=A0=A0=A0=A0=A0=A0int i;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0for (i =3D 0; i < irqp->num_ent; i++)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (mvq->map.virq =3D=3D =
irqp->entries[i].map.virq) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0f=
ree_irq(mvq->map.virq, irqp->entries[i].dev_id);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0i=
rqp->entries[i].used =3D false;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r=
eturn;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > +}
> > +
> > =A0static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_vir=
tqueue
> > *mvq)
> > =A0{
> > =A0=A0=A0=A0=A0=A0=A0=A0u16 idx =3D mvq->index;
> > @@ -1223,27 +1288,31 @@ static int setup_vq(struct mlx5_vdpa_net *ndev,=
 struct
> > mlx5_vdpa_virtqueue *mvq)
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0err =3D counter_set_alloc(ndev, mvq);
> > =A0=A0=A0=A0=A0=A0=A0=A0if (err)
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto err_counter;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto err_connect;
> > =A0
> > +=A0=A0=A0=A0=A0=A0=A0alloc_vector(ndev, mvq);
> > =A0=A0=A0=A0=A0=A0=A0=A0err =3D create_virtqueue(ndev, mvq);
> > =A0=A0=A0=A0=A0=A0=A0=A0if (err)
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto err_connect;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto err_vq;
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0if (mvq->ready) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0err =3D modify_virtqueu=
e(ndev, mvq,
> > MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (err) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0mlx5_vdpa_warn(&ndev->mvdev, "failed to modify to
> > ready vq idx %d(%d)\n",
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 idx, err);
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0g=
oto err_connect;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0g=
oto err_modify;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0mvq->initialized =3D true;
> > =A0=A0=A0=A0=A0=A0=A0=A0return 0;
> > =A0
> > -err_connect:
> > +err_modify:
> > +=A0=A0=A0=A0=A0=A0=A0destroy_virtqueue(ndev, mvq);
> > +err_vq:
> > +=A0=A0=A0=A0=A0=A0=A0dealloc_vector(ndev, mvq);
> > =A0=A0=A0=A0=A0=A0=A0=A0counter_set_dealloc(ndev, mvq);
> > -err_counter:
> > +err_connect:
> > =A0=A0=A0=A0=A0=A0=A0=A0qp_destroy(ndev, &mvq->vqqp);
> > =A0err_vqqp:
> > =A0=A0=A0=A0=A0=A0=A0=A0qp_destroy(ndev, &mvq->fwqp);
> > @@ -1288,6 +1357,7 @@ static void teardown_vq(struct mlx5_vdpa_net *nde=
v,
> > struct mlx5_vdpa_virtqueue *
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0suspend_vq(ndev, mvq);
> > =A0=A0=A0=A0=A0=A0=A0=A0destroy_virtqueue(ndev, mvq);
> > +=A0=A0=A0=A0=A0=A0=A0dealloc_vector(ndev, mvq);
> > =A0=A0=A0=A0=A0=A0=A0=A0counter_set_dealloc(ndev, mvq);
> > =A0=A0=A0=A0=A0=A0=A0=A0qp_destroy(ndev, &mvq->vqqp);
> > =A0=A0=A0=A0=A0=A0=A0=A0qp_destroy(ndev, &mvq->fwqp);
> > @@ -2505,6 +2575,7 @@ static int save_channel_info(struct mlx5_vdpa_net=
 *ndev,
> > struct mlx5_vdpa_virtqu
> > =A0=A0=A0=A0=A0=A0=A0=A0ri->desc_addr =3D mvq->desc_addr;
> > =A0=A0=A0=A0=A0=A0=A0=A0ri->device_addr =3D mvq->device_addr;
> > =A0=A0=A0=A0=A0=A0=A0=A0ri->driver_addr =3D mvq->driver_addr;
> > +=A0=A0=A0=A0=A0=A0=A0ri->map =3D mvq->map;
> > =A0=A0=A0=A0=A0=A0=A0=A0ri->restore =3D true;
> > =A0=A0=A0=A0=A0=A0=A0=A0return 0;
> > =A0}
> > @@ -2549,6 +2620,7 @@ static void restore_channels_info(struct mlx5_vdp=
a_net
> > *ndev)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mvq->desc_addr =3D ri->=
desc_addr;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mvq->device_addr =3D ri=
->device_addr;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mvq->driver_addr =3D ri=
->driver_addr;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mvq->map =3D ri->map;
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0}
> > =A0
> > @@ -2833,6 +2905,25 @@ static struct device *mlx5_get_vq_dma_dev(struct
> > vdpa_device *vdev, u16 idx)
> > =A0=A0=A0=A0=A0=A0=A0=A0return mvdev->vdev.dma_dev;
> > =A0}
> > =A0
> > +static void free_irqs(struct mlx5_vdpa_net *ndev)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0struct mlx5_vdpa_irq_pool_entry *ent;
> > +=A0=A0=A0=A0=A0=A0=A0int i;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!msix_mode_supported(&ndev->mvdev))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!ndev->irqp.entries)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0for (i =3D ndev->irqp.num_ent - 1; i >=3D 0; i--)=
 {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ent =3D ndev->irqp.entrie=
s + i;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (ent->map.virq)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0p=
ci_msix_free_irq(ndev->mvdev.mdev->pdev, ent->map);
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0kfree(ndev->irqp.entries);
> > +}
> > +
> > =A0static void mlx5_vdpa_free(struct vdpa_device *vdev)
> > =A0{
> > =A0=A0=A0=A0=A0=A0=A0=A0struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> > @@ -2848,6 +2939,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vd=
ev)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mlx5_mpfs_del_mac(pfmde=
v, ndev->config.mac);
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0=A0=A0=A0mlx5_vdpa_free_resources(&ndev->mvdev);
> > +=A0=A0=A0=A0=A0=A0=A0free_irqs(ndev);
> > =A0=A0=A0=A0=A0=A0=A0=A0kfree(ndev->event_cbs);
> > =A0=A0=A0=A0=A0=A0=A0=A0kfree(ndev->vqs);
> > =A0}
> > @@ -2876,9 +2968,23 @@ static struct vdpa_notification_area
> > mlx5_get_vq_notification(struct vdpa_device
> > =A0=A0=A0=A0=A0=A0=A0=A0return ret;
> > =A0}
> > =A0
> > -static int mlx5_get_vq_irq(struct vdpa_device *vdv, u16 idx)
> > +static int mlx5_get_vq_irq(struct vdpa_device *vdev, u16 idx)
> > =A0{
> > -=A0=A0=A0=A0=A0=A0=A0return -EOPNOTSUPP;
> > +=A0=A0=A0=A0=A0=A0=A0struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> > +=A0=A0=A0=A0=A0=A0=A0struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(=
mvdev);
> > +=A0=A0=A0=A0=A0=A0=A0struct mlx5_vdpa_virtqueue *mvq;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!is_index_valid(mvdev, idx))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EINVAL;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (is_ctrl_vq_idx(mvdev, idx))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EOPNOTSUPP;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0mvq =3D &ndev->vqs[idx];
> > +=A0=A0=A0=A0=A0=A0=A0if (!mvq->map.virq)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EOPNOTSUPP;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0return mvq->map.virq;
> > =A0}
> > =A0
> > =A0static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
> > @@ -3155,6 +3261,34 @@ static int config_func_mtu(struct mlx5_core_dev =
*mdev,
> > u16 mtu)
> > =A0=A0=A0=A0=A0=A0=A0=A0return err;
> > =A0}
> > =A0
> > +static void allocate_irqs(struct mlx5_vdpa_net *ndev)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0struct mlx5_vdpa_irq_pool_entry *ent;
> > +=A0=A0=A0=A0=A0=A0=A0int i;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!msix_mode_supported(&ndev->mvdev))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!ndev->mvdev.mdev->pdev)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0ndev->irqp.entries =3D kcalloc(ndev->mvdev.max_vq=
s, sizeof(*ndev-
> > >irqp.entries), GFP_KERNEL);
> > +=A0=A0=A0=A0=A0=A0=A0if (!ndev->irqp.entries)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > +
> > +
> > +=A0=A0=A0=A0=A0=A0=A0for (i =3D 0; i < ndev->mvdev.max_vqs; i++) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ent =3D ndev->irqp.entrie=
s + i;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0snprintf(ent->name, MLX5_=
VDPA_IRQ_NAME_LEN, "%s-vq-%d",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
dev_name(&ndev->mvdev.vdev.dev), i);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ent->map =3D pci_msix_all=
oc_irq_at(ndev->mvdev.mdev->pdev,
> > MSI_ANY_INDEX, NULL);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!ent->map.virq)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r=
eturn;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ndev->irqp.num_ent++;
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +}
> > +
> > =A0static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const cha=
r *name,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 const struct vdpa_dev_set_config *add_config)
> > =A0{
> > @@ -3233,6 +3367,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev
> > *v_mdev, const char *name,
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0init_mvqs(ndev);
> > +=A0=A0=A0=A0=A0=A0=A0allocate_irqs(ndev);
> > =A0=A0=A0=A0=A0=A0=A0=A0init_rwsem(&ndev->reslock);
> > =A0=A0=A0=A0=A0=A0=A0=A0config =3D &ndev->config;
> > =A0
> > @@ -3413,6 +3548,17 @@ static void mlx5v_remove(struct auxiliary_device=
 *adev)
> > =A0=A0=A0=A0=A0=A0=A0=A0kfree(mgtdev);
> > =A0}
> > =A0
> > +static void mlx5v_shutdown(struct auxiliary_device *auxdev)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0struct mlx5_vdpa_mgmtdev *mgtdev;
> > +=A0=A0=A0=A0=A0=A0=A0struct mlx5_vdpa_net *ndev;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0mgtdev =3D auxiliary_get_drvdata(auxdev);
> > +=A0=A0=A0=A0=A0=A0=A0ndev =3D mgtdev->ndev;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0free_irqs(ndev);
> > +}
> > +
> > =A0static const struct auxiliary_device_id mlx5v_id_table[] =3D {
> > =A0=A0=A0=A0=A0=A0=A0=A0{ .name =3D MLX5_ADEV_NAME ".vnet", },
> > =A0=A0=A0=A0=A0=A0=A0=A0{},
> > @@ -3424,6 +3570,7 @@ static struct auxiliary_driver mlx5v_driver =3D {
> > =A0=A0=A0=A0=A0=A0=A0=A0.name =3D "vnet",
> > =A0=A0=A0=A0=A0=A0=A0=A0.probe =3D mlx5v_probe,
> > =A0=A0=A0=A0=A0=A0=A0=A0.remove =3D mlx5v_remove,
> > +=A0=A0=A0=A0=A0=A0=A0.shutdown =3D mlx5v_shutdown,
> > =A0=A0=A0=A0=A0=A0=A0=A0.id_table =3D mlx5v_id_table,
> > =A0};
> > =A0
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> > index c90a89e1de4d..36c44d9fdd16 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> > @@ -26,6 +26,20 @@ static inline u16 key2vid(u64 key)
> > =A0=A0=A0=A0=A0=A0=A0=A0return (u16)(key >> 48) & 0xfff;
> > =A0}
> > =A0
> > +#define MLX5_VDPA_IRQ_NAME_LEN 32
> > +
> > +struct mlx5_vdpa_irq_pool_entry {
> > +=A0=A0=A0=A0=A0=A0=A0struct msi_map map;
> > +=A0=A0=A0=A0=A0=A0=A0bool used;
> > +=A0=A0=A0=A0=A0=A0=A0char name[MLX5_VDPA_IRQ_NAME_LEN];
> > +=A0=A0=A0=A0=A0=A0=A0void *dev_id;
> > +};
> > +
> > +struct mlx5_vdpa_irq_pool {
> > +=A0=A0=A0=A0=A0=A0=A0int num_ent;
> > +=A0=A0=A0=A0=A0=A0=A0struct mlx5_vdpa_irq_pool_entry *entries;
> > +};
> > +
> > =A0struct mlx5_vdpa_net {
> > =A0=A0=A0=A0=A0=A0=A0=A0struct mlx5_vdpa_dev mvdev;
> > =A0=A0=A0=A0=A0=A0=A0=A0struct mlx5_vdpa_net_resources res;
> > @@ -49,6 +63,7 @@ struct mlx5_vdpa_net {
> > =A0=A0=A0=A0=A0=A0=A0=A0struct vdpa_callback config_cb;
> > =A0=A0=A0=A0=A0=A0=A0=A0struct mlx5_vdpa_wq_ent cvq_ent;
> > =A0=A0=A0=A0=A0=A0=A0=A0struct hlist_head macvlan_hash[MLX5V_MACVLAN_SI=
ZE];
> > +=A0=A0=A0=A0=A0=A0=A0struct mlx5_vdpa_irq_pool irqp;
> > =A0=A0=A0=A0=A0=A0=A0=A0struct dentry *debugfs;
> > =A0};
> > =A0
> =

> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
