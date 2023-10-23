Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2D3CDB474
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 03:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1576A82189;
	Mon, 23 Oct 2023 03:08:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1576A82189
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=avPU206E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ostCfueUI5dD; Mon, 23 Oct 2023 03:08:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 83C3782185;
	Mon, 23 Oct 2023 03:08:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 83C3782185
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62806C0071;
	Mon, 23 Oct 2023 03:08:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F117C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 03:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69EEF40A06
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 03:08:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 69EEF40A06
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=avPU206E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nak0CsWsIKl8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 03:08:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27686405E9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 03:08:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 27686405E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698030507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xBOeibxJX7ajf1aeV2Zk4DcGw5kQ9lUUzX6LACViMuU=;
 b=avPU206ElLxojvRWQJdETadlT2LtymM5rIb8+pfDqsamuT6SO6mngnwDU2+G2Cb7n/xhq3
 JoAHji3OXvxRYNQcrhNcDDS73J8TiBfZoRRFCqBOi1AUXvNGoji0wmimJA2X4dfoNY73Iy
 AEnGv3zPkkOfQwouJqZ2t1eO4N0pUkg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-efjbJ_52MCS6gJUkye2BuA-1; Sun, 22 Oct 2023 23:08:26 -0400
X-MC-Unique: efjbJ_52MCS6gJUkye2BuA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5079f6c127cso2652116e87.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Oct 2023 20:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698030504; x=1698635304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xBOeibxJX7ajf1aeV2Zk4DcGw5kQ9lUUzX6LACViMuU=;
 b=eIto0/hwJuGm1dFpaZjNwmtgu9YxPPCzKpC7z5dD1G/7Ifvy96eDP3XSY9pvqmStqe
 Oq6XotyR9XAP1M7CKOTzfhUiis2QbK92Qd0jEG7kKweRZXKPyOgS8hzoJxHoxw4I+/JO
 Lju/e2P5WhavCH1LuFN9t8C9dXwZXpsfepafK5kb4uz/NMv7XyLDEvgoOlBZw7IOT0Nl
 7cG1KQeBqHpKKCBMOM2gXcdiHn8g41yB+J8iQAhNtUfvC8wg5eXnEW26ja2+bZyvqBxv
 EDg/4ShOa8l1Vl8jQD49sLfL6Qg9Wc6Wx684YM0QT+uDHfwPHobsYl0IHfaLbyUMBnLn
 XLPQ==
X-Gm-Message-State: AOJu0YwHpX2HGiR9Gzy+anMsWY5I4HeoGwUqSEsoVkmm13rImRLR6l/K
 fuqflvo3OU4pseiJKs9PURxVDW1ijVLoUZN2gVfPG6MAbOPFBilntiDfOl6Iwblvq+sVjxGThEO
 jvD6cwoOnnehbycex835OMupXKZePeoyuxB0Hpe3rgRhZzqwvEVn09cCoXA==
X-Received: by 2002:ac2:55bc:0:b0:503:5d8:da33 with SMTP id
 y28-20020ac255bc000000b0050305d8da33mr6046334lfg.20.1698030504585; 
 Sun, 22 Oct 2023 20:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGwpB4vFIdAbZcfeljxER7LRweZf4ru9I2yvVHjzD+LCuTkM/A5Yje/fKSpyK+5d8M/rDIDjEYZ98BuZFgyR4=
X-Received: by 2002:ac2:55bc:0:b0:503:5d8:da33 with SMTP id
 y28-20020ac255bc000000b0050305d8da33mr6046327lfg.20.1698030504273; Sun, 22
 Oct 2023 20:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231020155819.24000-1-maxime.coquelin@redhat.com>
 <20231020155819.24000-4-maxime.coquelin@redhat.com>
In-Reply-To: <20231020155819.24000-4-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 23 Oct 2023 11:08:11 +0800
Message-ID: <CACGkMEsKvLTQNPp3JE9V4MBEuv5LVC+tRXgYYijgb9N0DNtGZw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] vduse: Temporarily disable control queue features
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, paul@paul-moore.com, lulu@redhat.com,
 mst@redhat.com, selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 stephen.smalley.work@gmail.com, jmorris@namei.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 linux-security-module@vger.kernel.org, eparis@parisplace.org,
 david.marchand@redhat.com, serge@hallyn.com
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

T24gRnJpLCBPY3QgMjAsIDIwMjMgYXQgMTE6NTjigK9QTSBNYXhpbWUgQ29xdWVsaW4KPG1heGlt
ZS5jb3F1ZWxpbkByZWRoYXQuY29tPiB3cm90ZToKPgo+IFZpcnRpby1uZXQgZHJpdmVyIGNvbnRy
b2wgcXVldWUgaW1wbGVtZW50YXRpb24gaXMgbm90IHNhZmUKPiB3aGVuIHVzZWQgd2l0aCBWRFVT
RS4gSWYgdGhlIFZEVVNFIGFwcGxpY2F0aW9uIGRvZXMgbm90Cj4gcmVwbHkgdG8gY29udHJvbCBx
dWV1ZSBtZXNzYWdlcywgaXQgY3VycmVudGx5IGVuZHMgdXAKPiBoYW5naW5nIHRoZSBrZXJuZWwg
dGhyZWFkIHNlbmRpbmcgdGhpcyBjb21tYW5kLgo+Cj4gU29tZSB3b3JrIGlzIG9uLWdvaW5nIHRv
IG1ha2UgdGhlIGNvbnRyb2wgcXVldWUKPiBpbXBsZW1lbnRhdGlvbiByb2J1c3Qgd2l0aCBWRFVT
RS4gVW50aWwgaXQgaXMgY29tcGxldGVkLAo+IGxldCdzIGRpc2FibGUgY29udHJvbCB2aXJ0cXVl
dWUgYW5kIGZlYXR1cmVzIHRoYXQgZGVwZW5kIG9uCj4gaXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBN
YXhpbWUgQ29xdWVsaW4gPG1heGltZS5jb3F1ZWxpbkByZWRoYXQuY29tPgoKSSB3b25kZXIgaWYg
aXQncyBiZXR0ZXIgdG8gZG8gdGhpcyB3aXRoIHBhdGNoIDIgb3IgYmVmb3JlIHBhdGNoIDIgdG8K
dW5icmVhayB0aGUgYmlzZWN0aW9uPwoKVGhhbmtzCgo+IC0tLQo+ICBkcml2ZXJzL3ZkcGEvdmRw
YV91c2VyL3ZkdXNlX2Rldi5jIHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4g
IDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1
c2VfZGV2LmMKPiBpbmRleCA3M2FkM2I3ZWZkOGUuLjAyNDNkZWU5Y2YwZSAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4gKysrIGIvZHJpdmVycy92ZHBh
L3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+IEBAIC0yOCw2ICsyOCw3IEBACj4gICNpbmNsdWRlIDx1
YXBpL2xpbnV4L3ZpcnRpb19jb25maWcuaD4KPiAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlv
X2lkcy5oPgo+ICAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fYmxrLmg+Cj4gKyNpbmNsdWRl
IDx1YXBpL2xpbnV4L3ZpcnRpb19yaW5nLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9tb2RfZGV2aWNl
dGFibGUuaD4KPgo+ICAjaW5jbHVkZSAiaW92YV9kb21haW4uaCIKPiBAQCAtNDYsNiArNDcsMzAg
QEAKPgo+ICAjZGVmaW5lIElSUV9VTkJPVU5EIC0xCj4KPiArI2RlZmluZSBWRFVTRV9ORVRfVkFM
SURfRkVBVFVSRVNfTUFTSyAgICAgICAgICAgXAo+ICsgICAgICAgKEJJVF9VTEwoVklSVElPX05F
VF9GX0NTVU0pIHwgICAgICAgICAgIFwKPiArICAgICAgICBCSVRfVUxMKFZJUlRJT19ORVRfRl9H
VUVTVF9DU1VNKSB8ICAgICBcCj4gKyAgICAgICAgQklUX1VMTChWSVJUSU9fTkVUX0ZfTVRVKSB8
ICAgICAgICAgICAgXAo+ICsgICAgICAgIEJJVF9VTEwoVklSVElPX05FVF9GX01BQykgfCAgICAg
ICAgICAgIFwKPiArICAgICAgICBCSVRfVUxMKFZJUlRJT19ORVRfRl9HVUVTVF9UU080KSB8ICAg
ICBcCj4gKyAgICAgICAgQklUX1VMTChWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNikgfCAgICAgXAo+
ICsgICAgICAgIEJJVF9VTEwoVklSVElPX05FVF9GX0dVRVNUX0VDTikgfCAgICAgIFwKPiArICAg
ICAgICBCSVRfVUxMKFZJUlRJT19ORVRfRl9HVUVTVF9VRk8pIHwgICAgICBcCj4gKyAgICAgICAg
QklUX1VMTChWSVJUSU9fTkVUX0ZfSE9TVF9UU080KSB8ICAgICAgXAo+ICsgICAgICAgIEJJVF9V
TEwoVklSVElPX05FVF9GX0hPU1RfVFNPNikgfCAgICAgIFwKPiArICAgICAgICBCSVRfVUxMKFZJ
UlRJT19ORVRfRl9IT1NUX0VDTikgfCAgICAgICBcCj4gKyAgICAgICAgQklUX1VMTChWSVJUSU9f
TkVUX0ZfSE9TVF9VRk8pIHwgICAgICAgXAo+ICsgICAgICAgIEJJVF9VTEwoVklSVElPX05FVF9G
X01SR19SWEJVRikgfCAgICAgIFwKPiArICAgICAgICBCSVRfVUxMKFZJUlRJT19ORVRfRl9TVEFU
VVMpIHwgICAgICAgICBcCj4gKyAgICAgICAgQklUX1VMTChWSVJUSU9fTkVUX0ZfSE9TVF9VU08p
IHwgICAgICAgXAo+ICsgICAgICAgIEJJVF9VTEwoVklSVElPX0ZfQU5ZX0xBWU9VVCkgfCAgICAg
ICAgIFwKPiArICAgICAgICBCSVRfVUxMKFZJUlRJT19SSU5HX0ZfSU5ESVJFQ1RfREVTQykgfCBc
Cj4gKyAgICAgICAgQklUX1VMTChWSVJUSU9fUklOR19GX0VWRU5UX0lEWCkgfCAgICAgICAgICBc
Cj4gKyAgICAgICAgQklUX1VMTChWSVJUSU9fRl9WRVJTSU9OXzEpIHwgICAgICAgICAgXAo+ICsg
ICAgICAgIEJJVF9VTEwoVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNKSB8ICAgICBcCj4gKyAgICAg
ICAgQklUX1VMTChWSVJUSU9fRl9SSU5HX1BBQ0tFRCkgfCAgICAgICAgXAo+ICsgICAgICAgIEJJ
VF9VTEwoVklSVElPX0ZfSU5fT1JERVIpKQo+ICsKPiAgc3RydWN0IHZkdXNlX3ZpcnRxdWV1ZSB7
Cj4gICAgICAgICB1MTYgaW5kZXg7Cj4gICAgICAgICB1MTYgbnVtX21heDsKPiBAQCAtMTc3OCw2
ICsxODAzLDE2IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICp2ZHVzZV9kZXZfYXR0cnNbXSA9
IHsKPgo+ICBBVFRSSUJVVEVfR1JPVVBTKHZkdXNlX2Rldik7Cj4KPiArc3RhdGljIHZvaWQgdmR1
c2VfZGV2X2ZlYXR1cmVzX2ZpbHRlcihzdHJ1Y3QgdmR1c2VfZGV2X2NvbmZpZyAqY29uZmlnKQo+
ICt7Cj4gKyAgICAgICAvKgo+ICsgICAgICAgICogVGVtcG9yYXJpbHkgZmlsdGVyIG91dCB2aXJ0
aW8tbmV0J3MgY29udHJvbCB2aXJ0cXVldWUgYW5kIGZlYXR1cmVzCj4gKyAgICAgICAgKiB0aGF0
IGRlcGVuZCBvbiBpdCB3aGlsZSBDVlEgaXMgYmVpbmcgbWFkZSBtb3JlIHJvYnVzdCBmb3IgVkRV
U0UuCj4gKyAgICAgICAgKi8KPiArICAgICAgIGlmIChjb25maWctPmRldmljZV9pZCA9PSBWSVJU
SU9fSURfTkVUKQo+ICsgICAgICAgICAgICAgICBjb25maWctPmZlYXR1cmVzICY9IFZEVVNFX05F
VF9WQUxJRF9GRUFUVVJFU19NQVNLOwo+ICt9Cj4gKwo+ICBzdGF0aWMgaW50IHZkdXNlX2NyZWF0
ZV9kZXYoc3RydWN0IHZkdXNlX2Rldl9jb25maWcgKmNvbmZpZywKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdm9pZCAqY29uZmlnX2J1ZiwgdTY0IGFwaV92ZXJzaW9uKQo+ICB7Cj4gQEAg
LTE3OTMsNiArMTgyOCw4IEBAIHN0YXRpYyBpbnQgdmR1c2VfY3JlYXRlX2RldihzdHJ1Y3QgdmR1
c2VfZGV2X2NvbmZpZyAqY29uZmlnLAo+ICAgICAgICAgaWYgKCFkZXYpCj4gICAgICAgICAgICAg
ICAgIGdvdG8gZXJyOwo+Cj4gKyAgICAgICB2ZHVzZV9kZXZfZmVhdHVyZXNfZmlsdGVyKGNvbmZp
Zyk7Cj4gKwo+ICAgICAgICAgZGV2LT5hcGlfdmVyc2lvbiA9IGFwaV92ZXJzaW9uOwo+ICAgICAg
ICAgZGV2LT5kZXZpY2VfZmVhdHVyZXMgPSBjb25maWctPmZlYXR1cmVzOwo+ICAgICAgICAgZGV2
LT5kZXZpY2VfaWQgPSBjb25maWctPmRldmljZV9pZDsKPiAtLQo+IDIuNDEuMAo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
