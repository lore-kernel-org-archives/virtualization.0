Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E83C38A2D
	for <virtualization@archiver.kernel.org>; Mon, 24 Oct 2022 08:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDF5D81366;
	Mon, 24 Oct 2022 08:40:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDF5D81366
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gRZ1adkO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W8VXDI-EIjrZ; Mon, 24 Oct 2022 08:40:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5ACC98131B;
	Mon, 24 Oct 2022 08:40:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5ACC98131B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27C43C0033;
	Mon, 24 Oct 2022 08:40:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11B95C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 08:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0FD14030F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 08:40:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0FD14030F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gRZ1adkO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sro2R4Mah0R8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 08:40:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 975F24025F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 975F24025F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 08:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666600817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jOtyWoqxkZ/eX0vtXBOH4xVpL53S8rDbYyVtgKpmPhw=;
 b=gRZ1adkOMpgbwP8zDM+HREsurDCpTgZ3HyovEVuGiYRLutdPiraCU29uPfviyxsi7Hg1yY
 4VEnhEPa3c60oUex/PR0O+ykRSZ0iRk8+eAb638FF37hgHao69lwCiDySrfPhYMlz8WU8R
 4bR/ekmy0Pd21iNDTIrNHj6jAlqz8Iw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-13-32SPsf7cPc6D-vZ4P6bduQ-1; Mon, 24 Oct 2022 04:40:15 -0400
X-MC-Unique: 32SPsf7cPc6D-vZ4P6bduQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 e10-20020a4a91ca000000b0047f7bf95662so4268878ooh.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 01:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jOtyWoqxkZ/eX0vtXBOH4xVpL53S8rDbYyVtgKpmPhw=;
 b=NVAvwZUWlbjeUYJLHEqF/jxdazZddvLW46u5W4Rtb9IS3TjNE5vFJibGDfCI77P2D3
 9HJKaDvCUIHYZZgq4VSc0xzIY+HFxJo9ZC1ySnoeqKVSoJJ8ueq+TCyUyVO5DdAY0Lgu
 8G8jedW2tVZMoiYfDe4IQ22e7728IYUoQADsoxUs3BTevZyx1SiiyUr6gvsBuxeQ8KZU
 zxb/QUrxCvk8rNSYM0qeAFwnbuNyuLVECBUaJDGLzUF5YVs7z6hwHW07zGSfEO9/SeOs
 u1OYO/xLrQF6xKadlb1YPSviHbnTwI68G0025dYTWtWxv8XSCgVRceWVc1R1WDhLc2EB
 y6tw==
X-Gm-Message-State: ACrzQf3BmvMsPk+IscAtgioaQYh6HvDyKNbbxvMccocUgx4AervwRBjZ
 fiucgA1PoRUa1G4onsccwJABmJMus+WBsaEU/yC44KaGUl/fe1UShQtMd0yDB1tRgoONsjeTrZG
 8qPgrP3J35ICaJTryD5LFFu+Z3qwJ/gkCcWoe8pFACS3fQ/IR/QtyI9wnuQ==
X-Received: by 2002:a4a:c590:0:b0:480:5ecf:85f4 with SMTP id
 x16-20020a4ac590000000b004805ecf85f4mr14098470oop.93.1666600814956; 
 Mon, 24 Oct 2022 01:40:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Ujz325p1cEEZ0K87dSJzKxjltvHmnBxpIgouVrUw+DXeA7g2lWNByih9zLWwML4S4QBTumyt6BFF4MfxxWKI=
X-Received: by 2002:a4a:c590:0:b0:480:5ecf:85f4 with SMTP id
 x16-20020a4ac590000000b004805ecf85f4mr14098460oop.93.1666600814718; Mon, 24
 Oct 2022 01:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
 <1666392237-4042-4-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1666392237-4042-4-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Oct 2022 16:40:03 +0800
Message-ID: <CACGkMEti0Z2_sqJbBh_bOVq2ijSUJ96OPS-qd+P4bV490XAA3w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] vdpa: show dev config as-is in "vdpa dev show"
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

On Sat, Oct 22, 2022 at 7:49 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> Live migration of vdpa would typically require re-instate vdpa
> device with an idential set of configs on the destination node,
> same way as how source node created the device in the first
> place. In order to save orchestration software from memorizing
> and keeping track of vdpa config, it will be helpful if the vdpa
> tool provides the aids for exporting the initial configs as-is,
> the way how vdpa device was created. The "vdpa dev show" command
> seems to be the right vehicle for that. It is unlike the "vdpa dev
> config show" command output which usually goes with the live value
> in the device config space, and is not quite reliable subject to
> the dynamics of feature negotiation or possible change by the
> driver to the config space.
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
>   initial_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> $ vdpa dev -jp show
> {
>     "dev": {
>         "vdpa0": {
>             "type": "network",
>             "mgmtdev": "pci/0000:41:04.2",
>             "vendor_id": 5555,
>             "max_vqs": 9,
>             "max_vq_size": 256,
>             "initial_config": {
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
> index bebded6..bfb8f54 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -677,6 +677,41 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>  }
>
>  static int
> +vdpa_dev_initcfg_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 device_id)
> +{
> +       struct vdpa_dev_set_config *cfg = &vdev->init_cfg;
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
> +       default:
> +               break;
> +       }
> +
> +       if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &&
> +           nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
> +                             cfg->device_features, VDPA_ATTR_PAD))
> +               return err;

A question: If any of those above attributes were not provisioned,
should we show the ones that are inherited from the parent?

Thanks

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
> +       err = vdpa_dev_initcfg_fill(vdev, msg, device_id);
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
