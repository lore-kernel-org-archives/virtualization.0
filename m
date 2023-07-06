Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6175EB64DA
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 01:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9330560745;
	Thu,  6 Jul 2023 01:58:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9330560745
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IMN1jHGu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1z1qdqae9lnn; Thu,  6 Jul 2023 01:58:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0CE6060BE8;
	Thu,  6 Jul 2023 01:58:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0CE6060BE8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7187C0071;
	Thu,  6 Jul 2023 01:58:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D48FDC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 01:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B545060BE8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 01:58:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B545060BE8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iuq2kG0PXoEb
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 01:58:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE19760745
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE19760745
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 01:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688608715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NsasqXB9dldWhzDq9CuN3y5r4mmR4a5/kKY+3ZImxK0=;
 b=IMN1jHGuRm+kM4LefCYKHVeNb2AnLNhzWXvaOcxWZ0ZfiBP7AQiItt9LqOLjTYmFyvtzg/
 7vaEBnW0okvlnlNLGqExB28c44nfIUoVEMHjQmS6QojO7XBWWROUDUUw9OLIiPSdr90SDe
 UzrAL6d2WQRqLIhWaUcqErKErR3MACo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-6DSiiATNP0iiBr4lrl7pdQ-1; Wed, 05 Jul 2023 21:58:34 -0400
X-MC-Unique: 6DSiiATNP0iiBr4lrl7pdQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6f51e170fso1020841fa.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Jul 2023 18:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688608713; x=1691200713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NsasqXB9dldWhzDq9CuN3y5r4mmR4a5/kKY+3ZImxK0=;
 b=G/M653N4OUctYHAALfAjrrWGF95Ld7qM+5ZCGWJRe4N+OghT3UgGQo8fBmzUO5glXY
 BHCsszmoOr1VqncqsJu1e9N3+yJmuGcfguSLnPlzI4craH0EZpuZNMGuTu7v4KF6K+BQ
 asnJEakWJxBaxQAK7dO3PPuj0zA+UlJ+emj7j0Z20lm+/dTtzqM3NgXy7xCt+5yCWaCv
 gfP3FpLoa9sUIPr6aJuZRA56UTboOZhjR7Yo+0f8FmZDiviWlooy+kHx0h/v2LvlHGUf
 OiBTHk/8WeXp7SzNuli2ONuMkCPam+HMKERvXdkxbOMmzYneLrRGeyVhfcPrEYbT4+pP
 7wtQ==
X-Gm-Message-State: ABy/qLaVbHigbys3NphHqXm0FCaAHlwVYH28iFE+QWaGoQuPECXZnVGr
 VAd6cbzvx4ODECYWxs8eAqX/7MT77rY0eBtBNtxyEfbD1qP2frmTByAFeqOzk5lhznY8DvEoaWx
 c4dvdm/eQR7OEes7f3s3JGyVSYKPm4KLz7spBiAw/GfuEGSEnKkl3oxK5dg==
X-Received: by 2002:a2e:9b84:0:b0:2b6:9e83:73da with SMTP id
 z4-20020a2e9b84000000b002b69e8373damr283161lji.32.1688608713366; 
 Wed, 05 Jul 2023 18:58:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE00soEfxOJ/QbJordnNOL8MCWk5yZ7zVg1rcWKrVsTwrOST2cDpf/yuu7m4ImfdJtC64rluVxV55WVfuh4yOE=
X-Received: by 2002:a2e:9b84:0:b0:2b6:9e83:73da with SMTP id
 z4-20020a2e9b84000000b002b69e8373damr283157lji.32.1688608713057; Wed, 05 Jul
 2023 18:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
 <20230705100430.61927-4-maxime.coquelin@redhat.com>
In-Reply-To: <20230705100430.61927-4-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jul 2023 09:58:22 +0800
Message-ID: <CACGkMEtBJx97caD=7s_cGfQxpYhnzb_LN8fsMq7V2CT=PnQKww@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] vduse: Temporarily disable control queue features
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 eperezma@redhat.com, david.marchand@redhat.com
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

T24gV2VkLCBKdWwgNSwgMjAyMyBhdCA2OjA04oCvUE0gTWF4aW1lIENvcXVlbGluCjxtYXhpbWUu
Y29xdWVsaW5AcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBWaXJ0aW8tbmV0IGRyaXZlciBjb250cm9s
IHF1ZXVlIGltcGxlbWVudGF0aW9uIGlzIG5vdCBzYWZlCj4gd2hlbiB1c2VkIHdpdGggVkRVU0Uu
IElmIHRoZSBWRFVTRSBhcHBsaWNhdGlvbiBkb2VzIG5vdAo+IHJlcGx5IHRvIGNvbnRyb2wgcXVl
dWUgbWVzc2FnZXMsIGl0IGN1cnJlbnRseSBlbmRzIHVwCj4gaGFuZ2luZyB0aGUga2VybmVsIHRo
cmVhZCBzZW5kaW5nIHRoaXMgY29tbWFuZC4KPgo+IFNvbWUgd29yayBpcyBvbi1nb2luZyB0byBt
YWtlIHRoZSBjb250cm9sIHF1ZXVlCj4gaW1wbGVtZW50YXRpb24gcm9idXN0IHdpdGggVkRVU0Uu
IFVudGlsIGl0IGlzIGNvbXBsZXRlZCwKPiBsZXQncyBmaWx0ZXIgb3V0IGNvbnRyb2wgdmlydHF1
ZXVlIGFuZCBmZWF0dXJlcyB0aGF0IGRlcGVuZAo+IG9uIGl0IGJ5IGtlZXBpbmcgb25seSBmZWF0
dXJlcyBrbm93biB0byBiZSBzdXBwb3J0ZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXhpbWUgQ29x
dWVsaW4gPG1heGltZS5jb3F1ZWxpbkByZWRoYXQuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvdmRwYS92ZHBh
X3VzZXIvdmR1c2VfZGV2LmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAg
MSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVz
ZV9kZXYuYwo+IGluZGV4IDEyNzFjOTc5NjUxNy4uNzM0NTA3MWRiMGE4IDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEv
dmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4gQEAgLTQ2LDYgKzQ2LDMwIEBACj4KPiAgI2RlZmluZSBJ
UlFfVU5CT1VORCAtMQo+Cj4gKyNkZWZpbmUgVkRVU0VfTkVUX1ZBTElEX0ZFQVRVUkVTX01BU0sg
ICAgICAgICAgIFwKPiArICAgICAgIChCSVRfVUxMKFZJUlRJT19ORVRfRl9DU1VNKSB8ICAgICAg
ICAgICBcCj4gKyAgICAgICAgQklUX1VMTChWSVJUSU9fTkVUX0ZfR1VFU1RfQ1NVTSkgfCAgICAg
XAo+ICsgICAgICAgIEJJVF9VTEwoVklSVElPX05FVF9GX01UVSkgfCAgICAgICAgICAgIFwKPiAr
ICAgICAgICBCSVRfVUxMKFZJUlRJT19ORVRfRl9NQUMpIHwgICAgICAgICAgICBcCj4gKyAgICAg
ICAgQklUX1VMTChWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNCkgfCAgICAgXAo+ICsgICAgICAgIEJJ
VF9VTEwoVklSVElPX05FVF9GX0dVRVNUX1RTTzYpIHwgICAgIFwKPiArICAgICAgICBCSVRfVUxM
KFZJUlRJT19ORVRfRl9HVUVTVF9FQ04pIHwgICAgICBcCj4gKyAgICAgICAgQklUX1VMTChWSVJU
SU9fTkVUX0ZfR1VFU1RfVUZPKSB8ICAgICAgXAo+ICsgICAgICAgIEJJVF9VTEwoVklSVElPX05F
VF9GX0hPU1RfVFNPNCkgfCAgICAgIFwKPiArICAgICAgICBCSVRfVUxMKFZJUlRJT19ORVRfRl9I
T1NUX1RTTzYpIHwgICAgICBcCj4gKyAgICAgICAgQklUX1VMTChWSVJUSU9fTkVUX0ZfSE9TVF9F
Q04pIHwgICAgICAgXAo+ICsgICAgICAgIEJJVF9VTEwoVklSVElPX05FVF9GX0hPU1RfVUZPKSB8
ICAgICAgIFwKPiArICAgICAgICBCSVRfVUxMKFZJUlRJT19ORVRfRl9NUkdfUlhCVUYpIHwgICAg
ICBcCj4gKyAgICAgICAgQklUX1VMTChWSVJUSU9fTkVUX0ZfU1RBVFVTKSB8ICAgICAgICAgXAo+
ICsgICAgICAgIEJJVF9VTEwoVklSVElPX05FVF9GX0hPU1RfVVNPKSB8ICAgICAgIFwKPiArICAg
ICAgICBCSVRfVUxMKFZJUlRJT19GX0FOWV9MQVlPVVQpIHwgICAgICAgICBcCj4gKyAgICAgICAg
QklUX1VMTChWSVJUSU9fUklOR19GX0lORElSRUNUX0RFU0MpIHwgXAo+ICsgICAgICAgIEJJVF9V
TEwoVklSVElPX0ZfRVZFTlRfSURYKSB8ICAgICAgICAgIFwKPiArICAgICAgICBCSVRfVUxMKFZJ
UlRJT19GX1ZFUlNJT05fMSkgfCAgICAgICAgICBcCj4gKyAgICAgICAgQklUX1VMTChWSVJUSU9f
Rl9JT01NVV9QTEFURk9STSkgfCAgICAgXAo+ICsgICAgICAgIEJJVF9VTEwoVklSVElPX0ZfUklO
R19QQUNLRUQpIHwgICAgICAgIFwKPiArICAgICAgICBCSVRfVUxMKFZJUlRJT19GX0lOX09SREVS
KSkKPiArCj4gIHN0cnVjdCB2ZHVzZV92aXJ0cXVldWUgewo+ICAgICAgICAgdTE2IGluZGV4Owo+
ICAgICAgICAgdTE2IG51bV9tYXg7Cj4gQEAgLTE3NzgsNiArMTgwMiwxNiBAQCBzdGF0aWMgc3Ry
dWN0IGF0dHJpYnV0ZSAqdmR1c2VfZGV2X2F0dHJzW10gPSB7Cj4KPiAgQVRUUklCVVRFX0dST1VQ
Uyh2ZHVzZV9kZXYpOwo+Cj4gK3N0YXRpYyB2b2lkIHZkdXNlX2Rldl9mZWF0dXJlc19maWx0ZXIo
c3RydWN0IHZkdXNlX2Rldl9jb25maWcgKmNvbmZpZykKPiArewo+ICsgICAgICAgLyoKPiArICAg
ICAgICAqIFRlbXBvcmFyaWx5IGZpbHRlciBvdXQgdmlydGlvLW5ldCdzIGNvbnRyb2wgdmlydHF1
ZXVlIGFuZCBmZWF0dXJlcwo+ICsgICAgICAgICogdGhhdCBkZXBlbmQgb24gaXQgd2hpbGUgQ1ZR
IGlzIGJlaW5nIG1hZGUgbW9yZSByb2J1c3QgZm9yIFZEVVNFLgo+ICsgICAgICAgICovCj4gKyAg
ICAgICBpZiAoY29uZmlnLT5kZXZpY2VfaWQgPT0gVklSVElPX0lEX05FVCkKPiArICAgICAgICAg
ICAgICAgY29uZmlnLT5mZWF0dXJlcyAmPSBWRFVTRV9ORVRfVkFMSURfRkVBVFVSRVNfTUFTSzsK
PiArfQo+ICsKPiAgc3RhdGljIGludCB2ZHVzZV9jcmVhdGVfZGV2KHN0cnVjdCB2ZHVzZV9kZXZf
Y29uZmlnICpjb25maWcsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmNvbmZp
Z19idWYsIHU2NCBhcGlfdmVyc2lvbikKPiAgewo+IEBAIC0xNzkzLDYgKzE4MjcsOCBAQCBzdGF0
aWMgaW50IHZkdXNlX2NyZWF0ZV9kZXYoc3RydWN0IHZkdXNlX2Rldl9jb25maWcgKmNvbmZpZywK
PiAgICAgICAgIGlmICghZGV2KQo+ICAgICAgICAgICAgICAgICBnb3RvIGVycjsKPgo+ICsgICAg
ICAgdmR1c2VfZGV2X2ZlYXR1cmVzX2ZpbHRlcihjb25maWcpOwo+ICsKPiAgICAgICAgIGRldi0+
YXBpX3ZlcnNpb24gPSBhcGlfdmVyc2lvbjsKPiAgICAgICAgIGRldi0+ZGV2aWNlX2ZlYXR1cmVz
ID0gY29uZmlnLT5mZWF0dXJlczsKPiAgICAgICAgIGRldi0+ZGV2aWNlX2lkID0gY29uZmlnLT5k
ZXZpY2VfaWQ7Cj4gLS0KPiAyLjQxLjAKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
