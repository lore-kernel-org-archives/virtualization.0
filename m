Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF0BC433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 03:00:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0011561108
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 03:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0011561108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD9DE4038A;
	Tue, 14 Sep 2021 03:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uxpVxpgW5nU4; Tue, 14 Sep 2021 03:00:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2D3234036D;
	Tue, 14 Sep 2021 03:00:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA401C0011;
	Tue, 14 Sep 2021 03:00:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A463DC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 03:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7FD0E40215
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 03:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jFouI42mBaKG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 03:00:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C731400C7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 03:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631588441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j5P3oz84qM/k5PDTLF0AIvBQ+ESjggmz52EUd2MnYeQ=;
 b=BwwWxeW2/dgfYKAO+t5pxz1izq0sIrfLYBl8DcX5A/sIn2ugL/4ve4Z5N3KSASMsuvPcLW
 FW9cg+PhGVJpiuEOTiMmpChSqL8V7LrzudxYiU1BivDTkPdS5pLvzY8LpteuKxwPGGx2bB
 zaq9vAQAWn/WnqNzJSVstMLRfB7jyNY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-N8BvP-v8O5G-9eAoCwMAFA-1; Mon, 13 Sep 2021 23:00:40 -0400
X-MC-Unique: N8BvP-v8O5G-9eAoCwMAFA-1
Received: by mail-lj1-f199.google.com with SMTP id
 w28-20020a2e161c000000b001ba14fc0cd4so5172390ljd.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j5P3oz84qM/k5PDTLF0AIvBQ+ESjggmz52EUd2MnYeQ=;
 b=jIZoNZBifreSlo8JixEdgD9meDYzcSD4MbQQgyse8mjhDOZ8/bjIFeOX5GLizdi/wK
 khNrnH9N6gMXZYzCPY4mzxy3w1NLBDYMJXFHG41xx+yL8u4Ep+95f/5tU/xoo3ZG+XGi
 7N6ObWTlWRhdC+apQrkXXkT8cBK6iqN1T3/SQDhZFOSRESpm1gWv/p/l4zO2HJYrjPkj
 +7WjsWIHISFuUGKaAz0sgm/StlWmD1prNmcLECXO2c47kdYAoKzfiHpo5r06XZilHNaf
 VllmkSjftIN0pZUidiPHgwly9kb2GZIU9q+11+K6/Y0NOzFS/O+4FcLCqfCy5MRqMuLh
 Zcvw==
X-Gm-Message-State: AOAM530RCnQZeHYbudTp0UW5F77BHfNdpL5ebNXJoLq5EIFLQC7fnAN/
 5rf/u+TwCLZuAvFB8JTVEN31kStcrob58w4oXabWLvjydNoXiuHnPVO5a6qBaACtjwuacjSUXtH
 P7s8QVCHfi3jnc3dXDsPzvM3Tb5SSti44VQWaBBrOyxHaXoS96mT24b5iug==
X-Received: by 2002:a2e:5353:: with SMTP id t19mr4361187ljd.420.1631588438124; 
 Mon, 13 Sep 2021 20:00:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMJ53kUl85fwoFKO0jD/Mn+1xOg/JoVLdI5iJAiIdNRp7oOfvrQwFmcgQHIrNHTfuUj1XHZ2WPlpBB2cZmu80=
X-Received: by 2002:a2e:5353:: with SMTP id t19mr4361172ljd.420.1631588437904; 
 Mon, 13 Sep 2021 20:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210909123635.30884-1-elic@nvidia.com>
 <20210909123635.30884-4-elic@nvidia.com>
In-Reply-To: <20210909123635.30884-4-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Sep 2021 11:00:27 +0800
Message-ID: <CACGkMEtj+GjqbFzixJkRUikVKftfXMprkHsUAxvCrBGSXj2NYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] vdpa/mlx5: Propagate link status from device to vdpa
 driver
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma <eperezma@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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

On Thu, Sep 9, 2021 at 8:36 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Add code to register to hardware asynchronous events. Use this
> mechanism to track link status events coming from the device and update
> the config struct.
>
> After doing link status change, call the vdpa callback to notify of the
> link status change.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 94 ++++++++++++++++++++++++++++++-
>  1 file changed, 92 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 59f1874648ae..c2b5c62358b8 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -160,6 +160,8 @@ struct mlx5_vdpa_net {
>         struct mlx5_flow_handle *rx_rule;
>         bool setup;
>         u32 cur_num_vqs;
> +       struct notifier_block nb;
> +       struct vdpa_callback config_cb;
>  };
>
>  static void free_resources(struct mlx5_vdpa_net *ndev);
> @@ -1851,6 +1853,7 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
>         ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_CTRL_VQ);
>         ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR);
>         ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MQ);
> +       ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
>
>         print_features(mvdev, ndev->mvdev.mlx_features, false);
>         return ndev->mvdev.mlx_features;
> @@ -1947,8 +1950,10 @@ static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
>
>  static void mlx5_vdpa_set_config_cb(struct vdpa_device *vdev, struct vdpa_callback *cb)
>  {
> -       /* not implemented */
> -       mlx5_vdpa_warn(to_mvdev(vdev), "set config callback not supported\n");
> +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +
> +       ndev->config_cb = *cb;
>  }
>
>  #define MLX5_VDPA_MAX_VQ_ENTRIES 256
> @@ -2393,6 +2398,82 @@ struct mlx5_vdpa_mgmtdev {
>         struct mlx5_vdpa_net *ndev;
>  };
>
> +static u8 query_vport_state(struct mlx5_core_dev *mdev, u8 opmod, u16 vport)
> +{
> +       u32 out[MLX5_ST_SZ_DW(query_vport_state_out)] = {};
> +       u32 in[MLX5_ST_SZ_DW(query_vport_state_in)] = {};
> +       int err;
> +
> +       MLX5_SET(query_vport_state_in, in, opcode, MLX5_CMD_OP_QUERY_VPORT_STATE);
> +       MLX5_SET(query_vport_state_in, in, op_mod, opmod);
> +       MLX5_SET(query_vport_state_in, in, vport_number, vport);
> +       if (vport)
> +               MLX5_SET(query_vport_state_in, in, other_vport, 1);
> +
> +       err = mlx5_cmd_exec_inout(mdev, query_vport_state, in, out);
> +       if (err)
> +               return 0;
> +
> +       return MLX5_GET(query_vport_state_out, out, state);
> +}
> +
> +static bool get_link_state(struct mlx5_vdpa_dev *mvdev)
> +{
> +       if (query_vport_state(mvdev->mdev, MLX5_VPORT_STATE_OP_MOD_VNIC_VPORT, 0) ==
> +           VPORT_STATE_UP)
> +               return true;
> +
> +       return false;
> +}
> +
> +static void update_carrier(struct work_struct *work)
> +{
> +       struct mlx5_vdpa_wq_ent *wqent;
> +       struct mlx5_vdpa_dev *mvdev;
> +       struct mlx5_vdpa_net *ndev;
> +
> +       wqent = container_of(work, struct mlx5_vdpa_wq_ent, work);
> +       mvdev = wqent->mvdev;
> +       ndev = to_mlx5_vdpa_ndev(mvdev);
> +       if (get_link_state(mvdev))
> +               ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> +       else
> +               ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
> +
> +       if (ndev->config_cb.callback)
> +               ndev->config_cb.callback(ndev->config_cb.private);
> +
> +       kfree(wqent);
> +}
> +
> +static int event_handler(struct notifier_block *nb, unsigned long event, void *param)
> +{
> +       struct mlx5_vdpa_net *ndev = container_of(nb, struct mlx5_vdpa_net, nb);
> +       struct mlx5_eqe *eqe = param;
> +       int ret = NOTIFY_DONE;
> +       struct mlx5_vdpa_wq_ent *wqent;
> +
> +       if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
> +               switch (eqe->sub_type) {
> +               case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
> +               case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
> +                       wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
> +                       if (!wqent)
> +                               return NOTIFY_DONE;
> +
> +                       wqent->mvdev = &ndev->mvdev;
> +                       INIT_WORK(&wqent->work, update_carrier);
> +                       queue_work(ndev->mvdev.wq, &wqent->work);
> +                       ret = NOTIFY_OK;
> +                       break;
> +               default:
> +                       return NOTIFY_DONE;
> +               }
> +               return ret;
> +       }
> +       return ret;
> +}
> +
>  static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
>  {
>         struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
> @@ -2441,6 +2522,11 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
>         if (err)
>                 goto err_mtu;
>
> +       if (get_link_state(mvdev))
> +               ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> +       else
> +               ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
> +
>         if (!is_zero_ether_addr(config->mac)) {
>                 pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
>                 err = mlx5_mpfs_add_mac(pfmdev, config->mac);
> @@ -2472,6 +2558,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
>                 goto err_res2;
>         }
>
> +       ndev->nb.notifier_call = event_handler;
> +       mlx5_notifier_register(mdev, &ndev->nb);
>         ndev->cur_num_vqs = 2 * mlx5_vdpa_max_qps(max_vqs);
>         mvdev->vdev.mdev = &mgtdev->mgtdev;
>         err = _vdpa_register_device(&mvdev->vdev, ndev->cur_num_vqs + 1);
> @@ -2502,7 +2590,9 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
>  {
>         struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
>         struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>
> +       mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
>         destroy_workqueue(mvdev->wq);
>         _vdpa_unregister_device(dev);
>         mgtdev->ndev = NULL;
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
