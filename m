Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8A7EB64DD
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 04:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 181E441FED;
	Thu, 13 Jul 2023 04:57:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 181E441FED
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AJZ9TPeH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GWZ9qwk4m0yj; Thu, 13 Jul 2023 04:57:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1B31441F55;
	Thu, 13 Jul 2023 04:57:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B31441F55
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F118EC0071;
	Thu, 13 Jul 2023 04:57:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFE4EC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 04:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 770C3403E0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 04:57:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 770C3403E0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AJZ9TPeH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F0wRiuQjLdy2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 04:57:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 91E4E40018
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 91E4E40018
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 04:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689224223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V7SVbq30Rq4Z2EWDTRaHNrJofzuhocgPZjljJ+sgEcs=;
 b=AJZ9TPeHRrMMsiZh6RY3iaWAoC1yP3kTDi+J4dJM8FIdTmYMkKQScSZfpPw99/+JZB8Pzf
 7yzpWInpRAMANexps5pRJK9D/JsODIw/w8Hu7oEhsK4obpXuNIsJKknuaFtKLIzzxbeElv
 OrrK7M4dOG7viRsj73Y9FmzpZvLgZrE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-o1MwahPAPWmqMfd4VKJ87g-1; Thu, 13 Jul 2023 00:57:02 -0400
X-MC-Unique: o1MwahPAPWmqMfd4VKJ87g-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b6ff15946fso2021741fa.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 21:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689224220; x=1691816220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V7SVbq30Rq4Z2EWDTRaHNrJofzuhocgPZjljJ+sgEcs=;
 b=T9pCR/Uontt8ttjIiqvlbtcJiCbxNawVbc1EswRr1l1SbGKGYL/anlRcB6zO/QcJ0R
 gY7p4d/kY/tZE48mY6nvOZ/juW9Yrvq47pLHpLXIsxAyzSOoitQOEV8ulpEnxffARWvD
 GN9GyZMfOv7rlyEYGzCf6MzJ9TscpXeiUQ1gNJWo6ir8rcBN04UsEI9sceHXA5sHyyt4
 MmKpwfA7NzM7d3/y1i8K9tczOoPq9FYsLisQt71skFkGnVb3u5dzNYaGDVNDZZm5hRy5
 OnZSghlq+J5FJdg8UOGBq94ZqwGM2zjtdRfqd16hXPslQhSmlLAHArwl5bebboPCigpu
 zS8w==
X-Gm-Message-State: ABy/qLaP7HuTt/XCW47odHejqb4gb5Lj7bgm44gSfPP5kgV5jUCoLFFR
 0jZJniQP6yTarwTqaU530EloYYVVVfPO+U/qNdx9S4KhYSmm0hkaltW86opFCq5Gm/COJGCWVHx
 rF05C+W8FyVzetONnHStRsI/XhL28Zk3cBQK5fgp2JC9evrrAHyeTdDWW5A==
X-Received: by 2002:a2e:9953:0:b0:2b4:94ec:e4 with SMTP id
 r19-20020a2e9953000000b002b494ec00e4mr341032ljj.22.1689224220602; 
 Wed, 12 Jul 2023 21:57:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGIypabmIEdWpREVJFlLHTSD3PLjp2d5P942GzWJq5RfB8/egNbaTfoBXMp9i+V2xRC5DcfoYK+ycaDkV04YXI=
X-Received: by 2002:a2e:9953:0:b0:2b4:94ec:e4 with SMTP id
 r19-20020a2e9953000000b002b494ec00e4mr341016ljj.22.1689224220304; 
 Wed, 12 Jul 2023 21:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230711042437.69381-1-shannon.nelson@amd.com>
 <20230711042437.69381-2-shannon.nelson@amd.com>
In-Reply-To: <20230711042437.69381-2-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Jul 2023 12:56:49 +0800
Message-ID: <CACGkMEtXGqePYsYLkTQarkn9=857kYFyq8TaVwTuWTRE9KS+Rg@mail.gmail.com>
Subject: Re: [PATCH v2 virtio 1/5] pds_vdpa: reset to vdpa specified mac
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, Allen Hubbe <allen.hubbe@amd.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 drivers@pensando.io
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

T24gVHVlLCBKdWwgMTEsIDIwMjMgYXQgMTI6MjXigK9QTSBTaGFubm9uIE5lbHNvbiA8c2hhbm5v
bi5uZWxzb25AYW1kLmNvbT4gd3JvdGU6Cj4KPiBGcm9tOiBBbGxlbiBIdWJiZSA8YWxsZW4uaHVi
YmVAYW1kLmNvbT4KPgo+IFdoZW4gdGhlIHZkcGEgZGV2aWNlIGlzIHJlc2V0LCBhbHNvIHJlaW5p
dGlhbGl6ZSBpdCB3aXRoIHRoZSBtYWMgYWRkcmVzcwo+IHRoYXQgd2FzIGFzc2lnbmVkIHdoZW4g
dGhlIGRldmljZSB3YXMgYWRkZWQuCj4KPiBGaXhlczogMTUxY2M4MzRmM2RkICgicGRzX3ZkcGE6
IGFkZCBzdXBwb3J0IGZvciB2ZHBhIGFuZCB2ZHBhbWdtdCBpbnRlcmZhY2VzIikKPiBTaWduZWQt
b2ZmLWJ5OiBBbGxlbiBIdWJiZSA8YWxsZW4uaHViYmVAYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4KCkFja2VkLWJ5OiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+IC0tLQo+ICBkcml2ZXJzL3Zk
cGEvcGRzL3ZkcGFfZGV2LmMgfCAxNiArKysrKysrKy0tLS0tLS0tCj4gIGRyaXZlcnMvdmRwYS9w
ZHMvdmRwYV9kZXYuaCB8ICAxICsKPiAgMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyks
IDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rl
di5jIGIvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5jCj4gaW5kZXggNTA3MWE0ZDU4ZjhkLi5l
MmU5OWJiMGJlMmIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5jCj4g
KysrIGIvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5jCj4gQEAgLTQwOSw2ICs0MDksOCBAQCBz
dGF0aWMgdm9pZCBwZHNfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9k
ZXYsIHU4IHN0YXR1cykKPiAgICAgICAgICAgICAgICAgICAgICAgICBwZHN2LT52cXNbaV0uYXZh
aWxfaWR4ID0gMDsKPiAgICAgICAgICAgICAgICAgICAgICAgICBwZHN2LT52cXNbaV0udXNlZF9p
ZHggPSAwOwo+ICAgICAgICAgICAgICAgICB9Cj4gKwo+ICsgICAgICAgICAgICAgICBwZHNfdmRw
YV9jbWRfc2V0X21hYyhwZHN2LCBwZHN2LT5tYWMpOwo+ICAgICAgICAgfQo+Cj4gICAgICAgICBp
ZiAoc3RhdHVzICYgfm9sZF9zdGF0dXMgJiBWSVJUSU9fQ09ORklHX1NfRkVBVFVSRVNfT0spIHsK
PiBAQCAtNTMyLDcgKzUzNCw2IEBAIHN0YXRpYyBpbnQgcGRzX3ZkcGFfZGV2X2FkZChzdHJ1Y3Qg
dmRwYV9tZ210X2RldiAqbWRldiwgY29uc3QgY2hhciAqbmFtZSwKPiAgICAgICAgIHN0cnVjdCBk
ZXZpY2UgKmRtYV9kZXY7Cj4gICAgICAgICBzdHJ1Y3QgcGNpX2RldiAqcGRldjsKPiAgICAgICAg
IHN0cnVjdCBkZXZpY2UgKmRldjsKPiAtICAgICAgIHU4IG1hY1tFVEhfQUxFTl07Cj4gICAgICAg
ICBpbnQgZXJyOwo+ICAgICAgICAgaW50IGk7Cj4KPiBAQCAtNjE3LDE5ICs2MTgsMTggQEAgc3Rh
dGljIGludCBwZHNfdmRwYV9kZXZfYWRkKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICptZGV2LCBjb25z
dCBjaGFyICpuYW1lLAo+ICAgICAgICAgICogb3Igc2V0IGEgcmFuZG9tIG1hYyBpZiBkZWZhdWx0
IGlzIDAwOi4uOjAwCj4gICAgICAgICAgKi8KPiAgICAgICAgIGlmIChhZGRfY29uZmlnLT5tYXNr
ICYgQklUX1VMTChWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQUREUikpIHsKPiAtICAgICAgICAg
ICAgICAgZXRoZXJfYWRkcl9jb3B5KG1hYywgYWRkX2NvbmZpZy0+bmV0Lm1hYyk7Cj4gLSAgICAg
ICAgICAgICAgIHBkc192ZHBhX2NtZF9zZXRfbWFjKHBkc3YsIG1hYyk7Cj4gKyAgICAgICAgICAg
ICAgIGV0aGVyX2FkZHJfY29weShwZHN2LT5tYWMsIGFkZF9jb25maWctPm5ldC5tYWMpOwo+ICAg
ICAgICAgfSBlbHNlIHsKPiAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRpb19uZXRfY29uZmln
IF9faW9tZW0gKnZjOwo+Cj4gICAgICAgICAgICAgICAgIHZjID0gcGRzdi0+dmRwYV9hdXgtPnZk
X21kZXYuZGV2aWNlOwo+IC0gICAgICAgICAgICAgICBtZW1jcHlfZnJvbWlvKG1hYywgdmMtPm1h
Yywgc2l6ZW9mKG1hYykpOwo+IC0gICAgICAgICAgICAgICBpZiAoaXNfemVyb19ldGhlcl9hZGRy
KG1hYykpIHsKPiAtICAgICAgICAgICAgICAgICAgICAgICBldGhfcmFuZG9tX2FkZHIobWFjKTsK
PiAtICAgICAgICAgICAgICAgICAgICAgICBkZXZfaW5mbyhkZXYsICJzZXR0aW5nIHJhbmRvbSBt
YWMgJXBNXG4iLCBtYWMpOwo+IC0gICAgICAgICAgICAgICAgICAgICAgIHBkc192ZHBhX2NtZF9z
ZXRfbWFjKHBkc3YsIG1hYyk7Cj4gKyAgICAgICAgICAgICAgIG1lbWNweV9mcm9taW8ocGRzdi0+
bWFjLCB2Yy0+bWFjLCBzaXplb2YocGRzdi0+bWFjKSk7Cj4gKyAgICAgICAgICAgICAgIGlmIChp
c196ZXJvX2V0aGVyX2FkZHIocGRzdi0+bWFjKSkgewo+ICsgICAgICAgICAgICAgICAgICAgICAg
IGV0aF9yYW5kb21fYWRkcihwZHN2LT5tYWMpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGRl
dl9pbmZvKGRldiwgInNldHRpbmcgcmFuZG9tIG1hYyAlcE1cbiIsIHBkc3YtPm1hYyk7Cj4gICAg
ICAgICAgICAgICAgIH0KPiAgICAgICAgIH0KPiArICAgICAgIHBkc192ZHBhX2NtZF9zZXRfbWFj
KHBkc3YsIHBkc3YtPm1hYyk7Cj4KPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBwZHN2LT5udW1f
dnFzOyBpKyspIHsKPiAgICAgICAgICAgICAgICAgcGRzdi0+dnFzW2ldLnFpZCA9IGk7Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9wZHMvdmRwYV9kZXYuaCBiL2RyaXZlcnMvdmRwYS9wZHMv
dmRwYV9kZXYuaAo+IGluZGV4IGExYmMzN2RlOTUzNy4uY2YwMmRmMjg3ZmM0IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmRwYS9wZHMvdmRwYV9kZXYuaAo+ICsrKyBiL2RyaXZlcnMvdmRwYS9wZHMv
dmRwYV9kZXYuaAo+IEBAIC0zOSw2ICszOSw3IEBAIHN0cnVjdCBwZHNfdmRwYV9kZXZpY2Ugewo+
ICAgICAgICAgdTY0IHJlcV9mZWF0dXJlczsgICAgICAgICAgICAgICAvKiBmZWF0dXJlcyByZXF1
ZXN0ZWQgYnkgdmRwYSAqLwo+ICAgICAgICAgdTggdmRwYV9pbmRleDsgICAgICAgICAgICAgICAg
ICAvKiByc3ZkIGZvciBmdXR1cmUgc3ViZGV2aWNlIHVzZSAqLwo+ICAgICAgICAgdTggbnVtX3Zx
czsgICAgICAgICAgICAgICAgICAgICAvKiBudW0gdnFzIGluIHVzZSAqLwo+ICsgICAgICAgdTgg
bWFjW0VUSF9BTEVOXTsgICAgICAgICAgICAgICAvKiBtYWMgc2VsZWN0ZWQgd2hlbiB0aGUgZGV2
aWNlIHdhcyBhZGRlZCAqLwo+ICAgICAgICAgc3RydWN0IHZkcGFfY2FsbGJhY2sgY29uZmlnX2Ni
Owo+ICAgICAgICAgc3RydWN0IG5vdGlmaWVyX2Jsb2NrIG5iOwo+ICB9Owo+IC0tCj4gMi4xNy4x
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
