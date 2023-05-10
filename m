Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D99C7EE22
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 04:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39F3860E96;
	Wed, 10 May 2023 04:07:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39F3860E96
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SWY0uqYm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gOtDYBJs3IzZ; Wed, 10 May 2023 04:07:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B523460AFC;
	Wed, 10 May 2023 04:07:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B523460AFC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BEBDC0036;
	Wed, 10 May 2023 04:07:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D40D2C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 04:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A76E8427ED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 04:07:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A76E8427ED
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SWY0uqYm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QXEiZ5tUxqpN
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 04:07:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0DE6427D9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B0DE6427D9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 04:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683691622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUMwiiMo+uImtVa1NMnxeZGa2c1vgyzXNYzjiq0BCYA=;
 b=SWY0uqYmeRQGzWUhqi4VtQYgJeFTPxD1sgBa4CqdFJJD/iKFZ29oiXTnHGwg5zTZh21tLf
 ityJXvJNnesxoOB3uqS8uRsZLJX6G76SPCflNBPeiNSXqUxUI3bLhfpEXKeC+8flYY/ttR
 8Hup7HVnv0nHe5zveLoQKGAGopDBOpU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-nE-4Sm3_M3-snP-w0dU--A-1; Wed, 10 May 2023 00:07:00 -0400
X-MC-Unique: nE-4Sm3_M3-snP-w0dU--A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-969d75fec7aso220782366b.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 May 2023 21:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683691620; x=1686283620;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gUMwiiMo+uImtVa1NMnxeZGa2c1vgyzXNYzjiq0BCYA=;
 b=N9mPL+OKrJiPzwUCoIPha5TmoI2+/J7JHVXGgcq1AaRfcqzoiR+j4M4ssiKIVa+0pc
 q+aCVRPW5ZdNeJlHzdihqWz9dvJGWZZoCFqd50rz0GAadN7e2NLAe2uZFfI74rB6A+Gp
 4w905/IDgjJgEyqpXo/ZwZL7S9+9PRWZ4AQD3JrZm2F8Jfhc6gjtjOciUCEUzbMsU/vi
 vaxrIeSHaXV6nUO3Zvcyc8/ax+G6ib0QM78MFuU34SYp8WegA/I3VO0abZCGX9gNC0Ld
 zFbQWVlMK2sgYYjKbS6lErSStb7BnuSBcEiBc7DaIOCk5H8h2ncS2oH5YSyxAJ3Z6vP4
 yzgg==
X-Gm-Message-State: AC+VfDyBXV7cp50wo1X3wMvm1CVvSFnikzcizngh7/9XSCUqkuddLKPv
 xm8sgbexJA97ppQdtfcSq9niM0a4BNHp1R3KReZAZNCD3Itzk3S+12ZT7Ceakr2CjL2cJheV53B
 Kq3+eOedwNaMCu0DxpGid6wa42u/4xcE/hQshQaikkw==
X-Received: by 2002:a17:906:974b:b0:957:943e:7416 with SMTP id
 o11-20020a170906974b00b00957943e7416mr16092526ejy.15.1683691619888; 
 Tue, 09 May 2023 21:06:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ASWwnTtQgH66opLJjp20JjkoXCAaF1TMqwqlbANYYaPhCUcoC3US8+hYl0Ip1aqx4KRzvaA==
X-Received: by 2002:a17:906:974b:b0:957:943e:7416 with SMTP id
 o11-20020a170906974b00b00957943e7416mr16092513ejy.15.1683691619610; 
 Tue, 09 May 2023 21:06:59 -0700 (PDT)
Received: from redhat.com ([176.119.195.36]) by smtp.gmail.com with ESMTPSA id
 hx8-20020a170906846800b00965e839f56bsm2088336ejc.182.2023.05.09.21.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 May 2023 21:06:59 -0700 (PDT)
Date: Wed, 10 May 2023 00:06:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
Message-ID: <20230510000603-mutt-send-email-mst@kernel.org>
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
 <1683689214.9647853-1-xuanzhuo@linux.alibaba.com>
 <20230509233907-mutt-send-email-mst@kernel.org>
 <CACGkMEujVhZrU2Wa3=-6DAgK5x8suC9EDxMxt5nN3Y1-LAVcUA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEujVhZrU2Wa3=-6DAgK5x8suC9EDxMxt5nN3Y1-LAVcUA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Joerg Roedel <jroedel@suse.de>,
 linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org
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

T24gV2VkLCBNYXkgMTAsIDIwMjMgYXQgMTI6MDQ6NTBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBXZWQsIE1heSAxMCwgMjAyMyBhdCAxMTo0NOKAr0FNIE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFdlZCwgTWF5IDEwLCAyMDIzIGF0
IDExOjI2OjU0QU0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToKPiA+ID4gT24gV2VkLCAxMCBNYXkg
MjAyMyAxMDo1NDozNyArMDgwMCwgemhlbndlaSBwaSA8cGl6aGVud2VpQGJ5dGVkYW5jZS5jb20+
IHdyb3RlOgo+ID4gPiA+IEJvdGggc3BsaXQgcmluZyBhbmQgcGFja2VkIHJpbmcgdXNlIDMyYml0
cyB0byBkZXNjcmliZSB0aGUgbGVuZ3RoIG9mCj4gPiA+ID4gYSBkZXNjcmlwdG9yOiBzZWUgc3Ry
dWN0IHZyaW5nX2Rlc2MgYW5kIHN0cnVjdCB2cmluZ19wYWNrZWRfZGVzYy4KPiA+ID4gPiBUaGlz
IG1lYW5zIHRoZSBtYXggc2VnbWVudCBzaXplIHN1cHBvcnRlZCBieSB2aXJ0aW8gaXMgVTMyX01B
WC4KPiA+ID4gPgo+ID4gPiA+IEFuIGV4YW1wbGUgb2YgdmlydGlvX21heF9kbWFfc2l6ZSBpbiB2
aXJ0aW9fYmxrLmM6Cj4gPiA+ID4gICB1MzIgdiwgbWF4X3NpemU7Cj4gPiA+ID4KPiA+ID4gPiAg
IG1heF9zaXplID0gdmlydGlvX21heF9kbWFfc2l6ZSh2ZGV2KTsgIC0+IGltcGxpY2l0IGNvbnZl
cnQKPiA+ID4gPiAgIGVyciA9IHZpcnRpb19jcmVhZF9mZWF0dXJlKHZkZXYsIFZJUlRJT19CTEtf
Rl9TSVpFX01BWCwKPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2
aXJ0aW9fYmxrX2NvbmZpZywgc2l6ZV9tYXgsICZ2KTsKPiA+ID4gPiAgIG1heF9zaXplID0gbWlu
KG1heF9zaXplLCB2KTsKPiA+ID4gPgo+ID4gPiA+IFRoZXJlIGlzIGEgcmlzayBkdXJpbmcgaW1w
bGljaXQgY29udmVydCBoZXJlLCBvbmNlIHZpcnRpb19tYXhfZG1hX3NpemUKPiA+ID4gPiByZXR1
cm5zIDRHLCBtYXhfc2l6ZSBiZWNvbWVzIDAuCj4gPiA+ID4KPiA+ID4gPiBGaXhlczogZTZkNmRk
NmM4NzVlICgidmlydGlvOiBJbnRyb2R1Y2UgdmlydGlvX21heF9kbWFfc2l6ZSgpIikKPiA+ID4g
PiBDYzogSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+Cj4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogemhlbndlaSBwaSA8cGl6aGVud2VpQGJ5dGVkYW5jZS5jb20+Cj4gPiA+ID4gLS0tCj4gPiA+
ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxMiArKysrKysrKy0tLS0KPiA+ID4g
PiAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICAyICstCj4gPiA+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+ID4gPiA+Cj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gPiA+ID4gaW5kZXggYzUzMTBlYWY4YjQ2Li41NWNmZWNmMDMwYTEg
MTAwNjQ0Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiA+
ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gPiBAQCAtMjg5LDEyICsy
ODksMTYgQEAgc3RhdGljIGJvb2wgdnJpbmdfdXNlX2RtYV9hcGkoY29uc3Qgc3RydWN0IHZpcnRp
b19kZXZpY2UgKnZkZXYpCj4gPiA+ID4gICAgIHJldHVybiBmYWxzZTsKPiA+ID4gPiAgfQo+ID4g
PiA+Cj4gPiA+ID4gLXNpemVfdCB2aXJ0aW9fbWF4X2RtYV9zaXplKGNvbnN0IHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ICt1MzIgdmlydGlvX21heF9kbWFfc2l6ZShjb25zdCBz
dHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+ID4KPiA+ID4KPiA+ID4gTEdUTQo+ID4gPgo+
ID4gPiBCdXQsIHNob3VsZCB3ZSBjaGFuZ2UgdGhlIHBhcmFtZXRlciB0byB2cSwgdGhlbiB1c2Ug
dGhlIGRtYV9kZXY/Cj4gPiA+Cj4gPiA+IEBKYXNvbgo+ID4gPgo+ID4gPiBUaGFua3MuCj4gPiA+
Cj4gPgo+ID4KPiA+IHRoYXQgd291bGQgYmUgYW4gdW5yZWxhdGVkIHJld29yay4KPiAKPiBQcm9i
YWJseSwgYnV0IEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gYmUgZG9uZSBvbiB0b3Agb3RoZXJ3aXNl
IHdlIG1heSBmb3JnZXQuCj4gCj4gVGhhbmtzCgpKdXN0IHRvIG1ha2UgdGhpbmdzIGNsZWFyIEkn
bSBtZXJnaW5nIGZpeGVzIGZvciB0aGlzCnJlbGVhc2UgYnV0IGNsZWFudXBzIGJlbG9uZyBpbiB0
aGUgbmV4dCBvbmUuCgo+ID4KPiA+ID4gPiAgewo+ID4gPiA+IC0gICBzaXplX3QgbWF4X3NlZ21l
bnRfc2l6ZSA9IFNJWkVfTUFYOwo+ID4gPiA+ICsgICB1MzIgbWF4X3NlZ21lbnRfc2l6ZSA9IFUz
Ml9NQVg7Cj4gPiA+ID4KPiA+ID4gPiAtICAgaWYgKHZyaW5nX3VzZV9kbWFfYXBpKHZkZXYpKQo+
ID4gPiA+IC0gICAgICAgICAgIG1heF9zZWdtZW50X3NpemUgPSBkbWFfbWF4X21hcHBpbmdfc2l6
ZSh2ZGV2LT5kZXYucGFyZW50KTsKPiA+ID4gPiArICAgaWYgKHZyaW5nX3VzZV9kbWFfYXBpKHZk
ZXYpKSB7Cj4gPiA+ID4gKyAgICAgICAgICAgc2l6ZV90IG1heF9kbWFfc2l6ZSA9IGRtYV9tYXhf
bWFwcGluZ19zaXplKHZkZXYtPmRldi5wYXJlbnQpOwo+ID4gPiA+ICsKPiA+ID4gPiArICAgICAg
ICAgICBpZiAobWF4X2RtYV9zaXplIDwgbWF4X3NlZ21lbnRfc2l6ZSkKPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgIG1heF9zZWdtZW50X3NpemUgPSBtYXhfZG1hX3NpemU7Cj4gPiA+ID4gKyAg
IH0KPiA+ID4gPgo+ID4gPiA+ICAgICByZXR1cm4gbWF4X3NlZ21lbnRfc2l6ZTsKPiA+ID4gPiAg
fQo+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9s
aW51eC92aXJ0aW8uaAo+ID4gPiA+IGluZGV4IGI5MzIzOGRiOTRlMy4uMWE2MDVmNDA4MzI5IDEw
MDY0NAo+ID4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiA+ID4gPiArKysgYi9p
bmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gPiA+ID4gQEAgLTE0Nyw3ICsxNDcsNyBAQCBpbnQgdmly
dGlvX2RldmljZV9yZXN0b3JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpOwo+ID4gPiA+ICAj
ZW5kaWYKPiA+ID4gPiAgdm9pZCB2aXJ0aW9fcmVzZXRfZGV2aWNlKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICpkZXYpOwo+ID4gPiA+Cj4gPiA+ID4gLXNpemVfdCB2aXJ0aW9fbWF4X2RtYV9zaXplKGNv
bnN0IHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KTsKPiA+ID4gPiArdTMyIHZpcnRpb19tYXhf
ZG1hX3NpemUoY29uc3Qgc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpOwo+ID4gPiA+Cj4gPiA+
ID4gICNkZWZpbmUgdmlydGlvX2RldmljZV9mb3JfZWFjaF92cSh2ZGV2LCB2cSkgXAo+ID4gPiA+
ICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHZxLCAmdmRldi0+dnFzLCBsaXN0KQo+ID4gPiA+IC0t
Cj4gPiA+ID4gMi4yMC4xCj4gPiA+ID4KPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
