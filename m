Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E96C77B72
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 05:59:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 988D981F72;
	Thu, 20 Apr 2023 05:59:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 988D981F72
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f9kU+0St
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dgrvHr6OMi82; Thu, 20 Apr 2023 05:59:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1DE918212C;
	Thu, 20 Apr 2023 05:59:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1DE918212C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5578AC008F;
	Thu, 20 Apr 2023 05:59:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4D0CC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 05:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A11F341FD9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 05:59:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A11F341FD9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f9kU+0St
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iBc-pn8ndBHx
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 05:59:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5037941ECB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5037941ECB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 05:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681970378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hveHIV0W/0tavurLqEiHz1ZtN9TlgvI4rK8vvrCevO8=;
 b=f9kU+0StoS/8gm2uUWuh1pw3UlCm+gAWg2MLSBaVq0ceAh0zvozxKgV0q+MuGMZ+TjFHBQ
 OBSCU7pxkglB4Sfnds7CsNge9X6uzesbV39nfhyI0zaAEgSqajp7DPG7ce3LmVnvenL2dg
 k4L1Tdvqr1keOsLPMYYCL7hA3o+JSe4=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-hCbE4Vs9MS-IDFmq9Pg-1A-1; Thu, 20 Apr 2023 01:59:32 -0400
X-MC-Unique: hCbE4Vs9MS-IDFmq9Pg-1A-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-541b5f11916so414172eaf.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 22:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681970371; x=1684562371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hveHIV0W/0tavurLqEiHz1ZtN9TlgvI4rK8vvrCevO8=;
 b=GEZN3ggR1xqxuTaYHvDqmwvpTDTco3xkAZB4dbMRlkIr/LAAV+ZYEdG6tnX20RLPML
 7kudhoe2neXbUqm5R7BiH4eBM8xF3Aq/QoFcYFBgQLWic5E9hKn9/J4K+z1fDOKObchD
 dpS2YQhhJhmENCvigy73YeOyZnd4dOpKxQgjzHh8qwMIb39lZTozS61zo6uRUwWLSPSG
 GFufpbESVr6X11CXNQNUXu8WNE4tvRcxWrfbXjlxd3JJCaqBEzl6jeq8YQ5AwTgoRBn6
 DchMSM41S+T15xxF9YHhn7ikbadtnIBIo4b1Ow41dHWVyEJQjeMAn0QgSrhtQplAj8aW
 1eUg==
X-Gm-Message-State: AAQBX9fCE0vFNo9jk0bxMG1N+wnZqiMzYelThDBttTtd9SxxgWYJYzCk
 kMGpjSdZbwlsx1DAHBMZ5OHoJ7qFG0BUoMBknJ8FWuAnWCMSu3uJquMF8pnsXcy2b3N+g1QV9lw
 qBCluGAtNXPLNcEdCnpph8FNBpb7luqXhSfF3VZLk3Q9VVMmjOuLY5yILYQ==
X-Received: by 2002:a05:6808:dc4:b0:38e:76b7:373b with SMTP id
 g4-20020a0568080dc400b0038e76b7373bmr122680oic.53.1681970371345; 
 Wed, 19 Apr 2023 22:59:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZvYzMl2Q/fTCVElfs5rQv18o8xDGYLuKKRqRJEJpB7Hd9k4LnatLfEPLyfUP2jvZRreRukLvonhHp+BHD/cgY=
X-Received: by 2002:a05:6808:dc4:b0:38e:76b7:373b with SMTP id
 g4-20020a0568080dc400b0038e76b7373bmr122660oic.53.1681970370934; Wed, 19 Apr
 2023 22:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
 <20230418065327.72281-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230418065327.72281-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Apr 2023 13:59:19 +0800
Message-ID: <CACGkMEu6Bqcskv1wtXGFrMMxx2ALLq3M9-6fOnnbR0ph7FtqNA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 03/14] virtio_net: optimize
 mergeable_xdp_prepare()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCBBcHIgMTgsIDIwMjMgYXQgMjo1M+KAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gVGhlIHByZXZpb3VzIHBhdGNoLCBpbiBvcmRlciB0
byBmYWNpbGl0YXRlIHJldmlldywgSSBkbyBub3QgZG8gYW55Cj4gbW9kaWZpY2F0aW9uLiBUaGlz
IHBhdGNoIGhhcyBtYWRlIHNvbWUgb3B0aW1pemF0aW9uIG9uIHRoZSB0b3AuCj4KPiAqIHJlbW92
ZSBzb21lIHJlcGVhdGVkIGxvZ2ljcyBpbiB0aGlzIGZ1bmN0aW9uLgo+ICogYWRkIGZhc3QgY2hl
Y2sgZm9yIHBhc3Npbmcgd2l0aG91dCBhbnkgYWxsb2MuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCgo+IC0tLQo+ICBkcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgfCAyOSArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hh
bmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5k
ZXggMTI1NTkwNjJmZmI2Li41MGRjNjRkODBkM2IgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTExOTIs
NiArMTE5MiwxMSBAQCBzdGF0aWMgdm9pZCAqbWVyZ2VhYmxlX3hkcF9wcmVwYXJlKHN0cnVjdCB2
aXJ0bmV0X2luZm8gKnZpLAo+ICAgICAgICAgICovCj4gICAgICAgICAqZnJhbWVfc3ogPSB0cnVl
c2l6ZTsKPgo+ICsgICAgICAgaWYgKGxpa2VseShoZWFkcm9vbSA+PSB2aXJ0bmV0X2dldF9oZWFk
cm9vbSh2aSkgJiYKPiArICAgICAgICAgICAgICAgICAgKCpudW1fYnVmID09IDEgfHwgeGRwX3By
b2ctPmF1eC0+eGRwX2hhc19mcmFncykpKSB7Cj4gKyAgICAgICAgICAgICAgIHJldHVybiBwYWdl
X2FkZHJlc3MoKnBhZ2UpICsgb2Zmc2V0Owo+ICsgICAgICAgfQo+ICsKPiAgICAgICAgIC8qIFRo
aXMgaGFwcGVucyB3aGVuIGhlYWRyb29tIGlzIG5vdCBlbm91Z2ggYmVjYXVzZQo+ICAgICAgICAg
ICogb2YgdGhlIGJ1ZmZlciB3YXMgcHJlZmlsbGVkIGJlZm9yZSBYRFAgaXMgc2V0Lgo+ICAgICAg
ICAgICogVGhpcyBzaG91bGQgb25seSBoYXBwZW4gZm9yIHRoZSBmaXJzdCBzZXZlcmFsIHBhY2tl
dHMuCj4gQEAgLTEyMDAsMjIgKzEyMDUsMTUgQEAgc3RhdGljIHZvaWQgKm1lcmdlYWJsZV94ZHBf
cHJlcGFyZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiAgICAgICAgICAqIHN1cHBvcnQgaXQs
IGFuZCB3ZSBkb24ndCB3YW50IHRvIGJvdGhlciB1c2VycyB3aG8gYXJlCj4gICAgICAgICAgKiB1
c2luZyB4ZHAgbm9ybWFsbHkuCj4gICAgICAgICAgKi8KPiAtICAgICAgIGlmICgheGRwX3Byb2ct
PmF1eC0+eGRwX2hhc19mcmFncyAmJgo+IC0gICAgICAgICAgICgqbnVtX2J1ZiA+IDEgfHwgaGVh
ZHJvb20gPCB2aXJ0bmV0X2dldF9oZWFkcm9vbSh2aSkpKSB7Cj4gKyAgICAgICBpZiAoIXhkcF9w
cm9nLT5hdXgtPnhkcF9oYXNfZnJhZ3MpIHsKPiAgICAgICAgICAgICAgICAgLyogbGluZWFyaXpl
IGRhdGEgZm9yIFhEUCAqLwo+ICAgICAgICAgICAgICAgICB4ZHBfcGFnZSA9IHhkcF9saW5lYXJp
emVfcGFnZShycSwgbnVtX2J1ZiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKnBhZ2UsIG9mZnNldCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgVklSVElPX1hEUF9IRUFEUk9PTSwKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGVuKTsKPiAtICAgICAgICAgICAgICAgKmZy
YW1lX3N6ID0gUEFHRV9TSVpFOwo+IC0KPiAgICAgICAgICAgICAgICAgaWYgKCF4ZHBfcGFnZSkK
PiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsKPiAtICAgICAgICAgICAgICAg
b2Zmc2V0ID0gVklSVElPX1hEUF9IRUFEUk9PTTsKPiAtCj4gLSAgICAgICAgICAgICAgIHB1dF9w
YWdlKCpwYWdlKTsKPiAtICAgICAgICAgICAgICAgKnBhZ2UgPSB4ZHBfcGFnZTsKPiAtICAgICAg
IH0gZWxzZSBpZiAodW5saWtlbHkoaGVhZHJvb20gPCB2aXJ0bmV0X2dldF9oZWFkcm9vbSh2aSkp
KSB7Cj4gKyAgICAgICB9IGVsc2Ugewo+ICAgICAgICAgICAgICAgICB4ZHBfcm9vbSA9IFNLQl9E
QVRBX0FMSUdOKFZJUlRJT19YRFBfSEVBRFJPT00gKwo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3Qgc2tiX3NoYXJlZF9pbmZvKSk7Cj4gICAg
ICAgICAgICAgICAgIGlmICgqbGVuICsgeGRwX3Jvb20gPiBQQUdFX1NJWkUpCj4gQEAgLTEyMjcs
MTQgKzEyMjUsMTUgQEAgc3RhdGljIHZvaWQgKm1lcmdlYWJsZV94ZHBfcHJlcGFyZShzdHJ1Y3Qg
dmlydG5ldF9pbmZvICp2aSwKPgo+ICAgICAgICAgICAgICAgICBtZW1jcHkocGFnZV9hZGRyZXNz
KHhkcF9wYWdlKSArIFZJUlRJT19YRFBfSEVBRFJPT00sCj4gICAgICAgICAgICAgICAgICAgICAg
ICBwYWdlX2FkZHJlc3MoKnBhZ2UpICsgb2Zmc2V0LCAqbGVuKTsKPiAtICAgICAgICAgICAgICAg
KmZyYW1lX3N6ID0gUEFHRV9TSVpFOwo+IC0gICAgICAgICAgICAgICBvZmZzZXQgPSBWSVJUSU9f
WERQX0hFQURST09NOwo+IC0KPiAtICAgICAgICAgICAgICAgcHV0X3BhZ2UoKnBhZ2UpOwo+IC0g
ICAgICAgICAgICAgICAqcGFnZSA9IHhkcF9wYWdlOwo+ICAgICAgICAgfQo+Cj4gLSAgICAgICBy
ZXR1cm4gcGFnZV9hZGRyZXNzKCpwYWdlKSArIG9mZnNldDsKPiArICAgICAgICpmcmFtZV9zeiA9
IFBBR0VfU0laRTsKPiArCj4gKyAgICAgICBwdXRfcGFnZSgqcGFnZSk7Cj4gKwo+ICsgICAgICAg
KnBhZ2UgPSB4ZHBfcGFnZTsKPiArCj4gKyAgICAgICByZXR1cm4gcGFnZV9hZGRyZXNzKCpwYWdl
KSArIFZJUlRJT19YRFBfSEVBRFJPT007Cj4gIH0KPgo+ICBzdGF0aWMgc3RydWN0IHNrX2J1ZmYg
KnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gLS0KPiAyLjMyLjAu
My5nMDExOTVjZjlmCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
