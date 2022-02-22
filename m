Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3A1C433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 07:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95AE340145;
	Tue, 22 Feb 2022 07:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LuiroPldVoSB; Tue, 22 Feb 2022 07:57:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9EA6440140;
	Tue, 22 Feb 2022 07:57:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7783FC0021;
	Tue, 22 Feb 2022 07:57:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FF9FC0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B9DA40145
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:57:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tC7IDMDsLNXf
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:57:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 213C040140
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645516672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jak+R5KzARn5K1izhjT97Tj8yU7wN3uYReK7z1qVK18=;
 b=i3I+ymQiEW5oeOswHd8ki6K+PSwrhWHJvzzf99PDrl2gSX5TaskqDwQ13BdXe0vwdLS9PD
 Hy6SuRXzc7FlMafekoGGeGr/lwI24kF+G3Qgad3+eKr111j8W/IuHC3JXTsE8gs0Pf9ICm
 LZeGVK8S7tAqvQrVR6oVMJpAq0Z+o70=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-h8SH50KrOWq5ZGBii3feOw-1; Tue, 22 Feb 2022 02:57:51 -0500
X-MC-Unique: h8SH50KrOWq5ZGBii3feOw-1
Received: by mail-lj1-f199.google.com with SMTP id
 r27-20020a2e575b000000b002463f43ca0aso2663335ljd.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 23:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jak+R5KzARn5K1izhjT97Tj8yU7wN3uYReK7z1qVK18=;
 b=t7N2FIYUW9ZgX8bvflZaZ8U/O2+rHzRG3wnKMuyFocTqCzFpowWLLs5YRbUpp8Ztoz
 OtZlej2XOtp0YzRBzcGD+o2H3eHEPICWS+XU5iN6emPsLp4CueOl7WiHs67YAed+Dkb7
 0e1CjaNTWZZ58wzv62D6lUbICpAxlL7RT5YxD/mcIiYUOukiyMxTjY2xma+Z4A81mNdS
 4Nmnf9SSE6MBY6qpupXDVRO2yst9DRMozLxv7qrtSlsICGr1cof/2h6/qSjW/D/LrXp6
 I+xt/53QgHVQN8Bd3GYIhTvQae1GPN9ec9Mj6Dwecwjgt6kfKMuKmwHNYQf4SOpWGRB0
 evvg==
X-Gm-Message-State: AOAM531GJfwXT+Rb2xF3nbHS8/KCG2wI37NcBOd7aCd+N6cHzCuXZAwD
 uDqXIguMQ66LhPfjrqjfQMgjFjayqc/lf6wID2faebwFUa9WAHe+Rms8p3eIjx9Kv7G5fOTfHT0
 e6zeEqrVDfSSRZK83FiJFd+MazEg8VyxdUHy+Rm7z3b95B4NKw4/0TiEOLw==
X-Received: by 2002:ac2:5dc9:0:b0:443:5db1:244c with SMTP id
 x9-20020ac25dc9000000b004435db1244cmr16813186lfq.84.1645516669641; 
 Mon, 21 Feb 2022 23:57:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRD4SZY3hFMpUcSFnP6oSzTp5IlGuyhQh7h1DPkXZ7soRwiqP+cNY1NipEPu075HgHchKGXdUYwQaJ2k8Qlss=
X-Received: by 2002:ac2:5dc9:0:b0:443:5db1:244c with SMTP id
 x9-20020ac25dc9000000b004435db1244cmr16813178lfq.84.1645516669410; Mon, 21
 Feb 2022 23:57:49 -0800 (PST)
MIME-Version: 1.0
References: <20220221131751.197830-1-elic@nvidia.com>
 <20220221131751.197830-3-elic@nvidia.com>
In-Reply-To: <20220221131751.197830-3-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Feb 2022 15:57:37 +0800
Message-ID: <CACGkMEtJitAH3bnsu5Z5wgCa+ooTGxZsLxzgu-j7RZsWVZZ8mg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] vdpa: Allow for printing negotiated features of a
 device
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

On Mon, Feb 21, 2022 at 9:18 PM Eli Cohen <elic@nvidia.com> wrote:
>
> When reading the configuration of a vdpa device, check if the
> VDPA_ATTR_DEV_NEGOTIATED_FEATURES is available. If it is, parse the
> feature bits and print a string representation of each of the feature
> bits.
>
> We keep the strings in two different arrays. One for net device related
> devices and one for generic feature bits.
>
> In this patch we parse only net device specific features. Support for
> other devices can be added later. If the device queried is not a net
> device, we print its bit number only.
>
> Examples:
> 1. Standard presentation
> $ vdpa dev config show vdpa-a
> vdpa-a: mac 00:00:00:00:88:88 link up link_announce false max_vq_pairs 2 mtu 9000
>   negotiated_features CSUM GUEST_CSUM MTU MAC HOST_TSO4 HOST_TSO6 STATUS \
> CTRL_VQ MQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>
> 2. json output
> $ vdpa -j dev config show vdpa-a
> {"config":{"vdpa-a":{"mac":"00:00:00:00:88:88","link":"up","link_announce":false,\
> "max_vq_pairs":2,"mtu":9000,"negotiated_features":["CSUM","GUEST_CSUM",\
> "MTU","MAC","HOST_TSO4","HOST_TSO6","STATUS","CTRL_VQ","MQ","CTRL_MAC_ADDR",\
> "VERSION_1","ACCESS_PLATFORM"]}}}
>
> 3. Pretty json
> $ vdpa -jp dev config show vdpa-a
> {
>     "config": {
>         "vdpa-a": {
>             "mac": "00:00:00:00:88:88",
>             "link ": "up",
>             "link_announce ": false,
>             "max_vq_pairs": 2,
>             "mtu": 9000,
>             "negotiated_features": [
> "CSUM","GUEST_CSUM","MTU","MAC","HOST_TSO4","HOST_TSO6","STATUS","CTRL_VQ",\
> "MQ","CTRL_MAC_ADDR","VERSION_1","ACCESS_PLATFORM" ]
>         }
>     }
> }
>
> Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  vdpa/include/uapi/linux/vdpa.h |   2 +
>  vdpa/vdpa.c                    | 107 ++++++++++++++++++++++++++++++++-
>  2 files changed, 107 insertions(+), 2 deletions(-)
>
> diff --git a/vdpa/include/uapi/linux/vdpa.h b/vdpa/include/uapi/linux/vdpa.h
> index b7eab069988a..748c350450b2 100644
> --- a/vdpa/include/uapi/linux/vdpa.h
> +++ b/vdpa/include/uapi/linux/vdpa.h
> @@ -40,6 +40,8 @@ enum vdpa_attr {
>         VDPA_ATTR_DEV_NET_CFG_MAX_VQP,          /* u16 */
>         VDPA_ATTR_DEV_NET_CFG_MTU,              /* u16 */
>
> +       VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
> +
>         /* new attributes must be added above here */
>         VDPA_ATTR_MAX,
>  };
> diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
> index 4ccb564872a0..5f1aa91a4b96 100644
> --- a/vdpa/vdpa.c
> +++ b/vdpa/vdpa.c
> @@ -10,6 +10,8 @@
>  #include <linux/virtio_net.h>
>  #include <linux/netlink.h>
>  #include <libmnl/libmnl.h>
> +#include <linux/virtio_ring.h>
> +#include <linux/virtio_config.h>
>  #include "mnl_utils.h"
>  #include <rt_names.h>
>
> @@ -78,6 +80,7 @@ static const enum mnl_attr_data_type vdpa_policy[VDPA_ATTR_MAX + 1] = {
>         [VDPA_ATTR_DEV_VENDOR_ID] = MNL_TYPE_U32,
>         [VDPA_ATTR_DEV_MAX_VQS] = MNL_TYPE_U32,
>         [VDPA_ATTR_DEV_MAX_VQ_SIZE] = MNL_TYPE_U16,
> +       [VDPA_ATTR_DEV_NEGOTIATED_FEATURES] = MNL_TYPE_U64,
>  };
>
>  static int attr_cb(const struct nlattr *attr, void *data)
> @@ -385,6 +388,96 @@ static const char *parse_class(int num)
>         return class ? class : "< unknown class >";
>  }
>
> +static const char * const net_feature_strs[64] = {
> +       [VIRTIO_NET_F_CSUM] = "CSUM",
> +       [VIRTIO_NET_F_GUEST_CSUM] = "GUEST_CSUM",
> +       [VIRTIO_NET_F_CTRL_GUEST_OFFLOADS] = "CTRL_GUEST_OFFLOADS",
> +       [VIRTIO_NET_F_MTU] = "MTU",
> +       [VIRTIO_NET_F_MAC] = "MAC",
> +       [VIRTIO_NET_F_GUEST_TSO4] = "GUEST_TSO4",
> +       [VIRTIO_NET_F_GUEST_TSO6] = "GUEST_TSO6",
> +       [VIRTIO_NET_F_GUEST_ECN] = "GUEST_ECN",
> +       [VIRTIO_NET_F_GUEST_UFO] = "GUEST_UFO",
> +       [VIRTIO_NET_F_HOST_TSO4] = "HOST_TSO4",
> +       [VIRTIO_NET_F_HOST_TSO6] = "HOST_TSO6",
> +       [VIRTIO_NET_F_HOST_ECN] = "HOST_ECN",
> +       [VIRTIO_NET_F_HOST_UFO] = "HOST_UFO",
> +       [VIRTIO_NET_F_MRG_RXBUF] = "MRG_RXBUF",
> +       [VIRTIO_NET_F_STATUS] = "STATUS",
> +       [VIRTIO_NET_F_CTRL_VQ] = "CTRL_VQ",
> +       [VIRTIO_NET_F_CTRL_RX] = "CTRL_RX",
> +       [VIRTIO_NET_F_CTRL_VLAN] = "CTRL_VLAN",
> +       [VIRTIO_NET_F_CTRL_RX_EXTRA] = "CTRL_RX_EXTRA",
> +       [VIRTIO_NET_F_GUEST_ANNOUNCE] = "GUEST_ANNOUNCE",
> +       [VIRTIO_NET_F_MQ] = "MQ",
> +       [VIRTIO_F_NOTIFY_ON_EMPTY] = "NOTIFY_ON_EMPTY",
> +       [VIRTIO_NET_F_CTRL_MAC_ADDR] = "CTRL_MAC_ADDR",
> +       [VIRTIO_F_ANY_LAYOUT] = "ANY_LAYOUT",
> +       [VIRTIO_NET_F_RSC_EXT] = "RSC_EXT",
> +       [VIRTIO_NET_F_HASH_REPORT] = "HASH_REPORT",
> +       [VIRTIO_NET_F_RSS] = "RSS",
> +       [VIRTIO_NET_F_STANDBY] = "STANDBY",
> +       [VIRTIO_NET_F_SPEED_DUPLEX] = "SPEED_DUPLEX",
> +};
> +
> +#define VIRTIO_F_IN_ORDER 35
> +#define VIRTIO_F_NOTIFICATION_DATA 38
> +#define VDPA_EXT_FEATURES_SZ (VIRTIO_TRANSPORT_F_END - \
> +                             VIRTIO_TRANSPORT_F_START + 1)
> +
> +static const char * const ext_feature_strs[VDPA_EXT_FEATURES_SZ] = {
> +       [VIRTIO_RING_F_INDIRECT_DESC - VIRTIO_TRANSPORT_F_START] = "RING_INDIRECT_DESC",
> +       [VIRTIO_RING_F_EVENT_IDX - VIRTIO_TRANSPORT_F_START] = "RING_EVENT_IDX",
> +       [VIRTIO_F_VERSION_1 - VIRTIO_TRANSPORT_F_START] = "VERSION_1",
> +       [VIRTIO_F_ACCESS_PLATFORM - VIRTIO_TRANSPORT_F_START] = "ACCESS_PLATFORM",
> +       [VIRTIO_F_RING_PACKED - VIRTIO_TRANSPORT_F_START] = "RING_PACKED",
> +       [VIRTIO_F_IN_ORDER - VIRTIO_TRANSPORT_F_START] = "IN_ORDER",
> +       [VIRTIO_F_ORDER_PLATFORM - VIRTIO_TRANSPORT_F_START] = "ORDER_PLATFORM",
> +       [VIRTIO_F_SR_IOV - VIRTIO_TRANSPORT_F_START] = "SR_IOV",
> +       [VIRTIO_F_NOTIFICATION_DATA - VIRTIO_TRANSPORT_F_START] = "NOTIFICATION_DATA",
> +};
> +
> +static const char * const *dev_to_feature_str[] = {
> +       [VIRTIO_ID_NET] = net_feature_strs,
> +};
> +
> +static void print_features(struct vdpa *vdpa, uint64_t features, bool mgmtdevf,
> +                          uint16_t dev_id)
> +{
> +       const char * const *feature_strs = NULL;
> +       const char *s;
> +       int i;
> +
> +       if (dev_id < ARRAY_SIZE(dev_to_feature_str))
> +               feature_strs = dev_to_feature_str[dev_id];
> +
> +       if (mgmtdevf)
> +               pr_out_array_start(vdpa, "dev_features");
> +       else
> +               pr_out_array_start(vdpa, "negotiated_features");
> +
> +       for (i = 0; i < 64; i++) {
> +               if (!(features & (1ULL << i)))
> +                       continue;
> +
> +               if (i < VIRTIO_TRANSPORT_F_START || i > VIRTIO_TRANSPORT_F_END) {
> +                       if (feature_strs) {
> +                               s = feature_strs[i];
> +                       } else {
> +                               s = NULL;
> +                       }
> +               } else {
> +                       s = ext_feature_strs[i - VIRTIO_TRANSPORT_F_START];
> +               }
> +               if (!s)
> +                       print_uint(PRINT_ANY, NULL, " bit_%d", i);
> +               else
> +                       print_string(PRINT_ANY, NULL, " %s", s);
> +       }
> +
> +       pr_out_array_end(vdpa);
> +}
> +
>  static void pr_out_mgmtdev_show(struct vdpa *vdpa, const struct nlmsghdr *nlh,
>                                 struct nlattr **tb)
>  {
> @@ -579,9 +672,10 @@ static int cmd_dev_del(struct vdpa *vdpa,  int argc, char **argv)
>         return mnlu_gen_socket_sndrcv(&vdpa->nlg, nlh, NULL, NULL);
>  }
>
> -static void pr_out_dev_net_config(struct nlattr **tb)
> +static void pr_out_dev_net_config(struct vdpa *vdpa, struct nlattr **tb)
>  {
>         SPRINT_BUF(macaddr);
> +       uint64_t val_u64;
>         uint16_t val_u16;
>
>         if (tb[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> @@ -610,6 +704,15 @@ static void pr_out_dev_net_config(struct nlattr **tb)
>                 val_u16 = mnl_attr_get_u16(tb[VDPA_ATTR_DEV_NET_CFG_MTU]);
>                 print_uint(PRINT_ANY, "mtu", "mtu %d ", val_u16);
>         }
> +       if (tb[VDPA_ATTR_DEV_NEGOTIATED_FEATURES]) {
> +               uint16_t dev_id = 0;
> +
> +               if (tb[VDPA_ATTR_DEV_ID])
> +                       dev_id = mnl_attr_get_u32(tb[VDPA_ATTR_DEV_ID]);
> +
> +               val_u64 = mnl_attr_get_u64(tb[VDPA_ATTR_DEV_NEGOTIATED_FEATURES]);
> +               print_features(vdpa, val_u64, false, dev_id);
> +       }
>  }
>
>  static void pr_out_dev_config(struct vdpa *vdpa, struct nlattr **tb)
> @@ -619,7 +722,7 @@ static void pr_out_dev_config(struct vdpa *vdpa, struct nlattr **tb)
>         pr_out_vdev_handle_start(vdpa, tb);
>         switch (device_id) {
>         case VIRTIO_ID_NET:
> -               pr_out_dev_net_config(tb);
> +               pr_out_dev_net_config(vdpa, tb);
>                 break;
>         default:
>                 break;
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
