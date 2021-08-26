Return-Path: <SRS0=dyh5=NR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6D3C432BE
	for <virtualization@archiver.kernel.org>; Thu, 26 Aug 2021 03:30:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926D661008
	for <virtualization@archiver.kernel.org>; Thu, 26 Aug 2021 03:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 926D661008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E62580D18;
	Thu, 26 Aug 2021 03:30:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q3DG4bWTAvCe; Thu, 26 Aug 2021 03:30:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E2F3A80D09;
	Thu, 26 Aug 2021 03:30:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1D6DC001A;
	Thu, 26 Aug 2021 03:30:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30F3EC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Aug 2021 03:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1254F407DC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Aug 2021 03:30:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NGggYvd6-1XL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Aug 2021 03:30:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C86F407D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Aug 2021 03:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629948620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eEAbeV6QhPu84KG5CC307zTKXbX2UdBwPkKc0p1KhSE=;
 b=G9aAHO3qBliltCFQA5BSZpizX/RxIZ1jkDGhVmlf2+DfOjwRmUUgGkwe4Jm+2NMcVS+Pop
 Rl7zyPl8Rapke5PvlBI//IhJZYz5bmUIfy+eypnqcFkisIEEJ7FHjDzJmzn+WvXzwG9DG3
 cQpy5zutsS/qKhYks4KseRn/lYl9wZU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-l1o-RGjcMTKHI8Az9iobPg-1; Wed, 25 Aug 2021 23:30:19 -0400
X-MC-Unique: l1o-RGjcMTKHI8Az9iobPg-1
Received: by mail-lj1-f200.google.com with SMTP id
 s15-20020a2eb8cf000000b001cbf358ed4eso528582ljp.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 20:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eEAbeV6QhPu84KG5CC307zTKXbX2UdBwPkKc0p1KhSE=;
 b=j9YWY952n4GVOFSgLvpF+xBN9LWgwyvVCZRZW5BF+h20M3FH5c0oQkRdO7nFszBxkG
 B4AzV0xIO2SdZuk0GRjurILXIqaFGTE7ZAZWLSO917J8NpcRVIxaforjcx0O0Wdpmp9L
 YQo/M47zIGhrNWR0HZgg1xzEDKxqp0hc0qV2DCVZOFpM9E3U7TpjFje9x8U6fhWQjhk7
 c0znk2RtemU5n8i70hP3hj1QX4Pw7ECpJLqXp7QDneiyOU+MiUUtUNxyG67C01zMoWEZ
 gG/FgvDioMS/BvvQ6IxvoXUKNgFU+5ufOx/L09M/YVPjDitcWDODzoC+Zmi64mUAubCC
 Tzxw==
X-Gm-Message-State: AOAM533k1wKkisZNXcBzDwJ3WfMPDeun98YHVAXzLt0od/XQUiV6Rv3W
 BXEWNfQli22DXQDTBCMs+y8l9DPjQcD6Y8PbzjpP93L3+A5DrG0hpUuJSExgwbOaBS6N2rkN3rv
 EX7YxJhXpz045fPg0CsSvfdd+c/AEUbxOg+Jl7YvWpOPf+f+/GGewIiazNQ==
X-Received: by 2002:a05:651c:10a3:: with SMTP id
 k3mr1143740ljn.471.1629948617803; 
 Wed, 25 Aug 2021 20:30:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyovJ4/uCaZXr4m33mK988gFYVkr+C8ARZKldn+ftKy6xj/3lgAQDoaX2wc7igzKNKlWI3wDnMsLWgS4jENFjA=
X-Received: by 2002:a05:651c:10a3:: with SMTP id
 k3mr1143728ljn.471.1629948617641; 
 Wed, 25 Aug 2021 20:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <1629946187-60536-1-git-send-email-linyunsheng@huawei.com>
In-Reply-To: <1629946187-60536-1-git-send-email-linyunsheng@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Aug 2021 11:30:06 +0800
Message-ID: <CACGkMEsphZkkRv5AnXUE_86FUKHMgTXpyVVgDUb+tNdATKQsWA@mail.gmail.com>
Subject: Re: [PATCH net-next] sock: remove one redundant SKB_FRAG_PAGE_ORDER
 macro
To: Yunsheng Lin <linyunsheng@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: aahringo@redhat.com, kvm <kvm@vger.kernel.org>, mst <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, fw@strlen.de, linuxarm@openeuler.org,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, yangbo.lu@nxp.com,
 Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
 davem <davem@davemloft.net>, linux-kernel <linux-kernel@vger.kernel.org>
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

On Thu, Aug 26, 2021 at 10:51 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> Both SKB_FRAG_PAGE_ORDER are defined to the same value in
> net/core/sock.c and drivers/vhost/net.c.
>
> Move the SKB_FRAG_PAGE_ORDER definition to net/core/sock.h,
> as both net/core/sock.c and drivers/vhost/net.c include it,
> and it seems a reasonable file to put the macro.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

>  drivers/vhost/net.c | 2 --
>  include/net/sock.h  | 1 +
>  net/core/sock.c     | 1 -
>  3 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 6414bd5..3a249ee 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -643,8 +643,6 @@ static bool tx_can_batch(struct vhost_virtqueue *vq, size_t total_len)
>                !vhost_vq_avail_empty(vq->dev, vq);
>  }
>
> -#define SKB_FRAG_PAGE_ORDER     get_order(32768)
> -
>  static bool vhost_net_page_frag_refill(struct vhost_net *net, unsigned int sz,
>                                        struct page_frag *pfrag, gfp_t gfp)
>  {
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 95b2577..66a9a90 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2717,6 +2717,7 @@ extern int sysctl_optmem_max;
>  extern __u32 sysctl_wmem_default;
>  extern __u32 sysctl_rmem_default;
>
> +#define SKB_FRAG_PAGE_ORDER    get_order(32768)
>  DECLARE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
>
>  static inline int sk_get_wmem0(const struct sock *sk, const struct proto *proto)
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 950f1e7..62627e8 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2574,7 +2574,6 @@ static void sk_leave_memory_pressure(struct sock *sk)
>         }
>  }
>
> -#define SKB_FRAG_PAGE_ORDER    get_order(32768)
>  DEFINE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
>
>  /**
> --
> 2.7.4
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
