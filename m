Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08770C77B60
	for <virtualization@archiver.kernel.org>; Wed, 26 Apr 2023 04:02:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 824236136A;
	Wed, 26 Apr 2023 04:02:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 824236136A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZBE7NAZj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y6DM6nd2PMcu; Wed, 26 Apr 2023 04:02:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D7AED60A47;
	Wed, 26 Apr 2023 04:02:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D7AED60A47
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA66AC007C;
	Wed, 26 Apr 2023 04:02:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 350D5C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 04:02:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0964D41C22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 04:02:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0964D41C22
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZBE7NAZj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TEBnXXWmkk-3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 04:02:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBD6541C0B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBD6541C0B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 04:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682481741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vw69lNb1tc4oj+jSFrP/kIbcVwM05f3i2Codr93d7Ws=;
 b=ZBE7NAZj+YuqUZJtOOnWJUFJ1OGWOf+KDCk1BE4wf2XRG199+PxXqw9N3woFf3+ldncpBW
 UQJSgFZ11cLvR1KZj4ncGJbq0TJvzGggAZoLUjwOU1MLxCv3CLwUSWih7+z9vfbHOvLKBb
 MrvZ58NlKWxtLnWj86rmR295Q+7qaDc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-D4lF6wwBMUqYtG4WlVnXBg-1; Wed, 26 Apr 2023 00:02:16 -0400
X-MC-Unique: D4lF6wwBMUqYtG4WlVnXBg-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1a93b7975f3so61753535ad.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682481735; x=1685073735;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vw69lNb1tc4oj+jSFrP/kIbcVwM05f3i2Codr93d7Ws=;
 b=JsAYhbEwyBmRM+kH3KsbHSA8+k+100NkJH7jyR+AIDlMasG6y++UtgSf5OZTb9CTZe
 3yuuIdi6wIJI0+ODMmu5fwS9/XygGbbutWpAXwlLuekZYhiEG7vFSRbBNgUh19dWTlxe
 8iHraMxwM16jJSp09CnUE4CTOaMm9W88AhlngpDBzGlXs/fRJA0T3kMzoj0UsegpMvS1
 zVIP0RYCCXY4sHoMUgCHH0qx2hGN+0r6wKk/mhAIt/hqkC5xtdLnQpcPSGA6haYzIUOQ
 tI5UqxN9dT0p8amSLxn48gBwb9Mb/4VaU6GBgQ7uXOaMSIK9r+1P7djF1IaQLOuqRwUJ
 ymzQ==
X-Gm-Message-State: AAQBX9dAh5pw1oIepW4+8/bz8JUAo+xocZtbKP0mbUh6kw1GPDMcnRRG
 92MjMV0Y2yt4i4+zapeO7IVyBVNYEhfd/5IC56GeQg+lKAFuKWsK9tl9lqdZRPNEtC4AnMNtpsg
 RC0Tq8R0jbdCE+pBJqUwY97KxBaXCMuDeRCxXK/Dukg==
X-Received: by 2002:a17:902:ce88:b0:1a5:1586:7761 with SMTP id
 f8-20020a170902ce8800b001a515867761mr22950366plg.36.1682481735125; 
 Tue, 25 Apr 2023 21:02:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y7nqiXwfCzu4hzizf73FYliH0j4FMvAIuppS8C9SUCEPoy+v7mzNS6A4EmO2boo6FLjXloBg==
X-Received: by 2002:a17:902:ce88:b0:1a5:1586:7761 with SMTP id
 f8-20020a170902ce8800b001a515867761mr22950330plg.36.1682481734684; 
 Tue, 25 Apr 2023 21:02:14 -0700 (PDT)
Received: from [10.72.13.54] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 k23-20020a170902761700b001a9581d3ef5sm6217138pll.97.2023.04.25.21.02.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Apr 2023 21:02:14 -0700 (PDT)
Message-ID: <57ffdd27-ba11-4fec-487f-e63999ce7e93@redhat.com>
Date: Wed, 26 Apr 2023 12:02:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 2/5] get_driver_features from virito registers
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
 <20230331204854.20082-3-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230331204854.20082-3-lingshan.zhu@intel.com>
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

CuWcqCAyMDIzLzQvMSAwNDo0OCwgWmh1IExpbmdzaGFuIOWGmemBkzoKPiBUaGlzIGNvbW1pdCBp
bXBsZW1lbnRzIGEgbmV3IGZ1bmN0aW9uIGlmY3ZmX2dldF9kcml2ZXJfZmVhdHVyZSgpCj4gd2hp
Y2ggcmVhZCBkcml2ZXJfZmVhdHVyZXMgZnJvbSB2aXJ0aW8gcmVnaXN0ZXJzLgo+Cj4gVG8gYmUg
bGVzcyBhbWJpZ3VvdXMsIGlmY3ZmX3NldF9mZWF0dXJlcygpIGlzIHJlbmFtZWQgdG8KPiBpZmN2
Zl9zZXRfZHJpdmVyX2ZlYXR1cmVzKCksIGFuZCBpZmN2Zl9nZXRfZmVhdHVyZXMoKQo+IGlzIHJl
bmFtZWQgdG8gaWZjdmZfZ2V0X2Rldl9mZWF0dXJlcygpIHdoaWNoIHJldHVybnMKPiB0aGUgcHJv
dmlzaW9uZWQgdkRQQSBkZXZpY2UgZmVhdHVyZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGlu
Z3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5jIHwgMzggKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tCj4g
ICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHwgIDUgKysrLS0KPiAgIGRyaXZlcnMv
dmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgfCAgOSArKysrKy0tLQo+ICAgMyBmaWxlcyBjaGFuZ2Vk
LCAyOSBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jh
c2UuYwo+IGluZGV4IDZjNTY1MGY3MzAwNy4uNTQ2ZTkyM2JjZDE2IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfYmFzZS5jCj4gQEAgLTIwNCwxMSArMjA0LDI5IEBAIHU2NCBpZmN2Zl9nZXRfaHdfZmVh
dHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpodykKPiAgIAlyZXR1cm4gZmVhdHVyZXM7Cj4gICB9Cj4g
ICAKPiAtdTY0IGlmY3ZmX2dldF9mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+ICsvKiBy
ZXR1cm4gcHJvdmlzaW9uZWQgdkRQQSBkZXYgZmVhdHVyZXMgKi8KPiArdTY0IGlmY3ZmX2dldF9k
ZXZfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpodykKPiAgIHsKPiAgIAlyZXR1cm4gaHctPmRl
dl9mZWF0dXJlczsKPiAgIH0KPiAgIAo+ICt1NjQgaWZjdmZfZ2V0X2RyaXZlcl9mZWF0dXJlcyhz
dHJ1Y3QgaWZjdmZfaHcgKmh3KQo+ICt7Cj4gKwlzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2Zn
IF9faW9tZW0gKmNmZyA9IGh3LT5jb21tb25fY2ZnOwo+ICsJdTMyIGZlYXR1cmVzX2xvLCBmZWF0
dXJlc19oaTsKPiArCXU2NCBmZWF0dXJlczsKPiArCj4gKwl2cF9pb3dyaXRlMzIoMCwgJmNmZy0+
ZGV2aWNlX2ZlYXR1cmVfc2VsZWN0KTsKPiArCWZlYXR1cmVzX2xvID0gdnBfaW9yZWFkMzIoJmNm
Zy0+Z3Vlc3RfZmVhdHVyZSk7Cj4gKwo+ICsJdnBfaW93cml0ZTMyKDEsICZjZmctPmRldmljZV9m
ZWF0dXJlX3NlbGVjdCk7Cj4gKwlmZWF0dXJlc19oaSA9IHZwX2lvcmVhZDMyKCZjZmctPmd1ZXN0
X2ZlYXR1cmUpOwo+ICsKPiArCWZlYXR1cmVzID0gKCh1NjQpZmVhdHVyZXNfaGkgPDwgMzIpIHwg
ZmVhdHVyZXNfbG87Cj4gKwo+ICsJcmV0dXJuIGZlYXR1cmVzOwo+ICt9CgoKVGhpcyBkdXBsaWNh
dGVzIHdpdGggdGhlIGxvZ2ljIGlmY3ZmX2dldF9od19mZWF0dXJlcygpLCBpdCB3b3VsZCBiZSAK
c2ltcGxlciBpZiB3ZSBqdXN0IGRvIGEgcmVuYW1lLgoKVGhhbmtzCgoKPiArCj4gICBpbnQgaWZj
dmZfdmVyaWZ5X21pbl9mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1NjQgZmVhdHVyZXMp
Cj4gICB7Cj4gICAJaWYgKCEoZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX0FDQ0VTU19QTEFU
Rk9STSkpICYmIGZlYXR1cmVzKSB7Cj4gQEAgLTI3NSw3ICsyOTMsNyBAQCB2b2lkIGlmY3ZmX3dy
aXRlX2Rldl9jb25maWcoc3RydWN0IGlmY3ZmX2h3ICpodywgdTY0IG9mZnNldCwKPiAgIAkJdnBf
aW93cml0ZTgoKnArKywgaHctPmRldl9jZmcgKyBvZmZzZXQgKyBpKTsKPiAgIH0KPiAgIAo+IC1z
dGF0aWMgdm9pZCBpZmN2Zl9zZXRfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpodywgdTY0IGZl
YXR1cmVzKQo+ICt2b2lkIGlmY3ZmX3NldF9kcml2ZXJfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3
ICpodywgdTY0IGZlYXR1cmVzKQo+ICAgewo+ICAgCXN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9j
ZmcgX19pb21lbSAqY2ZnID0gaHctPmNvbW1vbl9jZmc7Cj4gICAKPiBAQCAtMjg2LDE5ICszMDQs
NiBAQCBzdGF0aWMgdm9pZCBpZmN2Zl9zZXRfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpodywg
dTY0IGZlYXR1cmVzKQo+ICAgCXZwX2lvd3JpdGUzMihmZWF0dXJlcyA+PiAzMiwgJmNmZy0+Z3Vl
c3RfZmVhdHVyZSk7Cj4gICB9Cj4gICAKPiAtc3RhdGljIGludCBpZmN2Zl9jb25maWdfZmVhdHVy
ZXMoc3RydWN0IGlmY3ZmX2h3ICpodykKPiAtewo+IC0JaWZjdmZfc2V0X2ZlYXR1cmVzKGh3LCBo
dy0+cmVxX2ZlYXR1cmVzKTsKPiAtCWlmY3ZmX2FkZF9zdGF0dXMoaHcsIFZJUlRJT19DT05GSUdf
U19GRUFUVVJFU19PSyk7Cj4gLQo+IC0JaWYgKCEoaWZjdmZfZ2V0X3N0YXR1cyhodykgJiBWSVJU
SU9fQ09ORklHX1NfRkVBVFVSRVNfT0spKSB7Cj4gLQkJSUZDVkZfRVJSKGh3LT5wZGV2LCAiRmFp
bGVkIHRvIHNldCBGRUFUVVJFU19PSyBzdGF0dXNcbiIpOwo+IC0JCXJldHVybiAtRUlPOwo+IC0J
fQo+IC0KPiAtCXJldHVybiAwOwo+IC19Cj4gLQo+ICAgdTE2IGlmY3ZmX2dldF92cV9zdGF0ZShz
dHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlkKQo+ICAgewo+ICAgCXN0cnVjdCBpZmN2Zl9sbV9j
ZmcgX19pb21lbSAqaWZjdmZfbG07Cj4gQEAgLTM4Nyw5ICszOTIsNiBAQCBpbnQgaWZjdmZfc3Rh
cnRfaHcoc3RydWN0IGlmY3ZmX2h3ICpodykKPiAgIAlpZmN2Zl9hZGRfc3RhdHVzKGh3LCBWSVJU
SU9fQ09ORklHX1NfQUNLTk9XTEVER0UpOwo+ICAgCWlmY3ZmX2FkZF9zdGF0dXMoaHcsIFZJUlRJ
T19DT05GSUdfU19EUklWRVIpOwo+ICAgCj4gLQlpZiAoaWZjdmZfY29uZmlnX2ZlYXR1cmVzKGh3
KSA8IDApCj4gLQkJcmV0dXJuIC1FSU5WQUw7Cj4gLQo+ICAgCWlmY3ZmX2FkZF9zdGF0dXMoaHcs
IFZJUlRJT19DT05GSUdfU19EUklWRVJfT0spOwo+ICAgCj4gICAJcmV0dXJuIDA7Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggYi9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5oCj4gaW5kZXggZDU0NWE5NDExMTQzLi5jYjE5MTk2YzNlY2UgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+ICsrKyBiL2RyaXZlcnMv
dmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiBAQCAtNjksNyArNjksNiBAQCBzdHJ1Y3QgaWZjdmZf
aHcgewo+ICAgCXBoeXNfYWRkcl90IG5vdGlmeV9iYXNlX3BhOwo+ICAgCXUzMiBub3RpZnlfb2Zm
X211bHRpcGxpZXI7Cj4gICAJdTMyIGRldl90eXBlOwo+IC0JdTY0IHJlcV9mZWF0dXJlczsKPiAg
IAl1NjQgaHdfZmVhdHVyZXM7Cj4gICAJLyogcHJvdmlzaW9uZWQgZGV2aWNlIGZlYXR1cmVzICov
Cj4gICAJdTY0IGRldl9mZWF0dXJlczsKPiBAQCAtMTIyLDcgKzEyMSw3IEBAIHU4IGlmY3ZmX2dl
dF9zdGF0dXMoc3RydWN0IGlmY3ZmX2h3ICpodyk7Cj4gICB2b2lkIGlmY3ZmX3NldF9zdGF0dXMo
c3RydWN0IGlmY3ZmX2h3ICpodywgdTggc3RhdHVzKTsKPiAgIHZvaWQgaW9fd3JpdGU2NF90d29w
YXJ0KHU2NCB2YWwsIHUzMiAqbG8sIHUzMiAqaGkpOwo+ICAgdm9pZCBpZmN2Zl9yZXNldChzdHJ1
Y3QgaWZjdmZfaHcgKmh3KTsKPiAtdTY0IGlmY3ZmX2dldF9mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZf
aHcgKmh3KTsKPiArdTY0IGlmY3ZmX2dldF9kZXZfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpo
dyk7Cj4gICB1NjQgaWZjdmZfZ2V0X2h3X2ZlYXR1cmVzKHN0cnVjdCBpZmN2Zl9odyAqaHcpOwo+
ICAgaW50IGlmY3ZmX3ZlcmlmeV9taW5fZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpodywgdTY0
IGZlYXR1cmVzKTsKPiAgIHUxNiBpZmN2Zl9nZXRfdnFfc3RhdGUoc3RydWN0IGlmY3ZmX2h3ICpo
dywgdTE2IHFpZCk7Cj4gQEAgLTEzNyw0ICsxMzYsNiBAQCBpbnQgaWZjdmZfc2V0X3ZxX2FkZHJl
c3Moc3RydWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCwgdTY0IGRlc2NfYXJlYSwKPiAgIAkJCSB1
NjQgZHJpdmVyX2FyZWEsIHU2NCBkZXZpY2VfYXJlYSk7Cj4gICBib29sIGlmY3ZmX2dldF92cV9y
ZWFkeShzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlkKTsKPiAgIHZvaWQgaWZjdmZfc2V0X3Zx
X3JlYWR5KHN0cnVjdCBpZmN2Zl9odyAqaHcsIHUxNiBxaWQsIGJvb2wgcmVhZHkpOwo+ICt2b2lk
IGlmY3ZmX3NldF9kcml2ZXJfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpodywgdTY0IGZlYXR1
cmVzKTsKPiArdTY0IGlmY3ZmX2dldF9kcml2ZXJfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpo
dyk7Cj4gICAjZW5kaWYgLyogX0lGQ1ZGX0hfICovCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9tYWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4g
aW5kZXggMTM1N2M2NzAxNGFiLi40NTg4NDg0YmQ1M2QgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9t
YWluLmMKPiBAQCAtNDEwLDcgKzQxMCw3IEBAIHN0YXRpYyB1NjQgaWZjdmZfdmRwYV9nZXRfZGV2
aWNlX2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4gICAJdTY0IGZlYXR1
cmVzOwo+ICAgCj4gICAJaWYgKHR5cGUgPT0gVklSVElPX0lEX05FVCB8fCB0eXBlID09IFZJUlRJ
T19JRF9CTE9DSykKPiAtCQlmZWF0dXJlcyA9IGlmY3ZmX2dldF9mZWF0dXJlcyh2Zik7Cj4gKwkJ
ZmVhdHVyZXMgPSBpZmN2Zl9nZXRfZGV2X2ZlYXR1cmVzKHZmKTsKPiAgIAllbHNlIHsKPiAgIAkJ
ZmVhdHVyZXMgPSAwOwo+ICAgCQlJRkNWRl9FUlIocGRldiwgIlZJUlRJTyBJRCAldSBub3Qgc3Vw
cG9ydGVkXG4iLCB2Zi0+ZGV2X3R5cGUpOwo+IEBAIC00MjgsNyArNDI4LDcgQEAgc3RhdGljIGlu
dCBpZmN2Zl92ZHBhX3NldF9kcml2ZXJfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBh
X2RldiwgdTY0IGZlYXQKPiAgIAlpZiAocmV0KQo+ICAgCQlyZXR1cm4gcmV0Owo+ICAgCj4gLQl2
Zi0+cmVxX2ZlYXR1cmVzID0gZmVhdHVyZXM7Cj4gKwlpZmN2Zl9zZXRfZHJpdmVyX2ZlYXR1cmVz
KHZmLCBmZWF0dXJlcyk7Cj4gICAKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiBAQCAtNDM2LDggKzQz
NiwxMSBAQCBzdGF0aWMgaW50IGlmY3ZmX3ZkcGFfc2V0X2RyaXZlcl9mZWF0dXJlcyhzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkcGFfZGV2LCB1NjQgZmVhdAo+ICAgc3RhdGljIHU2NCBpZmN2Zl92ZHBh
X2dldF9kcml2ZXJfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPiAgIHsK
PiAgIAlzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gdmRwYV90b192Zih2ZHBhX2Rldik7Cj4gKwl1NjQg
ZmVhdHVyZXM7Cj4gKwo+ICsJZmVhdHVyZXMgPSBpZmN2Zl9nZXRfZHJpdmVyX2ZlYXR1cmVzKHZm
KTsKPiAgIAo+IC0JcmV0dXJuIHZmLT5yZXFfZmVhdHVyZXM7Cj4gKwlyZXR1cm4gZmVhdHVyZXM7
Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB1OCBpZmN2Zl92ZHBhX2dldF9zdGF0dXMoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZHBhX2RldikKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
