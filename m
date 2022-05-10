Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6392DC433F5
	for <virtualization@archiver.kernel.org>; Tue, 10 May 2022 02:06:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 029F84155E;
	Tue, 10 May 2022 02:06:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1trpPABAKyTH; Tue, 10 May 2022 02:06:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 440E5402AC;
	Tue, 10 May 2022 02:06:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10F6DC0039;
	Tue, 10 May 2022 02:06:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DACD2C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 02:06:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C342F40142
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 02:06:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YcCKjma9TvUl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 02:06:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 29CC04002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 02:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652148371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1+7DKJlYnVWlLlv05GdYL70k7bNZ4ECrKaTftEIR5dg=;
 b=cQwTTsyxooTXXp+7j+rluwTNJ6Jry3vCKXEnHgSsqCCVDnmb0H+7+gjLrZYbYWJzMVZf54
 3v0NVjJCaQFQu3fzQLgsba4m8tgq9koNQlqhAC2+cLWTjmnDa/1YApdwTm2gKBX5ldaO3J
 TICxkJGeMggv3w+Yl2M2cW6x6nqZT+w=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-dTmgJKX8PhqgxuwGiqyx6w-1; Mon, 09 May 2022 22:06:10 -0400
X-MC-Unique: dTmgJKX8PhqgxuwGiqyx6w-1
Received: by mail-lf1-f70.google.com with SMTP id
 a13-20020a19ca0d000000b0047233f64994so6601752lfg.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 May 2022 19:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1+7DKJlYnVWlLlv05GdYL70k7bNZ4ECrKaTftEIR5dg=;
 b=yJlKXuqmnfy4emHdSXsGrspCJ5d6cH4o+X72RB2jnom1jzmQWnDNg2U52MTyYnnWgw
 4hZZNQyjTZdu/ucq3MEfxO41PSutZyRmZdgPYUBSztyLNYnpZkjV/Gxkzbl8L3zDiKtY
 C6zW0OiKM3dgHxhhV/DXZDI+BJHeQ/YeFPSZGyPBbiqWcVFwRTjWZKEcEFKbaXK/DXm5
 AvDd+hUT21DqENTE3fiBMWH6MXmIiI979aONMy9b+RB2lXqE/SLODq7FTN7PXZzFut4Q
 LJJmfRKQ+fdCQIJTYMwwkF68LLPIMCqjvBMjFAL1Y7ITHwC1XdJdEPaAryH6Z0iWNtOQ
 f7+w==
X-Gm-Message-State: AOAM5305/6cBqi0W4341tVfbRmgcXMwPilXTkvjSJzJlBkLIGG7mHMl5
 MhgRLu1v/khS1u7l+pRwo4W83eq0vwb/ThkjlylAph4tgyXfjaojLziYPf2CAHvpDiZv7Q049/4
 LMGsw8cHsMwwiirzqGCKsJj/Ti8Miqdv4O3yXNkN53jdnzcvxf3Ab57KkIA==
X-Received: by 2002:a05:6512:1291:b0:473:b522:ef58 with SMTP id
 u17-20020a056512129100b00473b522ef58mr14663342lfs.190.1652148369282; 
 Mon, 09 May 2022 19:06:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqm9wM4Q4M/oBxtLuElylO6DH3m6+GFVYHnDAHl4WJIlpMcpnYNKA34plV6IrXxJfBaTuguqI4UMAX70BJRQI=
X-Received: by 2002:a05:6512:1291:b0:473:b522:ef58 with SMTP id
 u17-20020a056512129100b00473b522ef58mr14663333lfs.190.1652148369130; Mon, 09
 May 2022 19:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220509131432.16568-1-tangbin@cmss.chinamobile.com>
In-Reply-To: <20220509131432.16568-1-tangbin@cmss.chinamobile.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 May 2022 10:05:58 +0800
Message-ID: <CACGkMEtVZ7MA5ZU8rogJYRvuD6D0Zm1Dg_LKXJ2NmPhJ6Smi-A@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Remove unused case in virtio_skb_set_hash()
To: Tang Bin <tangbin@cmss.chinamobile.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 davem <davem@davemloft.net>
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

On Mon, May 9, 2022 at 9:17 PM Tang Bin <tangbin@cmss.chinamobile.com> wrote:
>
> In this function, "VIRTIO_NET_HASH_REPORT_NONE" is included
> in "default", so it canbe removed.
>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/net/virtio_net.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 87838cbe3..b3e5d8637 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1172,7 +1172,6 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
>         case VIRTIO_NET_HASH_REPORT_IPv6_EX:
>                 rss_hash_type = PKT_HASH_TYPE_L3;
>                 break;
> -       case VIRTIO_NET_HASH_REPORT_NONE:
>         default:
>                 rss_hash_type = PKT_HASH_TYPE_NONE;

I wonder if we need to do things in the reverse. Warn for default and
only set NONE when it's NONE?

Thanks

>         }
> --
> 2.20.1.windows.1
>
>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
