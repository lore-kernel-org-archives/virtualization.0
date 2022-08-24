Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A743EC00140
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 09:49:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4723F81395;
	Wed, 24 Aug 2022 09:49:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4723F81395
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=31w6WANT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1rNEKWHSpg35; Wed, 24 Aug 2022 09:49:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E117281394;
	Wed, 24 Aug 2022 09:49:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E117281394
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6EBEC0032;
	Wed, 24 Aug 2022 09:49:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D928C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 34657408ED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:49:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34657408ED
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=31w6WANT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WDp5Kx2cNlcZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:49:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6214D408BC
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6214D408BC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:49:01 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 x63-20020a17090a6c4500b001fabbf8debfso962337pjj.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 02:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=Jvrubn18J8eklgHdQHhQd3gyNTiHNSTFv8jwxExN4J8=;
 b=31w6WANToCNULKSXTU9h2RVabvBvXJoJRsd6RXj8W5he+kpfxOdEb/EfDI9bd+j3pR
 2nGMQPaZniuCyOJZI1R9jvkdWn/Rc85CYUc987IEwY686vEjGlKzSvnxEeEYEwKJ5D2a
 zN5HKUElhusizMmJqMtgNoy7g2O0WI85DnbKY5J3RZZZ6re3OySZ0kf2YSqyqd+8wImv
 Ng2Acf5BtjV43k1opU7toDg4++bJiGhgablmj0CSVZA6B6teXWAAUVDFiC8xm0zPj4qe
 gry029J70X5fjuequnt9OlpM+L2xG5fr7XUJrxLALxvJ3uGt3GaMCWRMff0/WE2KnfhY
 IC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=Jvrubn18J8eklgHdQHhQd3gyNTiHNSTFv8jwxExN4J8=;
 b=5i/BDQcj3QR/uMNkjLCXX+NHmILJwc/HqWRpYYPoY4U+trODRV3n53nla/QQXVWikO
 cGaJYqXtP1nYOeF8xU/oU76CokEX8W1I7k4nJNG+6fJex2bHa78eaCPbzN0/CeUBNcYg
 GG6/3rFgvKEsOBmjt57nreFBRl2JEQ/yGSmhRtfGQL+FG7w4tr/hxISRCKxh2ynNiSDC
 SPmlfyb12GLtExBRGFX7A6XpukrJ1qI5ar14+73VQpGiWZtcHrMQnQLfh6aIL+hWxXUG
 Y7J8MMUMYyICghFnP530td1IQrYBr31kl/KU88G9K2XcGTtQQdTSC0kAVJGMFE6IlAZc
 zLjA==
X-Gm-Message-State: ACgBeo3Vfike2QfMPTpO5SA71rk3Eqij62mhEEUVmljBsC7DAUSXCHXs
 iq/5EktjcuJQMJxDBqrnTQKHvehZTbe6Da3TXaDt3A==
X-Google-Smtp-Source: AA6agR4aEnInt+vSrAp2U9v0QsHLFNF9sfG4nHzvJMFmhDtPHYin40m+OfN5jDy7mPaVEjmMjE72VntbuAqzHCzIask=
X-Received: by 2002:a17:90b:17c2:b0:1fb:7a6f:7977 with SMTP id
 me2-20020a17090b17c200b001fb7a6f7977mr3669227pjb.53.1661334540765; Wed, 24
 Aug 2022 02:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAJs=3_DJ8x5h98WBbXhzxVx+D6pqpBkCrBHXa_7ApqYO4vGDpQ@mail.gmail.com>
 <CACGkMEuQBLpaW6-tD3oqR90ya5=js6DJ=pHiOJmG2SOt-6ycpA@mail.gmail.com>
 <CAJs=3_Cnf29Om2yB=JkdASuu=YBPRmZ4i7ncFfTzrftTkYZVmQ@mail.gmail.com>
 <bedae890-80e6-9777-caff-98749d46ba3b@suse.de>
In-Reply-To: <bedae890-80e6-9777-caff-98749d46ba3b@suse.de>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 24 Aug 2022 12:48:25 +0300
Message-ID: <CAJs=3_AW1-SVOOg8MT65KxtrZs7ikJ6DZ3xXSQZX07jA8VBr1g@mail.gmail.com>
Subject: Re: Virtio-net - add timeouts to control commands
To: Hannes Reinecke <hare@suse.de>
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

> Quite the contrary.
> There is no guarantee that a completion for a given command will be
> signaled at all; if the completion is never posted to the virtio queue
> the VM will spin forever.
>
> This is a simplistic approach. _Any_ command sent via virtio will have
> to have some sort of handling in the host, so an immediate response is
> not guaranteed.
> Especially virtio-block command will _not_ be handled immediately.


I'm referring to virtnet control commands.
virtnet_send_command is a blocking function, and returns once a
response is received for the sent control command.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
