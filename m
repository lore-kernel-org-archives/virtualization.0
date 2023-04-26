Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B55AC77B60
	for <virtualization@archiver.kernel.org>; Wed, 26 Apr 2023 04:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68D8841BAE;
	Wed, 26 Apr 2023 04:05:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68D8841BAE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e/rMn2hL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xqzRsN9GobUB; Wed, 26 Apr 2023 04:05:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5282941B8F;
	Wed, 26 Apr 2023 04:05:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5282941B8F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 217EAC0036;
	Wed, 26 Apr 2023 04:05:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94D28C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 04:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6930082065
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 04:05:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6930082065
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=e/rMn2hL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e_dloaHxUce0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 04:05:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93A9582061
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93A9582061
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 04:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682481902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EEdVR9DAkXNfLgQQwW7BgEwz+el3stxyptCFUGADz1Y=;
 b=e/rMn2hLAi/8LWRFb8WpK6xWfI2OtRA42hG8SaGnQcuzG8coVwcYY/gbHDy4P0VoeZQu1S
 rbekl6DnXYm4Foc8a8Ybu9/q3l+AuI0w+9XSNUBdLur+pQGZ9cxhTTGkxmn4gOW4roYcnX
 JfDEvIfuZ+Hpbrl/hejvHEbpJeZPv+I=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-vGeoRU12NKacziegtLty1g-1; Wed, 26 Apr 2023 00:05:01 -0400
X-MC-Unique: vGeoRU12NKacziegtLty1g-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1a63d87bd46so42603005ad.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682481900; x=1685073900;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EEdVR9DAkXNfLgQQwW7BgEwz+el3stxyptCFUGADz1Y=;
 b=YPOotpnetUJsFZ12mIWISSMHmqlLB+IPXNFYHtQuV3D/OfeW9nosyuoV0W1+PG+xgZ
 A98LOdA4pS+gSdBdRUlmlH+pdo/UVdCjrRMyYCeq7YTzw0WfP3hMUGiesA3fZKvC1qaL
 ae0lbYNPfj8nSdioasqGCHEIUbPm6jIR7aeJlJy/vB2ss5b7ZEvfUQo/l0lg49WVwmgw
 ACcYcWw2HuE7BKiNFoyB5ZaXj05efwoYEDBd9SjTsWYSRkIXZSwptxsLPF7AkOw2Sorn
 I7to7aoQFJW1Da6vn4ujnffL02SzWabMninqB4soblkVD5iwQ9o+WeW43ok3IminIDOV
 eZuQ==
X-Gm-Message-State: AAQBX9cdltysef9LoPR2qp1a5mP3yFy2IGv1B66s5hyneXkjduwdfWKQ
 5B3e0+fuGMlFeSqcM1Zzj6YGHUPBFOdU8LYGXyXtOBisCWk3juVFcsSNSEKr168BUsyH1IZSZZR
 Z4CZ21Du/6FzY2J//T1h6XyKQTnZULiDu9MKqzrRVgQ==
X-Received: by 2002:a17:902:c40d:b0:1a9:2823:dac2 with SMTP id
 k13-20020a170902c40d00b001a92823dac2mr27142675plk.57.1682481900251; 
 Tue, 25 Apr 2023 21:05:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350bToq7oF7nl5Omy+lBvIMpdKidjyP1JLvIFb1zOdJnG/wrv1+xuf7r6+/9DUhIOeKEcUIFR6A==
X-Received: by 2002:a17:902:c40d:b0:1a9:2823:dac2 with SMTP id
 k13-20020a170902c40d00b001a92823dac2mr27142658plk.57.1682481899926; 
 Tue, 25 Apr 2023 21:04:59 -0700 (PDT)
Received: from [10.72.13.54] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a170902690c00b001a6a6169d45sm8984679plk.168.2023.04.25.21.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Apr 2023 21:04:59 -0700 (PDT)
Message-ID: <acc427b5-6f22-9792-b3d8-cc8fb10fe30e@redhat.com>
Date: Wed, 26 Apr 2023 12:04:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 3/5] retire ifcvf_start_datapath and ifcvf_add_status
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
 <20230331204854.20082-4-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230331204854.20082-4-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIzLzQvMSAwNDo0OCwgWmh1IExpbmdzaGFuIOWGmemBkzoKPiBSYXRoZXIgdGhhbiBm
b3JtZXIgbGF6eS1pbml0aWFsaXphdGlvbiBtZWNoYW5pc20sCj4gbm93IHRoZSB2aXJ0cXVldWUg
b3BlcmF0aW9ucyBhbmQgZHJpdmVyX2ZlYXR1cmVzIHJlbGF0ZWQKPiBvcHMgYWNjZXNzIHRoZSB2
aXJ0aW8gcmVnaXN0ZXJzIGRpcmVjdGx5IHRvIHRha2UKPiBpbW1lZGlhdGUgYWN0aW9ucy4gU28g
aWZjdmZfc3RhcnRfZGF0YXBhdGgoKSBzaG91bGQKPiByZXRpcmUuCj4KPiBpZmN2Zl9hZGRfc3Rh
dHVzKCkgaXMgcmV0aWVyZCBiZWNhdXNlIHdlIHNob3VsZCBub3QgY2hhbmdlCj4gZGV2aWNlIHN0
YXR1cyBieSBhIHZlbmRvciBkcml2ZXIncyBkZWNpc2lvbiwgdGhpcyBkcml2ZXIgc2hvdWxkCj4g
b25seSBzZXQgZGV2aWNlIHN0YXR1cyB3aGljaCBpcyBmcm9tIHZpcml0byBkcml2ZXJzCj4gdXBv
biB2ZHBhX29wcy5zZXRfc3RhdHVzKCkKPgo+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8
bGluZ3NoYW4uemh1QGludGVsLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KClRoYW5rcwoKCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZf
YmFzZS5jIHwgMTkgLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lm
Y3ZmX2Jhc2UuaCB8ICAxIC0KPiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgfCAy
MyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA0MyBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jIGIv
ZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+IGluZGV4IDU0NmU5MjNiY2QxNi4uNzll
MzEzYzVlMTBlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMK
PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4gQEAgLTE3OCwxNSArMTc4
LDYgQEAgdm9pZCBpZmN2Zl9yZXNldChzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+ICAgCWlmY3ZmX2dl
dF9zdGF0dXMoaHcpOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyB2b2lkIGlmY3ZmX2FkZF9zdGF0dXMo
c3RydWN0IGlmY3ZmX2h3ICpodywgdTggc3RhdHVzKQo+IC17Cj4gLQlpZiAoc3RhdHVzICE9IDAp
Cj4gLQkJc3RhdHVzIHw9IGlmY3ZmX2dldF9zdGF0dXMoaHcpOwo+IC0KPiAtCWlmY3ZmX3NldF9z
dGF0dXMoaHcsIHN0YXR1cyk7Cj4gLQlpZmN2Zl9nZXRfc3RhdHVzKGh3KTsKPiAtfQo+IC0KPiAg
IHU2NCBpZmN2Zl9nZXRfaHdfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpodykKPiAgIHsKPiAg
IAlzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnIF9faW9tZW0gKmNmZyA9IGh3LT5jb21tb25f
Y2ZnOwo+IEBAIC0zODcsMTYgKzM3OCw2IEBAIHN0YXRpYyB2b2lkIGlmY3ZmX2h3X2Rpc2FibGUo
c3RydWN0IGlmY3ZmX2h3ICpodykKPiAgIAl9Cj4gICB9Cj4gICAKPiAtaW50IGlmY3ZmX3N0YXJ0
X2h3KHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4gLXsKPiAtCWlmY3ZmX2FkZF9zdGF0dXMoaHcsIFZJ
UlRJT19DT05GSUdfU19BQ0tOT1dMRURHRSk7Cj4gLQlpZmN2Zl9hZGRfc3RhdHVzKGh3LCBWSVJU
SU9fQ09ORklHX1NfRFJJVkVSKTsKPiAtCj4gLQlpZmN2Zl9hZGRfc3RhdHVzKGh3LCBWSVJUSU9f
Q09ORklHX1NfRFJJVkVSX09LKTsKPiAtCj4gLQlyZXR1cm4gMDsKPiAtfQo+IC0KPiAgIHZvaWQg
aWZjdmZfc3RvcF9odyhzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+ICAgewo+ICAgCWlmY3ZmX2h3X2Rp
c2FibGUoaHcpOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5o
IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+IGluZGV4IGNiMTkxOTZjM2VjZS4u
ZDM0ZDNiYzBkYmY0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNl
LmgKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gQEAgLTExMCw3ICsx
MTAsNiBAQCBzdHJ1Y3QgaWZjdmZfdmRwYV9tZ210X2RldiB7Cj4gICB9Owo+ICAgCj4gICBpbnQg
aWZjdmZfaW5pdF9odyhzdHJ1Y3QgaWZjdmZfaHcgKmh3LCBzdHJ1Y3QgcGNpX2RldiAqZGV2KTsK
PiAtaW50IGlmY3ZmX3N0YXJ0X2h3KHN0cnVjdCBpZmN2Zl9odyAqaHcpOwo+ICAgdm9pZCBpZmN2
Zl9zdG9wX2h3KHN0cnVjdCBpZmN2Zl9odyAqaHcpOwo+ICAgdm9pZCBpZmN2Zl9ub3RpZnlfcXVl
dWUoc3RydWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCk7Cj4gICB2b2lkIGlmY3ZmX3JlYWRfZGV2
X2NvbmZpZyhzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1NjQgb2Zmc2V0LAo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3Zm
X21haW4uYwo+IGluZGV4IDQ1ODg0ODRiZDUzZC4uOTY4Njg3MTU5ZTQ0IDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfbWFpbi5jCj4gQEAgLTM0NiwyMiArMzQ2LDYgQEAgc3RhdGljIGludCBpZmN2Zl9y
ZXF1ZXN0X2lycShzdHJ1Y3QgaWZjdmZfaHcgKnZmKQo+ICAgCXJldHVybiAwOwo+ICAgfQo+ICAg
Cj4gLXN0YXRpYyBpbnQgaWZjdmZfc3RhcnRfZGF0YXBhdGgoc3RydWN0IGlmY3ZmX2FkYXB0ZXIg
KmFkYXB0ZXIpCj4gLXsKPiAtCXN0cnVjdCBpZmN2Zl9odyAqdmYgPSBhZGFwdGVyLT52ZjsKPiAt
CXU4IHN0YXR1czsKPiAtCWludCByZXQ7Cj4gLQo+IC0JcmV0ID0gaWZjdmZfc3RhcnRfaHcodmYp
Owo+IC0JaWYgKHJldCA8IDApIHsKPiAtCQlzdGF0dXMgPSBpZmN2Zl9nZXRfc3RhdHVzKHZmKTsK
PiAtCQlzdGF0dXMgfD0gVklSVElPX0NPTkZJR19TX0ZBSUxFRDsKPiAtCQlpZmN2Zl9zZXRfc3Rh
dHVzKHZmLCBzdGF0dXMpOwo+IC0JfQo+IC0KPiAtCXJldHVybiByZXQ7Cj4gLX0KPiAtCj4gICBz
dGF0aWMgaW50IGlmY3ZmX3N0b3BfZGF0YXBhdGgoc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0
ZXIpCj4gICB7Cj4gICAJc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IGFkYXB0ZXItPnZmOwo+IEBAIC00
NTIsMTMgKzQzNiwxMSBAQCBzdGF0aWMgdTggaWZjdmZfdmRwYV9nZXRfc3RhdHVzKHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4gICAKPiAgIHN0YXRpYyB2b2lkIGlmY3ZmX3ZkcGFfc2V0
X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LCB1OCBzdGF0dXMpCj4gICB7Cj4g
LQlzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqYWRhcHRlcjsKPiAgIAlzdHJ1Y3QgaWZjdmZfaHcgKnZm
Owo+ICAgCXU4IHN0YXR1c19vbGQ7Cj4gICAJaW50IHJldDsKPiAgIAo+ICAgCXZmICA9IHZkcGFf
dG9fdmYodmRwYV9kZXYpOwo+IC0JYWRhcHRlciA9IHZkcGFfdG9fYWRhcHRlcih2ZHBhX2Rldik7
Cj4gICAJc3RhdHVzX29sZCA9IGlmY3ZmX2dldF9zdGF0dXModmYpOwo+ICAgCj4gICAJaWYgKHN0
YXR1c19vbGQgPT0gc3RhdHVzKQo+IEBAIC00NzMsMTEgKzQ1NSw2IEBAIHN0YXRpYyB2b2lkIGlm
Y3ZmX3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LCB1OCBzdGF0
dXMpCj4gICAJCQlpZmN2Zl9zZXRfc3RhdHVzKHZmLCBzdGF0dXMpOwo+ICAgCQkJcmV0dXJuOwo+
ICAgCQl9Cj4gLQo+IC0JCWlmIChpZmN2Zl9zdGFydF9kYXRhcGF0aChhZGFwdGVyKSA8IDApCj4g
LQkJCUlGQ1ZGX0VSUihhZGFwdGVyLT5wZGV2LAo+IC0JCQkJICAiRmFpbGVkIHRvIHNldCBpZmN2
ZiB2ZHBhICBzdGF0dXMgJXVcbiIsCj4gLQkJCQkgIHN0YXR1cyk7Cj4gICAJfQo+ICAgCj4gICAJ
aWZjdmZfc2V0X3N0YXR1cyh2Ziwgc3RhdHVzKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
