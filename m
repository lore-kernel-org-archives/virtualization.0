Return-Path: <SRS0=Lrx6=QC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5093EC433F5
	for <virtualization@archiver.kernel.org>; Mon, 15 Nov 2021 16:35:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29D66121F
	for <virtualization@archiver.kernel.org>; Mon, 15 Nov 2021 16:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F29D66121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA42880CE0;
	Mon, 15 Nov 2021 16:35:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TXlJn2-v7iXJ; Mon, 15 Nov 2021 16:35:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4645080A89;
	Mon, 15 Nov 2021 16:35:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1593FC001E;
	Mon, 15 Nov 2021 16:35:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DE33C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 16:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 691B7605FC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 16:34:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B7rolTYUm1lH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 16:34:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E760605F2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 16:34:56 +0000 (UTC)
Received: by mail-ua1-x935.google.com with SMTP id b17so36251702uas.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 08:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VZxSbYl5jQSt8wP2WiEBDzWy0O0u/xAxqhCPrf7Lr/o=;
 b=iCS17978TSzIQAa0BVPeYfWl+7UloyD5JoRTt4zIwhZyL0g4q+bymce0OmcdgeAXMV
 9kIvfKFWP/yGmqmUAwMpCL1AFf61uZj8A+jvP6wsbTn0vRYmF2VjYJTwZuDRxndPVsAP
 +nKR4RRTl13Sx9d1IrG571PkZQL/t2SbMzYzzX+5JvJjiS1CUMHBew5CV2sFXmL6nXNH
 0WLmM0LpUg/iD/brXqL1glozQ0dUoZMoCsWLx/dvUd+JbnmE6Fxipcz4Gzy8TOHMGcvJ
 4vh98FTvHaKNA9HQ998z9vyeMSXc3/JeyuoAC1UKYUKBmm6KJCJF+nUu0Ztpm4ta97T6
 UKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VZxSbYl5jQSt8wP2WiEBDzWy0O0u/xAxqhCPrf7Lr/o=;
 b=gpqxxWoWBB/EnTkW97j6bfPOkkhhIihB9u0yZHp8lLOqCD8akNpf/64tSzq3eZfN80
 uTlcok0lyjUDnzUvubgStjuaa0z4yOluc0r8krtdP1o17It7aRhDXw4AkbJTeK9t7mv+
 e3Xoo2Occ3q6iUSl1jKabauifA71Lhsa7D8q42m/h4J+ToLLcVulPr7X32c5oF2GLxsD
 4e/fX7pLmXobFrmYI6WKW87hapxObR+caxoJn6MhfZYnfsB41acb7Oft9nlPJkeLwzni
 t21DArkAwpnofFUwYFUl0byJB8HpmKpHMcFEJcqnUmCP5irTDTRWrdymAHQlZKu+p3KE
 OnEA==
X-Gm-Message-State: AOAM530j/HLGx5EHPBrmNsFz62zyF5nrY4fEzlUb1czKdfyiqEmBopUM
 bG0kNVdgkzDnmOcAwC7jUKtx37tCI6VS9g==
X-Google-Smtp-Source: ABdhPJwfNGmLNr+TRtf0+UkWy7PKvYAuahkAXwGhqlaMEE8zW5wzYRuTYhHQ5+mw9QJJqqaIRA2SNw==
X-Received: by 2002:a05:6102:316c:: with SMTP id
 l12mr44339958vsm.1.1636994095288; 
 Mon, 15 Nov 2021 08:34:55 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com.
 [209.85.222.44])
 by smtp.gmail.com with ESMTPSA id i27sm11093662uab.8.2021.11.15.08.34.54
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Nov 2021 08:34:54 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id ay21so36091327uab.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 08:34:54 -0800 (PST)
X-Received: by 2002:a05:6102:38d4:: with SMTP id
 k20mr45378060vst.42.1636994094206; 
 Mon, 15 Nov 2021 08:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20211115151618.126875-1-jonathan.davies@nutanix.com>
In-Reply-To: <20211115151618.126875-1-jonathan.davies@nutanix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 15 Nov 2021 17:34:17 +0100
X-Gmail-Original-Message-ID: <CA+FuTScqWToamoOqAWkf1VbzYnjoM-y+-rQe_wEkPmBsOZbsLA@mail.gmail.com>
Message-ID: <CA+FuTScqWToamoOqAWkf1VbzYnjoM-y+-rQe_wEkPmBsOZbsLA@mail.gmail.com>
Subject: Re: [PATCH net] net: virtio_net_hdr_to_skb: count transport header in
 UFO
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

On Mon, Nov 15, 2021 at 4:16 PM Jonathan Davies
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

Thanks for the fix, and the detailed explanation of the bug.

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  include/linux/virtio_net.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index b465f8f..bea56af 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -122,8 +122,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>                 u16 gso_size = __virtio16_to_cpu(little_endian, hdr->gso_size);
>                 struct skb_shared_info *shinfo = skb_shinfo(skb);
>
> -               /* Too small packets are not really GSO ones. */
> -               if (skb->len - p_off > gso_size) {
> +               /* Too small packets are not really GSO ones.
> +                * UFO may not include transport header in gso_size.
> +                */
> +               if (gso_type & SKB_GSO_UDP && skb->len - p_off + thlen > gso_size ||
> +                   skb->len - p_off > gso_size) {

Perhaps for readability instead something like

  unsigned int nh_off = p_off;

  if (gso_type & SKB_GSO_UDP)
    nh_off -= thlen;




>                         shinfo->gso_size = gso_size;
>                         shinfo->gso_type = gso_type;
>
> --
> 2.9.3
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
