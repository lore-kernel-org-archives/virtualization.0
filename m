Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A70C433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 11:26:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7676525D
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 11:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7676525D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B79CD83A61;
	Tue,  9 Mar 2021 11:26:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ajTtFVWQdPu2; Tue,  9 Mar 2021 11:26:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CFC683A1C;
	Tue,  9 Mar 2021 11:26:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2690DC000B;
	Tue,  9 Mar 2021 11:26:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F835C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 11:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17E906F562
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 11:26:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zadAQytiLWgU
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 11:26:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 338006F4F9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 11:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615289174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QJTu97af+WLCQFYiPKebiLOkL3siT4cw4KW3jFKHkGM=;
 b=KZpoidckAmNZIv+Wir7fZbLO8QUUn9Kqewy4kOisadHDy8ghR3l5e22wVOyYuUMV0v/g8t
 KpwbIDz+CbLTFxx/zPW2bq3F5Rsm0gdHP0grAQUqrxYuuM2FPFThR3QyXQPHvNtxdfhHi6
 jqXuQ3g4ei1wi0426o4YcGIyh9Er1Yk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-9BEWdgZONxGSgtdoRKE_Ww-1; Tue, 09 Mar 2021 06:26:12 -0500
X-MC-Unique: 9BEWdgZONxGSgtdoRKE_Ww-1
Received: by mail-wr1-f69.google.com with SMTP id g5so6244441wrd.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Mar 2021 03:26:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QJTu97af+WLCQFYiPKebiLOkL3siT4cw4KW3jFKHkGM=;
 b=OHJ5KHFUB1OPh/gACehcsfUSMHDoCFRi0XejRz4fJjLYS48GUAZpoh77MYvJrTczJe
 De3hWQ4TwVxSP8cC4EfAiUe9c3hrGlCKfs/PWaeIiE7gesXdZTI4X844GpUrfEU+ph3M
 MVjS+8GMFXwbt8oB+6Nps8qdEAXsxnC3c1jZnPz/HQ1eQrGSueAiA3us/VtHjWIfnRFf
 1hyQiOh7u4tDKWnu4XXZ5pQUNHkDxl0Rp/98C2dSKfp2JR5yLIzdmk1v/0XDX0OgN0py
 7T+A6apb8GGhYjIAyu3siYPeCWa9/WLn/5fC8jaa5H0NIBd6YllVN9CSZP5S8nb1TWMt
 nWfw==
X-Gm-Message-State: AOAM530RUOf/KLcQAIv46UxGwXXzKg5hbwlRziYdbygZUzasn7oJkcLp
 DDGgpWXvwMCKwKhNmXqIg9olBZQxusR5nP2mseVEZy9WJ0PsiNbmXgZSXSh1aTy3hlbd35Vf+e3
 bnm3f/kVclIDNSdmgur2jVik16UkmApFyHjoAfya67g==
X-Received: by 2002:a1c:67d6:: with SMTP id b205mr3538397wmc.118.1615289170615; 
 Tue, 09 Mar 2021 03:26:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGyKCvOiCoJXkY1zxim1zjyVYdNBYQs3pqMhTrVxV5v8BM0tI/MjusSGpEIQUXq09e+JkHjw==
X-Received: by 2002:a1c:67d6:: with SMTP id b205mr3538382wmc.118.1615289170481; 
 Tue, 09 Mar 2021 03:26:10 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id f17sm22314511wru.31.2021.03.09.03.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Mar 2021 03:26:09 -0800 (PST)
Date: Tue, 9 Mar 2021 06:26:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Balazs Nemeth <bnemeth@redhat.com>
Subject: Re: [PATCH v2 1/2] net: check if protocol extracted by
 virtio_net_hdr_set_proto is correct
Message-ID: <20210309062116-mutt-send-email-mst@kernel.org>
References: <cover.1615199056.git.bnemeth@redhat.com>
 <8f2cb8f8614d86bba02df73c1a0665179583f1c3.1615199056.git.bnemeth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8f2cb8f8614d86bba02df73c1a0665179583f1c3.1615199056.git.bnemeth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: willemb@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, davem@davemloft.net
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

On Mon, Mar 08, 2021 at 11:31:25AM +0100, Balazs Nemeth wrote:
> For gso packets, virtio_net_hdr_set_proto sets the protocol (if it isn't
> set) based on the type in the virtio net hdr, but the skb could contain
> anything since it could come from packet_snd through a raw socket. If
> there is a mismatch between what virtio_net_hdr_set_proto sets and
> the actual protocol, then the skb could be handled incorrectly later
> on.
> 
> An example where this poses an issue is with the subsequent call to
> skb_flow_dissect_flow_keys_basic which relies on skb->protocol being set
> correctly. A specially crafted packet could fool
> skb_flow_dissect_flow_keys_basic preventing EINVAL to be returned.
> 
> Avoid blindly trusting the information provided by the virtio net header
> by checking that the protocol in the packet actually matches the
> protocol set by virtio_net_hdr_set_proto. Note that since the protocol
> is only checked if skb->dev implements header_ops->parse_protocol,
> packets from devices without the implementation are not checked at this
> stage.
> 
> Fixes: 9274124f023b ("net: stricter validation of untrusted gso packets")
> Signed-off-by: Balazs Nemeth <bnemeth@redhat.com>
> ---
>  include/linux/virtio_net.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index e8a924eeea3d..6c478eee0452 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -79,8 +79,14 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  		if (gso_type && skb->network_header) {
>  			struct flow_keys_basic keys;
>  
> -			if (!skb->protocol)
> +			if (!skb->protocol) {
> +				const struct ethhdr *eth = skb_eth_hdr(skb);
> +				__be16 etype = dev_parse_header_protocol(skb);
> +
>  				virtio_net_hdr_set_proto(skb, hdr);
> +				if (etype && etype != skb->protocol)
> +					return -EINVAL;
> +			}


Well the protocol in the header is an attempt at an optimization to
remove need to parse the packet ... any data on whether this
affecs performance?

>  retry:
>  			if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
>  							      NULL, 0, 0, 0,
> -- 
> 2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
