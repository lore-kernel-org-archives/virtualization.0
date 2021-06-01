Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCC8C47080
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 03:32:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D7A60FDC
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 03:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D7A60FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C203A40448;
	Tue,  1 Jun 2021 03:32:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gUhmrm-mzwHy; Tue,  1 Jun 2021 03:32:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF13540440;
	Tue,  1 Jun 2021 03:32:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A07C5C000D;
	Tue,  1 Jun 2021 03:32:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EB75C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E15783C87
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:32:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id udwf512Yaoem
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:32:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C33C83C7C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622518323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wO/Ymt4rFpB9aPVUx2fOwYVlvuO0/tOHoU+BNz8BFGU=;
 b=TCjyoQyUBQENuXLQqlpGtdEZvf4/uz13Ok7dtJaPdw7gRXvUJuYdCrc0CvjtgWaq6P5+1/
 44LS9nfEuThdtwXH7yQTU3Wgwz/0aLx2eyuK6E/vgQ8d1Rtv6eshFR+Mf+eEmj554KdIqi
 7pC7sko7/4b+EanxHsg519iFSX56jUk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-8VZZ9PqDNIueOv2BKWduBA-1; Mon, 31 May 2021 23:32:02 -0400
X-MC-Unique: 8VZZ9PqDNIueOv2BKWduBA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d3-20020a1709026543b02900ef00d14127so3877088pln.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 20:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=wO/Ymt4rFpB9aPVUx2fOwYVlvuO0/tOHoU+BNz8BFGU=;
 b=tdTFsAbaV1IPbLNjQf7HGYht5O6OdFKKelM3CH+9iN4DkzZxzIrrWL3kozGib22B9g
 WTvU5e68mQIE9yOVmklbhnPHoLe4KAu8KruOXyxGB3ZDwmRob1gxb+KgHMW+F2l8Cmqh
 Vv/yoTCxAr2QHWHZ5SDkSVAlR2Vva3YjoLRb41P3YnqqrX/zKoTcBvFSTH8p9U5cdTqN
 G4ihFuhcUN/eO8ILSz/a01r8ElonQdC1ERZF/4u0VRIjRHX2l+4Yzk4ik9thkREMTIEu
 ty2w5jABPNu0jD/C+PiC4gUt7esLpvzFS5JDy3AVJA1RbFLXtCvv6LG+2GZtWeRCmGVj
 AZ9A==
X-Gm-Message-State: AOAM5320WpgvaCU9RCtfSoLUr5jkMOmtBAwLc8SaGHcU4dXmSoq+YMmb
 zNErx0WWlDVIRvm1rBuaagFzvWuBIsqwr4cn4ti1KrNy+dpDG6XtEaaG6wjLlJCP106iBYVhLvf
 zt8U3dzRBs4WtoF/1+GMPtPM5Ke9aFNsSi2yCfz4Dgg==
X-Received: by 2002:a62:860b:0:b029:28e:d45b:4d2e with SMTP id
 x11-20020a62860b0000b029028ed45b4d2emr20061989pfd.70.1622518321024; 
 Mon, 31 May 2021 20:32:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzz8tloqg4mNdNJcuGsMq7jMbGxC3NTMB3AeEEmzuoOAB9HUW4bJISV/+kfES7ueUEZ0B+d1A==
X-Received: by 2002:a62:860b:0:b029:28e:d45b:4d2e with SMTP id
 x11-20020a62860b0000b029028ed45b4d2emr20061973pfd.70.1622518320807; 
 Mon, 31 May 2021 20:32:00 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id r11sm12553574pgl.34.2021.05.31.20.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 20:32:00 -0700 (PDT)
Subject: Re: [PATCH V2 RESEND 2/2] vDPA/ifcvf: implement doorbell mapping for
 ifcvf
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com
References: <20210531073316.363655-1-lingshan.zhu@intel.com>
 <20210531073316.363655-3-lingshan.zhu@intel.com>
 <f3c28e92-3e8d-2a8a-ec5a-fc64f2098678@redhat.com>
 <5dbdc6a5-1510-9411-6b85-d947d091089c@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <91c64c0c-7b78-4c41-a6d7-6d9f084c7cc5@redhat.com>
Date: Tue, 1 Jun 2021 11:31:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <5dbdc6a5-1510-9411-6b85-d947d091089c@intel.com>
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzYvMSDkuIrljYgxMToyNywgWmh1LCBMaW5nc2hhbiDlhpnpgZM6Cj4KPgo+IE9u
IDUvMzEvMjAyMSAzOjU2IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiDlnKggMjAyMS81LzMx
IOS4i+WNiDM6MzMsIFpodSBMaW5nc2hhbiDlhpnpgZM6Cj4+PiBUaGlzIGNvbW1pdCBpbXBsZW1l
bnRzIGRvb3JiZWxsIG1hcHBpbmcgZmVhdHVyZSBmb3IgaWZjdmYuCj4+PiBUaGlzIGZlYXR1cmUg
bWFwcyB0aGUgbm90aWZ5IHBhZ2UgdG8gdXNlcnNwYWNlLCB0byBlbGltaW5hdGUKPj4+IHZtZXhp
dCB3aGVuIGtpY2sgYSB2cS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxp
bmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9tYWluLmMgfCAxNyArKysrKysrKysrKysrKysrKwo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQs
IDE3IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3Zm
L2lmY3ZmX21haW4uYyAKPj4+IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+Pj4g
aW5kZXggYWIwYWI1Y2YwZjZlLi5lZmZiMGU1NDkxMzUgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJz
L3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZj
dmZfbWFpbi5jCj4+PiBAQCAtNDEzLDYgKzQxMywyMiBAQCBzdGF0aWMgaW50IGlmY3ZmX3ZkcGFf
Z2V0X3ZxX2lycShzdHJ1Y3QgCj4+PiB2ZHBhX2RldmljZSAqdmRwYV9kZXYsCj4+PiDCoMKgwqDC
oMKgIHJldHVybiB2Zi0+dnJpbmdbcWlkXS5pcnE7Cj4+PiDCoCB9Cj4+PiDCoCArc3RhdGljIHN0
cnVjdCB2ZHBhX25vdGlmaWNhdGlvbl9hcmVhIAo+Pj4gaWZjdmZfZ2V0X3ZxX25vdGlmaWNhdGlv
bihzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHUxNiBpZHgp
Cj4+PiArewo+Pj4gK8KgwqDCoCBzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqYWRhcHRlciA9IHZkcGFf
dG9fYWRhcHRlcih2ZHBhX2Rldik7Cj4+PiArwqDCoMKgIHN0cnVjdCBpZmN2Zl9odyAqdmYgPSB2
ZHBhX3RvX3ZmKHZkcGFfZGV2KTsKPj4+ICvCoMKgwqAgc3RydWN0IHBjaV9kZXYgKnBkZXYgPSBh
ZGFwdGVyLT5wZGV2Owo+Pj4gK8KgwqDCoCBzdHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYSBh
cmVhOwo+Pj4gKwo+Pj4gK8KgwqDCoCBhcmVhLmFkZHIgPSB2Zi0+dnJpbmdbaWR4XS5ub3RpZnlf
cGE7Cj4+PiArwqDCoMKgIGFyZWEuc2l6ZSA9IFBBR0VfU0laRTsKPj4+ICvCoMKgwqAgaWYgKGFy
ZWEuYWRkciAlIFBBR0VfU0laRSkKPj4+ICvCoMKgwqDCoMKgwqDCoCBJRkNWRl9EQkcocGRldiwg
InZxICV1IGRvb3JiZWxsIGFkZHJlc3MgaXMgbm90IFBBR0VfU0laRSAKPj4+IGFsaWduZWRcbiIs
IGlkeCk7Cj4+Cj4+Cj4+IExldCdzIGxlYXZlIHRoZSBkZWNpc2lvbiB0byB1cHBlciBsYXllciBi
eTogKHNlZSAKPj4gdnBfdmRwYV9nZXRfdnFfbm90aWZpY2F0aW9uKQo+Pgo+PiBhcmVhLmFkZHIg
PSBub3RpZnlfcGE7Cj4+IGFyZWEuc2l6ZSA9IG5vdGlmeV9vZmZzZXRfbXVsdGlwbGllcjsKPj4K
Pj4gVGhhbmtzCj4KPiBIaSBKYXNvbiwKPgo+IG5vdGlmeV9vZmZzZXRfbXVsdGlwbGllciBjYW4g
YmUgemVybywgbWVhbnMgdnFzIHNoYXJlIHRoZSBzYW1lIAo+IGRvb3JiZWxsIGFkZHJlc3MsIGRp
c3Rpbmd1aXNoZWQgYnkgcWlkLgo+IGFuZCBpbiB2ZHBhLmM6Cj4KPiDCoMKgwqDCoMKgwqDCoCBp
ZiAodm1hLT52bV9lbmQgLSB2bWEtPnZtX3N0YXJ0ICE9IG5vdGlmeS5zaXplKQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT1RTVVBQOwo+Cj4gc28gYSB6ZXJvIHNp
emUgd291bGQgY2F1c2UgdGhpcyBmZWF0dXJlIGZhaWx1cmUuCj4gbW1hcCBzaG91bGQgd29yayBv
biBhdCBsZWFzdCBhIHBhZ2UsIHNvIGlmIHdlIHJlYWxseSB3YW50ICJhcmVhLnNpemUgPSAKPiBu
b3RpZnlfb2Zmc2V0X211bHRpcGxpZXI7Igo+IEkgdGhpbmsgd2Ugc2hvdWxkIGFkZCBzb21lIGNv
ZGUgaW4gdmRwYS5jLCBsaWtlOgo+Cj4gaWYoIW5vdGlmeS5zaXplKQo+IMKgwqDCoCBub3RpZnku
c2l6ZSA9IFBBR0VfU0laRTsKPgo+IHNvdW5kcyBnb29kPwoKCkl0J3MgdGhlIHJlc3BvbnNpYmls
aXR5IG9mIHRoZSBkcml2ZXIgdG8gcmVwb3J0IGEgY29ycmVjdCBvbmUuIFNvIEkgCnRoaW5rIGl0
J3MgYmV0dGVyIHRvIHR3ZWFrIGl0IGFzOgoKYXJlYS5zaXplID0gbm90aWZ5X29mZnNldF9tdWx0
aXBsaWVyID86IFBBR0VfU0laRTsKClRoYW5rcwoKCj4KPiBUaGFua3MKPiBaaHUgTGluZ3NoYW4K
Pj4KPj4KPj4+ICsKPj4+ICvCoMKgwqAgcmV0dXJuIGFyZWE7Cj4+PiArfQo+Pj4gKwo+Pj4gwqAg
LyoKPj4+IMKgwqAgKiBJRkNWRiBjdXJyZW50bHkgZG9lcyd0IGhhdmUgb24tY2hpcCBJT01NVSwg
c28gbm90Cj4+PiDCoMKgICogaW1wbGVtZW50ZWQgc2V0X21hcCgpL2RtYV9tYXAoKS9kbWFfdW5t
YXAoKQo+Pj4gQEAgLTQ0MCw2ICs0NTYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29u
ZmlnX29wcyBpZmNfdmRwYV9vcHMgCj4+PiA9IHsKPj4+IMKgwqDCoMKgwqAgLmdldF9jb25maWfC
oMKgwqAgPSBpZmN2Zl92ZHBhX2dldF9jb25maWcsCj4+PiDCoMKgwqDCoMKgIC5zZXRfY29uZmln
wqDCoMKgID0gaWZjdmZfdmRwYV9zZXRfY29uZmlnLAo+Pj4gwqDCoMKgwqDCoCAuc2V0X2NvbmZp
Z19jYsKgID0gaWZjdmZfdmRwYV9zZXRfY29uZmlnX2NiLAo+Pj4gK8KgwqDCoCAuZ2V0X3ZxX25v
dGlmaWNhdGlvbiA9IGlmY3ZmX2dldF92cV9ub3RpZmljYXRpb24sCj4+PiDCoCB9Owo+Pj4gwqAg
wqAgc3RhdGljIGludCBpZmN2Zl9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29uc3Qgc3Ry
dWN0IAo+Pj4gcGNpX2RldmljZV9pZCAqaWQpCj4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
