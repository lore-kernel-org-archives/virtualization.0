Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44948C433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 08:29:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C02C660D5F;
	Tue, 11 Jan 2022 08:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rrG8tRWKBLiC; Tue, 11 Jan 2022 08:29:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DD3B060AB1;
	Tue, 11 Jan 2022 08:29:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA9CCC002F;
	Tue, 11 Jan 2022 08:29:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CA81C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 08:29:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D7F3740435
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 08:29:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n001mLnsyPjg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 08:29:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E21040143
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 08:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641889757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JvYypoUbYDiVg3ux9eaNRw2DIWrNFhGbhr0blC8iG8U=;
 b=WkiKe+Mpc2yi8FT4pAP9ml3u8k48phYUiI0Hr9QG4vcMumjVu3z+FPapH9lR6BF0/rvkjw
 43h8HktXdkuXYAS0dMsrz/64EwNDvchdMrdipfW6UqX8/AdQXPliDX6/HKJb7L1LPwWF/n
 MJ3U7RVX+eSAL144hIBXSB/6eEaguok=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-iZEFKOF0Pcq4YBa-aT5_AQ-1; Tue, 11 Jan 2022 03:29:11 -0500
X-MC-Unique: iZEFKOF0Pcq4YBa-aT5_AQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 z23-20020a0565120c1700b004258a35caf2so8401749lfu.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 00:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JvYypoUbYDiVg3ux9eaNRw2DIWrNFhGbhr0blC8iG8U=;
 b=xwDfp/0jynofgyV/NCEizpUR+ZXbFrFLm5Xct1EWdUAYIVUsOoPzXSKj0xGpTbcnT5
 VrMN4fzTyq+Y2W77saQxA4IJrMtzY4Av+XfgXC3GSuxDpaFgz6iOcyJV/VBedTRg/HfU
 2Jwm/LHjaNNDZYwyLV1VKseGHRQAGH1UfVgOI3Bo+YsSLcY4UvkW854POXnJhIonEiNF
 RS3FU5SgjXDh1tAnEcbEdeUSkWUkO5++IWSAZS6Pz9TqnnSD2gQTYx6o2IXzFb0b6KNF
 NU7GVFRUw4GTjCpK6nexMW1NqCoOdEUdJIjNYjEEbczqe3ai1yNJprmRR15GkryqinmG
 Dv2Q==
X-Gm-Message-State: AOAM531Kr5sy8Yh1vhPYuijy3oZDM5Zf8ibVY6wpoqiJuyUARAME09P6
 hIkIUyDCYOdixRLln16UzFlFurTC9ThDAL0ZOp/Swe2Rb1FyoEockQ8m/nMJsE+d3t7v7plWPrf
 CTe0Xd6RqbWQt5aAC2MqZ+3PBITlSrL/3wikxOBMRGOI3636Y8dWftyEZ4Q==
X-Received: by 2002:a05:651c:1a0d:: with SMTP id
 by13mr2247013ljb.107.1641889749957; 
 Tue, 11 Jan 2022 00:29:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyj9GJR8wL+h08vlhNHlqKbovoPy2uDaG6j3TFHkaCNYxwWKKoUaP73OzWDiagytejB3x/5aA0H8qUiuvkordc=
X-Received: by 2002:a05:651c:1a0d:: with SMTP id
 by13mr2246992ljb.107.1641889749616; 
 Tue, 11 Jan 2022 00:29:09 -0800 (PST)
MIME-Version: 1.0
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-8-elic@nvidia.com>
 <99150f0c-6814-a0cc-8640-aa8014af6ed0@oracle.com>
 <3205e802-a982-fbe2-511e-f5c28fc19b36@oracle.com>
 <20220109141023.GB70879@mtl-vdi-166.wap.labs.mlnx>
 <94048dc7-defa-2c7b-9350-540e8b9df227@oracle.com>
 <20220111073416.GB149570@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20220111073416.GB149570@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Jan 2022 16:28:58 +0800
Message-ID: <CACGkMEsJYoEop+shT6mngH68pYbGzMQhC4FO9UtzDczv6Lvbzw@mail.gmail.com>
Subject: Re: [PATCH v7 07/14] vdpa/mlx5: Support configuring max data virtqueue
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Tue, Jan 11, 2022 at 3:34 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Mon, Jan 10, 2022 at 05:00:34PM -0800, Si-Wei Liu wrote:
> >
> >
> > On 1/9/2022 6:10 AM, Eli Cohen wrote:
> > > On Thu, Jan 06, 2022 at 05:50:24PM -0800, Si-Wei Liu wrote:
> > > >
> > > > On 1/6/2022 5:27 PM, Si-Wei Liu wrote:
> > > > >
> > > > > On 1/5/2022 3:46 AM, Eli Cohen wrote:
> > > > > > Check whether the max number of data virtqueue pairs was provided when a
> > > > > > adding a new device and verify the new value does not exceed device
> > > > > > capabilities.
> > > > > >
> > > > > > In addition, change the arrays holding virtqueue and callback contexts
> > > > > > to be dynamically allocated.
> > > > > >
> > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > ---
> > > > > > v6 -> v7:
> > > > > > 1. Evaluate RQT table size based on config.max_virtqueue_pairs.
> > > > > >
> > > > > >    drivers/vdpa/mlx5/net/mlx5_vnet.c | 51 ++++++++++++++++++++++---------
> > > > > >    1 file changed, 37 insertions(+), 14 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > index 4a2149f70f1e..d4720444bf78 100644
> > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > @@ -131,11 +131,6 @@ struct mlx5_vdpa_virtqueue {
> > > > > >        struct mlx5_vq_restore_info ri;
> > > > > >    };
> > > > > >    -/* We will remove this limitation once mlx5_vdpa_alloc_resources()
> > > > > > - * provides for driver space allocation
> > > > > > - */
> > > > > > -#define MLX5_MAX_SUPPORTED_VQS 16
> > > > > > -
> > > > > >    static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
> > > > > >    {
> > > > > >        if (unlikely(idx > mvdev->max_idx))
> > > > > > @@ -148,8 +143,8 @@ struct mlx5_vdpa_net {
> > > > > >        struct mlx5_vdpa_dev mvdev;
> > > > > >        struct mlx5_vdpa_net_resources res;
> > > > > >        struct virtio_net_config config;
> > > > > > -    struct mlx5_vdpa_virtqueue vqs[MLX5_MAX_SUPPORTED_VQS];
> > > > > > -    struct vdpa_callback event_cbs[MLX5_MAX_SUPPORTED_VQS + 1];
> > > > > > +    struct mlx5_vdpa_virtqueue *vqs;
> > > > > > +    struct vdpa_callback *event_cbs;
> > > > > >          /* Serialize vq resources creation and destruction. This is
> > > > > > required
> > > > > >         * since memory map might change and we need to destroy and create
> > > > > > @@ -1218,7 +1213,7 @@ static void suspend_vqs(struct mlx5_vdpa_net
> > > > > > *ndev)
> > > > > >    {
> > > > > >        int i;
> > > > > >    -    for (i = 0; i < MLX5_MAX_SUPPORTED_VQS; i++)
> > > > > > +    for (i = 0; i < ndev->mvdev.max_vqs; i++)
> > > > > >            suspend_vq(ndev, &ndev->vqs[i]);
> > > > > >    }
> > > > > >    @@ -1244,8 +1239,14 @@ static int create_rqt(struct mlx5_vdpa_net
> > > > > > *ndev)
> > > > > >        void *in;
> > > > > >        int i, j;
> > > > > >        int err;
> > > > > > +    int num;
> > > > > >    -    max_rqt = min_t(int, MLX5_MAX_SUPPORTED_VQS / 2,
> > > > > > +    if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> > > > > > +        num = 1;
> > > > > > +    else
> > > > > > +        num = le16_to_cpu(ndev->config.max_virtqueue_pairs);
> > > > > > +
> > > > > > +    max_rqt = min_t(int, roundup_pow_of_two(num),
> > > > > >                1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> > > > > >        if (max_rqt < 1)
> > > > > >            return -EOPNOTSUPP;
> > > > > > @@ -1262,7 +1263,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
> > > > > >        MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
> > > > > >        list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> > > > > >        for (i = 0, j = 0; i < max_rqt; i++, j += 2)
> > > > > > -        list[i] = cpu_to_be32(ndev->vqs[j %
> > > > > > ndev->mvdev.max_vqs].virtq_id);
> > > > > > +        list[i] = cpu_to_be32(ndev->vqs[j % (2 * num)].virtq_id);
> > > > > Good catch. LGTM.
> > > > >
> > > > > Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
> > > > >
> > > > Apologies to reply to myself. It looks to me we need to set cur_num_vqs to
> > > > the negotiated num of queues. Otherwise any site referencing cur_num_vqs
> > > > won't work properly.
> > > You can't really use cur_num_vqs. Consider this scenario:
> > > create vdpa device with max VQs = 16 (RQT size created with 8 entries)
> > > boot VM
> > > ethtool modify num QPs to 2. cur_num_vqs now equals 2.
> > > reboot VM.
> > Once VM is rebooted, the cur_num_vqs has to reset to 0 in the reset() op.
>
> Why reset to 0? The correct value to set here is
> config->max_virtqueue_pairs.

Multiqueue is disabled by default so I think it should be 1 here. This
is the behavior of Qemu.

It looks to me we need to clarify this in the spec.

Thanks

> This is what happens when you add the
> device. Setting cur_num_vqs to config->max_virtqueue_pairs will address
> your concerns with respect to modify_rqt. Once you reset cur_num_vqs to
> config->max_virtqueue_pairs your concerns with respect to changing
> mumber of QPs should be addressed. We could even leave create_rqt
> untouched or modify the code to use cur_num_vqs. It should work the
> same.
>
> > > create RQT with 1 entry only.
> > Here cur_num_vqs will be loaded with the newly negotiated value (max_rqt)
> > again.
> >
> > > ethtool modify num QPs to 4. modify RQT will fail since it was created
> > > with max QPs equals 1.
> > It won't fail as the cur_num_vqs will be consistent with the number of
> > queues newly negotiated (i.e the max_rqt in create_rqt) for modify.
> >
> > >
> > > I think it is ok to create the RQT always with the value configured when
> > > the device was created.
> > The problem of not setting cur_num_vqs in create_rqt (and resetting it in
> > mlx5_vdpa_reset) is that, once the VM is rebooted or the device is reset,
> > the value doesn't go with the actual number of rqt entries hence would break
> > various assumptions in change_num_qps() or modify_rqt(). For instances,
> >
> > create vdpa device with max data VQs = 16
> > boot VM
> > features_ok set with MQ negotiated
> > RQT created with 8 entries in create_rqt
> > ethtool modify num QPs to 2. cur_num_vqs now equals 2.
> > reboot VM
> > features_ok set with MQ negotiated
> > RQT created with 8 entries in create_rqt
> > ethtool modify num QPs to 6.
> > cur_num_vqs was 2 while the actual RQT size is 8 (= 16 / 2)
> > change_num_qps would fail as the wrong increment branch (rather than the decrement) was taken
> >
> > and this case too, which calls out the need to validate the presence of
> > VIRTIO_NET_F_MQ in handle_ctrl_mq()
> >
> > create vdpa device with max data VQs = 16 (RQT size created with 8 entries)
> > boot VM
> > features_ok set with MQ negotiated
> > RQT created with 8 entries in create_rqt
> > ethtool modify num QPs to 2. cur_num_vqs now equals 2.
> > reboot VM
> > features_ok set with no MQ negotiated
> > RQT created with 8 entries in create_rqt
> > ethtool modify num QPs to 6. suppose guest runs a custom kernel without checking the #channels to configure
> > change_num_qps can succeed and no host side check prohibiting a single queue guest to set multi-queue
> >
> > Thanks,
> > -Siwei
> > >
> > > > Further, we need to validate VIRTIO_NET_F_MQ is present
> > > > in handle_ctrl_mq() before changing the number of queue pairs.
> > > >
> > > > So just disregard my previous R-b for this patch.
> > > >
> > > > Thanks,
> > > > -Siwei
> > > >
> > > >
> > > > > >          MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> > > > > >        err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen,
> > > > > > &ndev->res.rqtn);
> > > > > > @@ -2220,7 +2221,7 @@ static int mlx5_vdpa_reset(struct vdpa_device
> > > > > > *vdev)
> > > > > >        clear_vqs_ready(ndev);
> > > > > >        mlx5_vdpa_destroy_mr(&ndev->mvdev);
> > > > > >        ndev->mvdev.status = 0;
> > > > > > -    memset(ndev->event_cbs, 0, sizeof(ndev->event_cbs));
> > > > > > +    memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) *
> > > > > > (mvdev->max_vqs + 1));
> > > > > >        ndev->mvdev.actual_features = 0;
> > > > > >        ++mvdev->generation;
> > > > > >        if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> > > > > > @@ -2293,6 +2294,8 @@ static void mlx5_vdpa_free(struct vdpa_device
> > > > > > *vdev)
> > > > > >        }
> > > > > >        mlx5_vdpa_free_resources(&ndev->mvdev);
> > > > > >        mutex_destroy(&ndev->reslock);
> > > > > > +    kfree(ndev->event_cbs);
> > > > > > +    kfree(ndev->vqs);
> > > > > >    }
> > > > > >      static struct vdpa_notification_area
> > > > > > mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
> > > > > > @@ -2538,15 +2541,33 @@ static int mlx5_vdpa_dev_add(struct
> > > > > > vdpa_mgmt_dev *v_mdev, const char *name,
> > > > > >            return -EOPNOTSUPP;
> > > > > >        }
> > > > > >    -    /* we save one virtqueue for control virtqueue should we
> > > > > > require it */
> > > > > >        max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev,
> > > > > > max_num_virtio_queues);
> > > > > > -    max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
> > > > > > +    if (max_vqs < 2) {
> > > > > > +        dev_warn(mdev->device,
> > > > > > +             "%d virtqueues are supported. At least 2 are required\n",
> > > > > > +             max_vqs);
> > > > > > +        return -EAGAIN;
> > > > > > +    }
> > > > > > +
> > > > > > +    if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> > > > > > +        if (add_config->net.max_vq_pairs > max_vqs / 2)
> > > > > > +            return -EINVAL;
> > > > > > +        max_vqs = min_t(u32, max_vqs, 2 *
> > > > > > add_config->net.max_vq_pairs);
> > > > > > +    } else {
> > > > > > +        max_vqs = 2;
> > > > > > +    }
> > > > > >          ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev,
> > > > > > mdev->device, &mlx5_vdpa_ops,
> > > > > >                     name, false);
> > > > > >        if (IS_ERR(ndev))
> > > > > >            return PTR_ERR(ndev);
> > > > > >    +    ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
> > > > > > +    ndev->event_cbs = kcalloc(max_vqs + 1,
> > > > > > sizeof(*ndev->event_cbs), GFP_KERNEL);
> > > > > > +    if (!ndev->vqs || !ndev->event_cbs) {
> > > > > > +        err = -ENOMEM;
> > > > > > +        goto err_alloc;
> > > > > > +    }
> > > > > >        ndev->mvdev.max_vqs = max_vqs;
> > > > > >        mvdev = &ndev->mvdev;
> > > > > >        mvdev->mdev = mdev;
> > > > > > @@ -2627,6 +2648,7 @@ static int mlx5_vdpa_dev_add(struct
> > > > > > vdpa_mgmt_dev *v_mdev, const char *name,
> > > > > >            mlx5_mpfs_del_mac(pfmdev, config->mac);
> > > > > >    err_mtu:
> > > > > >        mutex_destroy(&ndev->reslock);
> > > > > > +err_alloc:
> > > > > >        put_device(&mvdev->vdev.dev);
> > > > > >        return err;
> > > > > >    }
> > > > > > @@ -2669,7 +2691,8 @@ static int mlx5v_probe(struct auxiliary_device
> > > > > > *adev,
> > > > > >        mgtdev->mgtdev.ops = &mdev_ops;
> > > > > >        mgtdev->mgtdev.device = mdev->device;
> > > > > >        mgtdev->mgtdev.id_table = id_table;
> > > > > > -    mgtdev->mgtdev.config_attr_mask =
> > > > > > BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> > > > > > +    mgtdev->mgtdev.config_attr_mask =
> > > > > > BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
> > > > > > +                      BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> > > > > >        mgtdev->madev = madev;
> > > > > >          err = vdpa_mgmtdev_register(&mgtdev->mgtdev);
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
