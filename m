Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FB1C4332F
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 07:49:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F38560F07;
	Mon, 13 Dec 2021 07:49:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OQS_1oQ0gkRP; Mon, 13 Dec 2021 07:49:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ED94760EF8;
	Mon, 13 Dec 2021 07:49:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFD89C001E;
	Mon, 13 Dec 2021 07:49:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEC84C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 07:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9EEF360EFA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 07:49:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mfyttkKu31m0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 07:49:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F7FA60EF8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 07:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639381748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ajmFbDRx9BLe176bpdQggywBMmHI+LQFi36+JDBB49U=;
 b=GubAAYSVly5HxpYNqmXDo1MSbZoNzceDDzp1yzTU4/gk1qsRtm74RZ3zHpsoWlh08nKhBj
 szWKC0zqSIbNmN5g+ZJzIKjlUpS5IHsXl1B6vwcZsgkspQ+tpQMXpNZ6zX2osKGKNoxVjl
 4C0uB1bJ4TMX5RQi4CmuoV9I2d/qtJU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-VdWnLDToOIaIjpiIUBKKCw-1; Mon, 13 Dec 2021 02:49:06 -0500
X-MC-Unique: VdWnLDToOIaIjpiIUBKKCw-1
Received: by mail-lf1-f71.google.com with SMTP id
 o11-20020a056512230b00b0041ca68ddf35so7174305lfu.22
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 23:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ajmFbDRx9BLe176bpdQggywBMmHI+LQFi36+JDBB49U=;
 b=1Uy28zBD30fPwfCNofemPOSU/pHsedrApP408XcpCE9EIe/GUKlmcXCqCz0PK4zY2/
 GS+e90ibMlbSYZtXA5r8o7htQTScXpfwUE2Pix6cLb/zXSxH3VYdtphEnomL65v0uVHA
 AbCfUo2I3m5cgIO5scQlGURpPDGDbIcBeDzH92g0OYEN3V1h+eKK2okocP2aaFyidP+F
 7oYgNkXKIa+JZWdA9TxgCfo4MDptKB4I1rgnfjN9as/J7wsQ+O58G2eQm/AwHJf8bAMe
 Ivpz2AK+l1dT6/0iO9zI7muio+BcbCrAo1M7IQQ3W3ErF7rWojsVrlWhR5fDfZIcE79y
 7SUw==
X-Gm-Message-State: AOAM532LnL1B/p23ClqbAi4s5Qshg7CPy4fbwahgLmWfNrvyd0XzJgo1
 b537zCKLMmH5fZi/Rnreha9VknmPtYyWLW5RbiycTAZW07UyPfHAi0vlRQCQjhorGyrMPKfYCSf
 fil1gGkdgHFUqPrfqxhG4atimwWZvvvXXgHcVXANTlJ5lgs7jgyMHIua4mw==
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr28041721ljp.362.1639381745266; 
 Sun, 12 Dec 2021 23:49:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6Kho2IY5dIkx4dw7D65wn0As3tEagQCBwgaJDxLSQvZQN2qrKmtB5zWAMksvRMGbAAVFtrQQetSAmODA5C8k=
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr28041706ljp.362.1639381745081; 
 Sun, 12 Dec 2021 23:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20211213045012.12757-1-mengensun@tencent.com>
In-Reply-To: <20211213045012.12757-1-mengensun@tencent.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Dec 2021 15:48:53 +0800
Message-ID: <CACGkMEtLso8QjvmjTQ=S_bbGxu11O_scRa8GT7z6MXfJbfzfRg@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: make copy len check in xdp_linearize_page
To: mengensun8801@gmail.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: MengLong Dong <imagedong@tencent.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev <netdev@vger.kernel.org>,
 mengensun <mengensun@tencent.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 ZhengXiong Jiang <mungerjiang@tencent.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

On Mon, Dec 13, 2021 at 12:50 PM <mengensun8801@gmail.com> wrote:
>
> From: mengensun <mengensun@tencent.com>
>
> xdp_linearize_page asume ring elem size is smaller then page size
> when copy the first ring elem, but, there may be a elem size bigger
> then page size.
>
> add_recvbuf_mergeable may add a hole to ring elem, the hole size is
> not sure, according EWMA.

The logic is to try to avoid dropping packets in this case, so I
wonder if it's better to "fix" the add_recvbuf_mergeable().

Or another idea is to switch to use XDP generic here where we can use
skb_linearize() which should be more robust and we can drop the
xdp_linearize_page() logic completely.

Thanks

>
> so, fix it by check copy len,if checked failed, just dropped the
> whole frame, not make the memory dirty after the page.
>
> Signed-off-by: mengensun <mengensun@tencent.com>
> Reviewed-by: MengLong Dong <imagedong@tencent.com>
> Reviewed-by: ZhengXiong Jiang <mungerjiang@tencent.com>
> ---
>  drivers/net/virtio_net.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 36a4b7c195d5..844bdbd67ff7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -662,8 +662,12 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>                                        int page_off,
>                                        unsigned int *len)
>  {
> -       struct page *page = alloc_page(GFP_ATOMIC);
> +       struct page *page;
>
> +       if (*len > PAGE_SIZE - page_off)
> +               return NULL;
> +
> +       page = alloc_page(GFP_ATOMIC);
>         if (!page)
>                 return NULL;
>
> --
> 2.27.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
