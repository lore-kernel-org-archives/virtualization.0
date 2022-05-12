Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E78CC433F5
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 04:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F71860071;
	Thu, 12 May 2022 04:17:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iRAZVCen8EG9; Thu, 12 May 2022 04:17:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E27F1605A5;
	Thu, 12 May 2022 04:17:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4896C0039;
	Thu, 12 May 2022 04:17:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C6E4C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8D9B60D6A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:17:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sgm9Ro55uidu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:17:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1561660D6C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652329023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nWbAcC5FNfHptQ9LOrLEmiCRoHP7fuwDJCSDzfJtlPs=;
 b=YUFU8pTOdvTBtNhP3RAyEnw7sGYLqsxdmXFR2W9enYD6ewxeju324+QmUmnEyhZRxC8FNE
 ctybFBKDiI295X0q3LYCCCoTUVwuNI25xwRO1zF2xuLqChOwPGHnrvAj5z9EwnwfU56EaB
 gZshkXozvUGaoxagmHz653VxKXqsM18=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-j5hltlZNMkqCuX07kIhMPw-1; Thu, 12 May 2022 00:17:00 -0400
X-MC-Unique: j5hltlZNMkqCuX07kIhMPw-1
Received: by mail-lj1-f199.google.com with SMTP id
 j6-20020a2eb706000000b00250c3958dccso1194241ljo.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 21:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nWbAcC5FNfHptQ9LOrLEmiCRoHP7fuwDJCSDzfJtlPs=;
 b=6FgLT6yrbGI689gf80kVQvTA0RzKKpjTT+c/2wWwFnrZhHl2N5o4neIslR8Wiq1dDw
 +iRf3bcamU2EerOeMc+f3A0sBtW1OetVO28Zpj94A8D5XemHIfz5vIfk0H9sEVR3UwWb
 sECJ14Wg/3Wv1ZtNvfTlgDejn9vbzGiOWB9UTVckcSmvdVC/Aw1F7Othejhc0QOOIIMi
 qRTH3CiO/tftbc2Cg28TnJSRk/fQQILH5FpFWynYpQQ5wRWnVLvVNdnEzQtBJD8EW0pL
 S0r2yV5VQQY1UwZUDeoSxBZXKrBVn0JZhEPcoSXocvRYX1ZTl/W6fTRM6XMCsKZ8DTFi
 hMZA==
X-Gm-Message-State: AOAM5306nmf9fp+C9jHrsxMxmakeOwTfKjxOnZ3XkqSaydOjsAzaLvk5
 Z0v96mP0SSlZilspDYCluySac14CmRZ1S0WWYGdctDkaYSN4ziMvdRzrD5OpsQ7i9SWwF3co8Zg
 6m85NjsyJhbZnJr33UNiKlzAbZ6dETmXDpRsnUsUOulyWHztUkrFwAKkp9Q==
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr22275127lfj.587.1652329018972; 
 Wed, 11 May 2022 21:16:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqLAe52aFmtc+0GRPlfXryAbcmK9F8xqKCqbMEXRgK+5kNtP1dCuwfUe4PS/JXUaam3EoOd/RiICH6rsBNVb0=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr22275113lfj.587.1652329018751; Wed, 11
 May 2022 21:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220511105642.124806-1-elic@nvidia.com>
In-Reply-To: <20220511105642.124806-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 May 2022 12:16:47 +0800
Message-ID: <CACGkMEv2FGZ3na_HpAWorjBPN1vSp4_pmjz0s9O_hOoSihCL-w@mail.gmail.com>
Subject: Re: [PATCH v1] vdpa: Warn if MTU configured is too low
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Si-Wei Liu <si-wei.liu@oracle.com>,
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

On Wed, May 11, 2022 at 6:56 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Following the recommendation in virio spec 1.1, a device offering
> VIRTIO_NET_F_MTU should set the mtu to at least 1280 bytes.
>
> Print a warning if this recommendation is not met.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v0 -> v1:
>   chage pr_warn to netlink warning to userspace
>
>  drivers/vdpa/vdpa.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 91f4c13c7c7c..0fb4a615f267 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -583,6 +583,9 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>                                  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     | \
>                                  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
>
> +/* Recommended virtio spec 1.1 section 5.1.4.1 */
> +#define VIRTIO_MIN_PREFERRED_MTU 1280
> +
>  static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>         struct vdpa_dev_set_config config = {};
> @@ -634,6 +637,10 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>                 err = PTR_ERR(mdev);
>                 goto err;
>         }
> +       if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MTU)) &&
> +           (config.mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU) &&
> +           config.net.mtu < VIRTIO_MIN_PREFERRED_MTU))
> +               NL_SET_ERR_MSG_MOD(info->extack, "MTU is below recommended value\n");

Can this function be used for warning? I have a quick cscope that
tells me it's probably used only for error.

Will it be better if we fail only when the device supports VERSION_1?

Thanks

>         if ((config.mask & mdev->config_attr_mask) != config.mask) {
>                 NL_SET_ERR_MSG_MOD(info->extack,
>                                    "All provided attributes are not supported");
> @@ -1135,7 +1142,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>         [VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
>         [VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>         /* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
> -       [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> +       [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, ETH_MIN_MTU),
>  };
>
>  static const struct genl_ops vdpa_nl_ops[] = {
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
