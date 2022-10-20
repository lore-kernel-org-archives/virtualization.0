Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B4AC4332F
	for <virtualization@archiver.kernel.org>; Thu, 20 Oct 2022 05:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D172D41D27;
	Thu, 20 Oct 2022 05:26:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D172D41D27
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BtZ2uNxJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0kHRwVLQwV_b; Thu, 20 Oct 2022 05:26:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E63F4419E4;
	Thu, 20 Oct 2022 05:26:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E63F4419E4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C59DDC0032;
	Thu, 20 Oct 2022 05:26:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49554C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 05:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 167EB404F7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 05:26:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 167EB404F7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BtZ2uNxJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zHejnTKHXkhJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 05:26:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9316404F4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9316404F4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 05:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666243569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+RSA0RntEqf7QmuVbJ4H4/9krr36kS4aFkfU2E/RUmU=;
 b=BtZ2uNxJfEKvca2D4EMVLgjKphdpBPfAxLnMNHoLqaNSbK7gbLUc5eNlgoitf+mb8M280v
 LGpTQM3wh3ht7kdGYPOXhrSDKvOlk1gmbA3ytrV0bi6OqBOXwaf62NZEjuPi3Y8BFmVXOV
 I1+p28JS3/nEC9gvVfZtTC1MdvGHBpQ=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-8-PKJD6WVIM2Cs9KzGFn9LMg-1; Thu, 20 Oct 2022 01:26:08 -0400
X-MC-Unique: PKJD6WVIM2Cs9KzGFn9LMg-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-13234741239so9123969fac.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 22:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+RSA0RntEqf7QmuVbJ4H4/9krr36kS4aFkfU2E/RUmU=;
 b=xmXQgxTn5ZR+RN+Ew/K9f8YuCoERhUoA/Akr9MpzVFgqxPBba5wcKyy2M1Eu+iHety
 zVNBLMoZ08eeJuILsdQCjaqyOdgMoN7urRMH4SEoBWpzrixYjxTgzQwHqCByhyWc2CJ4
 JpI43ZyJs4xv6WkloLwwCXE1HE1Rr9G2JjOFPAq9kInn10MHbGszPEndFQcHvZcXUkoB
 7zoWJkEELiYzRNq8o6cXKp9MTmqsQZf6ExkB9gvAsHFj2UUXsJe+0yvUBuDoo/D5dPQR
 /06BBBjPNzCKnHyPt3r/sGDoQnvpbHp9ffZ11v+KSfNZu5gBAnJXsSgHuClhpuHWWTVA
 C+mw==
X-Gm-Message-State: ACrzQf3KZGKcdCCXj3sHmYTXMoHcsRTenQu6RxmPib5YVwHo+i01AE9v
 tTK09e7+w8Jghym3HxtWgTH74V/a91dtHlP9FIJDzTX4+HBdaV67dCL6N86AEUB2LkDWokUejwP
 t9sdf9bQ2DoMpy57ttA1FFCw10mAhcNKVbNk/0Rp6Oe6MRf0iFDs2spZgSQ==
X-Received: by 2002:a9d:12a8:0:b0:661:a06f:33d7 with SMTP id
 g37-20020a9d12a8000000b00661a06f33d7mr6035173otg.237.1666243567543; 
 Wed, 19 Oct 2022 22:26:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5nSvUC0HcWvAHFOesU6EeZfKDqnoOFz1h2xahVvfHticSDonuZxkzjvKKM0os702cuEIZFj9+ghX/ZL0FOJ/Y=
X-Received: by 2002:a9d:12a8:0:b0:661:a06f:33d7 with SMTP id
 g37-20020a9d12a8000000b00661a06f33d7mr6035164otg.237.1666243567310; Wed, 19
 Oct 2022 22:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
 <1666137032-28192-4-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1666137032-28192-4-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Oct 2022 13:25:55 +0800
Message-ID: <CACGkMEuDn+Y8OEw6uK+FC0oOOd6+kj0EXS4Fm-+54GjrqY3_Gw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] vdpa: show dev config as-is in "vdpa dev show"
 output
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> Live migration of vdpa would typically require re-instate vdpa
> device with an idential set of configs on the destination node,
> same way as how source node created the device in the first
> place. In order to save orchestration software from memorizing
> and keeping track of vdpa config, it will be helpful if the vdpa
> tool provides the aids for exporting the initial configs from
> which vdpa device was created as-is. The "vdpa dev show" command
> seems to be the right vehicle for that. It is unlike the "vdpa dev
> config show" command output that usually goes with the live value
> in the device config space, which is not quite reliable subject to
> the dynamics of feature negotiation and possible change in device
> config space.
>
> Examples:
>
> 1) Create vDPA by default without any config attribute
>
> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
> $ vdpa dev show vdpa0
> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
> $ vdpa dev -jp show vdpa0
> {
>     "dev": {
>         "vdpa0": {
>             "type": "network",
>             "mgmtdev": "pci/0000:41:04.2",
>             "vendor_id": 5555,
>             "max_vqs": 9,
>             "max_vq_size": 256,
>         }
>     }
> }
>
> 2) Create vDPA with config attribute(s) specified
>
> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
>     mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> $ vdpa dev show
> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
>   virtio_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> $ vdpa dev -jp show
> {
>     "dev": {
>         "vdpa0": {
>             "type": "network",
>             "mgmtdev": "pci/0000:41:04.2",
>             "vendor_id": 5555,
>             "max_vqs": 9,
>             "max_vq_size": 256,
>             "virtio_config": {
>                 "mac": "e4:11:c6:d3:45:f0",
>                 "max_vq_pairs": 4
>             }
>         }
>     }
> }
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/vdpa/vdpa.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 566c1c6..91eca6d 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -677,6 +677,41 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>  }
>
>  static int
> +vdpa_dev_cfgattrs_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 device_id)
> +{
> +       struct vdpa_dev_set_config *cfg = &vdev->vdev_cfg;
> +       int err = -EMSGSIZE;
> +
> +       if (!cfg->mask)
> +               return 0;
> +
> +       switch (device_id) {
> +       case VIRTIO_ID_NET:
> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) != 0 &&
> +                   nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
> +                           sizeof(cfg->net.mac), cfg->net.mac))
> +                       return err;
> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) != 0 &&
> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, cfg->net.mtu))
> +                       return err;
> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) != 0 &&
> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> +                               cfg->net.max_vq_pairs))
> +                       return err;
> +               break;

This makes me think if we can reuse the virtio_net_config structure
other than duplicate it slowly with a dedicated nested structure
inside vdpa_dev_set_config then we can reuse the
vdpa_dev_net_config_fill().

Thanks

> +       default:
> +               break;
> +       }
> +
> +       if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &&
> +           nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
> +                             cfg->device_features, VDPA_ATTR_PAD))
> +               return err;
> +
> +       return 0;
> +}
> +
> +static int
>  vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
>               int flags, struct netlink_ext_ack *extack)
>  {
> @@ -715,6 +750,10 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>         if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
>                 goto msg_err;
>
> +       err = vdpa_dev_cfgattrs_fill(vdev, msg, device_id);
> +       if (err)
> +               goto msg_err;
> +
>         genlmsg_end(msg, hdr);
>         return 0;
>
> --
> 1.8.3.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
