Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABE5C4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 12:45:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA7F641863;
	Wed, 21 Dec 2022 12:45:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA7F641863
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=aXWghNEf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sMJ0Tnz2-j4N; Wed, 21 Dec 2022 12:45:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1BDED4188D;
	Wed, 21 Dec 2022 12:45:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1BDED4188D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E55BC007D;
	Wed, 21 Dec 2022 12:45:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD0D0C0071
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B538D81E5D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:44:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B538D81E5D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=aXWghNEf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lWaYgDJs1PE9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:44:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2DDFB81E18
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2DDFB81E18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:44:58 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id v3so10332916pgh.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 04:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=87voKorkYhypVq01JjwM4w1ZUjFR2Vq5AJTk3xYnW4M=;
 b=aXWghNEfHt5qgm+LwHg4CjtcdfHnPyh7E1ET7j19TH452iazmQEnoC6MyN43uJpnaV
 Bs8djyw3mI6q03FYPa2JN/sYnD0weqSk5R1Fw0TN42ohXqEKynUfp0ohp3+DGlGNvjvi
 qJfD3wxUuajIBNGA4wHflHqourg3q+ix6blvA4fr6+NjeR+LtzBn7G3UvX+AW9Opm9yO
 17r5y+r6v6TtRrGi5lMH31Ru3SsrWrcIIt3heRyDjUl6GBoviQ6lfaDpVTVh9LBawZoC
 W3ObK+2uTLdm0akPUcXGITfOQE3p93s65jGmOd7yOzTQCnJfGddcURHtqAZ+cWB6LY1h
 J92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=87voKorkYhypVq01JjwM4w1ZUjFR2Vq5AJTk3xYnW4M=;
 b=2q4u7nJx8LJQ9y5qNg0whR7bgi6AgQE+PdgrDBKrysS7XwMipkYn7KqM10O+N/Zzpc
 hFlGnaPZ88GeISlLkR8hGL7SOqrEgyA4o5z2PbDbSORHWeyvqD7PoTP+tBhGXbBk3Qe0
 uHZkvS6PX73iEKBaa165ASLXRgXpx9AErC2MH9iERdMOL27UiJ9ki61rTH+VcdHL0mO3
 gumPUdsbhDCTb3UYlBJZMfMWMuWhyBCt2EXM11LwKOa14x2mzK0NgcQyuQ/7NdAMUlOv
 0TVPuJe7w77hoXLLZw6FoToeyEeInya89GOpKQqHPg6X0HemfZmqaHXcdOByw/t08X4X
 /kuQ==
X-Gm-Message-State: AFqh2krdhUXy5CILmeBdqzmZ6WyMb+wnJn6tSxtTTT6ucb4OUM62IZOe
 hSDHd97gX/Z5znYfYfi59NL2agEhSl3hiOqmhS6TXQ==
X-Google-Smtp-Source: AMrXdXt40PUOzzRkKPCAkXe6IfTye8YwOcziGNnm5ARbI2MeEsAGACZCnMHtldIPXSAAJMzOpNTjulqIN4necTCBwps=
X-Received: by 2002:aa7:9418:0:b0:577:8bad:4f9e with SMTP id
 x24-20020aa79418000000b005778bad4f9emr116308pfo.77.1671626697532; Wed, 21 Dec
 2022 04:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20221221120618.652074-1-alvaro.karsz@solid-run.com>
 <20221221073256-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221221073256-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 21 Dec 2022 14:44:21 +0200
Message-ID: <CAJs=3_CVUydOpH=a-RJLWUQ0_1EbkwKtGD2F3Xvw=dR5QFXP5g@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: send notification coalescing command only if
 value changed
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

> Why do we bother? Resending needs more code and helps
> reliability ...

It just seems unnecessary.
If a user changes just one parameter:
$ ethtool -C <iface> tx-usecs 30
It will trigger 2 commands, including
VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, even though no rx parameter changed.

If we'll add more ethtool coalescing parameters, changing one of the
new parameter will trigger meaningless
VIRTIO_NET_CTRL_NOTF_COAL_RX_SET and VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
commands.

Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
