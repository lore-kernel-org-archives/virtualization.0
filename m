Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B37C433F5
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 03:14:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FECB610D8;
	Tue, 17 May 2022 03:14:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sY7l_wk1DI9U; Tue, 17 May 2022 03:14:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 32AF660EB2;
	Tue, 17 May 2022 03:14:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A4E4C0039;
	Tue, 17 May 2022 03:14:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53C3FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3401460F99
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:14:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BGzoe7FDZqka
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:14:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61A4760EB2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652757290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x56Qa6ghnOqDMPN1uuvoAI6COP7Qgx3MEvUo9Z72Lbc=;
 b=KyiBrpQ+CzPevo0k6t5PkmIIQKN32UXDrnBTKn5Ru7YQBEnvYOb5EKN//4tdJENR2Vn2Jw
 Wk0daTZr4PEcqEFE4+yjC9lyW97lS/vD40/iMGnHtTlFv/QIWtr/c12i3fAg88YnfSzw/T
 E7bvss8SCpNxp0v0MZ35LuhymjMasno=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-whO_CQHBO6C19yoRhVlGrg-1; Mon, 16 May 2022 23:14:49 -0400
X-MC-Unique: whO_CQHBO6C19yoRhVlGrg-1
Received: by mail-pg1-f199.google.com with SMTP id
 q17-20020a656851000000b003c66b4c5d54so8241796pgt.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=x56Qa6ghnOqDMPN1uuvoAI6COP7Qgx3MEvUo9Z72Lbc=;
 b=phVmffg5LOOaJc327tMeDnPSyGfNepbG7qJ8MjL4SyX035nAgXboAnCOD1wut3fwUi
 0zjNXVWk0u/BZ20+N5avceNHYTy5M497nrQX0eH6Bqmau9hjyxiL6vdYlrhMl3dyvshI
 qFmBwlhbP5sm4W6Sa7Ynvx+wr+Hlx6FM6alZLwX6e0AAR6vkCgte2kjonbYXg89kMdLL
 drL7JzRj3nGdcMrtv+YOg8YSgTBEjOaOSmdqg3FFVR41FCpFfERCWjnRqVVUze12DpTO
 Rjv9Nx2qhAAJN0+N5sfvtDaE8qVSVzoCZnXRC4ZCD7TIkuFdpWm9QE01ff2w6bYhoulG
 0wnQ==
X-Gm-Message-State: AOAM533yor/+Lytuj5cphiM9CHvY9n3nl4B6CMMyvopFuI5HMVB482MT
 fj6OLA+wqo65jfTBw4aNGjz03Wy7rKPCMl+3QFDjYUAodRlqs0OMSzHy3EQ75DtUQzX4mzjQ59t
 zs7OkcFOqZp130MNRN3Rm11q/sWz0XQq3xarKa4+zBQ==
X-Received: by 2002:a63:24d:0:b0:3c2:2f74:2ddb with SMTP id
 74-20020a63024d000000b003c22f742ddbmr18064400pgc.83.1652757288157; 
 Mon, 16 May 2022 20:14:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfYqTm/MOUtBZuPu63gwGVs1tPlp56PulMly/dpzMLCDGWIRnks7SbKvhWDa3/PiLVUc0nZw==
X-Received: by 2002:a63:24d:0:b0:3c2:2f74:2ddb with SMTP id
 74-20020a63024d000000b003c22f742ddbmr18064381pgc.83.1652757287879; 
 Mon, 16 May 2022 20:14:47 -0700 (PDT)
Received: from [10.72.12.227] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a62d104000000b0050dc7628184sm7787329pfg.94.2022.05.16.20.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 May 2022 20:14:47 -0700 (PDT)
Message-ID: <f706e1ad-078b-671f-6ba9-b298c9485a1c@redhat.com>
Date: Tue, 17 May 2022 11:14:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH V2 1/8] vhost: get rid of vhost_poll_flush() wrapper
To: Mike Christie <michael.christie@oracle.com>, stefanha@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org, arbn@yandex-team.com
References: <20220515202922.174066-1-michael.christie@oracle.com>
 <20220515202922.174066-2-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220515202922.174066-2-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CuWcqCAyMDIyLzUvMTYgMDQ6MjksIE1pa2UgQ2hyaXN0aWUg5YaZ6YGTOgo+IEZyb206IEFuZHJl
eSBSeWFiaW5pbiA8YXJibkB5YW5kZXgtdGVhbS5jb20+Cj4KPiB2aG9zdF9wb2xsX2ZsdXNoKCkg
aXMgYSBzaW1wbGUgd3JhcHBlciBhcm91bmQgdmhvc3Rfd29ya19kZXZfZmx1c2goKS4KPiBJdCBn
aXZlcyB3cm9uZyBpbXByZXNzaW9uIHRoYXQgd2UgYXJlIGRvaW5nIHNvbWUgd29yayBvdmVyIHZo
b3N0X3BvbGwsCj4gd2hpbGUgaW4gZmFjdCBpdCBmbHVzaGVzIHZob3N0X3BvbGwtPmRldi4KPiBJ
dCBvbmx5IGNvbXBsaWNhdGUgdW5kZXJzdGFuZGluZyBvZiB0aGUgY29kZSBhbmQgbGVhZHMgdG8g
bWlzdGFrZXMKPiBsaWtlIGZsdXNoaW5nIHRoZSBzYW1lIHZob3N0X2RldiBzZXZlcmFsIHRpbWVz
IGluIGEgcm93Lgo+Cj4gSnVzdCByZW1vdmUgdmhvc3RfcG9sbF9mbHVzaCgpIGFuZCBjYWxsIHZo
b3N0X3dvcmtfZGV2X2ZsdXNoKCkgZGlyZWN0bHkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkg
UnlhYmluaW4gPGFyYm5AeWFuZGV4LXRlYW0uY29tPgo+IFttZXJnZSB2aG9zdF9wb2xsX2ZsdXNo
IHJlbW92YWwgZnJvbSBTdGVmYW5vIEdhcnphcmVsbGFdCj4gU2lnbmVkLW9mZi1ieTogTWlrZSBD
aHJpc3RpZSA8bWljaGFlbC5jaHJpc3RpZUBvcmFjbGUuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L25ldC5j
ICAgfCAgNCArKy0tCj4gICBkcml2ZXJzL3Zob3N0L3Rlc3QuYyAgfCAgMiArLQo+ICAgZHJpdmVy
cy92aG9zdC92aG9zdC5jIHwgMTIgKystLS0tLS0tLS0tCj4gICBkcml2ZXJzL3Zob3N0L3Zob3N0
LmggfCAgMSAtCj4gICBkcml2ZXJzL3Zob3N0L3Zzb2NrLmMgfCAgMiArLQo+ICAgNSBmaWxlcyBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmhvc3QvbmV0LmMgYi9kcml2ZXJzL3Zob3N0L25ldC5jCj4gaW5kZXggNzkyYWI1
ZjIzNjQ3Li40ZTU1YWQ4Yzk0MmEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC9uZXQuYwo+
ICsrKyBiL2RyaXZlcnMvdmhvc3QvbmV0LmMKPiBAQCAtMTM3Niw4ICsxMzc2LDggQEAgc3RhdGlj
IHZvaWQgdmhvc3RfbmV0X3N0b3Aoc3RydWN0IHZob3N0X25ldCAqbiwgc3RydWN0IHNvY2tldCAq
KnR4X3NvY2ssCj4gICAKPiAgIHN0YXRpYyB2b2lkIHZob3N0X25ldF9mbHVzaF92cShzdHJ1Y3Qg
dmhvc3RfbmV0ICpuLCBpbnQgaW5kZXgpCj4gICB7Cj4gLQl2aG9zdF9wb2xsX2ZsdXNoKG4tPnBv
bGwgKyBpbmRleCk7Cj4gLQl2aG9zdF9wb2xsX2ZsdXNoKCZuLT52cXNbaW5kZXhdLnZxLnBvbGwp
Owo+ICsJdmhvc3Rfd29ya19kZXZfZmx1c2gobi0+cG9sbFtpbmRleF0uZGV2KTsKPiArCXZob3N0
X3dvcmtfZGV2X2ZsdXNoKG4tPnZxc1tpbmRleF0udnEucG9sbC5kZXYpOwo+ICAgfQo+ICAgCj4g
ICBzdGF0aWMgdm9pZCB2aG9zdF9uZXRfZmx1c2goc3RydWN0IHZob3N0X25ldCAqbikKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92aG9zdC90ZXN0LmMgYi9kcml2ZXJzL3Zob3N0L3Rlc3QuYwo+IGlu
ZGV4IDA1NzQwY2JhMWNkOC4uZjBhYzllMzVmNWQ2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhv
c3QvdGVzdC5jCj4gKysrIGIvZHJpdmVycy92aG9zdC90ZXN0LmMKPiBAQCAtMTQ2LDcgKzE0Niw3
IEBAIHN0YXRpYyB2b2lkIHZob3N0X3Rlc3Rfc3RvcChzdHJ1Y3Qgdmhvc3RfdGVzdCAqbiwgdm9p
ZCAqKnByaXZhdGVwKQo+ICAgCj4gICBzdGF0aWMgdm9pZCB2aG9zdF90ZXN0X2ZsdXNoX3ZxKHN0
cnVjdCB2aG9zdF90ZXN0ICpuLCBpbnQgaW5kZXgpCj4gICB7Cj4gLQl2aG9zdF9wb2xsX2ZsdXNo
KCZuLT52cXNbaW5kZXhdLnBvbGwpOwo+ICsJdmhvc3Rfd29ya19kZXZfZmx1c2gobi0+dnFzW2lu
ZGV4XS5wb2xsLmRldik7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB2b2lkIHZob3N0X3Rlc3RfZmx1
c2goc3RydWN0IHZob3N0X3Rlc3QgKm4pCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhv
c3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+IGluZGV4IGQwMjE3M2ZiMjkwYy4uMWQ4NGEy
ODE4YzZmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ICsrKyBiL2RyaXZl
cnMvdmhvc3Qvdmhvc3QuYwo+IEBAIC0yNDUsMTQgKzI0NSw2IEBAIHZvaWQgdmhvc3Rfd29ya19k
ZXZfZmx1c2goc3RydWN0IHZob3N0X2RldiAqZGV2KQo+ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9H
UEwodmhvc3Rfd29ya19kZXZfZmx1c2gpOwo+ICAgCj4gLS8qIEZsdXNoIGFueSB3b3JrIHRoYXQg
aGFzIGJlZW4gc2NoZWR1bGVkLiBXaGVuIGNhbGxpbmcgdGhpcywgZG9uJ3QgaG9sZCBhbnkKPiAt
ICogbG9ja3MgdGhhdCBhcmUgYWxzbyB1c2VkIGJ5IHRoZSBjYWxsYmFjay4gKi8KPiAtdm9pZCB2
aG9zdF9wb2xsX2ZsdXNoKHN0cnVjdCB2aG9zdF9wb2xsICpwb2xsKQo+IC17Cj4gLQl2aG9zdF93
b3JrX2Rldl9mbHVzaChwb2xsLT5kZXYpOwo+IC19Cj4gLUVYUE9SVF9TWU1CT0xfR1BMKHZob3N0
X3BvbGxfZmx1c2gpOwo+IC0KPiAgIHZvaWQgdmhvc3Rfd29ya19xdWV1ZShzdHJ1Y3Qgdmhvc3Rf
ZGV2ICpkZXYsIHN0cnVjdCB2aG9zdF93b3JrICp3b3JrKQo+ICAgewo+ICAgCWlmICghZGV2LT53
b3JrZXIpCj4gQEAgLTY2Myw3ICs2NTUsNyBAQCB2b2lkIHZob3N0X2Rldl9zdG9wKHN0cnVjdCB2
aG9zdF9kZXYgKmRldikKPiAgIAlmb3IgKGkgPSAwOyBpIDwgZGV2LT5udnFzOyArK2kpIHsKPiAg
IAkJaWYgKGRldi0+dnFzW2ldLT5raWNrICYmIGRldi0+dnFzW2ldLT5oYW5kbGVfa2ljaykgewo+
ICAgCQkJdmhvc3RfcG9sbF9zdG9wKCZkZXYtPnZxc1tpXS0+cG9sbCk7Cj4gLQkJCXZob3N0X3Bv
bGxfZmx1c2goJmRldi0+dnFzW2ldLT5wb2xsKTsKPiArCQkJdmhvc3Rfd29ya19kZXZfZmx1c2go
ZGV2LT52cXNbaV0tPnBvbGwuZGV2KTsKPiAgIAkJfQo+ICAgCX0KPiAgIH0KPiBAQCAtMTcxOSw3
ICsxNzExLDcgQEAgbG9uZyB2aG9zdF92cmluZ19pb2N0bChzdHJ1Y3Qgdmhvc3RfZGV2ICpkLCB1
bnNpZ25lZCBpbnQgaW9jdGwsIHZvaWQgX191c2VyICphcmcKPiAgIAltdXRleF91bmxvY2soJnZx
LT5tdXRleCk7Cj4gICAKPiAgIAlpZiAocG9sbHN0b3AgJiYgdnEtPmhhbmRsZV9raWNrKQo+IC0J
CXZob3N0X3BvbGxfZmx1c2goJnZxLT5wb2xsKTsKPiArCQl2aG9zdF93b3JrX2Rldl9mbHVzaCh2
cS0+cG9sbC5kZXYpOwo+ICAgCXJldHVybiByOwo+ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwo
dmhvc3RfdnJpbmdfaW9jdGwpOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0Lmgg
Yi9kcml2ZXJzL3Zob3N0L3Zob3N0LmgKPiBpbmRleCA2MzhiYjY0MGQ2YjQuLmFlYjhlMWFkMTQ5
NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmgKPiArKysgYi9kcml2ZXJzL3Zo
b3N0L3Zob3N0LmgKPiBAQCAtNDQsNyArNDQsNiBAQCB2b2lkIHZob3N0X3BvbGxfaW5pdChzdHJ1
Y3Qgdmhvc3RfcG9sbCAqcG9sbCwgdmhvc3Rfd29ya19mbl90IGZuLAo+ICAgCQkgICAgIF9fcG9s
bF90IG1hc2ssIHN0cnVjdCB2aG9zdF9kZXYgKmRldik7Cj4gICBpbnQgdmhvc3RfcG9sbF9zdGFy
dChzdHJ1Y3Qgdmhvc3RfcG9sbCAqcG9sbCwgc3RydWN0IGZpbGUgKmZpbGUpOwo+ICAgdm9pZCB2
aG9zdF9wb2xsX3N0b3Aoc3RydWN0IHZob3N0X3BvbGwgKnBvbGwpOwo+IC12b2lkIHZob3N0X3Bv
bGxfZmx1c2goc3RydWN0IHZob3N0X3BvbGwgKnBvbGwpOwo+ICAgdm9pZCB2aG9zdF9wb2xsX3F1
ZXVlKHN0cnVjdCB2aG9zdF9wb2xsICpwb2xsKTsKPiAgIHZvaWQgdmhvc3Rfd29ya19kZXZfZmx1
c2goc3RydWN0IHZob3N0X2RldiAqZGV2KTsKPiAgIAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zo
b3N0L3Zzb2NrLmMgYi9kcml2ZXJzL3Zob3N0L3Zzb2NrLmMKPiBpbmRleCBlNmM5ZDQxZGIxZGUu
LmE0YzhhZTkyYTBmYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zzb2NrLmMKPiArKysg
Yi9kcml2ZXJzL3Zob3N0L3Zzb2NrLmMKPiBAQCAtNzA5LDcgKzcwOSw3IEBAIHN0YXRpYyB2b2lk
IHZob3N0X3Zzb2NrX2ZsdXNoKHN0cnVjdCB2aG9zdF92c29jayAqdnNvY2spCj4gICAKPiAgIAlm
b3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh2c29jay0+dnFzKTsgaSsrKQo+ICAgCQlpZiAodnNv
Y2stPnZxc1tpXS5oYW5kbGVfa2ljaykKPiAtCQkJdmhvc3RfcG9sbF9mbHVzaCgmdnNvY2stPnZx
c1tpXS5wb2xsKTsKPiArCQkJdmhvc3Rfd29ya19kZXZfZmx1c2godnNvY2stPnZxc1tpXS5wb2xs
LmRldik7Cj4gICAJdmhvc3Rfd29ya19kZXZfZmx1c2goJnZzb2NrLT5kZXYpOwo+ICAgfQo+ICAg
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
