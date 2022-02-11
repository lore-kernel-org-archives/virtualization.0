Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBADC433F5
	for <virtualization@archiver.kernel.org>; Fri, 11 Feb 2022 07:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 02AFA400E6;
	Fri, 11 Feb 2022 07:36:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZH6tmlyPd0CS; Fri, 11 Feb 2022 07:36:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2D1F340124;
	Fri, 11 Feb 2022 07:36:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF1FDC0011;
	Fri, 11 Feb 2022 07:36:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E79AFC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 07:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C878182998
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 07:36:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 55GKDwZ7cYSu
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 07:36:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 83A4382443
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 07:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644564990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ger/QR3OvBDgrfELo9ni0SFpEHXgnOyBAkmgj/wgKo=;
 b=L+sv64hnZSTSpn/HRlX2IX50GMMDW+hzNToR4vRMLb+Cs1vJLIyLfcttRMG6OlYOU8s9LJ
 1ruuEjsLveQ5LChm2qQpBpI0U3P9M74fnrZemAEudEM/gSUDIyNUGa1MuMss+OrjiUUGqk
 Ru6FLRnP+n8GBVLTAmWESsWzcG0X3mo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-OdU2txSKMwW0xDUNOHn9iw-1; Fri, 11 Feb 2022 02:36:29 -0500
X-MC-Unique: OdU2txSKMwW0xDUNOHn9iw-1
Received: by mail-lf1-f71.google.com with SMTP id
 o25-20020a05651205d900b0043e6c10892bso1889618lfo.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 23:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6ger/QR3OvBDgrfELo9ni0SFpEHXgnOyBAkmgj/wgKo=;
 b=rLPVkjDIIPX1xDpV252AYPu7buxSPTseAcS6rVUiB6vCxQNdDL2UMEu10nICRzGyCp
 LVr7vlz7lDk0VZ4r741FKDmhH37L/o30KirObV98Q2oO17T+twXBOC8aPT2S6pKUujWk
 jIgbJ19tITKpSHjukJcitT3gTczfbD1re3/I3E5K+OqJFgvfCyYHZ4Rmp4OfiPfXpRlO
 aocnxXQagrbMRy9OuWsOPI0EaJ3BvBZLm9FsA5/yfr85Zjs3cOVrdvaxoocmvCs0JnST
 oT+0zsvQ8HDu8U0f9sbKaP8zmHOpJMAGM9lNkWn2F3o3gR4IAmXURLmiwR/uNTDG+Osh
 fPWQ==
X-Gm-Message-State: AOAM531Kluoex55OFid2EXO1uWgIliBvSTOJPBVCCHghf95ZgLnIzSiq
 2lie1SzDKZTqPSETNJBYz1eiOFZprWVfYdP//ouCUoyZ6uLkaAV8UhFDz6Y2PQBrMv3kcSkPq18
 53rYhYSg5X33hm1++XARvz94/jtVKu+q2k6PzyAa0JK1v1qKrhiJA/yUDgQ==
X-Received: by 2002:ac2:4acf:: with SMTP id m15mr338620lfp.580.1644564987381; 
 Thu, 10 Feb 2022 23:36:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiq9kyvD4be5Fn1+/1LZaALFoATMR+JCZu8sTxPrafwqB0tr3RnE1Gwd2fhsEfOdiNhiDbr7hKgEwzFgtzIYo=
X-Received: by 2002:ac2:4acf:: with SMTP id m15mr338602lfp.580.1644564987072; 
 Thu, 10 Feb 2022 23:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
 <20220209122901.51790-10-xuanzhuo@linux.alibaba.com>
 <140fc738-3391-5529-dd5a-c46b9e937355@redhat.com>
 <1644563228.441517-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1644563228.441517-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 11 Feb 2022 15:36:15 +0800
Message-ID: <CACGkMEtzQFHZgMGe3-zg99bwdTB-X3-eo-AViDqXduoJb24d+w@mail.gmail.com>
Subject: Re: [PATCH v4 09/14] virtio: queue_reset: struct virtio_config_ops
 add callbacks for queue_reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gRnJpLCBGZWIgMTEsIDIwMjIgYXQgMzoxMyBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgMTEgRmViIDIwMjIgMTQ6NDk6MDMgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IOWcqCAy
MDIyLzIvOSDkuIvljYg4OjI4LCBYdWFuIFpodW8g5YaZ6YGTOgo+ID4gPiBQZXJmb3JtaW5nIHJl
c2V0IG9uIGEgcXVldWUgaXMgZGl2aWRlZCBpbnRvIGZvdXIgc3RlcHM6Cj4gPiA+Cj4gPiA+IDEu
IHJlc2V0X3ZxOiByZXNldCBvbmUgdnEKPiA+ID4gMi4gcmVjeWNsZSB0aGUgYnVmZmVyIGZyb20g
dnEgYnkgdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmKCkKPiA+ID4gMy4gcmVsZWFzZSB0aGUg
cmluZyBvZiB0aGUgdnEgYnkgdnJpbmdfcmVsZWFzZV92aXJ0cXVldWUoKQo+ID4gPiA0LiBlbmFi
bGVfcmVzZXRfdnE6IHJlLWVuYWJsZSB0aGUgcmVzZXQgcXVldWUKPiA+ID4KPiA+ID4gU28gYWRk
IHR3byBjYWxsYmFja3MgcmVzZXRfdnEsIGVuYWJsZV9yZXNldF92cSB0byBzdHJ1Y3QKPiA+ID4g
dmlydGlvX2NvbmZpZ19vcHMuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8
eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgIGluY2x1ZGUvbGlu
dXgvdmlydGlvX2NvbmZpZy5oIHwgMTMgKysrKysrKysrKysrKwo+ID4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxMyBpbnNlcnRpb25zKCspCj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L3ZpcnRpb19jb25maWcuaCBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gPiA+
IGluZGV4IDRkMTA3YWQzMTE0OS4uMGQwMWE2NGYyNTc2IDEwMDY0NAo+ID4gPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRp
b19jb25maWcuaAo+ID4gPiBAQCAtNzQsNiArNzQsMTcgQEAgc3RydWN0IHZpcnRpb19zaG1fcmVn
aW9uIHsKPiA+ID4gICAgKiBAc2V0X3ZxX2FmZmluaXR5OiBzZXQgdGhlIGFmZmluaXR5IGZvciBh
IHZpcnRxdWV1ZSAob3B0aW9uYWwpLgo+ID4gPiAgICAqIEBnZXRfdnFfYWZmaW5pdHk6IGdldCB0
aGUgYWZmaW5pdHkgZm9yIGEgdmlydHF1ZXVlIChvcHRpb25hbCkuCj4gPiA+ICAgICogQGdldF9z
aG1fcmVnaW9uOiBnZXQgYSBzaGFyZWQgbWVtb3J5IHJlZ2lvbiBiYXNlZCBvbiB0aGUgaW5kZXgu
Cj4gPiA+ICsgKiBAcmVzZXRfdnE6IHJlc2V0IGEgcXVldWUgaW5kaXZpZHVhbGx5Cj4gPgo+ID4K
PiA+IFRoaXMgbmVlZHMgdG8gYmUgbWFya2VkIGFzIG9wdGlvbmFsIEkgdGhpbmsuCj4KPiBPSy4K
Pgo+ID4KPiA+Cj4gPiA+ICsgKiB2cTogdGhlIHZpcnRxdWV1ZQo+ID4gPiArICogUmV0dXJucyAw
IG9uIHN1Y2Nlc3Mgb3IgZXJyb3Igc3RhdHVzCj4gPgo+ID4KPiA+IEl0IGxvb2tzIHRvIG1lIHRo
ZSBjYWxsZXIgc2hvdWxkIGFsc28gZ3VhcmFudGVlIHRoYXQgdGhlIHZyaW5nIGlzIG5vdAo+ID4g
YWNjc2VkIGJ5IGFueSBmdW5jdGlvbnMgZS5nIE5BUEkuCj4KPiBPSy4KPgo+ID4KPiA+Cj4gPiA+
ICsgKiBBZnRlciBzdWNjZXNzZnVsbHkgY2FsbGluZyB0aGlzLCBiZSBzdXJlIHRvIGNhbGwKPiA+
ID4gKyAqIHZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1ZigpIHRvIHJlY3ljbGUgdGhlIGJ1ZmZl
ciBpbiB0aGUgcmluZywgYW5kCj4gPiA+ICsgKiB0aGVuIGNhbGwgdnJpbmdfcmVsZWFzZV92aXJ0
cXVldWUoKSB0byByZWxlYXNlIHRoZSB2cSByaW5nLgo+ID4gPiArICogQGVuYWJsZV9yZXNldF92
cTogZW5hYmxlIGEgcmVzZXQgcXVldWUKPiA+ID4gKyAqIHZxOiB0aGUgdmlydHF1ZXVlCj4gPiA+
ICsgKiByaW5nX251bTogc3BlY2lmeSByaW5nIG51bSBmb3IgdGhlIHZxIHRvIGJlIHJlLWVuYWJs
ZWQuIDAgbWVhbnMgdXNlIHRoZQo+ID4gPiArICogICAgICAgICAgIGRlZmF1bHQgdmFsdWUuIE1V
U1QgYmUgYSBwb3dlciBvZiAyLgo+ID4KPiA+Cj4gPiBOb3RlIHRoYXQgd2UgZG9uJ3QgaGF2ZSBw
b3dlciBvZiAyIHJlcXVpcmVtZW50IGZvciBwYWNrZWQgdmlydHF1ZXVlLgo+Cj4KPiBTbyB0aGUg
Zm9sbG93aW5nIGNoZWNrIGhlcmUgZG9lcyBub3Qgc2VlbSByZWFzb25hYmxlLiAodmlydGlvX3Bj
aV9tb2Rlcm4uYykKClJldGhpbmsgYWJvdXQgdGhpcywgbG9va3MgbGlrZSBJIHdhcyB3cm9uZy4K
ClRob3VnaCBwYWNrZWQgdmlydHF1ZXVlIGRvZXNuJ3QgbWFuZGF0ZSBwb3dlciBvZiAyLCB0aGUg
YWN0dWFsIHF1ZXVlCmZvcm1hdCBzaG91bGQgYmUgaW52aXNpYmxlIHRvIGEgZHJpdmVyLgoKU28g
Zm9yY2luZyBwb3dlciBvZiAyIGlzIGNvcnJlY3QgKHNpbmNlIGl0IHdhcyByZXF1aXJlZCBieSBz
cGxpdCB2aXJ0cXVldWUpCgo+Cj4gc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnNldHVwX3ZxKHN0
cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2LAo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV92cV9pbmZvICppbmZvLAo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbmRleCwKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdm9pZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICp2cSks
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUsCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgY3R4LAo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1MTYgbXNpeF92ZWMpCj4gewo+Cj4gICAgICAgICBzdHJ1
Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2ID0gJnZwX2Rldi0+bWRldjsKPiAgICAg
ICAgIHN0cnVjdCB2aXJ0cXVldWUgKnZxOwo+ICAgICAgICAgdTE2IG51bTsKPiAgICAgICAgIGlu
dCBlcnI7Cj4KPiAgICAgICAgIGlmIChpbmRleCA+PSB2cF9tb2Rlcm5fZ2V0X251bV9xdWV1ZXMo
bWRldikpCj4gICAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9FTlQpOwo+Cj4gICAg
ICAgICAvKiBDaGVjayBpZiBxdWV1ZSBpcyBlaXRoZXIgbm90IGF2YWlsYWJsZSBvciBhbHJlYWR5
IGFjdGl2ZS4gKi8KPiAgICAgICAgIG51bSA9IHZwX21vZGVybl9nZXRfcXVldWVfc2l6ZShtZGV2
LCBpbmRleCk7Cj4gICAgICAgICBpZiAoIW51bSB8fCB2cF9tb2Rlcm5fZ2V0X3F1ZXVlX2VuYWJs
ZShtZGV2LCBpbmRleCkpCj4gICAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9FTlQp
Owo+Cj4gICAgICAgICBpZiAobnVtICYgKG51bSAtIDEpKSB7Cj4gICAgICAgICAgICAgICAgIGRl
dl93YXJuKCZ2cF9kZXYtPnBjaV9kZXYtPmRldiwgImJhZCBxdWV1ZSBzaXplICV1IiwgbnVtKTsK
PiAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7Cj4gICAgICAgICB9Cj4g
ICAgICAgICBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXgo+Cj4gPgo+ID4gQW5kIEkgd29uZGVyIGlm
IGl0J3MgY2xlYW5lciB0byBoYXZlIGEgZmluZF92cSgpIG9wcyBpbnN0ZWFkIHRvIGRlYWxpbmcK
PiA+IHdpdGggdGhlIHJlLWFsbG9jYXRpb24gYW5kIHBvc3NpYmxlIHNpemUgY2hhbmdlLCBvciBo
YXZlIGEgZGVkaWNhdGVkCj4gPiBoZWxwZXIgdG8gc2V0IHZyaW5nIHNpemUgc28gZHJpdmVyIGNh
biBkby4KPiA+Cj4gPiByZXNldF92cSgpCj4gPgo+ID4gdmlydHF1ZXVlX3NldF92cmluZ19zaXpl
KCkKPiA+Cj4gPiBlbmFibGVfcmVzZXRfdnEoKQo+Cj4gSSBsaWtlIHRvIGFkZCBhIGRlZGljYXRl
ZCBoZWxwZXIuCj4KPiA+Cj4gPgo+ID4gPiArICogUmV0dXJucyAwIG9uIHN1Y2Nlc3Mgb3IgZXJy
b3Igc3RhdHVzCj4gPiA+ICAgICovCj4gPiA+ICAgdHlwZWRlZiB2b2lkIHZxX2NhbGxiYWNrX3Qo
c3RydWN0IHZpcnRxdWV1ZSAqKTsKPiA+ID4gICBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgewo+
ID4gPiBAQCAtMTAwLDYgKzExMSw4IEBAIHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyB7Cj4gPiA+
ICAgICAgICAgICAgICAgICAgICAgaW50IGluZGV4KTsKPiA+ID4gICAgIGJvb2wgKCpnZXRfc2ht
X3JlZ2lvbikoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCB2aXJ0aW9fc2htX3JlZ2lvbiAqcmVnaW9uLCB1OCBpZCk7Cj4g
PiA+ICsgICBpbnQgKCpyZXNldF92cSkoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+ID4gPiArICAg
aW50ICgqZW5hYmxlX3Jlc2V0X3ZxKShzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdTE2IHJpbmdfbnVt
KTsKPiA+Cj4gPgo+ID4gTm90ZSB0aGF0IHRoZSBjdXJyZW50IGltcGxlbWVudCBpcyBiZXN0LWVm
Zm9ydCwgc28gaXQncyBub3QgZ3VhcmFudGVlCj4gPiB0aGF0IHdlIGNhbiBoYXZlIGEgdnJpbmcg
d2l0aCByaW5nX251bSwgd2UgbWF5IGdldCBsZXNzIHVuZGVyIG1lbW9yeQo+ID4gcHJlc3N1cmUg
b3IgZXZlbiBmYWlsLiBXZSBwcm9iYWJseSBuZWVkIHRvIGhhdmUgYSBwYW1hdGVyIHRvIG1hbmRh
dGUgdGhlCj4gPiByaW5nX251bSBvdGhlcndpc2UgdXNlciBtYXkgc3VycHJpc2UgdG8gc2VlIGEg
ZGVjcmVhc2VkIHNpemUgb2YgdGhlIHJpbmcKPiA+IHdoZW4gYSBpbmNyZWFzaW5nIGlzIGFjdHVh
bGx5IHJlcXVlc3RlZC4KPgo+IDEuIFdlIGNhbiBhZGQgYSBoZWxwZXIgdG8gc3BlY2lmeSBtYXgg
cmluZyBudW0uCj4gMi4gT3IgYWZ0ZXIgc3BlY2lmeWluZyByaW5nIG51bSwgaW4gY2FzZSBvZiBm
YWlsdXJlLCByZXR1cm4gZGlyZWN0bHkuCj4KPiBJIHByZWZlciAjMQoKVGhhdCdzIGZpbmUuCgpU
aGFua3MKCj4KPiBUaGFua3MuCj4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPgo+ID4gPiAgIH07Cj4g
PiA+Cj4gPiA+ICAgLyogSWYgZHJpdmVyIGRpZG4ndCBhZHZlcnRpc2UgdGhlIGZlYXR1cmUsIGl0
IHdpbGwgbmV2ZXIgYXBwZWFyLiAqLwo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
