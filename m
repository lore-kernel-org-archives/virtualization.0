Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DC0C433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 14:30:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64DE1651B2
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 14:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DE1651B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E14D06F5B8;
	Tue,  9 Mar 2021 14:30:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QDExgLOScIH3; Tue,  9 Mar 2021 14:30:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id A74706F54A;
	Tue,  9 Mar 2021 14:30:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FBAAC000A;
	Tue,  9 Mar 2021 14:30:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AEEEC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 14:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D82FD6F54A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 14:30:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m1EPGm-4dN5Z
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 14:30:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D5EA6F49F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 14:30:15 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id b7so20512124edz.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Mar 2021 06:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qXQaz6o4atEJRYBV31RTFfL6gXZMWZsubP8sDmVgbZQ=;
 b=au56fHLLqSDZ32svP/xUg7xLMNSde2/I3pHgvCvdQj4Hg4vCaCD6OmBVREF29YOaNk
 vJjCUz/23fLp5igggCvoWzZdbDJKzB3HCWTEMeQSF+dQw56rXDiY7UROn9tanPEwm/4O
 aVWGqQXGLpsfaXVuJj8POuaglPiq43KbYP3+rzOIm2NztRnr92M8Z2gQnuodZb9iy66p
 ylSyGZcZgRAHM72qPOKI9D+x9UcxbWivnI4svzrZraIVaEbebcQOjcD59L3w+NIq7FVS
 eboqFRffwc7ovjPZ0xWW6ogtUiYUwM95YkLDrK4TJyeot+r2cLyCDd5GegD5FEvUVfsk
 mUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qXQaz6o4atEJRYBV31RTFfL6gXZMWZsubP8sDmVgbZQ=;
 b=VbfgHh+Ei3/ZgAqMKy3oKHsV2kxvo32ud9gUN/06FNdEw7sUyBlh2dBgg4YmZx9zsc
 sFm8dvCjKdySUMLASkIbIAjktLOPANx+t41yOyGAQfccDv7YIArklBXD7enGto7rdGzz
 UrKE4fyZ71puxjvraiZYo0OsrDGlVFxNBA629MwPSsBsw8OlqbwjUvokYWxvEPPjqhEQ
 x58YT3gxBNSPI+Ts2k3tNQH/0RwuTCtcYSzF9OwLdfoDNaPAO+uUvQH/6IZFr+zx1wQV
 h2DiAxWF6FqiYHK0sfkksCTjtc/WMU3uHRz8yhOC7ExdmfWqIkNX4yEJaj1JExEAmxXb
 TCYg==
X-Gm-Message-State: AOAM531l84sWrVQQLeFt7t/7HjhWXiW+BhKl53Ue28ydf0Z5HkJLj2Li
 WErv93AjB2CDGQoorqPKKWGSiR2ujN0=
X-Google-Smtp-Source: ABdhPJxjW1ky1OxmuNhNzQDMyZGvEjoEuhVKQ2Bt5s32S1cLm74aAznWfn6o1aT/yrcFFKyuqpyU8A==
X-Received: by 2002:aa7:da48:: with SMTP id w8mr4318381eds.81.1615300211815;
 Tue, 09 Mar 2021 06:30:11 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com.
 [209.85.221.52])
 by smtp.gmail.com with ESMTPSA id bm21sm8442307ejb.100.2021.03.09.06.30.11
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Mar 2021 06:30:11 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id l12so15995506wry.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Mar 2021 06:30:11 -0800 (PST)
X-Received: by 2002:a5d:6cab:: with SMTP id a11mr28646938wra.419.1615300210948; 
 Tue, 09 Mar 2021 06:30:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1615288658.git.bnemeth@redhat.com>
 <9b79f43d2dfec8b2cb8e896b5591e7b1c3cc1f6c.1615288658.git.bnemeth@redhat.com>
In-Reply-To: <9b79f43d2dfec8b2cb8e896b5591e7b1c3cc1f6c.1615288658.git.bnemeth@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 9 Mar 2021 09:29:31 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfd=47GLDui1mmg_+OgG+OYf80XYKqMEvKUhbzJFM=dQw@mail.gmail.com>
Message-ID: <CA+FuTSfd=47GLDui1mmg_+OgG+OYf80XYKqMEvKUhbzJFM=dQw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] net: avoid infinite loop in mpls_gso_segment
 when mpls_hlen == 0
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
> A packet with skb_inner_network_header(skb) == skb_network_header(skb)
> and ETH_P_MPLS_UC will prevent mpls_gso_segment from pulling any headers
> from the packet. Subsequently, the call to skb_mac_gso_segment will
> again call mpls_gso_segment with the same packet leading to an infinite
> loop. In addition, ensure that the header length is a multiple of four,
> which should hold irrespective of the number of stacked labels.
>
> Signed-off-by: Balazs Nemeth <bnemeth@redhat.com>

Acked-by: Willem de Bruijn <willemb@google.com>

The compiler will convert that modulo into a cheap & (ETH_HLEN - 1)
test for this constant.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
