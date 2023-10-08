Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081D9E95A82
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 18:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7692860BD8;
	Sun,  8 Oct 2023 18:39:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7692860BD8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FjxdYF8S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7KbhKZgW2yNz; Sun,  8 Oct 2023 18:39:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E7A9D60BBB;
	Sun,  8 Oct 2023 18:39:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7A9D60BBB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB673C0039;
	Sun,  8 Oct 2023 18:39:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1908BC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 18:39:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D56CD81295
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 18:39:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D56CD81295
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=FjxdYF8S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0XckVj5T8Q4N
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 18:39:45 +0000 (UTC)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C67380E13
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 18:39:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C67380E13
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-49d6bd360f8so1381997e0c.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 08 Oct 2023 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696790384; x=1697395184;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tr653O7IJNfsfgKHhAi3CZ9n/CYymbSf0E9j3Afy54M=;
 b=FjxdYF8SBdo7qFdjoxS6knMAESatL1ELNGFKDXi5CXXxW01W31/D3DVNfb0OOHKuTx
 t1UQLDbs7EfgssIxwRN3TJ9eM3P6jKaO1sBybDVCMqqu0GA6/RycCDAwY3BfRwhQNY2I
 3agWXJT9Ady8EqN6ZGQUEcVhF84X9WKuRrdCGL5OqTpz8q0AziA/BM2JFW3hiz/SBqaz
 rMwCcBLNkJyguklX+yZuQHPU/jznZSzsOPFms4bzSHK6jdRSY/TGnvAL4XIPBvCdMHLo
 CDwHcizkekS1w/9iMKO5tgcHbkgCHMreyj8JRsMfToDre58m/I50dRidEeTo2a4yFhPG
 GtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696790384; x=1697395184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tr653O7IJNfsfgKHhAi3CZ9n/CYymbSf0E9j3Afy54M=;
 b=IDhkyIQuiC/k40EGvPCEB2uywjMzGi85eoYMuTPssgHY/43v4MyUGhs/cnHXl4zbb1
 lyzvG6AgR4V0isFevmp95hEMWvQLPp6zMGyTG4GlmwBP0g9ntKUhFOR+Rs9trSabisa3
 vpxTrG+NnxcLI2FXKTUGj68sXnbA89ljJzBITRrkraUQwRyGrb+6cqlnAfhcNCvrAELj
 jJmXqk8dfuk0N9Yduri6Sz8nRVBRSvCq1SNw/M4CnIkEBw3J8iymTV243DVr2xbHSv4q
 SuruZglZSMIztekllU8zomK/IdjIMWeKbotls/ZJCdn/GCF1BHJG+zD6uBGdl7ktRzx3
 ShzQ==
X-Gm-Message-State: AOJu0YxckG9T0pouuUV8g4568nAd8CP4I6bLFT7k9sKJeeQwQdt0vrms
 2tXYp34ntemvRO83hgJHeocvbaOeMdG8zS+H3dk=
X-Google-Smtp-Source: AGHT+IE/jeE8xp/dnu7wWNl+8oGAAPikxJaZzEQXCj6pPJv5za+sk1HRBAcSLpYAaMWWEgSrYl8NAuH0m57scqWgSgE=
X-Received: by 2002:a1f:ec83:0:b0:49a:a3ee:d280 with SMTP id
 k125-20020a1fec83000000b0049aa3eed280mr10123409vkh.16.1696790384365; Sun, 08
 Oct 2023 11:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-2-akihiko.odaki@daynix.com>
In-Reply-To: <20231008052101.144422-2-akihiko.odaki@daynix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 8 Oct 2023 20:39:07 +0200
Message-ID: <CAF=yD-K0RR5XCuPdHS8gPwppM-HAmodSOVBpS=v+j8X7=Su2Rg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] net: skbuff: Add tun_vnet_hash flag
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: songliubraving@fb.com, gustavoars@kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, decui@microsoft.com, ast@kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, yhs@fb.com,
 pabeni@redhat.com, pablo@netfilter.org, elver@google.com, kpsingh@kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, cai@lca.pw, kuba@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, nogikh@google.com,
 bpf@vger.kernel.org, kafai@fb.com
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

T24gU3VuLCBPY3QgOCwgMjAyMyBhdCA3OjIy4oCvQU0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5v
ZGFraUBkYXluaXguY29tPiB3cm90ZToKPgo+IHR1bl92bmV0X2hhc2ggY2FuIHVzZSB0aGlzIGZs
YWcgdG8gaW5kaWNhdGUgaXQgc3RvcmVkIHZpcnRpby1uZXQgaGFzaAo+IGNhY2hlIHRvIGNiLgo+
Cj4gU2lnbmVkLW9mZi1ieTogQWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXguY29t
Pgo+IC0tLQo+ICBpbmNsdWRlL2xpbnV4L3NrYnVmZi5oIHwgMiArKwo+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9za2J1ZmYu
aCBiL2luY2x1ZGUvbGludXgvc2tidWZmLmgKPiBpbmRleCA0MTc0YzRiODJkMTMuLmU2MzhmMTU3
YzEzYyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oCj4gKysrIGIvaW5jbHVk
ZS9saW51eC9za2J1ZmYuaAo+IEBAIC04MzcsNiArODM3LDcgQEAgdHlwZWRlZiB1bnNpZ25lZCBj
aGFyICpza19idWZmX2RhdGFfdDsKPiAgICogICAgIEB0cnVlc2l6ZTogQnVmZmVyIHNpemUKPiAg
ICogICAgIEB1c2VyczogVXNlciBjb3VudCAtIHNlZSB7ZGF0YWdyYW0sdGNwfS5jCj4gICAqICAg
ICBAZXh0ZW5zaW9uczogYWxsb2NhdGVkIGV4dGVuc2lvbnMsIHZhbGlkIGlmIGFjdGl2ZV9leHRl
bnNpb25zIGlzIG5vbnplcm8KPiArICogICAgIEB0dW5fdm5ldF9oYXNoOiB0dW4gc3RvcmVkIHZp
cnRpby1uZXQgaGFzaCBjYWNoZSB0byBjYgo+ICAgKi8KPgo+ICBzdHJ1Y3Qgc2tfYnVmZiB7Cj4g
QEAgLTk4OSw2ICs5OTAsNyBAQCBzdHJ1Y3Qgc2tfYnVmZiB7Cj4gICNpZiBJU19FTkFCTEVEKENP
TkZJR19JUF9TQ1RQKQo+ICAgICAgICAgX191OCAgICAgICAgICAgICAgICAgICAgY3N1bV9ub3Rf
aW5ldDoxOwo+ICAjZW5kaWYKPiArICAgICAgIF9fdTggICAgICAgICAgICAgICAgICAgIHR1bl92
bmV0X2hhc2g6MTsKCnNrX2J1ZmYgc3BhY2UgaXMgdmVyeSBsaW1pdGVkLgoKTm8gbmVlZCB0byBl
eHRlbmQgaXQsIGVzcGVjaWFsbHkgZm9yIGNvZGUgdGhhdCBzdGF5cyB3aXRoaW4gYSBzaW5nbGUK
c3Vic3lzdGVtICh0dW4pLgoKVG8gYSBsZXNzZXIgZXh0ZW50IHRoZSBzYW1lIHBvaW50IGFwcGxp
ZXMgdG8gdGhlIHFkaXNjX3NrYl9jYi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
