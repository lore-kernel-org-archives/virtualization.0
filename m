Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90635C54EBE
	for <virtualization@archiver.kernel.org>; Mon,  9 Jan 2023 09:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15E7181B52;
	Mon,  9 Jan 2023 09:11:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 15E7181B52
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MSZeAm5/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AoHt7z_T9fMU; Mon,  9 Jan 2023 09:11:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 969FB81AF5;
	Mon,  9 Jan 2023 09:11:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 969FB81AF5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A35DC0032;
	Mon,  9 Jan 2023 09:11:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC4C6C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 09:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AED4B40144
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 09:11:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AED4B40144
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MSZeAm5/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M-EmDlctPlac
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 09:11:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 076774052A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 076774052A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 09:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673255471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HWWqZ6YiCIVKb+/I92luLFC/9FKuoyt9EFa6x3IMgw=;
 b=MSZeAm5/HdMUhMDj2QoI5xmO/yv/rqU8YxsZfuOToxo7NM2xb4krsl0Ph2sJt9Ult846R7
 Sw5YCQiha6O9TUCoeM9RjbvpVlCZdQogOpZmI79xe5LCtJ7t7BbDgvWcxTENug6Rf1V5dS
 rS7xRbOjs73Nd0si7j/eCUJ6RsPKq44=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-457-NHON2P22McqHr57BRuTiEQ-1; Mon, 09 Jan 2023 04:11:10 -0500
X-MC-Unique: NHON2P22McqHr57BRuTiEQ-1
Received: by mail-oo1-f69.google.com with SMTP id
 i21-20020a4a9295000000b004a398cd439bso3028353ooh.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Jan 2023 01:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9HWWqZ6YiCIVKb+/I92luLFC/9FKuoyt9EFa6x3IMgw=;
 b=1Izm0K6uSOWBSi1gV93twgTKU2WuS77puH5cPhSqv9DBOARzD2IO1Z/vMYTtPw9R4Q
 i/K9/Wig99QEzmYg6+H1HVog02OASG2mHP3uy8U5C8ob+Hu52PrRM3pmWX6e09aVhezW
 9aDKQkpdP1NMPqX8ZyTLElrKjmvSkfWNVL8GwD8WCzUuiCHyYajpV4lW8V3kj2wqDeuE
 AsRXyrqdWoxa7sHTnLfy8fqfpOX+/5J/DBBX8Hu6DmdJ3BHQcbFrfF/Jf3zLUYJfbKJx
 fPjExH07gwfi9MTxvDz7WlArI1AFf4ILaKGvcHkjTV3Dbu3LIXk/L/zNhDYDqnAJKXld
 UG1A==
X-Gm-Message-State: AFqh2kpEFA8C9IlySBLE6WS/pG1o1UfEnKBIyMuuXoRwgC+k9Yt4SLLj
 zu7VMGu9CFmBMyG/ZWY7mxaeKzWL0RNwEd/45CsWmbFXwUtMeDE+CaY1loQm6UPjcT6vILpugc7
 3+VbxQ7zoUll3NpaQv2Oji82gt5kIRBlsA4mKw0r9C6ae+COdtrbjofER+A==
X-Received: by 2002:a54:4e89:0:b0:35c:303d:fe37 with SMTP id
 c9-20020a544e89000000b0035c303dfe37mr2722581oiy.35.1673255469659; 
 Mon, 09 Jan 2023 01:11:09 -0800 (PST)
X-Google-Smtp-Source: AMrXdXttJKR/AoV8GFnwdVWMBlXdcjw+JUR7pL8NbCWd68LCnWDwPiU7BjZq8ZXgx0rc58L+jlA8LjaLEdKo8joiBnA=
X-Received: by 2002:a54:4e89:0:b0:35c:303d:fe37 with SMTP id
 c9-20020a544e89000000b0035c303dfe37mr2722576oiy.35.1673255469418; Mon, 09 Jan
 2023 01:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20230104074418.1737510-1-yangyingliang@huawei.com>
In-Reply-To: <20230104074418.1737510-1-yangyingliang@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Jan 2023 17:10:58 +0800
Message-ID: <CACGkMEu90=fC3Nnj37c3PWqyiRAj=x5CBn3Zo5zGqSQcA3H+NA@mail.gmail.com>
Subject: Re: [PATCH -next] vdpa/mlx5: fix check wrong pointer in
 mlx5_vdpa_add_mac_vlan_rules()
To: Yang Yingliang <yangyingliang@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: elic@nvidia.com, mst@redhat.com, virtualization@lists.linux-foundation.org
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

On Wed, Jan 4, 2023 at 3:42 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> The local variable 'rule' is not used anymore, fix return value
> check after calling mlx5_add_flow_rules().
>
> Fixes: 8b14d56c6128 ("vdpa/mlx5: Add RX counters to debugfs")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 6632651b1e54..75f800685677 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1454,7 +1454,6 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>  {
>         struct mlx5_flow_destination dests[NUM_DESTS] = {};
>         struct mlx5_flow_act flow_act = {};
> -       struct mlx5_flow_handle *rule;
>         struct mlx5_flow_spec *spec;
>         void *headers_c;
>         void *headers_v;
> @@ -1494,8 +1493,8 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>         dests[1].counter_id = mlx5_fc_id(node->ucast_counter.counter);
>  #endif
>         node->ucast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
> -       if (IS_ERR(rule)) {
> -               err = PTR_ERR(rule);
> +       if (IS_ERR(node->ucast_rule)) {
> +               err = PTR_ERR(node->ucast_rule);
>                 goto err_ucast;
>         }
>
> @@ -1508,8 +1507,8 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>         dmac_c[0] = 1;
>         dmac_v[0] = 1;
>         node->mcast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
> -       if (IS_ERR(rule)) {
> -               err = PTR_ERR(rule);
> +       if (IS_ERR(node->mcast_rule)) {
> +               err = PTR_ERR(node->mcast_rule);
>                 goto err_mcast;
>         }
>         kvfree(spec);
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
