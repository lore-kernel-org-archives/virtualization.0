Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01CAC433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 14:36:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC4165239
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 14:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC4165239
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C140842C2D;
	Tue,  9 Mar 2021 14:36:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yy5kpVIwQxv1; Tue,  9 Mar 2021 14:36:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7446842FBE;
	Tue,  9 Mar 2021 14:36:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 493F1C000C;
	Tue,  9 Mar 2021 14:36:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B96CC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 14:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4EDD26F49F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 14:36:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yj_5fxinXT8z
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 14:36:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 818E560030
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 14:36:27 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id v13so20534215edw.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Mar 2021 06:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NkrImNhNpTZbyH50e8J9HL5+BNOIlHrCZBcyIPHvdns=;
 b=it1he6lFFcNQQOZEWQXRhe/IQSNeucdGGvbtokOSAmr4bBlJkfu+kpji98BR0/GsGV
 +AaWi1JPDbGLv8yzjYXF0BEZFEPWXHO+tRoydoYdlfq4OiRfjRazY6/0cX5LwDqnxyb1
 52430PMmUh1QDQ5kEmtyaFUChfVSFLzAghdgi15N7bXgXmnU0Df0iJPe2B27zg8+KaSl
 au9sjdS60+iMcJEQVcx4fqIuaGdn9LGT4Ff49QkovaprjQoZcH6ViqVbSbhMVjA64ARh
 S/Y4vriSZjZNir9OFVoGpHvP3Tsvg+9pOdxPZEwfoXV6wbNG7iHDbb47feA7dZq0Bfev
 sSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NkrImNhNpTZbyH50e8J9HL5+BNOIlHrCZBcyIPHvdns=;
 b=rroZnzV33yod5CgnfwZqGYDdHNZp2uKkcM2GeknR4MMAHtSkMhkFA/IFMGx5Zai2/1
 k+zylBQMncm8ZJzWSjUFFGSGjm6PALg0Eegco8sEdFk2zC0TmC/TYZAX6XxU0ZXRA6oO
 ViPNnLOgFWtwq798tzMUdU1TGewCWKDTYAgu2x6uBsmdrj0ccGDHMGFezep6HzauQtvY
 G4ykP7pLFP+NnZiG6IrHuVFseOHWuXCUtMWVvvCf9OfPYBdxOB1b1yYubnxorUDIAIYb
 hz+eNn32GzyJLUT90kuc8dlgVBSmXfrTqnO6fi0vnLuyxl7Sn6ADa6A6FoUFzbsYqnMT
 bfWw==
X-Gm-Message-State: AOAM530v/oqho9EWXWKnMi9gsRH95WfGPeM2PnaOgE6JekYqFUNFB/Bq
 go4/9UNdbAxRq4JeMnUbWKabdHPLdbs=
X-Google-Smtp-Source: ABdhPJyP9o13ky2XCPUi7FTTfj02g0nhCsmm4zoGkzgolL5PhBH4+mAbpz8V6EiDPhBzWeoAl/+QZA==
X-Received: by 2002:aa7:da04:: with SMTP id r4mr4426962eds.343.1615300585431; 
 Tue, 09 Mar 2021 06:36:25 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com.
 [209.85.221.51])
 by smtp.gmail.com with ESMTPSA id i2sm9377599edy.72.2021.03.09.06.36.24
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Mar 2021 06:36:24 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id f12so16047633wrx.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Mar 2021 06:36:24 -0800 (PST)
X-Received: by 2002:a5d:640b:: with SMTP id z11mr27886602wru.327.1615300583787; 
 Tue, 09 Mar 2021 06:36:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1615288658.git.bnemeth@redhat.com>
 <b07e88b0d023fd7c6f5bbee27ae1cb33e52b9546.1615288658.git.bnemeth@redhat.com>
In-Reply-To: <b07e88b0d023fd7c6f5bbee27ae1cb33e52b9546.1615288658.git.bnemeth@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 9 Mar 2021 09:35:44 -0500
X-Gmail-Original-Message-ID: <CA+FuTSf1RVx4HSyT7PvWfNpz2nYY5qWSf_RtYiejLbSccemQCA@mail.gmail.com>
Message-ID: <CA+FuTSf1RVx4HSyT7PvWfNpz2nYY5qWSf_RtYiejLbSccemQCA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net: check if protocol extracted by
 virtio_net_hdr_set_proto is correct
To: Balazs Nemeth <bnemeth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, David Ahern <dsahern@gmail.com>,
 David Miller <davem@davemloft.net>
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

On Tue, Mar 9, 2021 at 6:32 AM Balazs Nemeth <bnemeth@redhat.com> wrote:
>
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

Acked-by: Willem de Bruijn <willemb@google.com>

This still relies entirely on data from the untrusted process. But it
adds the constraint that the otherwise untrusted data at least has to
be consistent, closing one loophole.

As responded in v2, we may want to look at the (few) callers and make
sure that they initialize skb->protocol before the call to
virtio_net_hdr_to_skb where possible. That will avoid this entire
branch.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
