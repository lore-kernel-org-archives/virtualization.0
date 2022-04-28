Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437DCC433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 09:48:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E46BD823EB;
	Thu, 28 Apr 2022 09:48:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zA9vm1xsPJKT; Thu, 28 Apr 2022 09:48:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8C877812A5;
	Thu, 28 Apr 2022 09:48:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60342C0039;
	Thu, 28 Apr 2022 09:48:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 391CDC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 176CB41638
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:48:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id koGwoC37CRrN
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:48:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 21978415DD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651139289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/Q6+7UoJRX6cudWFKNW9tIbzrHbNM8vNgLsH23w4EQ=;
 b=OrN/00XzeMDgFKquoL7ZHckBgBhVtuzSlLT7SUrbJlp364nmqtOZs54nfqBePgmrAdDTs6
 86XhXwtNQ6d6KWc2mfC3LWXWhVSjjBKI/IwEq1uteL4NcE3UOVhfA4fhGEQFbxtYxxjkZY
 OmEyU01NhG+dBHq8YVJZVQqom84M4zM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-M745YxMiPiapbMOA27NJtg-1; Thu, 28 Apr 2022 05:48:05 -0400
X-MC-Unique: M745YxMiPiapbMOA27NJtg-1
Received: by mail-wm1-f69.google.com with SMTP id
 d13-20020a05600c3acd00b0038ff865c043so4155288wms.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 02:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Qatp2Yg/wXTDFXvXeilZVsHVfa7JvQVmG1q95f+gwzc=;
 b=NJTZQ77hYq1/vkmwlYDTMTvhY7N8mNnjjMJk2prs9cp3PJB5iqOoN0TCIVYxmq2Pec
 Gha7/glDS/kyu6uZOv3akeT1vajjznShL3YSofWtDidfK2iLPgsNnE2YtSm8e2B+xmDI
 X75QBTsMjwI2sHp5LKm8u6CyHkGNVYipqPTo0YD9yBUXsvyQAUcIFVwCyrce8NVcbPan
 bsJohUmmMRLE9tgnPcKz9cjebXxQsOJpYo0Me5twDzbmHPb4+ItbSLheeIN/zjEYd0q/
 JzMFXltQh2NIrH57A/kVTLQbiU3iTZCcnIyeYYGmmxxxNqGhga/cnAOP+ICmStwW+uj3
 Pzsg==
X-Gm-Message-State: AOAM533KT5MTP4O63x9RCLXTscuha8NyIynTzQGA/N/GBt2u1vemE6md
 GYsLNAIYROEsu5zvwI1HgTFxwuh05+dL0P3dujaCr38Pl01uSJYXHFbxjfyoGdEhHWM2YFeX1Sh
 EuimHgloDGpzDy0kp9TgbeeyBbvi+Fvdvgixvli2yDA==
X-Received: by 2002:a5d:4302:0:b0:206:4b2:8690 with SMTP id
 h2-20020a5d4302000000b0020604b28690mr25833754wrq.224.1651139284014; 
 Thu, 28 Apr 2022 02:48:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytEglwbjPG2HcsgM6oJexGZfTUC4dM+bbxTN5qYMDe8QZnP/GqEzl9BFojoxxRZ4Gj/Bqn1g==
X-Received: by 2002:a5d:4302:0:b0:206:4b2:8690 with SMTP id
 h2-20020a5d4302000000b0020604b28690mr25833710wrq.224.1651139283752; 
 Thu, 28 Apr 2022 02:48:03 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:834:5aa0:80d7:8022:3692:b311])
 by smtp.gmail.com with ESMTPSA id
 t8-20020adfa2c8000000b0020ad7121495sm11722189wra.23.2022.04.28.02.48.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 Apr 2022 02:48:03 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 3/3] virtio-pci: Use cpumask_available to fix compilation
 error
From: Christophe Marie Francois Dupont de Dinechin <cdupontd@redhat.com>
In-Reply-To: <20220415044657-mutt-send-email-mst@kernel.org>
Date: Thu, 28 Apr 2022 11:48:01 +0200
Message-Id: <3D264F7F-624D-4E9D-A139-F1DB0CC6045C@redhat.com>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-4-dinechin@redhat.com>
 <20220415044657-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cdupontd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Juri Lelli <juri.lelli@redhat.com>, trivial@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Zhen Lei <thunder.leizhen@huawei.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org, Ben Segall <bsegall@google.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
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

Cgo+IE9uIDE1IEFwciAyMDIyLCBhdCAxMDo0OCwgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4gCj4gT24gVGh1LCBBcHIgMTQsIDIwMjIgYXQgMDU6MDg6NTVQTSAr
MDIwMCwgQ2hyaXN0b3BoZSBkZSBEaW5lY2hpbiB3cm90ZToKPj4gV2l0aCBHQ0MgMTIgYW5kIGRl
ZmNvbmZpZywgd2UgZ2V0IHRoZSBmb2xsb3dpbmcgZXJyb3I6Cj4+IAo+PiB8ICAgQ0MgICAgICBk
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5vCj4+IHwgZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9jb21tb24uYzogSW4gZnVuY3Rpb24g4oCYdnBfZGVsX3Zxc+KAmToKPj4gfCBkcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jOjI1NzoyOTogZXJyb3I6IHRoZSBjb21wYXJp
c29uIHdpbGwKPj4gfCAgYWx3YXlzIGV2YWx1YXRlIGFzIOKAmHRydWXigJkgZm9yIHRoZSBwb2lu
dGVyIG9wZXJhbmQgaW4KPj4gfCAg4oCYdnBfZGV2LT5tc2l4X2FmZmluaXR5X21hc2tzICsgKHNp
emV0eXBlKSgobG9uZyB1bnNpZ25lZCBpbnQpaSAqIDgp4oCZCj4+IHwgIG11c3Qgbm90IGJlIE5V
TEwgWy1XZXJyb3I9YWRkcmVzc10KPj4gfCAgIDI1NyB8ICAgICAgICAgICAgICAgICAgICAgICAg
IGlmICh2cF9kZXYtPm1zaXhfYWZmaW5pdHlfbWFza3NbaV0pCj4+IHwgICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXn5+fn5+Cj4+IAo+PiBUaGlzIGhhcHBlbnMgaW4gdGhlIGNh
c2Ugd2hlcmUgQ09ORklHX0NQVU1BU0tfT0ZGU1RBQ0sgaXMgbm90IGRlZmluZWQsCj4+IHNpbmNl
IHdlIHR5cGVkZWYgY3B1bWFza192YXJfdCBhcyBhbiBhcnJheS4gVGhlIGNvbXBpbGVyIGlzIGVz
c2VudGlhbGx5Cj4+IGNvbXBsYWluaW5nIHRoYXQgYW4gYXJyYXkgcG9pbnRlciBjYW5ub3QgYmUg
TlVMTC4gVGhpcyBpcyBub3QgYSB2ZXJ5Cj4+IGltcG9ydGFudCB3YXJuaW5nLCBidXQgdGhlcmUg
aXMgYSBmdW5jdGlvbiBjYWxsZWQgY3B1bWFza19hdmFpbGFibGUgdGhhdAo+PiBzZWVtcyB0byBi
ZSBkZWZpbmVkIGp1c3QgZm9yIHRoYXQgY2FzZSwgc28gdGhlIGZpeCBpcyBlYXN5Lgo+PiAKPj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBkZSBEaW5lY2hpbiA8Y2hyaXN0b3BoZUBkaW5lY2hp
bi5vcmc+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUgZGUgRGluZWNoaW4gPGRpbmVjaGlu
QHJlZGhhdC5jb20+Cj4gCj4gVGhlcmUgd2FzIGFuIGFsdGVybmF0ZSBwYXRjaCBwcm9wb3NlZCBm
b3IgdGhpcyBieQo+IE11cmlsbyBPcHNmZWxkZXIgQXJhdWpvLiBXaGF0IGRvIHlvdSB0aGluayBh
Ym91dCB0aGF0IGFwcHJvYWNoPwoKSSByZXNwb25kZWQgb24gdGhlIG90aGVyIHRocmVhZCwgYnV0
IGxldCBtZSBzaGFyZSB0aGUgcmVzcG9uc2UgaGVyZToKClt0byBtdXJpbG9vQGxpbnV4LmlibS5j
b21dCkFwb2xvZ2llcyBmb3IgdGhlIGRlbGF5IGluIHJlc3BvbmRpbmcsIGJyb2tlbiBsYXB0b3Di
gKYKCkluIHRoZSBjYXNlIHdoZXJlIENPTkZJR19DUFVNQVNLX09GRlNUQUNLIGlzIG5vdCBkZWZp
bmVkLCB3ZSBoYXZlOgoKCXR5cGVkZWYgc3RydWN0IGNwdW1hc2sgY3B1bWFza192YXJfdFsxXTsK
ClNvIHRoYXQgdnBfZGV2LT5tc2l4X2FmZmluaXR5X21hc2tzW2ldIGlzIHN0YXRpY2FsbHkgbm90
IG51bGwgKHRoYXTigJlzIHRoZSB3YXJuaW5nKQpidXQgYWxzbyBhIHN0YXRpYyBwb2ludGVyLCBz
byBub3Qga2ZyZWUtc2FmZSBJTU8uCgo+IAo+IAo+PiAtLS0KPj4gZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9jb21tb24uYyB8IDIgKy0KPj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3BjaV9jb21tb24uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPj4gaW5k
ZXggZDcyNGY2NzY2MDhiLi41YzQ0YTJmMTNjOTMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9jb21tb24uYwo+PiBAQCAtMjU0LDcgKzI1NCw3IEBAIHZvaWQgdnBfZGVsX3ZxcyhzdHJ1Y3Qg
dmlydGlvX2RldmljZSAqdmRldikKPj4gCj4+IAlpZiAodnBfZGV2LT5tc2l4X2FmZmluaXR5X21h
c2tzKSB7Cj4+IAkJZm9yIChpID0gMDsgaSA8IHZwX2Rldi0+bXNpeF92ZWN0b3JzOyBpKyspCj4+
IC0JCQlpZiAodnBfZGV2LT5tc2l4X2FmZmluaXR5X21hc2tzW2ldKQo+PiArCQkJaWYgKGNwdW1h
c2tfYXZhaWxhYmxlKHZwX2Rldi0+bXNpeF9hZmZpbml0eV9tYXNrc1tpXSkpCj4+IAkJCQlmcmVl
X2NwdW1hc2tfdmFyKHZwX2Rldi0+bXNpeF9hZmZpbml0eV9tYXNrc1tpXSk7Cj4+IAl9Cj4+IAo+
PiAtLSAKPj4gMi4zNS4xCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
