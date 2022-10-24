Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEDCFA373F
	for <virtualization@archiver.kernel.org>; Mon, 24 Oct 2022 08:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6494D8126D;
	Mon, 24 Oct 2022 08:43:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6494D8126D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RyJ+1k9n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AxHkOnLmNxr3; Mon, 24 Oct 2022 08:43:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8527780C66;
	Mon, 24 Oct 2022 08:43:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8527780C66
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4198BC0033;
	Mon, 24 Oct 2022 08:43:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31D76C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 08:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E480180C0B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 08:43:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E480180C0B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BngSH0EXj1tm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 08:43:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7EF3380BE6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EF3380BE6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 08:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666601011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EBlUPB1Dnp0ElzXkc2Q3P+CryDXBiZoMR2HhVEPoizo=;
 b=RyJ+1k9nVJQaeOdu7XvDjpzFnU+ji3JANvMSkBWb2CpqMQq6DtOexxZxd92edsqhJMfBYV
 AfHegz5WTwHPj999UhjHCqSAd7K4UmMZ9LVWQVzEQ3V8qLbYPSdt1HUBD2iqCG4Y2+xMvR
 reay5qWSvacXNbdFgzViiy5YCUPPd0A=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-ktEXXpuqPpSo030WJBVYQA-1; Mon, 24 Oct 2022 04:43:28 -0400
X-MC-Unique: ktEXXpuqPpSo030WJBVYQA-1
Received: by mail-ot1-f71.google.com with SMTP id
 l5-20020a9d7345000000b00661c76ded95so5259105otk.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 01:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EBlUPB1Dnp0ElzXkc2Q3P+CryDXBiZoMR2HhVEPoizo=;
 b=aGDPbTV2/kb+v14G5WgBt8gYsWDEy/4e3hNvKKxmtaoJd9fOwmC/LVg+rNimfi5T0N
 yZEv2YSyCJ8YVD8Hbv5ilwoCPoQ05h8sfkznNhiqnZdD5QH4Ie6Hkl+xWwTK2jj1kbJV
 W2wcNw6SPbtev/ggsB6ZK7RAHpEhBwNkUgncIZwihyXUtpOn/9YC8M4sbOQExRwjSN7u
 tQoHr6UsvkIoopJhgkFD9QshkAbj/fto/7Q+XS8l23DFypAl4kNJt4PABmUvacQUitk7
 W2exaSblz03vn8lewwjfzVIqzegChECQQ75iB3cvxfl1kVs08OFWmLpQVrL8VVwWHM4g
 zqdQ==
X-Gm-Message-State: ACrzQf3V5FDhOFSzwz/kT3wCcD2yDPsRDT5ir+AyydMq37yWFbkSkv59
 83cjX6PALvZVAPzWR3Fnqq/OXnChzgnBjNMYcxJUu6RjgJhiItRNIzcdjmLhr8n6twNlzBDBrmF
 KUpY4dbLPeDM5pztcN6ekyU1fo1lFYOvIKBMxrXRm26DTPlsTeeOAdU9HKQ==
X-Received: by 2002:a05:6870:eca8:b0:132:df46:5c66 with SMTP id
 eo40-20020a056870eca800b00132df465c66mr19808365oab.280.1666601007325; 
 Mon, 24 Oct 2022 01:43:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Zb3Orw6wWrAZqEE2L4Qxj7bg42maeF5Lhl/j9tCMcEzX9D2AU5Ii/raMPDKVRJlXIuPk+u3Usv21pTZYHLDc=
X-Received: by 2002:a05:6870:eca8:b0:132:df46:5c66 with SMTP id
 eo40-20020a056870eca800b00132df465c66mr19808358oab.280.1666601007098; Mon, 24
 Oct 2022 01:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
 <1666392237-4042-5-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1666392237-4042-5-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Oct 2022 16:43:15 +0800
Message-ID: <CACGkMEvuExLpzOEDJN_dq+t3MBDNgpnkapyk13xtWBF4nKxutg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] vdpa: fix improper error message when adding vdpa
 dev
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
> In below example, before the fix, mtu attribute is supported
> by the parent mgmtdev, but the error message showing "All
> provided are not supported" is just misleading.
>
> $ vdpa mgmtdev show
> vdpasim_net:
>   supported_classes net
>   max_supported_vqs 3
>   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>
> $ vdpa dev add mgmtdev vdpasim_net name vdpasim0 mtu 5000 max_vqp 2
> Error: vdpa: All provided attributes are not supported.
> kernel answers: Operation not supported
>
> After fix, the relevant error message will be like:
>
> $ vdpa dev add mgmtdev vdpasim_net name vdpasim0 mtu 5000 max_vqp 2
> Error: vdpa: Some provided attributes are not supported.
> kernel answers: Operation not supported
>
> $ vdpa dev add mgmtdev vdpasim_net name vdpasim0 max_vqp 2
> Error: vdpa: All provided attributes are not supported.
> kernel answers: Operation not supported
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index bfb8f54..2638565 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -629,13 +629,20 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>                 err = PTR_ERR(mdev);
>                 goto err;
>         }
> -       if ((config.mask & mdev->config_attr_mask) != config.mask) {
> +       if (config.mask && (config.mask & mdev->config_attr_mask) == 0) {
>                 NL_SET_ERR_MSG_MOD(info->extack,
>                                    "All provided attributes are not supported");
>                 err = -EOPNOTSUPP;
>                 goto err;
>         }
>
> +       if ((config.mask & mdev->config_attr_mask) != config.mask) {
> +               NL_SET_ERR_MSG_MOD(info->extack,
> +                                  "Some provided attributes are not supported");
> +               err = -EOPNOTSUPP;
> +               goto err;
> +       }
> +
>         err = mdev->ops->dev_add(mdev, name, &config);
>  err:
>         up_write(&vdpa_dev_lock);
> --
> 1.8.3.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
