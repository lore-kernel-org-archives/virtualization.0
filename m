Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0814FC77B75
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 00:17:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A29526FF3B;
	Thu, 18 May 2023 00:17:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A29526FF3B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=IBG+nTw6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9k2MYMSCCpVP; Thu, 18 May 2023 00:17:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 37F156FF35;
	Thu, 18 May 2023 00:17:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 37F156FF35
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EA42C0037;
	Thu, 18 May 2023 00:17:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3CD0C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 00:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81C75404F9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 00:17:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 81C75404F9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=IBG+nTw6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YwodTPzpPdpP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 00:17:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4DA63400D6
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4DA63400D6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 00:17:16 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-966287b0f72so259061166b.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 17:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1684369034; x=1686961034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SghvpISWOr2Xb/wbBKmrX8f/G7elt4qY32AMimXheQA=;
 b=IBG+nTw6a9S41RaiATt9FaOTVAM8BW0SsRpKBG70mIJk1VQkCVz9FI5ORG0C0yMpoY
 KxRGxWy2rKXekTI0rpU+i2MyGHQo/IkfC9eD0Jsi34Kun68q4BGKjK7GrclveLWn2h+L
 T3nYGmA4/giGGqGgCrg54sbdj8a7PPdD5Htz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684369034; x=1686961034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SghvpISWOr2Xb/wbBKmrX8f/G7elt4qY32AMimXheQA=;
 b=J3qrqGGZL1LacV4yjkJnve9wFuB7WUvTC9R7QOQ1ENZqrIM+MCZRvsGBAcZvmKgSkC
 vHNmM6SEXBF9O43tFIEP+GG9+HLXVbx6doIuRVbyVpuQOjDevsoYOpFRBUynGGjL8tSB
 KGJqT4gJxEMlSkvCqCfCI6wV3odkZJ7152spWQysWIGw+A6QfgigchRvWI0VHFnzOGvw
 vo9v8ZmgyIpnz8QWnLiwNPM5hSKSBsgIxro9qtJQX1BOS90JYSSLolrhD+h9ZqeLp8pU
 VWvu+gxaiAADAau4hw0UWUHauGQwcYZc8gha36et7G4iVwzOGWZEJEDzH3rI9cZOVABo
 Kupg==
X-Gm-Message-State: AC+VfDwK9ZBaGpjQq3uwDReBVr9sakEUu0EDFf0Rr846RswsrIXFRf0u
 gVclSudVxvZ8rbSGgKnhCtj58odiWmG2CDYHuqJr/mWVHJk=
X-Google-Smtp-Source: ACHHUZ6hFP3b7ITgcLH6NAxFLDLHB+QLP3IBmD1hWTWea9oo5ShghiJZbf3yQ6tugktBhJRcQMyaAA==
X-Received: by 2002:a17:907:628c:b0:94f:2a13:4e01 with SMTP id
 nd12-20020a170907628c00b0094f2a134e01mr39554749ejc.74.1684369034297; 
 Wed, 17 May 2023 17:17:14 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com.
 [209.85.218.49]) by smtp.gmail.com with ESMTPSA id
 la17-20020a170906ad9100b00965ab02b42csm211613ejb.102.2023.05.17.17.17.13
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 17:17:14 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-965a68abfd4so256661166b.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 17:17:13 -0700 (PDT)
X-Received: by 2002:a17:907:97c8:b0:961:b0:3dfd with SMTP id
 js8-20020a17090797c800b0096100b03dfdmr42523477ejc.7.1684369033423; Wed, 17
 May 2023 17:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-3-michael.christie@oracle.com>
In-Reply-To: <20230518000920.191583-3-michael.christie@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 May 2023 17:16:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wga+96PqV4x8EwFAMfi--m9essdX+3uPE-AoOSAQR1ddA@mail.gmail.com>
Message-ID: <CAHk-=wga+96PqV4x8EwFAMfi--m9essdX+3uPE-AoOSAQR1ddA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/8] vhost/vhost_task: Hook vhost layer into signal
 handler
To: Mike Christie <michael.christie@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, oleg@redhat.com, ebiederm@xmission.com,
 stefanha@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBNYXkgMTcsIDIwMjMgYXQgNTowOeKAr1BNIE1pa2UgQ2hyaXN0aWUKPG1pY2hhZWwu
Y2hyaXN0aWVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiArICAgICAgIF9fc2V0X2N1cnJlbnRfc3Rh
dGUoVEFTS19SVU5OSU5HKTsKPiArICAgICAgIHJjID0gZ2V0X3NpZ25hbCgma3NpZyk7Cj4gKyAg
ICAgICBzZXRfY3VycmVudF9zdGF0ZShUQVNLX0lOVEVSUlVQVElCTEUpOwo+ICsgICAgICAgcmV0
dXJuIHJjOwoKVGhlIGdhbWVzIHdpdGggY3VycmVudF9zdGF0ZSBzZWVtIG5vbnNlbnNpY2FsLgoK
V2hhdCBhcmUgdGhleSBhbGwgYWJvdXQ/IGdldF9zaWduYWwoKSBzaG91bGRuJ3QgY2FyZSwgYW5k
IG5vIG90aGVyCmNhbGxlciBkb2VzIHRoaXMgdGhpbmcuIFRoaXMganVzdCBzZWVtcyBjb21wbGV0
ZWx5IHJhbmRvbS4KCiAgICAgIExpbnVzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
