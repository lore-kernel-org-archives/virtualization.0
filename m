Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EEAC433EF
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 09:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A4D883342;
	Wed, 11 May 2022 09:34:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DPaTJtNrBv-K; Wed, 11 May 2022 09:34:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 308D582EF0;
	Wed, 11 May 2022 09:34:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09911C0032;
	Wed, 11 May 2022 09:34:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0616C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9722832EB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:34:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M1Y2QkdntFPj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:34:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A31582EF0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652261680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QX0Cj/+aTx+xhTnveWbfnDHJZzn7y8L+bKOgxixU/4k=;
 b=dVCaNqVnHWm0tz2pU62w1fr7UIlD3J7R7RXuFl5MJpsjd8oFhaj0aMQ5eq8BRZhP6Z+CeM
 3oTytVzltAUTgrnA59i0RX8InnZpYEchky0yri+gNwcdmwTIOSb2pXe9Ixobgzwy/SP1eg
 RZ89ipgpPBIxmvFCLs9dOPXdr92p5+c=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-3M5KTs7aNbmqoEYZOLZFyQ-1; Wed, 11 May 2022 05:34:39 -0400
X-MC-Unique: 3M5KTs7aNbmqoEYZOLZFyQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 x29-20020a0565123f9d00b00471c2bbf57cso595747lfa.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QX0Cj/+aTx+xhTnveWbfnDHJZzn7y8L+bKOgxixU/4k=;
 b=flZwOD7XlgBvqxo9M0Cj7OYhjddRbbbOpcRm9eOuZ+rjvkj4EUUy41IURcQ3mOPQbO
 VcuAEVulsww3MQXsTTtOLR3nHwpyTIK0tv1V8iyJWOInBLUWVlc4q/372JLF8XY7DVqn
 Qhnh95GYVu91FbbNNB0IVC2ek+49bqvL/PeiD8fqYf6X7jSk9t1MdTeZvqfYqvLnqyd9
 GVLbylPGPCEn/WT211XtTsRxdGeQy2J/x+muJGCJo8Z4CJxUmNOF5xXs+AZgj/f9pDAc
 +onKlStkT+oMHdGcGyyud+mZTDAnndUNA+NRCsLHVPpCKB853i+dLypLwvhSQW8H2tOT
 JvRg==
X-Gm-Message-State: AOAM532uHYshnZydQiRGg5tPHVpuEqX/bd3qtNLfQWTlQ9tFgrww5dMr
 02450pd7iiSa5IYpCKftYyu53tMYTELY9fGzHsG4mr0DqJz4SpIkG2qOQaAb9ToDqFzZbKW+ixQ
 EDWgAYIh/fajB5PtrgCrzPkykMXdPC2BtHYnCwJgHBoxQeCiVkX8SDc2rmQ==
X-Received: by 2002:ac2:4e14:0:b0:474:1f4d:9b86 with SMTP id
 e20-20020ac24e14000000b004741f4d9b86mr12529117lfr.257.1652261678188; 
 Wed, 11 May 2022 02:34:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwSR3boxqB9WdjMa8GSORmdjNZKJuW9jsa+GGmDPHgBa8GPteEbR7AZJKTagjR6DSaEVD6g/u41NoP+SGevjE=
X-Received: by 2002:ac2:4e14:0:b0:474:1f4d:9b86 with SMTP id
 e20-20020ac24e14000000b004741f4d9b86mr12529040lfr.257.1652261676518; Wed, 11
 May 2022 02:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220511084804.82482-1-elic@nvidia.com>
In-Reply-To: <20220511084804.82482-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 May 2022 17:34:25 +0800
Message-ID: <CACGkMEt9h=hGH9cGj=NNLrGtvg2PguS8-pe4trxNUQOxmTRsog@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Warn if MTU configured is too low
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

On Wed, May 11, 2022 at 4:48 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Following the recommendation in virio spec 1.1, a device offering
> VIRTIO_NET_F_MTU should set the mtu to at least 1280 bytes.
>
> Print a warning if this recommendation is not met.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

I wonder why it's a must?

> ---
>  drivers/vdpa/vdpa.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 91f4c13c7c7c..961168fe9094 100644
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

Should be <= ?

Thanks

> +               pr_warn("MTU is below recommended value\n");
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
