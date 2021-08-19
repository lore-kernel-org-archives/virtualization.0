Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBF2C4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 04:09:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E235E610FE
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 04:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E235E610FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE0C680B20;
	Thu, 19 Aug 2021 04:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pwHutvSqNQl6; Thu, 19 Aug 2021 04:09:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 597A480AE0;
	Thu, 19 Aug 2021 04:09:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3001BC0010;
	Thu, 19 Aug 2021 04:09:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72435C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 04:09:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60639401E3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 04:09:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vm7mBxKJhXAX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 04:09:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51D9040184
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 04:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629346170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=845M9dCu0BBwxxguLiM0h6US9TVl5Oo1nvahLbWOs4I=;
 b=MfZTzKHcRpTxMKgdW+9U+9pXM0xPJIQ7GmwG5fDthd6C6kNFYS/98polsqFPbFeosp7eIw
 FWJ6hg6fYQbtLVvU9C9OvLCYVpbs9FqVh0gbOCdbXQyuKBzXyPmhVHoSWdQEisjGTAztST
 74wzG0t/xOLRANOJmi1nj1Mz2+/HPEs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-KVa27F5nNYSyyqIrkqwqUQ-1; Thu, 19 Aug 2021 00:09:28 -0400
X-MC-Unique: KVa27F5nNYSyyqIrkqwqUQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 q15-20020a056a0002af00b003e2840527ceso2425999pfs.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 21:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=845M9dCu0BBwxxguLiM0h6US9TVl5Oo1nvahLbWOs4I=;
 b=RXCqi63NyNRviJQ9CC2ssRi2a+QofLGoOifL17lFEzxHYlik2LclyquiaU40g7D/jx
 0KMg/+K6Yp11W5npBfwlliI0prqTmcoT+tzPIB7NYdxFujIc1lUdlkVxu1kNEXpv3e9Z
 mjzptXX9Xy0N1EFw4XYKjBNryfbtNp6yDH2h4Ag6o7ovLh3PskJJnoqUF51mAHNpjsv5
 1t9l3g2GW1iDYdL+1u/8q6XjCNHxZXfxbRwj2zwVlfIjry4CdmsrhPlKdniTMn+tCEHw
 9Q7kKST7TajYD3Qb3G7PWWCmtPrBmrrAsClczM8ur4DFWlWe+hvBRd6DRvZnrwSa9C37
 Xvlg==
X-Gm-Message-State: AOAM533+9LqYF5hOYfd3XGj/pQ2+wugmk3LJxtD/gdX+lFuiffxRNEsp
 5OPncvHHi3tKiwmVRcz95or08D1ymnLcE1mRUi+84yO5f+174KbrXjTu+hwi0yNN2/JTO/JSwd0
 tfxPHmobkRAjCYZ0YgeNRTLNEQymEgL1BiS0sfIo1nw==
X-Received: by 2002:a65:51c7:: with SMTP id i7mr11985373pgq.300.1629346167408; 
 Wed, 18 Aug 2021 21:09:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdDjel8iMgCuyVB7vKLugcmk5D1NVeufi9kRNTtKpFwx5blvUXV+sVKfFzR0MS5E4wBrhB6A==
X-Received: by 2002:a65:51c7:: with SMTP id i7mr11985360pgq.300.1629346167179; 
 Wed, 18 Aug 2021 21:09:27 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p34sm1355587pfh.172.2021.08.18.21.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Aug 2021 21:09:26 -0700 (PDT)
Subject: Re: [PATCH 1/2] vDPA/ifcvf: detect and use the onboard number of
 queues directly
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20210818095714.3220-1-lingshan.zhu@intel.com>
 <20210818095714.3220-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <78c25559-0423-7ef6-9cdd-d2b81df111ca@redhat.com>
Date: Thu, 19 Aug 2021 12:09:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818095714.3220-2-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvOC8xOCDPws7nNTo1NywgWmh1IExpbmdzaGFuINC0tcA6Cj4gVG8gZW5hYmxlIHRo
aXMgbXVsdGktcXVldWUgZmVhdHVyZSBmb3IgaWZjdmYsIHRoaXMgY29tbWl0Cj4gaW50ZW5kcyB0
byBkZXRlY3QgYW5kIHVzZSB0aGUgb25ib2FyZCBudW1iZXIgb2YgcXVldWVzCj4gZGlyZWN0bHkg
dGhhbiBJRkNWRl9NQVhfUVVFVUVfUEFJUlMgPSAxIChyZW1vdmVkKQo+Cj4gU2lnbmVkLW9mZi1i
eTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+IC0tLQo+ICAgZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyB8ICA4ICsrKysrLS0tCj4gICBkcml2ZXJzL3ZkcGEv
aWZjdmYvaWZjdmZfYmFzZS5oIHwgMTAgKysrKy0tLS0tLQo+ICAgZHJpdmVycy92ZHBhL2lmY3Zm
L2lmY3ZmX21haW4uYyB8IDIxICsrKysrKysrKysrKy0tLS0tLS0tLQo+ICAgMyBmaWxlcyBjaGFu
Z2VkLCAyMSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3Zm
X2Jhc2UuYwo+IGluZGV4IDZlMTk3ZmUwZmNmOS4uMjgwOGYxYmE5ZjdiIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5jCj4gQEAgLTE1OCw3ICsxNTgsOSBAQCBpbnQgaWZjdmZfaW5pdF9odyhz
dHJ1Y3QgaWZjdmZfaHcgKmh3LCBzdHJ1Y3QgcGNpX2RldiAqcGRldikKPiAgIAkJcmV0dXJuIC1F
SU87Cj4gICAJfQo+ICAgCj4gLQlmb3IgKGkgPSAwOyBpIDwgSUZDVkZfTUFYX1FVRVVFX1BBSVJT
ICogMjsgaSsrKSB7Cj4gKwlody0+bnJfdnJpbmcgPSBpZmNfaW9yZWFkMTYoJmh3LT5jb21tb25f
Y2ZnLT5udW1fcXVldWVzKTsKPiArCj4gKwlmb3IgKGkgPSAwOyBpIDwgaHctPm5yX3ZyaW5nOyBp
KyspIHsKPiAgIAkJaWZjX2lvd3JpdGUxNihpLCAmaHctPmNvbW1vbl9jZmctPnF1ZXVlX3NlbGVj
dCk7Cj4gICAJCW5vdGlmeV9vZmYgPSBpZmNfaW9yZWFkMTYoJmh3LT5jb21tb25fY2ZnLT5xdWV1
ZV9ub3RpZnlfb2ZmKTsKPiAgIAkJaHctPnZyaW5nW2ldLm5vdGlmeV9hZGRyID0gaHctPm5vdGlm
eV9iYXNlICsKPiBAQCAtMzA0LDcgKzMwNiw3IEBAIHUxNiBpZmN2Zl9nZXRfdnFfc3RhdGUoc3Ry
dWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCkKPiAgIAl1MzIgcV9wYWlyX2lkOwo+ICAgCj4gICAJ
aWZjdmZfbG0gPSAoc3RydWN0IGlmY3ZmX2xtX2NmZyBfX2lvbWVtICopaHctPmxtX2NmZzsKPiAt
CXFfcGFpcl9pZCA9IHFpZCAvIChJRkNWRl9NQVhfUVVFVUVfUEFJUlMgKiAyKTsKPiArCXFfcGFp
cl9pZCA9IHFpZCAvIGh3LT5ucl92cmluZzsKPiAgIAlhdmFpbF9pZHhfYWRkciA9ICZpZmN2Zl9s
bS0+dnJpbmdfbG1fY2ZnW3FfcGFpcl9pZF0uaWR4X2FkZHJbcWlkICUgMl07Cj4gICAJbGFzdF9h
dmFpbF9pZHggPSBpZmNfaW9yZWFkMTYoYXZhaWxfaWR4X2FkZHIpOwo+ICAgCj4gQEAgLTMxOCw3
ICszMjAsNyBAQCBpbnQgaWZjdmZfc2V0X3ZxX3N0YXRlKHN0cnVjdCBpZmN2Zl9odyAqaHcsIHUx
NiBxaWQsIHUxNiBudW0pCj4gICAJdTMyIHFfcGFpcl9pZDsKPiAgIAo+ICAgCWlmY3ZmX2xtID0g
KHN0cnVjdCBpZmN2Zl9sbV9jZmcgX19pb21lbSAqKWh3LT5sbV9jZmc7Cj4gLQlxX3BhaXJfaWQg
PSBxaWQgLyAoSUZDVkZfTUFYX1FVRVVFX1BBSVJTICogMik7Cj4gKwlxX3BhaXJfaWQgPSBxaWQg
LyBody0+bnJfdnJpbmc7Cj4gICAJYXZhaWxfaWR4X2FkZHIgPSAmaWZjdmZfbG0tPnZyaW5nX2xt
X2NmZ1txX3BhaXJfaWRdLmlkeF9hZGRyW3FpZCAlIDJdOwo+ICAgCWh3LT52cmluZ1txaWRdLmxh
c3RfYXZhaWxfaWR4ID0gbnVtOwo+ICAgCWlmY19pb3dyaXRlMTYobnVtLCBhdmFpbF9pZHhfYWRk
cik7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggYi9kcml2
ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gaW5kZXggMTYwMWU4Nzg3MGRhLi45N2Q5MDE5
YTNlYzAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+ICsr
KyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiBAQCAtMzEsOCArMzEsOCBAQAo+
ICAgCQkgKDFVTEwgPDwgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNKQkJfCBcCj4gICAJCSAoMVVM
TCA8PCBWSVJUSU9fTkVUX0ZfTVJHX1JYQlVGKSkKPiAgIAo+IC0vKiBPbmx5IG9uZSBxdWV1ZSBw
YWlyIGZvciBub3cuICovCj4gLSNkZWZpbmUgSUZDVkZfTUFYX1FVRVVFX1BBSVJTCTEKPiArLyog
TWF4IDggZGF0YSBxdWV1ZSBwYWlycygxNiBxdWV1ZXMpIGFuZCBvbmUgY29udHJvbCB2cSBmb3Ig
bm93LiAqLwo+ICsjZGVmaW5lIElGQ1ZGX01BWF9RVUVVRVMJMTcKCgpXaGlsZSBhdCBpdCwgSSB3
b25kZXIgaWYgd2UgY2FuIGdldCByaWQgb2YgdGhpcy4KCk90aGVyIHRoYW4gdGhpcywKCkFja2Vk
LWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gICAKPiAgICNkZWZpbmUg
SUZDVkZfUVVFVUVfQUxJR05NRU5UCVBBR0VfU0laRQo+ICAgI2RlZmluZSBJRkNWRl9RVUVVRV9N
QVgJCTMyNzY4Cj4gQEAgLTUxLDggKzUxLDYgQEAKPiAgICNkZWZpbmUgaWZjdmZfcHJpdmF0ZV90
b192ZihhZGFwdGVyKSBcCj4gICAJKCYoKHN0cnVjdCBpZmN2Zl9hZGFwdGVyICopYWRhcHRlcikt
PnZmKQo+ICAgCj4gLSNkZWZpbmUgSUZDVkZfTUFYX0lOVFIgKElGQ1ZGX01BWF9RVUVVRV9QQUlS
UyAqIDIgKyAxKQo+IC0KPiAgIHN0cnVjdCB2cmluZ19pbmZvIHsKPiAgIAl1NjQgZGVzYzsKPiAg
IAl1NjQgYXZhaWw7Cj4gQEAgLTgzLDcgKzgxLDcgQEAgc3RydWN0IGlmY3ZmX2h3IHsKPiAgIAl1
MzIgZGV2X3R5cGU7Cj4gICAJc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyBfX2lvbWVtICpj
b21tb25fY2ZnOwo+ICAgCXZvaWQgX19pb21lbSAqbmV0X2NmZzsKPiAtCXN0cnVjdCB2cmluZ19p
bmZvIHZyaW5nW0lGQ1ZGX01BWF9RVUVVRV9QQUlSUyAqIDJdOwo+ICsJc3RydWN0IHZyaW5nX2lu
Zm8gdnJpbmdbSUZDVkZfTUFYX1FVRVVFU107Cj4gICAJdm9pZCBfX2lvbWVtICogY29uc3QgKmJh
c2U7Cj4gICAJY2hhciBjb25maWdfbXNpeF9uYW1lWzI1Nl07Cj4gICAJc3RydWN0IHZkcGFfY2Fs
bGJhY2sgY29uZmlnX2NiOwo+IEBAIC0xMDMsNyArMTAxLDcgQEAgc3RydWN0IGlmY3ZmX3ZyaW5n
X2xtX2NmZyB7Cj4gICAKPiAgIHN0cnVjdCBpZmN2Zl9sbV9jZmcgewo+ICAgCXU4IHJlc2VydmVk
W0lGQ1ZGX0xNX1JJTkdfU1RBVEVfT0ZGU0VUXTsKPiAtCXN0cnVjdCBpZmN2Zl92cmluZ19sbV9j
ZmcgdnJpbmdfbG1fY2ZnW0lGQ1ZGX01BWF9RVUVVRV9QQUlSU107Cj4gKwlzdHJ1Y3QgaWZjdmZf
dnJpbmdfbG1fY2ZnIHZyaW5nX2xtX2NmZ1tJRkNWRl9NQVhfUVVFVUVTXTsKPiAgIH07Cj4gICAK
PiAgIHN0cnVjdCBpZmN2Zl92ZHBhX21nbXRfZGV2IHsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMK
PiBpbmRleCA0YjYyMzI1M2Y0NjAuLmUzNGMyZWMyYjY5YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3Zm
X21haW4uYwo+IEBAIC02Myw5ICs2MywxMyBAQCBzdGF0aWMgaW50IGlmY3ZmX3JlcXVlc3RfaXJx
KHN0cnVjdCBpZmN2Zl9hZGFwdGVyICphZGFwdGVyKQo+ICAgCXN0cnVjdCBwY2lfZGV2ICpwZGV2
ID0gYWRhcHRlci0+cGRldjsKPiAgIAlzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gJmFkYXB0ZXItPnZm
Owo+ICAgCWludCB2ZWN0b3IsIGksIHJldCwgaXJxOwo+ICsJdTE2IG1heF9pbnRyOwo+ICAgCj4g
LQlyZXQgPSBwY2lfYWxsb2NfaXJxX3ZlY3RvcnMocGRldiwgSUZDVkZfTUFYX0lOVFIsCj4gLQkJ
CQkgICAgSUZDVkZfTUFYX0lOVFIsIFBDSV9JUlFfTVNJWCk7Cj4gKwkvKiBhbGwgcXVldWVzIGFu
ZCBjb25maWcgaW50ZXJydXB0ICAqLwo+ICsJbWF4X2ludHIgPSB2Zi0+bnJfdnJpbmcgKyAxOwo+
ICsKPiArCXJldCA9IHBjaV9hbGxvY19pcnFfdmVjdG9ycyhwZGV2LCBtYXhfaW50ciwKPiArCQkJ
CSAgICBtYXhfaW50ciwgUENJX0lSUV9NU0lYKTsKPiAgIAlpZiAocmV0IDwgMCkgewo+ICAgCQlJ
RkNWRl9FUlIocGRldiwgIkZhaWxlZCB0byBhbGxvYyBJUlEgdmVjdG9yc1xuIik7Cj4gICAJCXJl
dHVybiByZXQ7Cj4gQEAgLTgzLDcgKzg3LDcgQEAgc3RhdGljIGludCBpZmN2Zl9yZXF1ZXN0X2ly
cShzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqYWRhcHRlcikKPiAgIAkJcmV0dXJuIHJldDsKPiAgIAl9
Cj4gICAKPiAtCWZvciAoaSA9IDA7IGkgPCBJRkNWRl9NQVhfUVVFVUVfUEFJUlMgKiAyOyBpKysp
IHsKPiArCWZvciAoaSA9IDA7IGkgPCB2Zi0+bnJfdnJpbmc7IGkrKykgewo+ICAgCQlzbnByaW50
Zih2Zi0+dnJpbmdbaV0ubXNpeF9uYW1lLCAyNTYsICJpZmN2Zlslc10tJWRcbiIsCj4gICAJCQkg
cGNpX25hbWUocGRldiksIGkpOwo+ICAgCQl2ZWN0b3IgPSBpICsgSUZDVkZfTVNJX1FVRVVFX09G
RjsKPiBAQCAtMTEyLDcgKzExNiw2IEBAIHN0YXRpYyBpbnQgaWZjdmZfc3RhcnRfZGF0YXBhdGgo
dm9pZCAqcHJpdmF0ZSkKPiAgIAl1OCBzdGF0dXM7Cj4gICAJaW50IHJldDsKPiAgIAo+IC0JdmYt
Pm5yX3ZyaW5nID0gSUZDVkZfTUFYX1FVRVVFX1BBSVJTICogMjsKPiAgIAlyZXQgPSBpZmN2Zl9z
dGFydF9odyh2Zik7Cj4gICAJaWYgKHJldCA8IDApIHsKPiAgIAkJc3RhdHVzID0gaWZjdmZfZ2V0
X3N0YXR1cyh2Zik7Cj4gQEAgLTEyOCw3ICsxMzEsNyBAQCBzdGF0aWMgaW50IGlmY3ZmX3N0b3Bf
ZGF0YXBhdGgodm9pZCAqcHJpdmF0ZSkKPiAgIAlzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gaWZjdmZf
cHJpdmF0ZV90b192Zihwcml2YXRlKTsKPiAgIAlpbnQgaTsKPiAgIAo+IC0JZm9yIChpID0gMDsg
aSA8IElGQ1ZGX01BWF9RVUVVRV9QQUlSUyAqIDI7IGkrKykKPiArCWZvciAoaSA9IDA7IGkgPCB2
Zi0+bnJfdnJpbmc7IGkrKykKPiAgIAkJdmYtPnZyaW5nW2ldLmNiLmNhbGxiYWNrID0gTlVMTDsK
PiAgIAo+ICAgCWlmY3ZmX3N0b3BfaHcodmYpOwo+IEBAIC0xNDEsNyArMTQ0LDcgQEAgc3RhdGlj
IHZvaWQgaWZjdmZfcmVzZXRfdnJpbmcoc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXIpCj4g
ICAJc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IGlmY3ZmX3ByaXZhdGVfdG9fdmYoYWRhcHRlcik7Cj4g
ICAJaW50IGk7Cj4gICAKPiAtCWZvciAoaSA9IDA7IGkgPCBJRkNWRl9NQVhfUVVFVUVfUEFJUlMg
KiAyOyBpKyspIHsKPiArCWZvciAoaSA9IDA7IGkgPCB2Zi0+bnJfdnJpbmc7IGkrKykgewo+ICAg
CQl2Zi0+dnJpbmdbaV0ubGFzdF9hdmFpbF9pZHggPSAwOwo+ICAgCQl2Zi0+dnJpbmdbaV0uZGVz
YyA9IDA7Cj4gICAJCXZmLT52cmluZ1tpXS5hdmFpbCA9IDA7Cj4gQEAgLTIyNyw3ICsyMzAsNyBA
QCBzdGF0aWMgdm9pZCBpZmN2Zl92ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZHBhX2RldiwgdTggc3RhdHVzKQo+ICAgCWlmICgoc3RhdHVzX29sZCAmIFZJUlRJT19DT05GSUdf
U19EUklWRVJfT0spICYmCj4gICAJICAgICEoc3RhdHVzICYgVklSVElPX0NPTkZJR19TX0RSSVZF
Ul9PSykpIHsKPiAgIAkJaWZjdmZfc3RvcF9kYXRhcGF0aChhZGFwdGVyKTsKPiAtCQlpZmN2Zl9m
cmVlX2lycShhZGFwdGVyLCBJRkNWRl9NQVhfUVVFVUVfUEFJUlMgKiAyKTsKPiArCQlpZmN2Zl9m
cmVlX2lycShhZGFwdGVyLCB2Zi0+bnJfdnJpbmcpOwo+ICAgCX0KPiAgIAo+ICAgCWlmIChzdGF0
dXMgPT0gMCkgewo+IEBAIC01MjYsMTMgKzUyOSwxMyBAQCBzdGF0aWMgaW50IGlmY3ZmX3ZkcGFf
ZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRldiwgY29uc3QgY2hhciAqbmFtZSkKPiAg
IAkJZ290byBlcnI7Cj4gICAJfQo+ICAgCj4gLQlmb3IgKGkgPSAwOyBpIDwgSUZDVkZfTUFYX1FV
RVVFX1BBSVJTICogMjsgaSsrKQo+ICsJZm9yIChpID0gMDsgaSA8IHZmLT5ucl92cmluZzsgaSsr
KQo+ICAgCQl2Zi0+dnJpbmdbaV0uaXJxID0gLUVJTlZBTDsKPiAgIAo+ICAgCXZmLT5od19mZWF0
dXJlcyA9IGlmY3ZmX2dldF9od19mZWF0dXJlcyh2Zik7Cj4gICAKPiAgIAlhZGFwdGVyLT52ZHBh
Lm1kZXYgPSAmaWZjdmZfbWdtdF9kZXYtPm1kZXY7Cj4gLQlyZXQgPSBfdmRwYV9yZWdpc3Rlcl9k
ZXZpY2UoJmFkYXB0ZXItPnZkcGEsIElGQ1ZGX01BWF9RVUVVRV9QQUlSUyAqIDIpOwo+ICsJcmV0
ID0gX3ZkcGFfcmVnaXN0ZXJfZGV2aWNlKCZhZGFwdGVyLT52ZHBhLCB2Zi0+bnJfdnJpbmcpOwo+
ICAgCWlmIChyZXQpIHsKPiAgIAkJSUZDVkZfRVJSKHBkZXYsICJGYWlsZWQgdG8gcmVnaXN0ZXIg
dG8gdkRQQSBidXMiKTsKPiAgIAkJZ290byBlcnI7CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
