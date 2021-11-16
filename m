Return-Path: <SRS0=Mct1=QD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D88DC433FE
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 21:43:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DC561263
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 21:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2DC561263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 640EA402A5;
	Tue, 16 Nov 2021 21:43:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CcieVHC1qXKc; Tue, 16 Nov 2021 21:43:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EFE5340496;
	Tue, 16 Nov 2021 21:43:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD7E5C001E;
	Tue, 16 Nov 2021 21:43:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DF56C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 21:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8506E615F1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 21:43:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HRzqNQ3iUCXb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 21:43:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C45CF615EF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 21:43:22 +0000 (UTC)
Received: by mail-ua1-x931.google.com with SMTP id az37so1203241uab.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 13:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=88TappYm4yL0O8HEW0TOShDM24Xx97b5DxNpcH/zWqQ=;
 b=XRDoMtUP6GzS9foDBRt9ZHRsri8/yfmInOx9aPd4oVUNaVqYqR8uh40QKti7EOgMdG
 nt+fQ1WiJi9RO6jO0t2xOLKnJwwxywCi10Mb4FSnJrB5tGfXo0V9LfpxdtPSB/5mIBnX
 Z9JWjAnaK5YdcKpPHR7J9Ucof7BNq/HXowou227czB+73v8lGk4rd7QSeJfd+cyxnq2a
 bfndFDDlOnjTlvlK+SP7M7SsB8SYukh5SYd5Rf9A7x8FOvuz7Sb5UGm4vQsvUTzEkmrJ
 0Mts00LYUtuCWXbBoz9HFyTApZowDvIj9i771xpszOeidCl920fShqy6vnUEpwWRU1zd
 u04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=88TappYm4yL0O8HEW0TOShDM24Xx97b5DxNpcH/zWqQ=;
 b=CSr3yMWGY6l+xd7GjPCuLETFlnziSX3YvcXitgkzea81yRCMaZiYf4bELxx8SBYejY
 JmYHzIILVCLXFf0vnSUvyOvTEDqnctG7Mh5JxNufJYGudZGlk9nZlFT7g3glWIWafyE8
 XMF+JdPjHMCteN4UzKwg3S324klpF57yXSmlNhw0G7Lka/u6/+PD6F76NcmFCRv7ypzH
 bb/ryJ/Z0M/ZsNFXlZReZQg84sIOX7mnE5sj1dpUh2ZjbbaXKQ304ctd8t1tTqTr7pr7
 ECwhSDhPgebPU2RPn9+8/+2RD++6VvkCtOsSPnsXxGDLvhdeRd827sfIa8ciWUDQeVKN
 b6oA==
X-Gm-Message-State: AOAM532iUItd0yKkX9OQHPqTylOvNscOGFrZCEePn6SL/p8Y8Z8tsh0G
 r26ZMBE/fc3oE4fludpBAXqw9iaRsnmy/w==
X-Google-Smtp-Source: ABdhPJyNTdQZB34+wc49wD4iXQgJ+lu6IUuJnvfrC+Q9I0C4tvjFnlSMLBmhOkZhDRXllKbl1kLZXw==
X-Received: by 2002:a9f:2431:: with SMTP id 46mr15633444uaq.114.1637099001660; 
 Tue, 16 Nov 2021 13:43:21 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com.
 [209.85.221.172])
 by smtp.gmail.com with ESMTPSA id o7sm5342133vkl.41.2021.11.16.13.43.21
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Nov 2021 13:43:21 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id m19so356900vko.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 13:43:21 -0800 (PST)
X-Received: by 2002:a1f:e287:: with SMTP id z129mr78866040vkg.17.1637099001001; 
 Tue, 16 Nov 2021 13:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20211116174242.32681-1-jonathan.davies@nutanix.com>
In-Reply-To: <20211116174242.32681-1-jonathan.davies@nutanix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 16 Nov 2021 22:42:45 +0100
X-Gmail-Original-Message-ID: <CA+FuTSfXfDXJpU7N2ba4D9wQy0A8acUq2k-RmVDJjT_bmtH_mw@mail.gmail.com>
Message-ID: <CA+FuTSfXfDXJpU7N2ba4D9wQy0A8acUq2k-RmVDJjT_bmtH_mw@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: virtio_net_hdr_to_skb: count transport header
 in UFO
To: Jonathan Davies <jonathan.davies@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Florian Schmidt <flosch@nutanix.com>,
 Thilak Raj Surendra Babu <thilakraj.sb@nutanix.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>
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

On Tue, Nov 16, 2021 at 6:43 PM Jonathan Davies
<jonathan.davies@nutanix.com> wrote:
>
> virtio_net_hdr_to_skb does not set the skb's gso_size and gso_type
> correctly for UFO packets received via virtio-net that are a little over
> the GSO size. This can lead to problems elsewhere in the networking
> stack, e.g. ovs_vport_send dropping over-sized packets if gso_size is
> not set.
>
> This is due to the comparison
>
>   if (skb->len - p_off > gso_size)
>
> not properly accounting for the transport layer header.
>
> p_off includes the size of the transport layer header (thlen), so
> skb->len - p_off is the size of the TCP/UDP payload.
>
> gso_size is read from the virtio-net header. For UFO, fragmentation
> happens at the IP level so does not need to include the UDP header.
>
> Hence the calculation could be comparing a TCP/UDP payload length with
> an IP payload length, causing legitimate virtio-net packets to have
> lack gso_type/gso_size information.
>
> Example: a UDP packet with payload size 1473 has IP payload size 1481.
> If the guest used UFO, it is not fragmented and the virtio-net header's
> flags indicate that it is a GSO frame (VIRTIO_NET_HDR_GSO_UDP), with
> gso_size = 1480 for an MTU of 1500.  skb->len will be 1515 and p_off
> will be 42, so skb->len - p_off = 1473.  Hence the comparison fails, and
> shinfo->gso_size and gso_type are not set as they should be.
>
> Instead, add the UDP header length before comparing to gso_size when
> using UFO. In this way, it is the size of the IP payload that is
> compared to gso_size.
>
> Fixes: 6dd912f8 ("net: check untrusted gso_size at kernel entry")
> Signed-off-by: Jonathan Davies <jonathan.davies@nutanix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> Changes in v2:
>  - refactor to use variable for readability
> ---
>  include/linux/virtio_net.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index b465f8f..04e87f4b 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -120,10 +120,15 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>
>         if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
>                 u16 gso_size = __virtio16_to_cpu(little_endian, hdr->gso_size);
> +               unsigned int nh_off = p_off;
>                 struct skb_shared_info *shinfo = skb_shinfo(skb);
>
> +               /* UFO may not include transport header in gso_size. */
> +               if (gso_type & SKB_GSO_UDP)
> +                       nh_off -= thlen;

Subtracting from an unsigned int always has the chance of negative overflow.

This case is safe, as all three paths that lead here have a p_off >= thlen.

I just noticed a more obscure fourth path:

        if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
                switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {

We do not explicitly check against hdr->gso_type ==
VIRTIO_NET_HDR_GSO_ECN. An obviously bogus value. That leaves p_off 0.
But it also leaves th_len 0, so it is safe.

Negative overflow is also safe in this case.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
