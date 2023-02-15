Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F65C636D7
	for <virtualization@archiver.kernel.org>; Wed, 15 Feb 2023 15:01:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E2114087E;
	Wed, 15 Feb 2023 15:01:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6E2114087E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=c2A/fYuk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dy7ZMuOJySrI; Wed, 15 Feb 2023 15:01:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CC0C540883;
	Wed, 15 Feb 2023 15:01:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC0C540883
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0F9EC0033;
	Wed, 15 Feb 2023 15:01:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36DABC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 15:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 112F160B2C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 15:01:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 112F160B2C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=c2A/fYuk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1UawweGzhpj7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 15:01:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 63A4960AAE
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 63A4960AAE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 15:01:44 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id 24so12729557pgt.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 07:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112; t=1676473304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=krRonHVJrX/AM3Nh6AH5T0UFeYhSLpzdF/4nvnQSNLk=;
 b=c2A/fYukOwwfzDaMTurevXYheqUukaoYMQYRHSZ/Fm7D09CXwDqq5YHKb1Wyru5iX7
 /Vgxu+ibCxWGNUxVeam2LFXY5nXoZMwGqJBoOgYOBoqNFmHOznkHC+BpqA/Fk69zqgKh
 8QeBcBd/gbGDcnRquNcM511DlK6yP8sn5qildhhnCev8n0ecF34ILCw1JrpVFq4BKttL
 7paWQS86AM+p1s5OuobFEkRuFCNUyOxlJY0CqwAoJqItSVIz6ByRHi0nT/wU895eW54Q
 Zc2ro6MfSccQnBVG/HKlALWd/hrKcdmKtp2/l1UsgrRUMc+JKS3Hl0joXO5a9tXiX8TD
 39gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1676473304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=krRonHVJrX/AM3Nh6AH5T0UFeYhSLpzdF/4nvnQSNLk=;
 b=ukoEqve+xJLbVS58Doip9l2nylFZzNiZ2aymCceh9EUvHxdVQ9LZe0Py88l+/euaM4
 a9WEDJtlN1h4Lu9D+kFxkTFbFFOdpcLLK/TFDczVoJAmz6cue3HDP8yT1Agj0zJDqfax
 th4UgIi1tXKO7L/v1wYbFxaXbClIHsePgMl4pBPt//8UWDQMkEufbitft8uqzsSgbnrh
 LfV7JW+WAeFAjB/dPD8Q0eeDTvKWcgB9tdT7b1mkT9Tp5O/HE8uACUREL+FGYwbb+7I9
 yed9QnAgf+QhuPkigHoHHgI03PzgtL+lCeX4p3X8JlfqR1VUAUaDRR664/FZR8tZm/xP
 x6oQ==
X-Gm-Message-State: AO0yUKUdW5HAgQrL5n6PQ2rSVM+hP7DZ6QbZhn7491Hn+L7tFXfSmefu
 bhzBUED8kkgeebOJDOr7B6emblJoGylpEq0RX/G0IA==
X-Google-Smtp-Source: AK7set8eYclydSnsS4f6WGQ79K7QG9Dj7rVMwYVsWKOzbw1m0ex53O0fUsAT3cYXW0lhpPJjpAKwtNyWvHXZMZ/mMRg=
X-Received: by 2002:a62:1754:0:b0:5a8:c6db:7e76 with SMTP id
 81-20020a621754000000b005a8c6db7e76mr341674pfx.12.1676473303711; Wed, 15 Feb
 2023 07:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20230209075128.78915-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20230209075128.78915-1-alvaro.karsz@solid-run.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 15 Feb 2023 17:01:07 +0200
Message-ID: <CAJs=3_CfX-K9E5Y=s8cK1YKRktcKNmyRhGFcD8OU-N8YYPt4XA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: snet: clear dpu_ready flag on reset
To: mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org
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

Ping.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
