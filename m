Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD12C636CD
	for <virtualization@archiver.kernel.org>; Wed,  1 Feb 2023 16:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D10DF40873;
	Wed,  1 Feb 2023 16:52:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D10DF40873
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ObfyWmej
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jYECZBzUI24o; Wed,  1 Feb 2023 16:52:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2122C4054A;
	Wed,  1 Feb 2023 16:52:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2122C4054A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00D40C0033;
	Wed,  1 Feb 2023 16:52:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53E36C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 16:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3BF7B60FE5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 16:52:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3BF7B60FE5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=ObfyWmej
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sn_NKvNyXfBU
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 16:52:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D1B960F79
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D1B960F79
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 16:52:00 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id d10so12913915pgm.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Feb 2023 08:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xm0nVrTiE2LwH6HdNccgqBbifUQn+UCt78Fv+efTCn4=;
 b=ObfyWmejm1HzZPB+QeACGcpOACEQgda9guHF+ZV5lEjWxEAO0jEHVo+/JoZbcG6Cnf
 yUBakjbT6aYEAy0H7fDiRXwmY9IY3bHQCrFIiGFhAu4QvwZQ7pYDf+s1uOLOkp73KSmB
 8XNvI0Pev6wIB7ei0DXXf6jDIw86WsfFf/DkCTIPABNnSxB6eh8KeiRXcQ3rr+NRYwlN
 ErhTyuKF5FqDfl4hBFWD95JnNy2nhs6NRRXhB4lBVHETWAe9+I/0SLDXjeUEPAq9mHoq
 g3byO1UGFqOlDdX8/PDuS4taTpR6ngepdWSzLjMnsJ9nEh1Se5CNjL2hmCx/g56vMiR9
 gAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xm0nVrTiE2LwH6HdNccgqBbifUQn+UCt78Fv+efTCn4=;
 b=gZlsdxbp/gqjEBOi3z+C1NY7e+/2Tq4AHyKUsDdi9an2rhGt0A9zLrYM0Q0hx6SSHA
 fCT9Y4+xA+4X1/1rbcNEly7umrqykMudnLhmufmdZ9MzLLnH6j6Wzt+afgo0N3maZ8ec
 AFlrPIgxLIvlegNhWdRrPKiAo8b/eZmnEFgqk0ysmOU51A5hI/8q9JZfSPzqVzpaPHvM
 R6/b+dwxiHv6w/z+WDsGFSkkMBg/hDf5upAbgD/U8cx+rQogS5dVxXOmVl8uVjO5sjD0
 mkm4/PIgRNKJAAsxyu5JTonA9Ka4cUiGdNuwfG/MiGzCJ5zHWljhQajXh73mfrRzma2K
 BQfA==
X-Gm-Message-State: AO0yUKVSd3I87wqMPCRY58WPoEC49tahzEABMa85PJSTi38VGul+7yIr
 O3gCDZfiDY7w+iIqdEsM00fm+rgyZujsbpX8YJnNJQ==
X-Google-Smtp-Source: AK7set+2REbogAH1fmSSzwS1kZBMqS2Vj5bOSAAXN63uUeD5POYhbr3TIi+wclMraNBed7OH6TljDaQq5C9LYsEZ+9U=
X-Received: by 2002:a05:6a00:2408:b0:593:c68b:4e5b with SMTP id
 z8-20020a056a00240800b00593c68b4e5bmr622769pfh.17.1675270319906; Wed, 01 Feb
 2023 08:51:59 -0800 (PST)
MIME-Version: 1.0
References: <20230201152018.1270226-1-alvaro.karsz@solid-run.com>
 <20230201105200-mutt-send-email-mst@kernel.org>
 <CAJs=3_Bw5QiZRu-nSeprhT1AMyGqw4oggTY=t+yaPeXBOAOjLQ@mail.gmail.com>
 <20230201110253-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230201110253-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 1 Feb 2023 18:51:23 +0200
Message-ID: <CAJs=3_DXaZh2aG7gJ66MUuqx4zTqK1ZWVsNudcGkQtnfAJhzBw@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: print error when vhost_vdpa_alloc_domain fails
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Eugenio Perez Martin <eperezma@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

> > dev_warn then?
>
> dev_warn_once is ok.

Ok, thanks
I'll send a new version tomorrow.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
