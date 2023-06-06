Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F14C77B73
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 01:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A1A881DE4;
	Tue,  6 Jun 2023 01:44:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A1A881DE4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZHpOLWes
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tGof2ofKYj-h; Tue,  6 Jun 2023 01:44:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 180AB81DE0;
	Tue,  6 Jun 2023 01:44:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 180AB81DE0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2C3DC007A;
	Tue,  6 Jun 2023 01:44:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCADCC0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 01:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96F0E81DE0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 01:44:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96F0E81DE0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m4hDtdk77ZmS
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 01:44:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8D97781D65
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D97781D65
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 01:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686015859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h6c7qR5QQL6O5muxAxTGbpH+uE3aElnAVDLZ6FGcR/0=;
 b=ZHpOLWesA6x+vFxNHqH/mMTaat+8G9WiAqw6+fscur+VXTKKRbSwlQy625NDYo+FfRdqZf
 tZUtT/C7jE4k+rD9L4b4RiwHSfoWsq4wyJOi/kxBOC74xIwA7o0MxZHKaGi0R617i2PjKL
 68jSX3zn6dNqzsKd6lpwLH7knU5Mc38=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-yJoKrYkaNrSxIdOyqKIWVg-1; Mon, 05 Jun 2023 21:44:18 -0400
X-MC-Unique: yJoKrYkaNrSxIdOyqKIWVg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f624a4ea72so1296851e87.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 18:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686015856; x=1688607856;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h6c7qR5QQL6O5muxAxTGbpH+uE3aElnAVDLZ6FGcR/0=;
 b=QAMn9+4UfWOTURQVat+Ijy08QFaYV0oN5lVrJ1m07m7qre4w1npBd7YYSU+FxaUAop
 OzlvIH7a+QnwRurjxfAk83JxqHGNmrykNezocKV0KE5JHkTectM6/8JhBhh0LE340TFZ
 eCNqdD6caAOpAybg5MWKaNfEXxTzj1BTQL72yx32gqVIK1irlQyFHi7nZeYmxSBvyEoq
 oEqfcJRqp07kb7nyWVIGl+pNf4RVNhOZJvzQw9jLFBN/YMpqO6cyAGDXFhhiiIqd27ZI
 CpjoSq1t96BX2pWD2T6Jq1jc2owHmHXHtu3s0BPzb3n0f6dU7kL6xJzc5wYecm89n1Mw
 BkQQ==
X-Gm-Message-State: AC+VfDyEXk5ocycfUdGoUSlMyUyVK2aDJwVvSBsPWd37y2aoOqN0NPg8
 h5ZPf94//FPDxemgwShVCSFyXBqHXBJr33zqRNec03eGiM69FYFEzBy3rmCvhi5Dgu9eXajtpXh
 irJPPok9WGRMmXwzF0Gobgb7Fca48K8f7ePucGrLLGlgwLk/bP05/JorLUQ==
X-Received: by 2002:a19:f811:0:b0:4f6:392:6917 with SMTP id
 a17-20020a19f811000000b004f603926917mr409092lff.34.1686015856764; 
 Mon, 05 Jun 2023 18:44:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4LdqhwRhX6mWyAhRtL4quj5OgTJ37m/xJNaUVO3cTyp8wh7GV96jSwFQyT4Y3Rw2vO3pQ6Kflt1z/JonqWEvw=
X-Received: by 2002:a19:f811:0:b0:4f6:392:6917 with SMTP id
 a17-20020a19f811000000b004f603926917mr409084lff.34.1686015856464; Mon, 05 Jun
 2023 18:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230605195925.51625-1-brett.creeley@amd.com>
In-Reply-To: <20230605195925.51625-1-brett.creeley@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Jun 2023 09:44:05 +0800
Message-ID: <CACGkMEvbWLZHeGww5_39BDkuKE1_L5YGAF6Wxq0u1cXPgdgf5g@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: use control_buf for coalesce params
To: Brett Creeley <brett.creeley@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 allen.hubbe@amd.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
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

T24gVHVlLCBKdW4gNiwgMjAyMyBhdCAzOjU54oCvQU0gQnJldHQgQ3JlZWxleSA8YnJldHQuY3Jl
ZWxleUBhbWQuY29tPiB3cm90ZToKPgo+IENvbW1pdCA2OTliMDQ1YThlNDMgKCJuZXQ6IHZpcnRp
b19uZXQ6IG5vdGlmaWNhdGlvbnMgY29hbGVzY2luZwo+IHN1cHBvcnQiKSBhZGRlZCBjb2FsZXNj
aW5nIGNvbW1hbmQgc3VwcG9ydCBmb3IgdmlydGlvX25ldC4gSG93ZXZlciwKPiB0aGUgY29hbGVz
Y2UgY29tbWFuZHMgYXJlIHVzaW5nIGJ1ZmZlcnMgb24gdGhlIHN0YWNrLCB3aGljaCBpcyBjYXVz
aW5nCj4gdGhlIGRldmljZSB0byBzZWUgRE1BIGVycm9ycy4gVGhlcmUgc2hvdWxkIGFsc28gYmUg
YSBjb21wbGFpbnQgZnJvbQo+IGNoZWNrX2Zvcl9zdGFjaygpIGluIGRlYnVnX2RtYV9tYXBfeHl6
KCkuIEZpeCB0aGlzIGJ5IGFkZGluZyBhbmQgdXNpbmcKPiBjb2FsZXNjZSBwYXJhbXMgZnJvbSB0
aGUgY29udHJvbF9idWYgc3RydWN0LCB3aGljaCBhbGlnbnMgd2l0aCBvdGhlcgo+IGNvbW1hbmRz
Lgo+Cj4gRml4ZXM6IDY5OWIwNDVhOGU0MyAoIm5ldDogdmlydGlvX25ldDogbm90aWZpY2F0aW9u
cyBjb2FsZXNjaW5nIHN1cHBvcnQiKQo+IFJldmlld2VkLWJ5OiBTaGFubm9uIE5lbHNvbiA8c2hh
bm5vbi5uZWxzb25AYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBBbGxlbiBIdWJiZSA8YWxsZW4u
aHViYmVAYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBCcmV0dCBDcmVlbGV5IDxicmV0dC5jcmVl
bGV5QGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDE2ICsrKysr
KysrLS0tLS0tLS0KClRoZSBwYXRjaCBpcyBuZWVkZWQgZm9yIC1zdGFibGUgSSB0aGluay4KCkFj
a2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+ICAxIGZp
bGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+
IGluZGV4IDU2Y2ExZDI3MDMwNC4uNDg2YjU4NDkwMzNkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC0y
MDUsNiArMjA1LDggQEAgc3RydWN0IGNvbnRyb2xfYnVmIHsKPiAgICAgICAgIF9fdmlydGlvMTYg
dmlkOwo+ICAgICAgICAgX192aXJ0aW82NCBvZmZsb2FkczsKPiAgICAgICAgIHN0cnVjdCB2aXJ0
aW9fbmV0X2N0cmxfcnNzIHJzczsKPiArICAgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2N0cmxfY29h
bF90eCBjb2FsX3R4Owo+ICsgICAgICAgc3RydWN0IHZpcnRpb19uZXRfY3RybF9jb2FsX3J4IGNv
YWxfcng7Cj4gIH07Cj4KPiAgc3RydWN0IHZpcnRuZXRfaW5mbyB7Cj4gQEAgLTI5MzQsMTIgKzI5
MzYsMTAgQEAgc3RhdGljIGludCB2aXJ0bmV0X3NlbmRfbm90Zl9jb2FsX2NtZHMoc3RydWN0IHZp
cnRuZXRfaW5mbyAqdmksCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3RydWN0IGV0aHRvb2xfY29hbGVzY2UgKmVjKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3Qgc2NhdHRl
cmxpc3Qgc2dzX3R4LCBzZ3Nfcng7Cj4gLSAgICAgICBzdHJ1Y3QgdmlydGlvX25ldF9jdHJsX2Nv
YWxfdHggY29hbF90eDsKPiAtICAgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2N0cmxfY29hbF9yeCBj
b2FsX3J4Owo+Cj4gLSAgICAgICBjb2FsX3R4LnR4X3VzZWNzID0gY3B1X3RvX2xlMzIoZWMtPnR4
X2NvYWxlc2NlX3VzZWNzKTsKPiAtICAgICAgIGNvYWxfdHgudHhfbWF4X3BhY2tldHMgPSBjcHVf
dG9fbGUzMihlYy0+dHhfbWF4X2NvYWxlc2NlZF9mcmFtZXMpOwo+IC0gICAgICAgc2dfaW5pdF9v
bmUoJnNnc190eCwgJmNvYWxfdHgsIHNpemVvZihjb2FsX3R4KSk7Cj4gKyAgICAgICB2aS0+Y3Ry
bC0+Y29hbF90eC50eF91c2VjcyA9IGNwdV90b19sZTMyKGVjLT50eF9jb2FsZXNjZV91c2Vjcyk7
Cj4gKyAgICAgICB2aS0+Y3RybC0+Y29hbF90eC50eF9tYXhfcGFja2V0cyA9IGNwdV90b19sZTMy
KGVjLT50eF9tYXhfY29hbGVzY2VkX2ZyYW1lcyk7Cj4gKyAgICAgICBzZ19pbml0X29uZSgmc2dz
X3R4LCAmdmktPmN0cmwtPmNvYWxfdHgsIHNpemVvZih2aS0+Y3RybC0+Y29hbF90eCkpOwo+Cj4g
ICAgICAgICBpZiAoIXZpcnRuZXRfc2VuZF9jb21tYW5kKHZpLCBWSVJUSU9fTkVUX0NUUkxfTk9U
Rl9DT0FMLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fTkVUX0NU
UkxfTk9URl9DT0FMX1RYX1NFVCwKPiBAQCAtMjk1MCw5ICsyOTUwLDkgQEAgc3RhdGljIGludCB2
aXJ0bmV0X3NlbmRfbm90Zl9jb2FsX2NtZHMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAg
ICAgICB2aS0+dHhfdXNlY3MgPSBlYy0+dHhfY29hbGVzY2VfdXNlY3M7Cj4gICAgICAgICB2aS0+
dHhfbWF4X3BhY2tldHMgPSBlYy0+dHhfbWF4X2NvYWxlc2NlZF9mcmFtZXM7Cj4KPiAtICAgICAg
IGNvYWxfcngucnhfdXNlY3MgPSBjcHVfdG9fbGUzMihlYy0+cnhfY29hbGVzY2VfdXNlY3MpOwo+
IC0gICAgICAgY29hbF9yeC5yeF9tYXhfcGFja2V0cyA9IGNwdV90b19sZTMyKGVjLT5yeF9tYXhf
Y29hbGVzY2VkX2ZyYW1lcyk7Cj4gLSAgICAgICBzZ19pbml0X29uZSgmc2dzX3J4LCAmY29hbF9y
eCwgc2l6ZW9mKGNvYWxfcngpKTsKPiArICAgICAgIHZpLT5jdHJsLT5jb2FsX3J4LnJ4X3VzZWNz
ID0gY3B1X3RvX2xlMzIoZWMtPnJ4X2NvYWxlc2NlX3VzZWNzKTsKPiArICAgICAgIHZpLT5jdHJs
LT5jb2FsX3J4LnJ4X21heF9wYWNrZXRzID0gY3B1X3RvX2xlMzIoZWMtPnJ4X21heF9jb2FsZXNj
ZWRfZnJhbWVzKTsKPiArICAgICAgIHNnX2luaXRfb25lKCZzZ3NfcngsICZ2aS0+Y3RybC0+Y29h
bF9yeCwgc2l6ZW9mKHZpLT5jdHJsLT5jb2FsX3J4KSk7Cj4KPiAgICAgICAgIGlmICghdmlydG5l
dF9zZW5kX2NvbW1hbmQodmksIFZJUlRJT19ORVRfQ1RSTF9OT1RGX0NPQUwsCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19ORVRfQ1RSTF9OT1RGX0NPQUxfUlhfU0VU
LAo+IC0tCj4gMi4xNy4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
