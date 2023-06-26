Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6637EB64DC
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 02:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C662410C2;
	Mon, 26 Jun 2023 02:48:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C662410C2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R2BPbWIC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dp8lIgU1q35p; Mon, 26 Jun 2023 02:48:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2472540924;
	Mon, 26 Jun 2023 02:48:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2472540924
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C07EDC0037;
	Mon, 26 Jun 2023 02:48:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAF73C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72A6C40424
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:48:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 72A6C40424
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=R2BPbWIC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JjOwLoE4g7yj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:48:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7AE544012D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7AE544012D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687747731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGX8V7wP//0Jy+D9uCpEgBEFrpfgjmODJWMCXkMrcto=;
 b=R2BPbWICi0idYS/LOcWJClloWfjF67LJ9t5Huq8aX1WnpvqjGXalaw9KtnlOqI/wPrSCAl
 WcGEH8WSTQhYiZet9m8c/K8vMgU83h9uuZnzo6UYP3UtrXQEvEfvhh4V95Bd7rVvP6U1VV
 hVcHadTIyhQXEReDJfXzwTh7q8M9mBg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-l6Jr-8JgNa2-jd-_eNku9A-1; Sun, 25 Jun 2023 22:48:50 -0400
X-MC-Unique: l6Jr-8JgNa2-jd-_eNku9A-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f84a8b00e3so1810582e87.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 19:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687747728; x=1690339728;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qGX8V7wP//0Jy+D9uCpEgBEFrpfgjmODJWMCXkMrcto=;
 b=LBO39SI/WWmViRUD2P/O4Ma4FNgAXn6aYclWKg8nSDAxtttCEwIxcu3hzmPTVD9F0p
 ZVDw3o6IXW1NOTI6sOPWmtwVG9SWUtl5p58NXI3JLFLSYDQQh4pyx16Ja7741GotKFw4
 CKc0RUprBmIYi45QNLZf3mkjAO6htk23IalLISD1T7voHnZeEmNjnd+Cs8s3gTnFRVlD
 zMZv5CLTO8tH5qDHOi3tF2n4Vc2y4FcVIpxFAxYad2oWXpE8NIDtQYjg2vgaEQ4lcp+M
 iEOwN5X0GvfeiN/zZ0oq76ovks/QDz3ldvBQKGHidALNuzvIbhOEH21SXDOH9tM4uTMX
 UjLQ==
X-Gm-Message-State: AC+VfDxQdsH9SsjncRTDBRzS2hI+GN/QZlJ0YSK662vZVqXS8eiwPFqK
 5uWQALVbOkidi1p/QMODm/uTNJjxHvp16t9ZiBoAe8d3zJdvWexomT5yuhd9I2HIwEBmrmtxuVK
 ITF3dKdI46PL//7Gp3D7oBCpB/Z4IBROZv+qOGKWXhT8YDZKn1Nz6Ibn6uw==
X-Received: by 2002:a19:9156:0:b0:4f8:58af:ebd7 with SMTP id
 y22-20020a199156000000b004f858afebd7mr14767727lfj.39.1687747728613; 
 Sun, 25 Jun 2023 19:48:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5R2gH4eej5iSdfnXd/1eyvPvDbvokv7Qi5BVCApmGJUgjh9dDA0xyB2a68k4+B07qSKXCi549pknE9An8erqA=
X-Received: by 2002:a19:9156:0:b0:4f8:58af:ebd7 with SMTP id
 y22-20020a199156000000b004f858afebd7mr14767725lfj.39.1687747728320; Sun, 25
 Jun 2023 19:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230612151420.1019504-1-lingshan.zhu@intel.com>
 <20230612151420.1019504-4-lingshan.zhu@intel.com>
In-Reply-To: <20230612151420.1019504-4-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Jun 2023 10:48:36 +0800
Message-ID: <CACGkMEvteTiPe1b8_h-yxr64Rt_VHAWUoFfcL35Xkv3qOHOMoA@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] vDPA/ifcvf: implement new accessors for vq_state
To: Zhu Lingshan <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
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

T24gTW9uLCBKdW4gMTIsIDIwMjMgYXQgMzoxNOKAr1BNIFpodSBMaW5nc2hhbiA8bGluZ3NoYW4u
emh1QGludGVsLmNvbT4gd3JvdGU6Cj4KPiBUaGlzIGNvbW1pdCBpbXBsZW1lbnRzIGEgYmV0dGVy
IGxheW91dCBvZiB0aGUKPiBsaXZlIG1pZ3JhdGlvbiBiYXIsIHRoZXJlZm9yZSB0aGUgYWNjZXNz
b3JzIGZvciB2aXJ0cXVldWUKPiBzdGF0ZSBoYXZlIGJlZW4gcmVmYWN0b3JlZC4KCkkgZ3Vlc3Mg
dGhlIHJlYXNvbiBmb3IgRjIwMDBYIGlzIHRoYXQgaXQgY2FuIHJlcG9ydCBhICN2cSB3aGljaCBp
cwpncmVhdGVyIHRoYW4gSUZDVkZfTUFYX1FVRVVFUy4gSWYgeWVzLCBsZXQncyBleHBsYWluIGl0
IGluIHRoZQpjaGFuZ2Vsb2cuCgpUaGFua3MKCgo+Cj4gVGhpcyBjb21taXQgYWxzbyBhZGQgYSBj
b21tZW50IHRvIHRoZSBwcm9iaW5nLWlkcyBsaXN0LAo+IGluZGljYXRpbmcgdGhpcyBkcml2ZXIg
ZHJpdmVzIEYyMDAwWC1QTCB2aXJ0aW8tbmV0Cj4KPiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3No
YW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9iYXNlLmMgfCAyMSArKysrKy0tLS0tLS0tLS0tLS0tLS0KPiAgZHJpdmVycy92ZHBhL2lm
Y3ZmL2lmY3ZmX2Jhc2UuaCB8IDI1ICsrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KPiAgZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8ICA0ICsrKy0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAx
NyBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2Uu
Ywo+IGluZGV4IGY0ZDdkOTZjNGM4Ni4uMDYwZjgzN2E0ZjlmIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZj
dmZfYmFzZS5jCj4gQEAgLTMyOCwzMCArMzI4LDE5IEBAIHZvaWQgaWZjdmZfc2V0X2RyaXZlcl9m
ZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1NjQgZmVhdHVyZXMpCj4KPiAgdTE2IGlmY3Zm
X2dldF92cV9zdGF0ZShzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlkKQo+ICB7Cj4gLSAgICAg
ICBzdHJ1Y3QgaWZjdmZfbG1fY2ZnIF9faW9tZW0gKmlmY3ZmX2xtOwo+IC0gICAgICAgdm9pZCBf
X2lvbWVtICphdmFpbF9pZHhfYWRkcjsKPiArICAgICAgIHN0cnVjdCBpZmN2Zl9sbV9jZmcgIF9f
aW9tZW0gKmxtX2NmZyA9IGh3LT5sbV9jZmc7Cj4gICAgICAgICB1MTYgbGFzdF9hdmFpbF9pZHg7
Cj4gLSAgICAgICB1MzIgcV9wYWlyX2lkOwo+Cj4gLSAgICAgICBpZmN2Zl9sbSA9IChzdHJ1Y3Qg
aWZjdmZfbG1fY2ZnIF9faW9tZW0gKilody0+bG1fY2ZnOwo+IC0gICAgICAgcV9wYWlyX2lkID0g
cWlkIC8gMjsKPiAtICAgICAgIGF2YWlsX2lkeF9hZGRyID0gJmlmY3ZmX2xtLT52cmluZ19sbV9j
ZmdbcV9wYWlyX2lkXS5pZHhfYWRkcltxaWQgJSAyXTsKPiAtICAgICAgIGxhc3RfYXZhaWxfaWR4
ID0gdnBfaW9yZWFkMTYoYXZhaWxfaWR4X2FkZHIpOwo+ICsgICAgICAgbGFzdF9hdmFpbF9pZHgg
PSB2cF9pb3JlYWQxNigmbG1fY2ZnLT52cV9zdGF0ZV9yZWdpb24gKyBxaWQgKiAyKTsKPgo+ICAg
ICAgICAgcmV0dXJuIGxhc3RfYXZhaWxfaWR4Owo+ICB9Cj4KPiAgaW50IGlmY3ZmX3NldF92cV9z
dGF0ZShzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlkLCB1MTYgbnVtKQo+ICB7Cj4gLSAgICAg
ICBzdHJ1Y3QgaWZjdmZfbG1fY2ZnIF9faW9tZW0gKmlmY3ZmX2xtOwo+IC0gICAgICAgdm9pZCBf
X2lvbWVtICphdmFpbF9pZHhfYWRkcjsKPiAtICAgICAgIHUzMiBxX3BhaXJfaWQ7Cj4gLQo+IC0g
ICAgICAgaWZjdmZfbG0gPSAoc3RydWN0IGlmY3ZmX2xtX2NmZyBfX2lvbWVtICopaHctPmxtX2Nm
ZzsKPiAtICAgICAgIHFfcGFpcl9pZCA9IHFpZCAvIDI7Cj4gLSAgICAgICBhdmFpbF9pZHhfYWRk
ciA9ICZpZmN2Zl9sbS0+dnJpbmdfbG1fY2ZnW3FfcGFpcl9pZF0uaWR4X2FkZHJbcWlkICUgMl07
Cj4gLSAgICAgICBody0+dnJpbmdbcWlkXS5sYXN0X2F2YWlsX2lkeCA9IG51bTsKPiAtICAgICAg
IHZwX2lvd3JpdGUxNihudW0sIGF2YWlsX2lkeF9hZGRyKTsKPiArICAgICAgIHN0cnVjdCBpZmN2
Zl9sbV9jZmcgIF9faW9tZW0gKmxtX2NmZyA9IGh3LT5sbV9jZmc7Cj4gKwo+ICsgICAgICAgdnBf
aW93cml0ZTE2KG51bSwgJmxtX2NmZy0+dnFfc3RhdGVfcmVnaW9uICsgcWlkICogMik7Cj4KPiAg
ICAgICAgIHJldHVybiAwOwo+ICB9Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9iYXNlLmggYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gaW5kZXggMzA5
MzVhOTViNjcyLi5iNTc4NDljNjQzZjYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3Zm
L2lmY3ZmX2Jhc2UuaAo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiBA
QCAtMjQsMTQgKzI0LDkgQEAKPiAgI2RlZmluZSBOMzAwMF9ERVZJQ0VfSUQgICAgICAgICAgICAg
ICAgMHgxMDQxCj4gICNkZWZpbmUgTjMwMDBfU1VCU1lTX0RFVklDRV9JRCAweDAwMUEKPgo+IC0v
KiBNYXggOCBkYXRhIHF1ZXVlIHBhaXJzKDE2IHF1ZXVlcykgYW5kIG9uZSBjb250cm9sIHZxIGZv
ciBub3cuICovCj4gLSNkZWZpbmUgSUZDVkZfTUFYX1FVRVVFUyAgICAgICAxNwo+IC0KPiAgI2Rl
ZmluZSBJRkNWRl9RVUVVRV9BTElHTk1FTlQgIFBBR0VfU0laRQo+ICAjZGVmaW5lIElGQ1ZGX1BD
SV9NQVhfUkVTT1VSQ0UgNgo+Cj4gLSNkZWZpbmUgSUZDVkZfTE1fQ0ZHX1NJWkUgICAgICAgICAg
ICAgIDB4NDAKPiAtI2RlZmluZSBJRkNWRl9MTV9SSU5HX1NUQVRFX09GRlNFVCAgICAgMHgyMAo+
ICAjZGVmaW5lIElGQ1ZGX0xNX0JBUiAgICAgICAgICAgICAgICAgICA0Cj4KPiAgI2RlZmluZSBJ
RkNWRl9FUlIocGRldiwgZm10LCAuLi4pICAgICAgZGV2X2VycigmcGRldi0+ZGV2LCBmbXQsICMj
X19WQV9BUkdTX18pCj4gQEAgLTU0LDEwICs0OSwxOCBAQCBzdHJ1Y3QgdnJpbmdfaW5mbyB7Cj4g
ICAgICAgICBjaGFyIG1zaXhfbmFtZVsyNTZdOwo+ICB9Owo+Cj4gK3N0cnVjdCBpZmN2Zl9sbV9j
Zmcgewo+ICsgICAgICAgX19sZTY0IGNvbnRyb2w7Cj4gKyAgICAgICBfX2xlNjQgc3RhdHVzOwo+
ICsgICAgICAgX19sZTY0IGxtX21lbV9sb2dfc3RhcnRfYWRkcjsKPiArICAgICAgIF9fbGU2NCBs
bV9tZW1fbG9nX2VuZF9hZGRyOwo+ICsgICAgICAgX19sZTE2IHZxX3N0YXRlX3JlZ2lvbjsKPiAr
fTsKPiArCj4gIHN0cnVjdCBpZmN2Zl9odyB7Cj4gICAgICAgICB1OCBfX2lvbWVtICppc3I7Cj4g
ICAgICAgICAvKiBMaXZlIG1pZ3JhdGlvbiAqLwo+IC0gICAgICAgdTggX19pb21lbSAqbG1fY2Zn
Owo+ICsgICAgICAgc3RydWN0IGlmY3ZmX2xtX2NmZyAgX19pb21lbSAqbG1fY2ZnOwo+ICAgICAg
ICAgLyogTm90aWZpY2F0aW9uIGJhciBudW1iZXIgKi8KPiAgICAgICAgIHU4IG5vdGlmeV9iYXI7
Cj4gICAgICAgICB1OCBtc2l4X3ZlY3Rvcl9zdGF0dXM7Cj4gQEAgLTkyLDE2ICs5NSw2IEBAIHN0
cnVjdCBpZmN2Zl9hZGFwdGVyIHsKPiAgICAgICAgIHN0cnVjdCBpZmN2Zl9odyAqdmY7Cj4gIH07
Cj4KPiAtc3RydWN0IGlmY3ZmX3ZyaW5nX2xtX2NmZyB7Cj4gLSAgICAgICB1MzIgaWR4X2FkZHJb
Ml07Cj4gLSAgICAgICB1OCByZXNlcnZlZFtJRkNWRl9MTV9DRkdfU0laRSAtIDhdOwo+IC19Owo+
IC0KPiAtc3RydWN0IGlmY3ZmX2xtX2NmZyB7Cj4gLSAgICAgICB1OCByZXNlcnZlZFtJRkNWRl9M
TV9SSU5HX1NUQVRFX09GRlNFVF07Cj4gLSAgICAgICBzdHJ1Y3QgaWZjdmZfdnJpbmdfbG1fY2Zn
IHZyaW5nX2xtX2NmZ1tJRkNWRl9NQVhfUVVFVUVTXTsKPiAtfTsKPiAtCj4gIHN0cnVjdCBpZmN2
Zl92ZHBhX21nbXRfZGV2IHsKPiAgICAgICAgIHN0cnVjdCB2ZHBhX21nbXRfZGV2IG1kZXY7Cj4g
ICAgICAgICBzdHJ1Y3QgaWZjdmZfaHcgdmY7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9p
ZmN2Zi9pZmN2Zl9tYWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gaW5k
ZXggYzNlY2UzOTVjYWY3Li5lOThmYTgxMDBmM2MgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX21haW4uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWlu
LmMKPiBAQCAtODUzLDcgKzg1Myw5IEBAIHN0YXRpYyBzdHJ1Y3QgcGNpX2RldmljZV9pZCBpZmN2
Zl9wY2lfaWRzW10gPSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgIE4zMDAwX0RFVklDRV9J
RCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgUENJX1ZFTkRPUl9JRF9JTlRFTCwKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgTjMwMDBfU1VCU1lTX0RFVklDRV9JRCkgfSwKPiAtICAgICAg
IC8qIEM1MDAwWC1QTCBuZXR3b3JrIGRldmljZSAqLwo+ICsgICAgICAgLyogQzUwMDBYLVBMIG5l
dHdvcmsgZGV2aWNlCj4gKyAgICAgICAgKiBGMjAwMFgtUEwgbmV0d29yayBkZXZpY2UKPiArICAg
ICAgICAqLwo+ICAgICAgICAgeyBQQ0lfREVWSUNFX1NVQihQQ0lfVkVORE9SX0lEX1JFREhBVF9R
VU1SQU5FVCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgVklSVElPX1RSQU5TX0lEX05FVCwK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgUENJX1ZFTkRPUl9JRF9JTlRFTCwKPiAtLQo+IDIu
MzkuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
