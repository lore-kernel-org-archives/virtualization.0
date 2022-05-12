Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD17C433EF
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 02:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D34DF83E28;
	Thu, 12 May 2022 02:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X4v0d9kU4y37; Thu, 12 May 2022 02:27:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F3049831A0;
	Thu, 12 May 2022 02:27:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6411C0039;
	Thu, 12 May 2022 02:27:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC614C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 02:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9516941880
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 02:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rRBs0nih0x1m
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 02:27:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 639DC41855
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 02:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652322464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MnBUsGH2NSc8mBV35xTwbMtmVCtbQHLIFU4mWOhbey8=;
 b=BaZWk7+0l9D7mW95S9ZstwAuBwZ5WonTMrWbj+lym2NYYHloZHDIfWdyHIvFgChHJvkNn7
 bLT7U8zdaHmb1o5OMY1y0K3zkxHYOnzsinvnhU7xBngngH8haBbn7EzbPpaZB3/wdZwohC
 Ait365ZoaRGa6OGTaIcuQYJ5tGzUpUk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-vbCqqADDMf27PwffLVOIQw-1; Wed, 11 May 2022 22:27:43 -0400
X-MC-Unique: vbCqqADDMf27PwffLVOIQw-1
Received: by mail-lf1-f69.google.com with SMTP id
 p5-20020ac246c5000000b0047257761087so1577051lfo.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 19:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MnBUsGH2NSc8mBV35xTwbMtmVCtbQHLIFU4mWOhbey8=;
 b=2AKzHO7yjXrZQIQptH/m3eF9oNi1/61XNVUmwO/NHkjci4bfPWjlK+RRZE/oBa+rpp
 3TITnJndcXKXXaAsyzvj53uIvA5D3gAeWA817wQfJ4K/ajS2C20SEz5rG8kY2mQ9722N
 ETXNz9XYxkmI0dTAR5psYjCSQG0/NEDA1ji+Lm4OSaoOlcO+E8oPF1R+Z6zbNnoP3Y44
 vUYKV8Ynz13XT5nk1yIKHaTQ7ROP9M6TfTmy/2jTwSdja2FnfWhW9cxC58ejr5msjbrt
 t6hHJBrN4jgj39SUWKtnsrfBEWu1g+u3Ii9/gFtZFcYVQhErB7dYjM8WrtvOzIJ2yWdJ
 86Bw==
X-Gm-Message-State: AOAM532r26EnXf2WOlYxv2cFxawe0xbNb+PJmDweykdpaxbUul9rFeny
 33pA8wmu++Hc6jGE1i2Xt1rD6uwsVau6Jst8QhtrRzr3+NJNMpF+B8yaj6p/st5tsy1agnftlfI
 mhZENzGZVX1VjBUBei77nZq3Qd+iiKQjyBJq3LsFLi46UyK+MUkFUamNzMA==
X-Received: by 2002:a05:6512:a91:b0:473:bb9e:fc80 with SMTP id
 m17-20020a0565120a9100b00473bb9efc80mr22620077lfu.471.1652322462250; 
 Wed, 11 May 2022 19:27:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx78nboFh642BuCza3MKFLezsqkwyeXvR/9J0hjpBPV1b0Vp7WAm2hs7bcJeSQdqbc3ew1R9svIM8EtpWgkNV4=
X-Received: by 2002:a05:6512:a91:b0:473:bb9e:fc80 with SMTP id
 m17-20020a0565120a9100b00473bb9efc80mr22620062lfu.471.1652322461990; Wed, 11
 May 2022 19:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220510112734.205669-1-elic@nvidia.com>
 <20220510112734.205669-4-elic@nvidia.com>
 <eda33c78-fd39-a5bb-9e9e-06b2c37d3fe5@oracle.com>
In-Reply-To: <eda33c78-fd39-a5bb-9e9e-06b2c37d3fe5@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 May 2022 10:27:31 +0800
Message-ID: <CACGkMEuvN2SSdcn5fY7TZr_-Aj8UFMshrrmFn4dcJPTH94cLSw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] vdpa/mlx5: Add support for reading descriptor
 statistics
To: Si-Wei Liu <si-wei.liu@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

On Thu, May 12, 2022 at 1:26 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 5/10/2022 4:27 AM, Eli Cohen wrote:
> > Implement the get_vq_stats calback of vdpa_config_ops to return the
> > statistics for a virtqueue.
> >
> > The statistics are provided as vendor specific statistics where the
> > driver provides a pair of attribute name and attribute value.
> >
> > In addition to the attribute name/attribute value pair, the driver
> > returns the negotiated features and max virtqueue pairs for userspace
> > can decide for a given queue index whether it is a data or control
> > virtqueue.
> >
> > Currently supported are received descriptors and completed descriptors.
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> > v4 -> v5:
> >   Remove numq_lock mutex. Use reslock instread.
> >
> >
> >   drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
> >   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 165 +++++++++++++++++++++++++++++
> >   include/linux/mlx5/mlx5_ifc.h      |   1 +
> >   include/linux/mlx5/mlx5_ifc_vdpa.h |  39 +++++++
> >   4 files changed, 207 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > index daaf7b503677..44104093163b 100644
> > --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > @@ -61,6 +61,8 @@ struct mlx5_control_vq {
> >       struct vringh_kiov riov;
> >       struct vringh_kiov wiov;
> >       unsigned short head;
> > +     unsigned int received_desc;
> > +     unsigned int completed_desc;
> >   };
> >
> >   struct mlx5_vdpa_wq_ent {
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 79001301b383..99b0621e7a87 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -119,6 +119,7 @@ struct mlx5_vdpa_virtqueue {
> >       struct mlx5_vdpa_umem umem2;
> >       struct mlx5_vdpa_umem umem3;
> >
> > +     u32 counter_set_id;
> >       bool initialized;
> >       int index;
> >       u32 virtq_id;
> > @@ -164,6 +165,7 @@ struct mlx5_vdpa_net {
> >       struct notifier_block nb;
> >       struct vdpa_callback config_cb;
> >       struct mlx5_vdpa_wq_ent cvq_ent;
> > +     /* sync access to virtqueues statistics */
> Dangling code change?
>
> >   };
> >
> >   static void free_resources(struct mlx5_vdpa_net *ndev);
> > @@ -822,6 +824,12 @@ static u16 get_features_12_3(u64 features)
> >              (!!(features & BIT_ULL(VIRTIO_NET_F_GUEST_CSUM)) << 6);
> >   }
> >
> > +static bool counters_supported(const struct mlx5_vdpa_dev *mvdev)
> > +{
> > +     return MLX5_CAP_GEN_64(mvdev->mdev, general_obj_types) &
> > +            BIT_ULL(MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> > +}
> > +
> >   static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> >   {
> >       int inlen = MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
> > @@ -876,6 +884,8 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> >       MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
> >       MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
> >       MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
> > +     if (counters_supported(&ndev->mvdev))
> > +             MLX5_SET(virtio_q, vq_ctx, counter_set_id, mvq->counter_set_id);
> >
> >       err = mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(out));
> >       if (err)
> > @@ -1139,6 +1149,47 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> >       return err;
> >   }
> >
> > +static int counter_set_alloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> > +{
> > +     u32 in[MLX5_ST_SZ_DW(create_virtio_q_counters_in)] = {};
> > +     u32 out[MLX5_ST_SZ_DW(create_virtio_q_counters_out)] = {};
> > +     void *cmd_hdr;
> > +     int err;
> > +
> > +     if (!counters_supported(&ndev->mvdev))
> > +             return 0;
> > +
> > +     cmd_hdr = MLX5_ADDR_OF(create_virtio_q_counters_in, in, hdr);
> > +
> > +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
> > +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> > +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
> > +
> > +     err = mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out));
> > +     if (err)
> > +             return err;
> > +
> > +     mvq->counter_set_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
> > +
> > +     return 0;
> > +}
> > +
> > +static void counter_set_dealloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> > +{
> > +     u32 in[MLX5_ST_SZ_DW(destroy_virtio_q_counters_in)] = {};
> > +     u32 out[MLX5_ST_SZ_DW(destroy_virtio_q_counters_out)] = {};
> > +
> > +     if (!counters_supported(&ndev->mvdev))
> > +             return;
> > +
> > +     MLX5_SET(destroy_virtio_q_counters_in, in, hdr.opcode, MLX5_CMD_OP_DESTROY_GENERAL_OBJECT);
> > +     MLX5_SET(destroy_virtio_q_counters_in, in, hdr.obj_id, mvq->counter_set_id);
> > +     MLX5_SET(destroy_virtio_q_counters_in, in, hdr.uid, ndev->mvdev.res.uid);
> > +     MLX5_SET(destroy_virtio_q_counters_in, in, hdr.obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> > +     if (mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out)))
> > +             mlx5_vdpa_warn(&ndev->mvdev, "dealloc counter set 0x%x\n", mvq->counter_set_id);
> > +}
> > +
> >   static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> >   {
> >       u16 idx = mvq->index;
> > @@ -1166,6 +1217,10 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> >       if (err)
> >               goto err_connect;
> >
> > +     err = counter_set_alloc(ndev, mvq);
> > +     if (err)
> > +             goto err_counter;
> > +
> >       err = create_virtqueue(ndev, mvq);
> >       if (err)
> >               goto err_connect;
> > @@ -1183,6 +1238,8 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
> >       return 0;
> >
> >   err_connect:
> > +     counter_set_dealloc(ndev, mvq);
> > +err_counter:
> >       qp_destroy(ndev, &mvq->vqqp);
> >   err_vqqp:
> >       qp_destroy(ndev, &mvq->fwqp);
> > @@ -1227,6 +1284,7 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
> >
> >       suspend_vq(ndev, mvq);
> >       destroy_virtqueue(ndev, mvq);
> > +     counter_set_dealloc(ndev, mvq);
> >       qp_destroy(ndev, &mvq->vqqp);
> >       qp_destroy(ndev, &mvq->fwqp);
> >       cq_destroy(ndev, mvq->index);
> > @@ -1681,6 +1739,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
> >               if (read != sizeof(ctrl))
> >                       break;
> >
> > +             cvq->received_desc++;
> >               switch (ctrl.class) {
> >               case VIRTIO_NET_CTRL_MAC:
> >                       status = handle_ctrl_mac(mvdev, ctrl.cmd);
> > @@ -1704,6 +1763,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
> >               if (vringh_need_notify_iotlb(&cvq->vring))
> >                       vringh_notify(&cvq->vring);
> >
> > +             cvq->completed_desc++;
> >               queue_work(mvdev->wq, &wqent->work);
> >               break;
> >       }
> > @@ -2323,6 +2383,8 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
> >       mlx5_vdpa_destroy_mr(&ndev->mvdev);
> >       ndev->mvdev.status = 0;
> >       ndev->cur_num_vqs = 0;
> > +     ndev->mvdev.cvq.received_desc = 0;
> > +     ndev->mvdev.cvq.completed_desc = 0;
> >       memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
> >       ndev->mvdev.actual_features = 0;
> >       ++mvdev->generation;
> > @@ -2442,6 +2504,108 @@ static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
> >       return mvdev->actual_features;
> >   }
> >
> > +static int counter_set_query(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq,
> > +                          u64 *received_desc, u64 *completed_desc)
> > +{
> > +     u32 in[MLX5_ST_SZ_DW(query_virtio_q_counters_in)] = {};
> > +     u32 out[MLX5_ST_SZ_DW(query_virtio_q_counters_out)] = {};
> > +     void *cmd_hdr;
> > +     void *ctx;
> > +     int err;
> > +
> > +     if (!counters_supported(&ndev->mvdev))
> > +             return -EOPNOTSUPP;
> > +
> > +     if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY)
> > +             return -EAGAIN;
> > +
> > +     cmd_hdr = MLX5_ADDR_OF(query_virtio_q_counters_in, in, hdr);
> > +
> > +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_QUERY_GENERAL_OBJECT);
> > +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_type, MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> > +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
> > +     MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_id, mvq->counter_set_id);
> > +
> > +     err = mlx5_cmd_exec(ndev->mvdev.mdev, in, sizeof(in), out, sizeof(out));
> > +     if (err)
> > +             return err;
> > +
> > +     ctx = MLX5_ADDR_OF(query_virtio_q_counters_out, out, counters);
> > +     *received_desc = MLX5_GET64(virtio_q_counters, ctx, received_desc);
> > +     *completed_desc = MLX5_GET64(virtio_q_counters, ctx, completed_desc);
> > +     return 0;
> > +}
> > +
> > +static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
> > +                                      struct sk_buff *msg,
> > +                                      struct netlink_ext_ack *extack)
> > +{
> > +     struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > +     struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > +     struct mlx5_vdpa_virtqueue *mvq;
> > +     struct mlx5_control_vq *cvq;
> > +     u64 received_desc;
> > +     u64 completed_desc;
> > +     int err = 0;
> > +     u16 max_vqp;
> > +
> > +     mutex_lock(&ndev->reslock);
> I wonder if we can change this lock to r/w semaphore too, otherwise it
> almost defeats the merit of converting vdpa_dev_mutex to the same. This
> change would benefit multiple parallel readers.
> > +     if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_FEATURES_OK)) {
> > +             NL_SET_ERR_MSG_MOD(extack, "feature negotiation not complete");
> > +             err = -EAGAIN;
> > +             goto out_err;
> > +     }
> > +
> > +     if (!is_index_valid(mvdev, idx)) {
> > +             NL_SET_ERR_MSG_MOD(extack, "virtqueue index is not valid");
> > +             err = -EINVAL;
> > +             goto out_err;
> > +     }
> > +
> > +     if (idx == ctrl_vq_idx(mvdev)) {
> > +             cvq = &mvdev->cvq;
> > +             received_desc = cvq->received_desc;
> > +             completed_desc = cvq->completed_desc;
> > +             goto out;
> > +     }
> > +
> > +     mvq = &ndev->vqs[idx];
> > +     err = counter_set_query(ndev, mvq, &received_desc, &completed_desc);
> > +     if (err) {
> > +             NL_SET_ERR_MSG_MOD(extack, "failed to query hardware");
> > +             goto out_err;
> > +     }
> > +
> > +out:
> > +     err = -EMSGSIZE;
> > +     if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
> > +                           mvdev->actual_features, VDPA_ATTR_PAD))
> > +             goto out_err;
> > +
> > +     max_vqp = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
> > +     if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, max_vqp))
> > +             goto out_err;
> Your userspace reference patch doesn't actually use this attribute, but
> instead calls the VDPA_CMD_DEV_CONFIG_GET in prior to get this
> information, which will break consistency. Is it your plan to change the
> userspace code to accommodate what's already piggybacked here and
> display stat query in just one atomic call? Hope all the available attrs
> here would satisfy the userspace need.

Right, I mentioned this in V4. If we depend on the vendor driver to
report the negotiated features, we will end up driver specific code in
the userspace which is sub-optimal.

I think we need to do this in the vdpa core so userspace knows for
sure it can get this.

THanks

>
> Thanks,
> -Siwei
>
> > +
> > +     if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME, "received_desc"))
> > +             goto out_err;
> > +
> > +     if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE, received_desc,
> > +                           VDPA_ATTR_PAD))
> > +             goto out_err;
> > +
> > +     if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME, "completed_desc"))
> > +             goto out_err;
> > +
> > +     if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE, completed_desc,
> > +                           VDPA_ATTR_PAD))
> > +             goto out_err;
> > +
> > +     err = 0;
> > +out_err:
> > +     mutex_unlock(&ndev->reslock);
> > +     return err;
> > +}
> > +
> >   static const struct vdpa_config_ops mlx5_vdpa_ops = {
> >       .set_vq_address = mlx5_vdpa_set_vq_address,
> >       .set_vq_num = mlx5_vdpa_set_vq_num,
> > @@ -2451,6 +2615,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
> >       .get_vq_ready = mlx5_vdpa_get_vq_ready,
> >       .set_vq_state = mlx5_vdpa_set_vq_state,
> >       .get_vq_state = mlx5_vdpa_get_vq_state,
> > +     .get_vendor_vq_stats = mlx5_vdpa_get_vendor_vq_stats,
> >       .get_vq_notification = mlx5_get_vq_notification,
> >       .get_vq_irq = mlx5_get_vq_irq,
> >       .get_vq_align = mlx5_vdpa_get_vq_align,
> > diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> > index 49a48d7709ac..1d193d9b6029 100644
> > --- a/include/linux/mlx5/mlx5_ifc.h
> > +++ b/include/linux/mlx5/mlx5_ifc.h
> > @@ -94,6 +94,7 @@ enum {
> >   enum {
> >       MLX5_OBJ_TYPE_GENEVE_TLV_OPT = 0x000b,
> >       MLX5_OBJ_TYPE_VIRTIO_NET_Q = 0x000d,
> > +     MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS = 0x001c,
> >       MLX5_OBJ_TYPE_MATCH_DEFINER = 0x0018,
> >       MLX5_OBJ_TYPE_MKEY = 0xff01,
> >       MLX5_OBJ_TYPE_QP = 0xff02,
> > diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > index 1a9c9d94cb59..4414ed5b6ed2 100644
> > --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> > +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > @@ -165,4 +165,43 @@ struct mlx5_ifc_modify_virtio_net_q_out_bits {
> >       struct mlx5_ifc_general_obj_out_cmd_hdr_bits general_obj_out_cmd_hdr;
> >   };
> >
> > +struct mlx5_ifc_virtio_q_counters_bits {
> > +     u8    modify_field_select[0x40];
> > +     u8    reserved_at_40[0x40];
> > +     u8    received_desc[0x40];
> > +     u8    completed_desc[0x40];
> > +     u8    error_cqes[0x20];
> > +     u8    bad_desc_errors[0x20];
> > +     u8    exceed_max_chain[0x20];
> > +     u8    invalid_buffer[0x20];
> > +     u8    reserved_at_180[0x280];
> > +};
> > +
> > +struct mlx5_ifc_create_virtio_q_counters_in_bits {
> > +     struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> > +     struct mlx5_ifc_virtio_q_counters_bits virtio_q_counters;
> > +};
> > +
> > +struct mlx5_ifc_create_virtio_q_counters_out_bits {
> > +     struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> > +     struct mlx5_ifc_virtio_q_counters_bits virtio_q_counters;
> > +};
> > +
> > +struct mlx5_ifc_destroy_virtio_q_counters_in_bits {
> > +     struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> > +};
> > +
> > +struct mlx5_ifc_destroy_virtio_q_counters_out_bits {
> > +     struct mlx5_ifc_general_obj_out_cmd_hdr_bits hdr;
> > +};
> > +
> > +struct mlx5_ifc_query_virtio_q_counters_in_bits {
> > +     struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> > +};
> > +
> > +struct mlx5_ifc_query_virtio_q_counters_out_bits {
> > +     struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
> > +     struct mlx5_ifc_virtio_q_counters_bits counters;
> > +};
> > +
> >   #endif /* __MLX5_IFC_VDPA_H_ */
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
