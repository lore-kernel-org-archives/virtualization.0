Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3971CC433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 10:20:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF6AE60803;
	Wed, 23 Feb 2022 10:20:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gGvY20dUtVss; Wed, 23 Feb 2022 10:20:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4B27E60AED;
	Wed, 23 Feb 2022 10:20:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FAB8C0021;
	Wed, 23 Feb 2022 10:20:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED62BC0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 10:20:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBB00826A8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 10:20:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HMGbat9HZAgQ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 10:20:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA36582410
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 10:20:14 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id 12so15923833pgd.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DQX7V52CBiJ7FddDejeLAMem+iUAD4nV8smE6+HMiCk=;
 b=nN41YCVInSLt/JhZi7jK4UIpYreHneBcjM9jaq1ZZoxJ1/HvTSNw/17hZcv+kDyYd6
 +REnkeyTUgx0AmMKdy+VTVlBINeBfEKvrtvRYmlTs9AgmnLtJF9qZixJ3s5pQNss0vs6
 zVZe/dXo1+NnSdrdMA9wcfg6nXb7vGWJxV6I5T0J6PkmWpN0YNnb6zjvCoCr935RSum7
 Y2LQBdU3OuNnflCdHskASMBzdNDYIplLTdH793XbTrZvH4nak4d7jYpjPCz/3Z2V+Mar
 9jB/QwBi/DjewJnn924OyllWj+1kAstpa7J+h5ZalOgqI27LkUHizcD3M1ll6ekNuD3h
 WfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DQX7V52CBiJ7FddDejeLAMem+iUAD4nV8smE6+HMiCk=;
 b=INE3jwEH7snPaMS6WQGbBwtXaZHpGVZsF/n+ttfCZqixMZmid2Bqfnx04q95+MioWB
 tUta61wp7oT6ydYsjp5wI99ZmLE8At5N3CRazSwA704gQtJ4GMZSkjityMk2kSKZvQPe
 0e182+M64BC6pW34UyEMdkCNLlKBlOPaKPgSgQF1cau5DTLZOR60QIBAp3zjh4P6dra/
 FX7l/tLqSdJLO7CFfw0PHtw02rv8KNb7JsCYkW1R1cddsGH0fPDzgF99txEHdOi9wbSw
 zGzaLLxnFAZIzl+LNMO9uqXRBvonDSUKGWff9gT14eFFVDleQccFX+ABU6THEIkVE2mQ
 yIMw==
X-Gm-Message-State: AOAM533tNrlbfW+TmkKf6rK9JJU3+qKMoAdvciTbuku4WGx75y+UgDJs
 Ox8Qjz1GiAOaVX9ZbbQ7HFTEQA==
X-Google-Smtp-Source: ABdhPJwOzH9BvKERdYDHwMSCkR2/GlOKIJMuXG+DePst13wAFc5G8wENJdbZFppqmk3wfvsgl9oAbg==
X-Received: by 2002:a63:af4b:0:b0:373:a2a1:bf9a with SMTP id
 s11-20020a63af4b000000b00373a2a1bf9amr23123430pgo.369.1645611614111; 
 Wed, 23 Feb 2022 02:20:14 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id
 x64-20020a17090a6c4600b001bc6d235a0esm2496931pjj.1.2022.02.23.02.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Feb 2022 02:20:13 -0800 (PST)
Subject: Re: [PATCH v2 3/3] virtio-crypto: implement RSA algorithm
From: zhenwei pi <pizhenwei@bytedance.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20220211084108.1254218-1-pizhenwei@bytedance.com>
 <20220211084108.1254218-4-pizhenwei@bytedance.com>
 <c9144b0d82e34566a960f210ddc32696@huawei.com>
 <8ef2f660-bd84-de70-1539-402c73795dfe@bytedance.com>
Message-ID: <bc2bbc3b-8a34-2f09-41f5-60f1568a6bef@bytedance.com>
Date: Wed, 23 Feb 2022 18:17:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8ef2f660-bd84-de70-1539-402c73795dfe@bytedance.com>
Content-Language: en-US
Cc: "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, kernel test robot <lkp@intel.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIvMTgvMjIgMTE6MTIgQU0sIHpoZW53ZWkgcGkgd3JvdGU6Cj4+PiArdm9pZCB2aXJ0aW9f
Y3J5cHRvX2FrY2lwaGVyX2FsZ3NfdW5yZWdpc3RlcihzdHJ1Y3QgdmlydGlvX2NyeXB0bwo+Pj4g
Kyp2Y3J5cHRvKSB7Cj4+PiArwqDCoMKgIGludCBpID0gMDsKPj4+ICsKPj4+ICvCoMKgwqAgbXV0
ZXhfbG9jaygmYWxnc19sb2NrKTsKPj4+ICsKPj4+ICvCoMKgwqAgZm9yIChpID0gMDsgaSA8IEFS
UkFZX1NJWkUodmlydGlvX2NyeXB0b19ha2NpcGhlcl9hbGdzKTsgaSsrKSB7Cj4+PiArwqDCoMKg
wqDCoMKgwqAgdWludDMyX3Qgc2VydmljZSA9IHZpcnRpb19jcnlwdG9fYWtjaXBoZXJfYWxnc1tp
XS5zZXJ2aWNlOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIHVpbnQzMl90IGFsZ29udW0gPSB2aXJ0aW9f
Y3J5cHRvX2FrY2lwaGVyX2FsZ3NbaV0uYWxnb251bTsKPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDC
oCBpZiAodmlydGlvX2NyeXB0b19ha2NpcGhlcl9hbGdzW2ldLmFjdGl2ZV9kZXZzID09IDAgfHwK
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICF2aXJ0Y3J5cHRvX2FsZ29faXNfc3VwcG9ydGVk
KHZjcnlwdG8sIHNlcnZpY2UsIGFsZ29udW0pKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y29udGludWU7Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHZpcnRpb19jcnlwdG9fYWtj
aXBoZXJfYWxnc1tpXS5hY3RpdmVfZGV2cyA9PSAxKQo+Pj4gKwo+Pj4gwqDCoMKgwqBjcnlwdG9f
dW5yZWdpc3Rlcl9ha2NpcGhlcigmdmlydGlvX2NyeXB0b19ha2NpcGhlcl9hbGdzW2ldLmFsZ28p
Owo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgIHZpcnRpb19jcnlwdG9fYWtjaXBoZXJfYWxnc1tp
XS5hY3RpdmVfZGV2cy0tOwo+Pj4gK8KgwqDCoCB9Cj4+PiArCj4+PiArwqDCoMKgIG11dGV4X3Vu
bG9jaygmYWxnc19sb2NrKTsKPj4+ICt9Cj4+Cj4+IFdoeSBkb24ndCB5b3UgcmV1c2UgdGhlIHZp
cnRpb19jcnlwdG9fYWxnc19yZWdpc3Rlci91bnJlZ2lzdGVyIGZ1bmN0aW9ucz8KPj4gVGhlIGN1
cnJlbnQgY29kZSBpcyB0b28gcmVwZXRpdGl2ZS4gTWF5YmUgd2UgZG9uJ3QgbmVlZCBjcmVhdGUg
dGhlIG5ldyAKPj4gZmlsZSB2aXJ0aW9fY3J5cHRvX2FrY2lwaGVyX2FsZ28uYwo+PiBiZWNhdXNl
IHdlIGhhZCB2aXJ0aW9fY3J5cHRvX2FsZ3MuYyB3aGljaCBpbmNsdWRlcyBhbGwgYWxnb3JpdGht
cy4KPj4KPiAKPiBZZXMsIHRoaXMgbG9va3Mgc2ltaWxhciB0byB2aXJ0aW9fY3J5cHRvX2FsZ3Nf
cmVnaXN0ZXIvdW5yZWdpc3Rlci4KPiAKPiBMZXQncyBsb29rIGF0IHRoZSBkaWZmZXJlbmNlOgo+
IHN0cnVjdCB2aXJ0aW9fY3J5cHRvX2FrY2lwaGVyX2FsZ28gewo+ICDCoMKgwqDCoMKgwqDCoCB1
aW50MzJfdCBhbGdvbnVtOwo+ICDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBzZXJ2aWNlOwo+ICDC
oMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgYWN0aXZlX2RldnM7Cj4gIMKgwqDCoMKgwqDCoMKg
IHN0cnVjdCBha2NpcGhlcl9hbGcgYWxnbzsKPiB9Owo+IAo+IHN0cnVjdCB2aXJ0aW9fY3J5cHRv
X2FsZ28gewo+ICDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBhbGdvbnVtOwo+ICDCoMKgwqDCoMKg
wqDCoCB1aW50MzJfdCBzZXJ2aWNlOwo+ICDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgYWN0
aXZlX2RldnM7Cj4gIMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBza2NpcGhlcl9hbGcgYWxnbzsgLyog
YWtjaXBoZXJfYWxnIFZTIHNrY2lwaGVyX2FsZyAqLwo+IH07Cj4gCj4gSWYgcmV1c2luZyB2aXJ0
aW9fY3J5cHRvX2FsZ3NfcmVnaXN0ZXIvdW5yZWdpc3Rlciwgd2UgbmVlZCB0byBtb2RpZnkgdGhl
IAo+IGRhdGEgc3RydWN0dXJlIGxpa2UgdGhpczoKPiBzdHJ1Y3QgdmlydGlvX2NyeXB0b19ha2Np
cGhlcl9hbGdvIHsKPiAgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgYWxnb251bTsKPiAgwqDCoMKg
wqDCoMKgwqAgdWludDMyX3Qgc2VydmljZTvCoMKgwqAgLyogdXNlIHNlcnZpY2UgdG8gZGlzdGlu
Z3Vpc2ggCj4gYWtjaXBoZXIvc2tjaXBoZXIgKi8KPiAgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQg
aW50IGFjdGl2ZV9kZXZzOwo+ICDCoMKgwqDCoHVuaW9uIHsKPiAgwqDCoMKgwqDCoMKgwqAgc3Ry
dWN0IHNrY2lwaGVyX2FsZyBza2NpcGhlcjsKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1
Y3QgYWtjaXBoZXJfYWxnIGFrY2lwaGVyOwo+ICDCoMKgwqDCoH0gYWxnOwo+IH07Cj4gCj4gaW50
IHZpcnRpb19jcnlwdG9fYWtjaXBoZXJfYWxnc19yZWdpc3RlcihzdHJ1Y3QgdmlydGlvX2NyeXB0
byAqdmNyeXB0bykKPiB7Cj4gIMKgwqDCoMKgLi4uCj4gIMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9
IDA7IGkgPCBBUlJBWV9TSVpFKHZpcnRpb19jcnlwdG9fYWtjaXBoZXJfYWxncyk7IGkrKykgewo+
ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3Qgc2VydmljZSA9IHZpcnRp
b19jcnlwdG9fYWtjaXBoZXJfYWxnc1tpXS5zZXJ2aWNlOwo+ICDCoMKgwqDCoMKgwqDCoCAuLi4K
PiAgwqDCoMKgwqDCoMKgwqAgLyogdGVzdCBzZXJ2aWNlIHR5cGUgdGhlbiBjYWxsIAo+IGNyeXB0
b19yZWdpc3Rlcl9ha2NpcGhlci9jcnlwdG9fcmVnaXN0ZXJfc2tjaXBoZXIgKi8KPiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChzZXJ2aWNlID09IFZJUlRJT19DUllQVE9fU0VS
VklDRV9BS0NJUEhFUikKPiAgICAgICAgICAgICAgCj4gY3J5cHRvX3JlZ2lzdGVyX2FrY2lwaGVy
KCZ2aXJ0aW9fY3J5cHRvX2FrY2lwaGVyX2FsZ3NbaV0uYWxnby5ha2NpcGhlcik7Cj4gIMKgwqDC
oMKgwqDCoMKgIGVsc2UKPiAgICAgICAgICAgICAgCj4gY3J5cHRvX3JlZ2lzdGVyX3NrY2lwaGVy
KCZ2aXJ0aW9fY3J5cHRvX3NrY2lwaGVyX2FsZ3NbaV0uYWxnby5za2NpcGhlcik7Cj4gIMKgwqDC
oMKgwqDCoMKgIC4uLgo+ICDCoMKgwqDCoMKgwqDCoCB9Cj4gIMKgwqDCoMKgLi4uCj4gfQo+IAo+
IEFsc28gdGVzdCBzZXJ2aWNlIHR5cGUgYW5kIGNhbGwgCj4gY3J5cHRvX3VucmVnaXN0ZXJfc2tj
aXBoZXIvY3J5cHRvX3VucmVnaXN0ZXJfYWtjaXBoZXIuCj4gCj4gVGhpcyBnZXRzIHVuY2xlYXIg
ZnJvbSBjdXJyZW50IHYyIHZlcnNpb24uCj4gCj4gT24gdGhlIG90aGVyIGhhbmQsIHRoZSBrZXJu
ZWwgc2lkZSBwcmVmZXJzIHRvIHNlcGFyYXRlIHNrY2lwaGVyIGFuZCAKPiBha2NpcGhlcihzZXBh
cmF0ZWQgaGVhZGVyIGZpbGVzIGFuZCBpbXBsZW1lbnRhdGlvbnMpLgo+IApIaSwgTGVpCkkgYWxz
byB0YWtlIGEgbG9vayBhdCBvdGhlciBjcnlwdG8gZHJpdmVycyBhdCBxYXQvY2NwL2hpc2lsaWNv
biwgdGhleSAKc2VwYXJhdGUgYWtjaXBoZXIvc2tjaXBoZXIgYWxnby4gSWYgeW91IGNvbnNpZGVy
IHRoYXQgcmV1c2luZyAKdmlydGlvX2NyeXB0b19hbGdzX3JlZ2lzdGVyL3VucmVnaXN0ZXIgc2Vl
bXMgYmV0dGVyLCBJIHdpbGwgdHJ5IHRvIG1lcmdlIAp0aGVtIGludG8gYSBzaW5nbGUgZnVuY3Rp
b24uCgotLSAKemhlbndlaSBwaQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
