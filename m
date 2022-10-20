Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDD5C433FE
	for <virtualization@archiver.kernel.org>; Thu, 20 Oct 2022 05:40:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2173A4198A;
	Thu, 20 Oct 2022 05:40:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2173A4198A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NxYAwD5K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nqOGDl8RtcKh; Thu, 20 Oct 2022 05:40:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 49BC44197D;
	Thu, 20 Oct 2022 05:40:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49BC44197D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F33E1C0032;
	Thu, 20 Oct 2022 05:40:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6D9CC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 05:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 89B7B83E44
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 05:40:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 89B7B83E44
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NxYAwD5K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bq4It6atLBYu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 05:40:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A667483E3E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A667483E3E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 05:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666244446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3cLm9HnF52RPDChT7zvm6M4NNF+pwOpLfcF1b46hwk4=;
 b=NxYAwD5K7VIgaTi3+C9zhvuIanJX0Hiz/hEmhbVWO9TFWdyLrqcMZ4DS63xi1g2U2vJKpN
 wlOE0WO5J0HWSxpje6A6znZscfva/CdWsAwXPdCXWDtU3djQ/f4DFpB1+zZDcVd/bwQDjH
 d4CiCwzYufa9akU+Pi8tDdQlOKeHvBw=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-583-nHcHnH_BOiCUtdagsfd-Iw-1; Thu, 20 Oct 2022 01:40:45 -0400
X-MC-Unique: nHcHnH_BOiCUtdagsfd-Iw-1
Received: by mail-oi1-f197.google.com with SMTP id
 w136-20020acaad8e000000b003552d4729d6so5600608oie.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 22:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3cLm9HnF52RPDChT7zvm6M4NNF+pwOpLfcF1b46hwk4=;
 b=q+Vl5PKoz8iLM0DZTYFbirqgPZ0SLgJUWTA0uw4jOzGM90xHrg/QUJDBrfrbB0H6FO
 slag87hCJQ0R+/SDYt38ztjcdcyv+nHPRRPfNmt3TrsGSGyZFriniAQPEJq3UI51WBoH
 md9XKduU1hR70ZHhH5qwOpo7UOCfJVyOIuhiMz10VWRPD8RYw6Nq/ojWGrg/AWCiv1J+
 fXmztu877RFyhRHU663v3i/apppSv92oMy/gg1jeYdVXk8LxsujE54bV61Mb+iaC1nuJ
 0br9InsMZTWixqJwt0spajkbm6jynhtFS/BF2kSohXurRWHv9Qea+t24w4HhwYIDT1eL
 yNMg==
X-Gm-Message-State: ACrzQf1eBvnJSpvLep00IdjoiXt73WzySVrUTs1DGOKERl/YLyuF7DGA
 ZIvkq/zolvwcJrp/Prp3Zvq1Wxv85hUga+KCQhNksOOVcfBCzIYTeS2nE+9iQSrKKMmVMeukzNi
 2N0iCB/R8uZQ/jFpNlUWCi+y7tK6ysbLf80pxaqlGz7iPiG4X2pC073RUfg==
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id
 k15-20020a9d7dcf000000b00661dc250ba0mr6006240otn.201.1666244444379; 
 Wed, 19 Oct 2022 22:40:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4KOnL5N1u6m6VXP6xpqvCTdnJWSdwlGbLkZlRfz6DwviF2O1N/QP25F1zjvuTZ8UH3pFNQC3QvWeykzR4PRL8=
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id
 k15-20020a9d7dcf000000b00661dc250ba0mr6006229otn.201.1666244444153; Wed, 19
 Oct 2022 22:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
 <1666137032-28192-5-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1666137032-28192-5-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Oct 2022 13:40:32 +0800
Message-ID: <CACGkMEtV_amYoz7JqpJyyUMDnsZuPJYfXk8bP9Yb1oyJrhpY8w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] vdpa: fix improper error message when adding vdpa
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

On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
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
> index 91eca6d..ff15e0a 100644
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
