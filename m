Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA26C433EF
	for <virtualization@archiver.kernel.org>; Mon, 14 Feb 2022 06:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5CCAA4012A;
	Mon, 14 Feb 2022 06:26:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LKm4baMbqVxX; Mon, 14 Feb 2022 06:26:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8A3DA400F6;
	Mon, 14 Feb 2022 06:26:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68FB2C0011;
	Mon, 14 Feb 2022 06:26:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CDE3C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 06:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 507E84032B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 06:26:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hv9wtBFW3Lat
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 06:26:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EF100402A8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 06:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644819972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MocfuCgXeofqqVmmusI1NLVP1hEoCkLeL//irsNDbNI=;
 b=cRX08Ovg/kk5GJxn95tNkrXnJFhuCRd1o8GxTasGaqoZd+nFTXJJ+kDzZ3YtmcKFQfVrMO
 x6cjGJV4kVxhqVeARvB+p34CqBDuO2PQyYYsTpgHC4WQ2Ov/ozzywwlaZ0zQ0Y29KqQ+gM
 AsDtyAfQRAJmnOXxLoxco3UwVbKo2G8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648--q-eDtmXMRm1NssJV2Gctw-1; Mon, 14 Feb 2022 01:26:11 -0500
X-MC-Unique: -q-eDtmXMRm1NssJV2Gctw-1
Received: by mail-pj1-f72.google.com with SMTP id
 t12-20020a17090a448c00b001b9cbac9c43so1888282pjg.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 22:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=MocfuCgXeofqqVmmusI1NLVP1hEoCkLeL//irsNDbNI=;
 b=hiAS3MHJWq5PpZTnFdsI5uAVM0Ma8KGDA7aSOilhbX1EoF2fleDbxcLOLeXqZN6Z1V
 8w10OAFwzImAK5gMOV0YmwnR4mf37cxNjvxHDO5dhrJaSGaFy1lpBHqKn77uMejSXDJe
 5Zm+VHcaoI8qUylqM9TcEZttCwaCpxVld5iSSbr2Y+WqGuJYM5FTMyYwftM+cnhdq55d
 rlhjGUl+PU5BhzTzdKZflYYdvGLap0843JV1/XUdn2Di4rLvZ3T840I1bIGgEw+kdYr5
 g0Nvhxo9U/8RvmeuxAmWEOWGuVSrwpN0UF/uVxy2xut37ez02QOfTLl2S+grZ+Tu2MUO
 kyUA==
X-Gm-Message-State: AOAM533H/Vwr7q+sVLAUzIGllAEXjGrbnZfkO3BfhhSQ2ZdTR2inTgOH
 68BvTaQ5DVP3cfeQ6DOpNwMFBi2vkIT9xCxf/qLeGHpWebBEK7wLYjfr70gzsmEgZw0j5cznUoX
 69NWI9aJMEcgVdeTqjicNcNgcn9sqfyja5xz4rEC0yA==
X-Received: by 2002:a17:90a:5a:: with SMTP id
 26mr13047544pjb.240.1644819970456; 
 Sun, 13 Feb 2022 22:26:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYCTIWIbAB3vhnD6sWKrSxihCfIRX4lvpLj+0epxRwz2O4+hNT+QkBupvVNAFGSmpLC8y3GA==
X-Received: by 2002:a17:90a:5a:: with SMTP id
 26mr13047534pjb.240.1644819970221; 
 Sun, 13 Feb 2022 22:26:10 -0800 (PST)
Received: from [10.72.12.239] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id q26sm1702931pgt.67.2022.02.13.22.26.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Feb 2022 22:26:09 -0800 (PST)
Message-ID: <8dc502ae-848d-565e-bdef-88bdd6b8053f@redhat.com>
Date: Mon, 14 Feb 2022 14:26:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH V4 2/4] vDPA/ifcvf: implement device MSIX vector allocator
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20220203072735.189716-1-lingshan.zhu@intel.com>
 <20220203072735.189716-3-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220203072735.189716-3-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIyLzIvMyDkuIvljYgzOjI3LCBaaHUgTGluZ3NoYW4g5YaZ6YGTOgo+IFRoaXMgY29t
bWl0IGltcGxlbWVudHMgYSBNU0lYIHZlY3RvciBhbGxvY2F0aW9uIGhlbHBlcgo+IGZvciB2cXMg
YW5kIGNvbmZpZyBpbnRlcnJ1cHRzLgo+Cj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxs
aW5nc2hhbi56aHVAaW50ZWwuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3Zm
X21haW4uYyB8IDM1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9tYWluLmMKPiBpbmRleCBkMWE2YjVhYjU0M2MuLjQ0Yzg5YWIwYjZkYSAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gKysrIGIvZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX21haW4uYwo+IEBAIC01OCwxNCArNTgsNDUgQEAgc3RhdGljIHZvaWQgaWZj
dmZfZnJlZV9pcnEoc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXIsIGludCBxdWV1ZXMpCj4g
ICAJaWZjdmZfZnJlZV9pcnFfdmVjdG9ycyhwZGV2KTsKPiAgIH0KPiAgIAo+ICsvKiBpZmN2ZiBN
U0lYIHZlY3RvcnMgYWxsb2NhdG9yLCB0aGlzIGhlbHBlciB0cmllcyB0byBhbGxvY2F0ZQo+ICsg
KiB2ZWN0b3JzIGZvciBhbGwgdmlydHF1ZXVlcyBhbmQgdGhlIGNvbmZpZyBpbnRlcnJ1cHQuCj4g
KyAqIEl0IHJldHVybnMgdGhlIG51bWJlciBvZiBhbGxvY2F0ZWQgdmVjdG9ycywgbmVnYXRpdmUK
PiArICogcmV0dXJuIHZhbHVlIHdoZW4gZmFpbHMuCj4gKyAqLwo+ICtzdGF0aWMgaW50IGlmY3Zm
X2FsbG9jX3ZlY3RvcnMoc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXIpCj4gK3sKPiArCXN0
cnVjdCBwY2lfZGV2ICpwZGV2ID0gYWRhcHRlci0+cGRldjsKPiArCXN0cnVjdCBpZmN2Zl9odyAq
dmYgPSAmYWRhcHRlci0+dmY7Cj4gKwlpbnQgbWF4X2ludHIsIHJldDsKPiArCj4gKwkvKiBhbGwg
cXVldWVzIGFuZCBjb25maWcgaW50ZXJydXB0ICAqLwo+ICsJbWF4X2ludHIgPSB2Zi0+bnJfdnJp
bmcgKyAxOwo+ICsJcmV0ID0gcGNpX2FsbG9jX2lycV92ZWN0b3JzKHBkZXYsIDEsIG1heF9pbnRy
LCBQQ0lfSVJRX01TSVggfCBQQ0lfSVJRX0FGRklOSVRZKTsKPiArCj4gKwlpZiAocmV0IDwgMCkg
ewo+ICsJCUlGQ1ZGX0VSUihwZGV2LCAiRmFpbGVkIHRvIGFsbG9jIElSUSB2ZWN0b3JzXG4iKTsK
PiArCQlyZXR1cm4gcmV0Owo+ICsJfQo+ICsKPiArCWlmIChyZXQgPCBtYXhfaW50cikKPiArCQlJ
RkNWRl9JTkZPKHBkZXYsCj4gKwkJCSAgICJSZXF1ZXN0ZWQgJXUgdmVjdG9ycywgaG93ZXZlciBv
bmx5ICV1IGFsbG9jYXRlZCwgbG93ZXIgcGVyZm9ybWFuY2VcbiIsCj4gKwkJCSAgIG1heF9pbnRy
LCByZXQpOwo+ICsKPiArCXJldHVybiByZXQ7Cj4gK30KPiArCj4gICBzdGF0aWMgaW50IGlmY3Zm
X3JlcXVlc3RfaXJxKHN0cnVjdCBpZmN2Zl9hZGFwdGVyICphZGFwdGVyKQo+ICAgewo+ICAgCXN0
cnVjdCBwY2lfZGV2ICpwZGV2ID0gYWRhcHRlci0+cGRldjsKPiAgIAlzdHJ1Y3QgaWZjdmZfaHcg
KnZmID0gJmFkYXB0ZXItPnZmOwo+IC0JaW50IHZlY3RvciwgaSwgcmV0LCBpcnE7Cj4gKwlpbnQg
dmVjdG9yLCBudmVjdG9ycywgaSwgcmV0LCBpcnE7Cj4gICAJdTE2IG1heF9pbnRyOwo+ICAgCj4g
LQkvKiBhbGwgcXVldWVzIGFuZCBjb25maWcgaW50ZXJydXB0ICAqLwo+ICsJbnZlY3RvcnMgPSBp
ZmN2Zl9hbGxvY192ZWN0b3JzKGFkYXB0ZXIpOwo+ICsJaWYgKCEobnZlY3RvcnMgPiAwKSkKPiAr
CQlyZXR1cm4gbnZlY3RvcnM7CgoKV2h5IG5vdCBzaW1wbHkgY2hlY2tpbmcgYnkgdXNpbmcgbnZl
Y3RvcnMgPD0gMD8gSWYgaWZjdmZfYWxsb2NfdmVjdG9ycyAKY2FuIHJldHVybiAwIHRoaXMgYnJl
YWtzIHRoZSBpZmN2Zl9yZXF1ZXN0X2lycSgpIGNhbGxlcidzIGFzc3VtcHRpb24uCgoKPiArCj4g
ICAJbWF4X2ludHIgPSB2Zi0+bnJfdnJpbmcgKyAxOwo+ICAgCj4gICAJcmV0ID0gcGNpX2FsbG9j
X2lycV92ZWN0b3JzKHBkZXYsIG1heF9pbnRyLAoKClNvIGlycSBpcyBhbGxvY2F0ZWQgdHdpY2Ug
aGVyZT8KClRoYW5rcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
