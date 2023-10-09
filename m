Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3F5E95A91
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 08:13:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6F98418B4;
	Mon,  9 Oct 2023 08:13:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6F98418B4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JcvlUZKE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PynWBDaRDYTC; Mon,  9 Oct 2023 08:13:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D84D2417AB;
	Mon,  9 Oct 2023 08:13:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D84D2417AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9475C0039;
	Mon,  9 Oct 2023 08:13:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58A71C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 08:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3020741859
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 08:13:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3020741859
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oFFKMok1uJAA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 08:13:54 +0000 (UTC)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2270417AB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 08:13:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2270417AB
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7b0ec7417bdso1238477241.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 01:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696839232; x=1697444032;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g97708SLPpUQGaeNPBhyGUaVogHGb5gBagyPdjwmXiM=;
 b=JcvlUZKE2JB6I/uxFMLI9V/sJKqPWlXWjDQ+xNNIh6SYfWB4mZuL9HhhLC2pUgRvaO
 PQdiyW/yUui7pRD3Z02DAtb2CiJxRF74dsPdlCWp8MtlSW8vXajHLEZRNJw6wY3sthIE
 i5f92VpGYMDGS1wa46Q6H9jXB9SXVjR2ycy1smJx4OWEmTuFo3QjlQJMG1C+Gv9dfMQA
 SecP184kaZ7HQQHSJ1oOfXRgo2tGWqw28NqXhU0zojUAXdGxbO4VfZWd1WFxYiO26s7X
 iO3helZi708KQ8KL4yUtt+yPN9uchNBzbnKaDR3JgzlVAirmR4PVX42Ccoo07B9l1wc9
 oNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696839233; x=1697444033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g97708SLPpUQGaeNPBhyGUaVogHGb5gBagyPdjwmXiM=;
 b=eoXpNep0wTDEbSmeWVvK+D94A+NJ63rUxAv9YcE3PGyYZVBlFbXGgh1QpYEwcTcOHJ
 s8fIosXWgTM3CMlrBoIaaArB0Zr+p7mcQfPMB1YQPmilOWUAuKpNtl2qjfJbR7x7Zwdp
 GozDzlxS00xyte0UKMGnwA7Vrw7MdJaF22Nh8uDSVn1dAt1I6CsTgs9oiUAkTdC2ESYM
 lb1Z9oJrMByKbhoyq6c0Eg+drAJfuoIslNYh9hTOhkgeoeGWL7bc8xyoFJV5/hLSr0T/
 iWzKB7jAjXH3T8XrJLA1lBSZuaFTEIg/AQy/LwdFdUNd1J+S4BKV9x7wJv49TfaAStmU
 cvjA==
X-Gm-Message-State: AOJu0YwAl89fk61lLP0bq7NL/7DRDoB5U77/r0W4XaSEvD3suEMqlezT
 sMBv4jBFs0561F8uJh8ICmudZ4D114mazJKubww=
X-Google-Smtp-Source: AGHT+IFADylaHVxGSdb1Oqn5UxNB9rtGxlVAuFq0a1ZtipvFhWLBvdaHsXsXzXMCgag4xO0u48yu7pmMnXOLi+XLyn8=
X-Received: by 2002:a67:f7c1:0:b0:44e:d6c3:51d4 with SMTP id
 a1-20020a67f7c1000000b0044ed6c351d4mr12138747vsp.18.1696839232644; Mon, 09
 Oct 2023 01:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
In-Reply-To: <20231008052101.144422-6-akihiko.odaki@daynix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 9 Oct 2023 03:13:15 -0500
Message-ID: <CAF=yD-K2MQt4nnfwJrx6h6Nii_rho7j1o6nb_jYaSwcWY45pPw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
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

T24gU3VuLCBPY3QgOCwgMjAyMyBhdCAxMjoyMuKAr0FNIEFraWhpa28gT2Rha2kgPGFraWhpa28u
b2Rha2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4KPiB2aXJ0aW8tbmV0IGhhdmUgdHdvIHVzYWdlIG9m
IGhhc2hlczogb25lIGlzIFJTUyBhbmQgYW5vdGhlciBpcyBoYXNoCj4gcmVwb3J0aW5nLiBDb252
ZW50aW9uYWxseSB0aGUgaGFzaCBjYWxjdWxhdGlvbiB3YXMgZG9uZSBieSB0aGUgVk1NLgo+IEhv
d2V2ZXIsIGNvbXB1dGluZyB0aGUgaGFzaCBhZnRlciB0aGUgcXVldWUgd2FzIGNob3NlbiBkZWZl
YXRzIHRoZQo+IHB1cnBvc2Ugb2YgUlNTLgo+Cj4gQW5vdGhlciBhcHByb2FjaCBpcyB0byB1c2Ug
ZUJQRiBzdGVlcmluZyBwcm9ncmFtLiBUaGlzIGFwcHJvYWNoIGhhcwo+IGFub3RoZXIgZG93bnNp
ZGU6IGl0IGNhbm5vdCByZXBvcnQgdGhlIGNhbGN1bGF0ZWQgaGFzaCBkdWUgdG8gdGhlCj4gcmVz
dHJpY3RpdmUgbmF0dXJlIG9mIGVCUEYuCj4KPiBJbnRyb2R1Y2UgdGhlIGNvZGUgdG8gY29tcHV0
ZSBoYXNoZXMgdG8gdGhlIGtlcm5lbCBpbiBvcmRlciB0byBvdmVyY29tZQo+IHRoc2UgY2hhbGxl
bmdlcy4gQW4gYWx0ZXJuYXRpdmUgc29sdXRpb24gaXMgdG8gZXh0ZW5kIHRoZSBlQlBGIHN0ZWVy
aW5nCj4gcHJvZ3JhbSBzbyB0aGF0IGl0IHdpbGwgYmUgYWJsZSB0byByZXBvcnQgdG8gdGhlIHVz
ZXJzcGFjZSwgYnV0IGl0IG1ha2VzCj4gbGl0dGxlIHNlbnNlIHRvIGFsbG93IHRvIGltcGxlbWVu
dCBkaWZmZXJlbnQgaGFzaGluZyBhbGdvcml0aG1zIHdpdGgKPiBlQlBGIHNpbmNlIHRoZSBoYXNo
IHZhbHVlIHJlcG9ydGVkIGJ5IHZpcnRpby1uZXQgaXMgc3RyaWN0bHkgZGVmaW5lZCBieQo+IHRo
ZSBzcGVjaWZpY2F0aW9uLgo+Cj4gVGhlIGhhc2ggdmFsdWUgYWxyZWFkeSBzdG9yZWQgaW4gc2tf
YnVmZiBpcyBub3QgdXNlZCBhbmQgY29tcHV0ZWQKPiBpbmRlcGVuZGVudGx5IHNpbmNlIGl0IG1h
eSBoYXZlIGJlZW4gY29tcHV0ZWQgaW4gYSB3YXkgbm90IGNvbmZvcm1hbnQKPiB3aXRoIHRoZSBz
cGVjaWZpY2F0aW9uLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWtpaGlrbyBPZGFraSA8YWtpaGlrby5v
ZGFraUBkYXluaXguY29tPgoKPiBAQCAtMjExNiwzMSArMjE3Miw0OSBAQCBzdGF0aWMgc3NpemVf
dCB0dW5fcHV0X3VzZXIoc3RydWN0IHR1bl9zdHJ1Y3QgKnR1biwKPiAgICAgICAgIH0KPgo+ICAg
ICAgICAgaWYgKHZuZXRfaGRyX3N6KSB7Cj4gLSAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0aW9f
bmV0X2hkciBnc287Cj4gKyAgICAgICAgICAgICAgIHVuaW9uIHsKPiArICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgdmlydGlvX25ldF9oZHIgaGRyOwo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl92MV9oYXNoIHYxX2hhc2hfaGRyOwo+ICsgICAgICAg
ICAgICAgICB9IGhkcjsKPiArICAgICAgICAgICAgICAgaW50IHJldDsKPgo+ICAgICAgICAgICAg
ICAgICBpZiAoaW92X2l0ZXJfY291bnQoaXRlcikgPCB2bmV0X2hkcl9zeikKPiAgICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPgo+IC0gICAgICAgICAgICAgICBpZiAodmly
dGlvX25ldF9oZHJfZnJvbV9za2Ioc2tiLCAmZ3NvLAo+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdHVuX2lzX2xpdHRsZV9lbmRpYW4odHVuKSwgdHJ1ZSwKPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZsYW5faGxlbikpIHsK
PiArICAgICAgICAgICAgICAgaWYgKChSRUFEX09OQ0UodHVuLT52bmV0X2hhc2guZmxhZ3MpICYg
VFVOX1ZORVRfSEFTSF9SRVBPUlQpICYmCj4gKyAgICAgICAgICAgICAgICAgICB2bmV0X2hkcl9z
eiA+PSBzaXplb2YoaGRyLnYxX2hhc2hfaGRyKSAmJgo+ICsgICAgICAgICAgICAgICAgICAgc2ti
LT50dW5fdm5ldF9oYXNoKSB7CgpJc24ndCB2bmV0X2hkcl9zeiBndWFyYW50ZWVkIHRvIGJlID49
IGhkci52MV9oYXNoX2hkciwgYnkgdmlydHVlIG9mCnRoZSBzZXQgaGFzaCBpb2N0bCBmYWlsaW5n
IG90aGVyd2lzZT8KClN1Y2ggY2hlY2tzIHNob3VsZCBiZSBsaW1pdGVkIHRvIGNvbnRyb2wgcGF0
aCB3aGVyZSBwb3NzaWJsZQoKPiArICAgICAgICAgICAgICAgICAgICAgICB2bmV0X2hkcl9jb250
ZW50X3N6ID0gc2l6ZW9mKGhkci52MV9oYXNoX2hkcik7Cj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcmV0ID0gdmlydGlvX25ldF9oZHJfdjFfaGFzaF9mcm9tX3NrYihza2IsCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmaGRy
LnYxX2hhc2hfaGRyLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdHJ1ZSwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZsYW5faGxlbiwKPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2bmV0
X2hhc2gpOwo+ICsgICAgICAgICAgICAgICB9IGVsc2Ugewo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHZuZXRfaGRyX2NvbnRlbnRfc3ogPSBzaXplb2YoaGRyLmhkcik7Cj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcmV0ID0gdmlydGlvX25ldF9oZHJfZnJvbV9za2Ioc2tiLCAmaGRyLmhkciwK
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0
dW5faXNfbGl0dGxlX2VuZGlhbih0dW4pLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHRydWUsIHZsYW5faGxlbik7Cj4gKyAgICAgICAgICAg
ICAgIH0KPiArCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
