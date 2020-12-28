Return-Path: <SRS0=SJT6=GA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1D3C433DB
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 17:29:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A7E0229C4
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 17:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7E0229C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C7FF185DE6;
	Mon, 28 Dec 2020 17:29:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RexmN0VzkAyD; Mon, 28 Dec 2020 17:29:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 991E885D7D;
	Mon, 28 Dec 2020 17:29:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 832C8C0893;
	Mon, 28 Dec 2020 17:29:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0DD5C0891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9B4D022D22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:29:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TvWh7U4Udbpa
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:29:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 249D7203E1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609176573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gqheeXuSb59aslpjArFSGbaeJvg58fMnkkWQl2JDjzE=;
 b=N7nCIZUw2+L74RGj3VI25DA69sdv+5x1ae2AtQt7hSJSj6Gv2UvwLa7xZjRSPzNqVWqVhz
 E4pLNWt67bmUft0ljHbwgwLBOsM96U2f5SEU1SBEgb2tL/auR1mpdAglplENvbCmkIqBhq
 /QMEDs96gpARfmXuh3LWBCfgL5PzaTw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-pKDiGuRLMMGzwMdzvzlR6w-1; Mon, 28 Dec 2020 12:29:30 -0500
X-MC-Unique: pKDiGuRLMMGzwMdzvzlR6w-1
Received: by mail-wr1-f71.google.com with SMTP id e12so6545519wrp.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 09:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gqheeXuSb59aslpjArFSGbaeJvg58fMnkkWQl2JDjzE=;
 b=qryCkJu9/FusMi+kEEWgdSH6gBuzEuBmZ74CDZZ7QwWF2gA8IcWDaiQ1L9RL5OrQW3
 LsJLFiBN6GN6PQPWfAlj/YgnhpZbuVbeIqRrbHFjbEigXGUI1aC3LSlZbKrE0b2GYZoe
 nACZy4w3cuzfQuFdnG0lhK3yJW3GO0/9KqMcC/rIgJCbv+PY6e78Dk0/j92Jl4eGsa7j
 dKhckKiVBfK0/9Zybzhw7qVRv2tVKsUoMINMCBdACmA0DMXizorEWaUBWnyhklbyOyNV
 iVBI3MQmqOwS6p3ZwsvtuO/qvpju2mUokY2wQEYXttP6bG36j23yX2VsyGouKtHL42Lp
 eJJA==
X-Gm-Message-State: AOAM530dmq55WnMdiqkoYAOPhDudZqPr1XjxVi5AJwGJF+8jWfURhdX+
 XK81rmtMfNMkkc/tHhnljHnXkrZhShkxQnkd6NOgYcONZVGiR1nwb324afrJpaSOzCgJV3q9DTL
 s54AxQWXo2/qckmLmH81+v0cBp1zAK+6jQ2osJj4tdA==
X-Received: by 2002:a1c:98cc:: with SMTP id
 a195mr21585537wme.150.1609176569783; 
 Mon, 28 Dec 2020 09:29:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyyjPoX1wv9vUJCGpM1vzOZhx2I0HhVXjs1OYgo5Qgnl9LdLiUKwvZrK3BBqN83Vcd/2tiOJw==
X-Received: by 2002:a1c:98cc:: with SMTP id
 a195mr21585531wme.150.1609176569653; 
 Mon, 28 Dec 2020 09:29:29 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id u3sm64803262wre.54.2020.12.28.09.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Dec 2020 09:29:29 -0800 (PST)
Date: Mon, 28 Dec 2020 12:29:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH rfc 0/3] virtio-net: add tx-hash, rx-tstamp and tx-tstamp
Message-ID: <20201228122911-mutt-send-email-mst@kernel.org>
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 virtualization@lists.linux-foundation.org
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

On Mon, Dec 28, 2020 at 11:22:30AM -0500, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> RFC for three new features to the virtio network device:
> 
> 1. pass tx flow hash and state to host, for routing + telemetry
> 2. pass rx tstamp to guest, for better RTT estimation
> 3. pass tx tstamp to host, for accurate pacing
> 
> All three would introduce an extension to the virtio spec.
> I assume this would require opening three ballots against v1.2 at
> https://www.oasis-open.org/committees/ballots.php?wg_abbrev=virtio
> 
> This RFC is to informally discuss the proposals first.
> 
> The patchset is against v5.10. Evaluation additionally requires
> changes to qemu and at least one back-end. I implemented preliminary
> support in Linux vhost-net. Both patches available through github at
> 
> https://github.com/wdebruij/linux/tree/virtio-net-txhash-1
> https://github.com/wdebruij/qemu/tree/virtio-net-txhash-1

Any data on what the benefits are?

> Willem de Bruijn (3):
>   virtio-net: support transmit hash report
>   virtio-net: support receive timestamp
>   virtio-net: support transmit timestamp
> 
>  drivers/net/virtio_net.c        | 52 +++++++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_net.h | 23 ++++++++++++++-
>  2 files changed, 71 insertions(+), 4 deletions(-)
> 
> -- 
> 2.29.2.729.g45daf8777d-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
