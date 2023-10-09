Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D35E95A91
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 11:50:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB870400BF;
	Mon,  9 Oct 2023 11:50:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB870400BF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FVgpEvih
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RPNYmr-52mFj; Mon,  9 Oct 2023 11:50:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3725F40190;
	Mon,  9 Oct 2023 11:50:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3725F40190
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FF77C0039;
	Mon,  9 Oct 2023 11:50:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0427C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A0894136C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:50:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A0894136C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FVgpEvih
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4GYHRyAgbkCy
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:50:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30050410E4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:50:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30050410E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696852226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBRRUjtk0t8+rSFYxPYd7qzO0KgNPL4SOI4O3jVUvmI=;
 b=FVgpEvihlZWaG1JOjDiEWO8y8AMb1bRIubJu1GiffL12+5DFkUF6Q9lCV8QKKDoZkv05cF
 8PMuJNUKUo5nOJNkoCps55qYqyQjfIfMUyqTYviIs/x+ch3vMTYh8PmocOZq/mZTsgnQWc
 ueWvmoGLg34aBTx7Dzs25b34JqaI1RU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-UDsvyxhPNXixEoX9ZN9l8g-1; Mon, 09 Oct 2023 07:50:23 -0400
X-MC-Unique: UDsvyxhPNXixEoX9ZN9l8g-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9b65b6bcfb7so361245066b.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 04:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696852222; x=1697457022;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MBRRUjtk0t8+rSFYxPYd7qzO0KgNPL4SOI4O3jVUvmI=;
 b=XWHdtA2BawDaGgUt1VQMiAUn6dmu5pFt5yACnuljemGydpIjb5y8XmkkhJoqDq4eYu
 HPeGBHcqvYe6oTUAnDc9iLvw+tWoIZ3bRz/GGDR6ZFojJ6VUAao2CTpuIBsB+VGdMsbA
 3T5r96hcrqR5THlvqGgmcn6+5eiTAwBpSN36gTNdfGWJMT6J+gjzOj0E99Yb4eL0Lrre
 A8ipfqFuedr16nomw/3t+KXJBwk9rBDVTnexeROHUo2uiIgM47VwvgdKmk4psYJFUhf7
 tmqbrEzaUOEF5drJIJwjty9Pvn0+YVnNuc529lg288+d0oj7AmrGVfs08EXhZJJAOACN
 PKvA==
X-Gm-Message-State: AOJu0Yyf3vBe2E4+jZAiq6RmdpXGkKSsnTRa8QU1x6ScsP5Gk6RIFfpH
 oCYBJqhONGw0IW5NmMLd9WlR+o60qsqKFbxUd3WqXlCa2RGCqNgIl/FY7IBYCNIkPG/Ch0srZfA
 DRcQjQutJrWbLBo4JEce722j2CEZdRl1wJA4KePKO0g==
X-Received: by 2002:a17:906:8a50:b0:9aa:2c5b:6591 with SMTP id
 gx16-20020a1709068a5000b009aa2c5b6591mr14399903ejc.9.1696852221874; 
 Mon, 09 Oct 2023 04:50:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOfzC8yt9O1EKKC6ulfMdWzK/Wyw5t8obuDTFM7EgyZXQHnZ2zQtwYH9FVSA5nqeIbOBRa3w==
X-Received: by 2002:a17:906:8a50:b0:9aa:2c5b:6591 with SMTP id
 gx16-20020a1709068a5000b009aa2c5b6591mr14399871ejc.9.1696852221495; 
 Mon, 09 Oct 2023 04:50:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16f:5caf:857a:f352:c1fc:cf50])
 by smtp.gmail.com with ESMTPSA id
 x19-20020aa7d393000000b005330b2d1904sm6058419edq.71.2023.10.09.04.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 04:50:20 -0700 (PDT)
Date: Mon, 9 Oct 2023 07:50:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
Message-ID: <20231009074840-mutt-send-email-mst@kernel.org>
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
 <CAF=yD-K2MQt4nnfwJrx6h6Nii_rho7j1o6nb_jYaSwcWY45pPw@mail.gmail.com>
 <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com>
MIME-Version: 1.0
In-Reply-To: <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: songliubraving@fb.com, gustavoars@kernel.org, kvm@vger.kernel.org,
 decui@microsoft.com, ast@kernel.org, virtualization@lists.linux-foundation.org,
 linux-kselftest@vger.kernel.org, steffen.klassert@secunet.com,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 herbert@gondor.apana.org.au, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, yhs@fb.com, pabeni@redhat.com, pablo@netfilter.org,
 elver@google.com, kpsingh@kernel.org,
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

T24gTW9uLCBPY3QgMDksIDIwMjMgYXQgMDU6NDQ6MjBQTSArMDkwMCwgQWtpaGlrbyBPZGFraSB3
cm90ZToKPiBPbiAyMDIzLzEwLzA5IDE3OjEzLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+ID4g
T24gU3VuLCBPY3QgOCwgMjAyMyBhdCAxMjoyMuKAr0FNIEFraWhpa28gT2Rha2kgPGFraWhpa28u
b2Rha2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4gPiA+IAo+ID4gPiB2aXJ0aW8tbmV0IGhhdmUgdHdv
IHVzYWdlIG9mIGhhc2hlczogb25lIGlzIFJTUyBhbmQgYW5vdGhlciBpcyBoYXNoCj4gPiA+IHJl
cG9ydGluZy4gQ29udmVudGlvbmFsbHkgdGhlIGhhc2ggY2FsY3VsYXRpb24gd2FzIGRvbmUgYnkg
dGhlIFZNTS4KPiA+ID4gSG93ZXZlciwgY29tcHV0aW5nIHRoZSBoYXNoIGFmdGVyIHRoZSBxdWV1
ZSB3YXMgY2hvc2VuIGRlZmVhdHMgdGhlCj4gPiA+IHB1cnBvc2Ugb2YgUlNTLgo+ID4gPiAKPiA+
ID4gQW5vdGhlciBhcHByb2FjaCBpcyB0byB1c2UgZUJQRiBzdGVlcmluZyBwcm9ncmFtLiBUaGlz
IGFwcHJvYWNoIGhhcwo+ID4gPiBhbm90aGVyIGRvd25zaWRlOiBpdCBjYW5ub3QgcmVwb3J0IHRo
ZSBjYWxjdWxhdGVkIGhhc2ggZHVlIHRvIHRoZQo+ID4gPiByZXN0cmljdGl2ZSBuYXR1cmUgb2Yg
ZUJQRi4KPiA+ID4gCj4gPiA+IEludHJvZHVjZSB0aGUgY29kZSB0byBjb21wdXRlIGhhc2hlcyB0
byB0aGUga2VybmVsIGluIG9yZGVyIHRvIG92ZXJjb21lCj4gPiA+IHRoc2UgY2hhbGxlbmdlcy4g
QW4gYWx0ZXJuYXRpdmUgc29sdXRpb24gaXMgdG8gZXh0ZW5kIHRoZSBlQlBGIHN0ZWVyaW5nCj4g
PiA+IHByb2dyYW0gc28gdGhhdCBpdCB3aWxsIGJlIGFibGUgdG8gcmVwb3J0IHRvIHRoZSB1c2Vy
c3BhY2UsIGJ1dCBpdCBtYWtlcwo+ID4gPiBsaXR0bGUgc2Vuc2UgdG8gYWxsb3cgdG8gaW1wbGVt
ZW50IGRpZmZlcmVudCBoYXNoaW5nIGFsZ29yaXRobXMgd2l0aAo+ID4gPiBlQlBGIHNpbmNlIHRo
ZSBoYXNoIHZhbHVlIHJlcG9ydGVkIGJ5IHZpcnRpby1uZXQgaXMgc3RyaWN0bHkgZGVmaW5lZCBi
eQo+ID4gPiB0aGUgc3BlY2lmaWNhdGlvbi4KPiA+ID4gCj4gPiA+IFRoZSBoYXNoIHZhbHVlIGFs
cmVhZHkgc3RvcmVkIGluIHNrX2J1ZmYgaXMgbm90IHVzZWQgYW5kIGNvbXB1dGVkCj4gPiA+IGlu
ZGVwZW5kZW50bHkgc2luY2UgaXQgbWF5IGhhdmUgYmVlbiBjb21wdXRlZCBpbiBhIHdheSBub3Qg
Y29uZm9ybWFudAo+ID4gPiB3aXRoIHRoZSBzcGVjaWZpY2F0aW9uLgo+ID4gPiAKPiA+ID4gU2ln
bmVkLW9mZi1ieTogQWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXguY29tPgo+ID4g
Cj4gPiA+IEBAIC0yMTE2LDMxICsyMTcyLDQ5IEBAIHN0YXRpYyBzc2l6ZV90IHR1bl9wdXRfdXNl
cihzdHJ1Y3QgdHVuX3N0cnVjdCAqdHVuLAo+ID4gPiAgICAgICAgICB9Cj4gPiA+IAo+ID4gPiAg
ICAgICAgICBpZiAodm5ldF9oZHJfc3opIHsKPiA+ID4gLSAgICAgICAgICAgICAgIHN0cnVjdCB2
aXJ0aW9fbmV0X2hkciBnc287Cj4gPiA+ICsgICAgICAgICAgICAgICB1bmlvbiB7Cj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2hkciBoZHI7Cj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl92MV9oYXNoIHYxX2hh
c2hfaGRyOwo+ID4gPiArICAgICAgICAgICAgICAgfSBoZHI7Cj4gPiA+ICsgICAgICAgICAgICAg
ICBpbnQgcmV0Owo+ID4gPiAKPiA+ID4gICAgICAgICAgICAgICAgICBpZiAoaW92X2l0ZXJfY291
bnQoaXRlcikgPCB2bmV0X2hkcl9zeikKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOwo+ID4gPiAKPiA+ID4gLSAgICAgICAgICAgICAgIGlmICh2aXJ0aW9fbmV0
X2hkcl9mcm9tX3NrYihza2IsICZnc28sCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdHVuX2lzX2xpdHRsZV9lbmRpYW4odHVuKSwgdHJ1ZSwKPiA+ID4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2bGFuX2hsZW4pKSB7
Cj4gPiA+ICsgICAgICAgICAgICAgICBpZiAoKFJFQURfT05DRSh0dW4tPnZuZXRfaGFzaC5mbGFn
cykgJiBUVU5fVk5FVF9IQVNIX1JFUE9SVCkgJiYKPiA+ID4gKyAgICAgICAgICAgICAgICAgICB2
bmV0X2hkcl9zeiA+PSBzaXplb2YoaGRyLnYxX2hhc2hfaGRyKSAmJgo+ID4gPiArICAgICAgICAg
ICAgICAgICAgIHNrYi0+dHVuX3ZuZXRfaGFzaCkgewo+ID4gCj4gPiBJc24ndCB2bmV0X2hkcl9z
eiBndWFyYW50ZWVkIHRvIGJlID49IGhkci52MV9oYXNoX2hkciwgYnkgdmlydHVlIG9mCj4gPiB0
aGUgc2V0IGhhc2ggaW9jdGwgZmFpbGluZyBvdGhlcndpc2U/Cj4gPiAKPiA+IFN1Y2ggY2hlY2tz
IHNob3VsZCBiZSBsaW1pdGVkIHRvIGNvbnRyb2wgcGF0aCB3aGVyZSBwb3NzaWJsZQo+IAo+IFRo
ZXJlIGlzIGEgcG90ZW50aWFsIHJhY2Ugc2luY2UgdHVuLT52bmV0X2hhc2guZmxhZ3MgYW5kIHZu
ZXRfaGRyX3N6IGFyZSBub3QKPiByZWFkIGF0IG9uY2UuCgpBbmQgdGhlbiBpdCdzIGEgY29tcGxl
dGUgbWVzcyBhbmQgeW91IGdldCBpbmNvbnNpc3RlbnQKYmVoYXZpb3VyIHdpdGggcGFja2V0cyBn
ZXR0aW5nIHNlbnQgYWxsIG92ZXIgdGhlIHBsYWNlLCByaWdodD8KU28gbWF5YmUga2VlcCBhIHBv
aW50ZXIgdG8gdGhpcyBzdHJ1Y3Qgc28gaXQgY2FuIGJlCmNoYW5nZWQgYXRvbWljYWxseSB0aGVu
LiBNYXliZSBldmVuIHNvbWV0aGluZyB3aXRoIHJjdSBJIGRvbm51LgoKLS0gCk1TVAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
