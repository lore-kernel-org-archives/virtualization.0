Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA491C77B7D
	for <virtualization@archiver.kernel.org>; Sat, 13 May 2023 15:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31F1E42D5D;
	Sat, 13 May 2023 15:16:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 31F1E42D5D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ZDKMqpOI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dA7wBCgCLU16; Sat, 13 May 2023 15:16:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1A90342D65;
	Sat, 13 May 2023 15:16:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A90342D65
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC10DC007C;
	Sat, 13 May 2023 15:16:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 026FBC002A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 15:16:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC10E42D65
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 15:16:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC10E42D65
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KN5KCF5iJA5b
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 15:15:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5662342D59
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5662342D59
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 15:15:58 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-966287b0f72so1602615966b.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1683990957; x=1686582957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrMPRtTxcv74Ng8wNryDIV11KZXuJe9+P1FFJBFwcZ0=;
 b=ZDKMqpOIF5XhvwEeKFMvUyardbTAIQJJlRNcEiiNS4D1M0UzbaP2RFIZWWMlqXam5x
 gAItJvpOfWPG8eA5urHKDo5IjllGbPQutFSon3f7i0GQmqFuwH+I6hn8mvCcyKeopuV3
 zVEi1ujOah0QsXIA1BzdVNk/dAhIlHjei/wqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683990957; x=1686582957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xrMPRtTxcv74Ng8wNryDIV11KZXuJe9+P1FFJBFwcZ0=;
 b=AgZGCR+DDHKWWesMzfzMNTY/GkbexHBNEvoiFJLR87IoyeZYijaqXwvA0WDm13wN1e
 fkAjQVKCkkWRZFuJiQV3bIFAsA+u6vCT6rVkPjK+ySGcjNwTI82PPsrjqyDHwmmUAQp2
 mIcaVIawub/Kvvtw0tltQj3Zove5lq2VQ5YyFkh0aNCQ/2oHF5mTc5CJ2oKUWs+8Xepk
 B9MQAVIkMde7mUaMvj1su+kVsjpdlDD0R/5DbXIPEhFSwDOi/pgw6PahEqgAfHr8HY7Y
 y4+bRFRN3XOyaiqu0rYMquxfLMHch01r322iv/hs2UYWQBNaNeOHwKnKED9jI37qVlA/
 9ygQ==
X-Gm-Message-State: AC+VfDypOtoW+Ci21LdEdp6P/26dRqiKoPVhE2BDjphyJ5bI3ISMMFd3
 EBvo7pje69z4pfYoa0EEy5CK/uwL6OYSjOROjXFMpUBf
X-Google-Smtp-Source: ACHHUZ6c+m+NYG4F74NtRUR2hpqojU7NUliViSLDHBPRFGTDm3nOynTzY5U+6wC3ZTAXAlURK369xw==
X-Received: by 2002:a17:907:7f94:b0:969:e9ec:9a0 with SMTP id
 qk20-20020a1709077f9400b00969e9ec09a0mr19969632ejc.77.1683990956661; 
 Sat, 13 May 2023 08:15:56 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com.
 [209.85.218.42]) by smtp.gmail.com with ESMTPSA id
 gv11-20020a1709072bcb00b009663cf5dc43sm6910725ejc.181.2023.05.13.08.15.56
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 May 2023 08:15:56 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-966287b0f72so1602613566b.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 08:15:56 -0700 (PDT)
X-Received: by 2002:a17:907:783:b0:862:c1d5:ea1b with SMTP id
 xd3-20020a170907078300b00862c1d5ea1bmr25847436ejb.8.1683990501510; Sat, 13
 May 2023 08:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
In-Reply-To: <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 13 May 2023 10:08:04 -0500
X-Gmail-Original-Message-ID: <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
Message-ID: <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Christian Brauner <brauner@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>, mst@redhat.com,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com, nicolas.dichtel@6wind.com
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

T24gU2F0LCBNYXkgMTMsIDIwMjMgYXQgNzozOeKAr0FNIFRob3JzdGVuIExlZW1odWlzIDxsaW51
eEBsZWVtaHVpcy5pbmZvPiB3cm90ZToKPgo+IEp1bXBpbmcgaW4gaGVyZSwgYXMgSSBmb3VuZCBh
bm90aGVyIHByb2JsZW0gd2l0aCB0aGF0IHBhdGNoOiBpdCBicm9rZQo+IHMyaWRsZSBvbiBteSBs
YXB0b3Agd2hlbiBhIHFlbXUta3ZtIFZNIGlzIHJ1bm5pbmcsIGFzIGZyZWV6aW5nIHVzZXIKPiBz
cGFjZSBwcm9jZXNzZXMgbm93IGZhaWxzIGZvciBtZToKCkhtbS4ga3RocmVhZHMgaGF2ZSBQRl9O
T0ZSRUVaRSBieSBkZWZhdWx0LCB3aGljaCBpcyBwcm9iYWJseSB0aGUgcmVhc29uLgoKQWRkaW5n
CgogICAgICAgIGN1cnJlbnQtPmZsYWdzIHw9IFBGX05PRlJFRVpFOwoKdG8gdGhlIHZob3N0X3Rh
c2sgc2V0dXAgbWlnaHQganVzdCBmaXggaXQsIGJ1dCBpdCBmZWVscyBhIGJpdCBvZmYuCgpUaGUg
d2F5IGlvX3VyaW5nIGRvZXMgdGhpcyBpcyB0byAgZG8KCiAgICAgICAgICAgICAgICBpZiAoc2ln
bmFsX3BlbmRpbmcoY3VycmVudCkpIHsKICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGtz
aWduYWwga3NpZzsKCiAgICAgICAgICAgICAgICAgICAgICAgIGlmICghZ2V0X3NpZ25hbCgma3Np
ZykpCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7CiAgICAgICAgICAg
ICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICAgICAgfQoKaW4gdGhlIG1haW4gbG9vcCwg
d2hpY2ggZW5kcyB1cCBoYW5kbGluZyB0aGUgZnJlZXplciBzaXR1YXRpb24gdG9vLgpCdXQgaXQg
c2hvdWxkIGhhbmRsZSB0aGluZ3MgbGlrZSBTSUdTVE9QIGV0YyBhcyB3ZWxsLCBhbmQgYWxzbyBl
eGl0IG9uCmFjdHVhbCBzaWduYWxzLgoKSSBnZXQgdGhlIGZlZWxpbmcgdGhhdCB0aGUgd2hvbGUg
InZob3N0X3Rhc2tfc2hvdWxkX3N0b3AoKSIgbG9naWMKc2hvdWxkIGhhdmUgdGhlIGV4YWN0IGxv
Z2ljIGFib3ZlLCBhbmQgYmFzaWNhbGx5IG1ha2UgdGhvc2UgdGhyZWFkcwpraWxsYWJsZSBhcyB3
ZWxsLgoKSG1tPwoKICAgICAgICAgICAgICAgIExpbnVzCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
