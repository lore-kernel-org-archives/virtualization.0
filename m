Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22680C6FA99
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 03:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 75D98405E2;
	Wed,  8 Mar 2023 03:36:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 75D98405E2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=cx6n34dK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NPdCL4oT3e_3; Wed,  8 Mar 2023 03:36:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 023CB400B9;
	Wed,  8 Mar 2023 03:36:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 023CB400B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEBA4C0035;
	Wed,  8 Mar 2023 03:36:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64473C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 03:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 402D860B30
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 03:36:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 402D860B30
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=cx6n34dK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B7QB_kbva0_1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 03:36:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58BFE60A77
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 58BFE60A77
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 03:36:37 +0000 (UTC)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-53d277c1834so107164897b3.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Mar 2023 19:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678246596;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBnC16V3DVRFG8Cx25Z1zKLSf9LWl69vSGngN5Vr3FQ=;
 b=cx6n34dK5vXQPXwCdkwXo3kfgSGrfhjM/SRm2cwr/AijaoqiGtJ9y2ht5cF7RPEXFR
 rY0B/LqRGjTi5vt6S986Gx5n/oO3hor4ILMtGkx24xL3N7SCxVUaPoANJUbmF5LIk1AK
 gpZFb2DGjo+WvHuRVLB72aZV/Q/U3cTdMvuC9LGgKVhjDB/wpDuVfJhU7R/SJQvihu6/
 pooDqJoLWTheTWkihT0Y/qtqW6vfM+JUm/IATk5GnsApHTg769XYMkoz2DVrYMoVqx1D
 w/fTDB6d3KUmoab20X3DcUu1hUiUH/FT91iWp2Oc9BN8z7EXyyrqB+Cw/7KYl/QfXIhw
 SGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678246596;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HBnC16V3DVRFG8Cx25Z1zKLSf9LWl69vSGngN5Vr3FQ=;
 b=s6Ch5tZ5R8WT0CB8k4xVvKWYqvsz2oHqO2U6X/jjQ9DUYCfIRDq1ZHsHfuVKSWbOUC
 pPQqO4afal9Ea+O09d8y7ZLuWNaZ36+QllAof9KYH8plcHKCXA6tAjjaaIuw/jW3YCDN
 eysAazP2C7vWS7DxAiCrPi+iymDqYz/oy9c6sfsjahIO6+aToM4h1Xk8TFCXzsIliXso
 GIcLs0i7E830uVGmPgBb8Ow2ivV96QaJVoaIrvtdVI4S0kbZqGiChj6lB+hGgI+7KabH
 p2GnsCSYJNvCmHLkHtCCpRWYsd70cQ6EkAjx6qPllbjb5+9RbzODvRkzcapqukvjzDpE
 G8gw==
X-Gm-Message-State: AO0yUKUd1s7Fv0bBoujiI5x5EqjQmEXgoyHCZVWCMHHczRTPYgW9ZCHM
 EIlOXVhCqGO4pUtbqqEndM1ZVblW/WKliNyWIjo=
X-Google-Smtp-Source: AK7set/z97qrdRU5Gsceap0mFRjtGxnmS4eQ5GpEo3x26lvH2ujczer+94shM10Dmck/wa8A9miTacTcR6m9nZcVAZo=
X-Received: by 2002:a81:b61a:0:b0:52e:c79a:cda with SMTP id
 u26-20020a81b61a000000b0052ec79a0cdamr10856119ywh.10.1678246596265; Tue, 07
 Mar 2023 19:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20230307130332.53029-1-daniel.almeida@collabora.com>
 <OBVROfBri9SuVdfyos-71URYovcNLhbDb_50cECWMwhycY2sHH90w28f0qlJ_q_dMuCnOD_4nQCVUnwOkgyCEH1298nsVLW0YFuuiIlLPow=@protonmail.com>
 <01010186bea3a046-f1f68507-2d3c-41c3-9066-44199e2ce071-000000@us-west-2.amazonses.com>
In-Reply-To: <01010186bea3a046-f1f68507-2d3c-41c3-9066-44199e2ce071-000000@us-west-2.amazonses.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 8 Mar 2023 04:36:25 +0100
Message-ID: <CANiq72m_ixnodZrDiZeYY1U3Wm8WJaWwCH=dVjKBKdmczbKrGA@mail.gmail.com>
Subject: Re: [PATCH] rust: virtio: add virtio support
To: FUJITA Tomonori <tomo@exabit.dev>
Cc: wedsonaf@gmail.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bjorn3_gh@protonmail.com, ojeda@kernel.org, kernel@collabora.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBNYXIgOCwgMjAyMyBhdCAxOjM04oCvQU0gRlVKSVRBIFRvbW9ub3JpIDx0b21vQGV4
YWJpdC5kZXY+IHdyb3RlOgo+Cj4gQyB2ZXJzaW9ucyBvZiB2aXJ0aW8tY29uc29sZSwgdmlydGlv
LXJuZywgYW5kIHZpcnRpby1uZXQgZXhpc3RzLiBCb3RoCj4gQyBhbmQgUnVzdCB2ZXJzaW9ucyBp
biBtYWlubGluZT8KPgo+IEFyZSB0aGVyZSBndWlkZWxpbmVzIG9uIHB1c2hpbmcgYSBSdXN0IGRy
aXZlciBpbiBtYWlubGluZT8KCkFsdGhvdWdoIHRoZSB3ZWJzaXRlIGlzIG5vdCBmaW5pc2hlZCB5
ZXQsIHBsZWFzZSBzZWUKaHR0cHM6Ly9ydXN0LWZvci1saW51eC5jb20vY29udHJpYnV0aW5nI3N1
Ym1pdHRpbmctbmV3LWFic3RyYWN0aW9ucy1hbmQtbW9kdWxlcy4KCkNoZWVycywKTWlndWVsCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
