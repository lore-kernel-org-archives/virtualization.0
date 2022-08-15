Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F126C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 11:24:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A00CA4163E;
	Mon, 15 Aug 2022 11:24:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A00CA4163E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=rUAYoxNn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RhTgG8BZPZzP; Mon, 15 Aug 2022 11:24:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E15194088B;
	Mon, 15 Aug 2022 11:24:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E15194088B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD594C0033;
	Mon, 15 Aug 2022 11:24:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D948C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 11:24:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0BC89408DF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 11:24:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0BC89408DF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=rUAYoxNn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xlxMaHKlCkhD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 11:24:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AAC87400CB
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AAC87400CB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 11:24:18 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-116c7286aaaso7819627fac.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=nZKRK6PqpP9DzZexrnN2X0Qb/e767BxaO5vGQnjget0=;
 b=rUAYoxNnI93ew8bxi9wgUMPjWeUoUDnG6Nj9o52dVkR2NlEGfl91GFzFSx79b35ysF
 B1/f8iqHvCTg/tXiPf3LIWX/oklVsJ7tVX70T4va49yXdi08istOw26actUfiqZb+vah
 9z6C3LLtxGrzUnJY1PszhLsgm1YkVdIstQG++4/Ynocf2OedbOgtDwb/H+MXDXGzanRY
 DadyoocQgJopr1HKQyZimw656KC+mmSB0JBGK5gr6LIB9Z4jLG6lkpq4sqoDS9+HUFy8
 +AYFuSacPLChDp5qNt8NFyWGvjbuq7p1FuZeUMvW9PJ4rgDl/6Qbna78pReiWl05XsvO
 dwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=nZKRK6PqpP9DzZexrnN2X0Qb/e767BxaO5vGQnjget0=;
 b=1aZgebeqSm04nhEauSINaYScUqRiIinJ5iwntFZlgx6uVM6F+DVtERlhihpCiY6iFl
 RmmkucsO594Vn0EGF4W9cShOsHtGu+yvYa7El2dMJnTm79huAek/RLRLx2vbx6JGBAkU
 h6GuiTxakvcbhTVZqHBnRFMOD8AX0m55spYLstBklOEEsVOmZRy6OhqxH3hgdz//vBi7
 QVPHrLtat8y86ztfxCcH+tCRF4kRVdhNFP4M3YK6LP8LtDpcCgQhW0p1f8XeKtMBkLND
 UlGjr4Ph9l+t/tmtVItFh7m4qsDslx95ko3RYcJv+s+HHqbyhmbfj7vnqYM3Q5zAd3JG
 QgbA==
X-Gm-Message-State: ACgBeo1WJns+FL+2JyI29Mu8QZ4PAyyCB3zQ/F6p6VqsP87UGyweNGOl
 z3JJEh/UtcsN4vFOt21Y+E/nBBJ2fcAoZzaznwSk6Q==
X-Google-Smtp-Source: AA6agR6wiP+vKr9ua4UscIVhTqUu7BG3rnpd+PJHlpopLMa7eQFclmDrowFtZDXtA0ZVOeaXnXx/ZkvJL/VIvqyLTbg=
X-Received: by 2002:a05:6870:b28a:b0:10f:72f:6c with SMTP id
 c10-20020a056870b28a00b0010f072f006cmr6274489oao.148.1660562657764; Mon, 15
 Aug 2022 04:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220811125156.293825-1-mst@redhat.com>
 <166030021657.10916.8438944707929097441.git-patchwork-notify@kernel.org>
In-Reply-To: <166030021657.10916.8438944707929097441.git-patchwork-notify@kernel.org>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Mon, 15 Aug 2022 14:12:16 +0300
Message-ID: <CABcq3pGwc0MnkBfUfryOEcJfh96Ar3p_ZZw7U0SHvtnxjt+4pQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: fix endian-ness for RSS
To: patchwork-bot+netdevbpf@kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, edumazet@google.com,
 Yan Vugenfirer <yan@daynix.com>, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
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

Reviewed-by: Andrew Melnychenko andrew@daynix.com

On Fri, Aug 12, 2022 at 1:30 PM <patchwork-bot+netdevbpf@kernel.org> wrote:
>
> Hello:
>
> This patch was applied to netdev/net.git (master)
> by David S. Miller <davem@davemloft.net>:
>
> On Thu, 11 Aug 2022 08:51:58 -0400 you wrote:
> > Using native endian-ness for device supplied fields is wrong
> > on BE platforms. Sparse warns about this.
> >
> > Fixes: 91f41f01d219 ("drivers/net/virtio_net: Added RSS hash report.")
> > Cc: "Andrew Melnychenko" <andrew@daynix.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > [...]
>
> Here is the summary with links:
>   - virtio_net: fix endian-ness for RSS
>     https://git.kernel.org/netdev/net/c/95bb633048fa
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
