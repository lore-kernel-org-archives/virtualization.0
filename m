Return-Path: <SRS0=m9lB=HX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F04C433DB
	for <virtualization@archiver.kernel.org>; Sun, 21 Feb 2021 11:26:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E7964EE9
	for <virtualization@archiver.kernel.org>; Sun, 21 Feb 2021 11:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E7964EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D50B885784;
	Sun, 21 Feb 2021 11:26:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MHWkx57AAExg; Sun, 21 Feb 2021 11:26:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 48A0885643;
	Sun, 21 Feb 2021 11:26:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3B47C000B;
	Sun, 21 Feb 2021 11:26:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46355C0001
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 11:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34E6F834DB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 11:26:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ipJ0hFZ53ZO1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 11:26:47 +0000 (UTC)
Received: by smtp1.osuosl.org (Postfix, from userid 1001)
 id 52E12835D3; Sun, 21 Feb 2021 11:26:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74C5D834DB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 11:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613906802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Ig11Pa9JeTNL+845eeMHRWH78YC6z1GjViCXAPXliA=;
 b=TpnUya5N1LHc0C6uCBBs7hLeUP7VT9mmOH7pWCb+bMEJ0h7B93KZvV6cmWhJwvE3WUukG8
 0WFLYTlGRnIfsO/dkL+qw7lEC1FU6Ns1LADAZtTNn1+PtTWK7PUz0eo2yaZl9xFNR27OBO
 N/10lBwcfm4X8gdn9WiApDjSRjcY4Ls=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-Zw2cxlPaNUG_XkNhiOSCcQ-1; Sun, 21 Feb 2021 06:26:40 -0500
X-MC-Unique: Zw2cxlPaNUG_XkNhiOSCcQ-1
Received: by mail-ed1-f72.google.com with SMTP id j10so5423866edv.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 03:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=8Ig11Pa9JeTNL+845eeMHRWH78YC6z1GjViCXAPXliA=;
 b=ZzTQ+HBYir8HiPlr3+reEd9I8S9+doT/6ytgyyMd4eEsue+JB4SOZ7jcKe++i1T1Rx
 /aV07l1981t/IBciTeAeTJDYFGndOSg2hZ5nUDkH5Uy7ilFpoTt7qsLtxxchqYg5bkf9
 exCtvjLkMIdEo+/TeqbeQi90BUW7nqBDOq2mpqZGtfGIRhlqPeMemcYSCUwvqEcktozH
 gmL6OfaW+KQWawRwJWLiXPKHcWbpR9cZfRoX1Zy+W8r1zqygZO6xJ6pCYQ8f+iFH4F83
 Rg1Nj4ALjgNDPKskPj2uN/U6iY4+j5SgGeIxZCGi2PoulgHMxJ7TO3966OBJ3LcFJLhY
 FYqw==
X-Gm-Message-State: AOAM533aanlR3C67qPnexpN2lv51v3WH/+9V6CBIXorKyL3OvXwF8KPJ
 yLYOrSApfNI9HP+/j61XZ+TnlnRR4A0T8C67PdgT8AjR/HTGSabPqYk8waHEIH4G/Il4P+I8IAd
 mhoi5yq/+B55J+110LxJdHZKXFum/MVoWdGz89FGtzA==
X-Received: by 2002:a17:906:4e19:: with SMTP id
 z25mr16557667eju.205.1613906799394; 
 Sun, 21 Feb 2021 03:26:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJym3ziM+C3oMmyNcWorCks/womKKudglaEVoLH6vh9AKa0j8BznTKu7kNGodpjIodbGSXj1HA==
X-Received: by 2002:a17:906:4e19:: with SMTP id
 z25mr16557658eju.205.1613906799243; 
 Sun, 21 Feb 2021 03:26:39 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id gt7sm5268170ejc.121.2021.02.21.03.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Feb 2021 03:26:38 -0800 (PST)
Date: Sun, 21 Feb 2021 06:26:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tang Bin <tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] virtio-mmio: Use to_virtio_mmio_device() to simply code
Message-ID: <20210221062628-mutt-send-email-mst@kernel.org>
References: <20210210030401.5532-1-tangbin@cmss.chinamobile.com>
 <b7043be4-46cf-e72c-b3aa-4a8d487e82ad@redhat.com>
 <740b0c1f-24d4-de31-8753-4c5ec07b92f9@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <740b0c1f-24d4-de31-8753-4c5ec07b92f9@cmss.chinamobile.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gVGh1LCBGZWIgMTgsIDIwMjEgYXQgMDk6MzQ6MDhBTSArMDgwMCwgVGFuZyBCaW4gd3JvdGU6
Cj4gRGVhciBKYXNvbu+8mgo+IAo+IMKgwqDCoMKgwqAgU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5
IHRoaXMgZW1haWwuCj4gCj4g5ZyoIDIwMjEvMi8xMCAxNjowOSwgSmFzb24gV2FuZyDlhpnpgZM6
Cj4gPiAKPiA+IE9uIDIwMjEvMi8xMCDkuIrljYgxMTowNCwgVGFuZyBCaW4gd3JvdGU6Cj4gPiA+
IFRoZSBmaWxlIHZpcnRpb19tbWlvLmMgaGFzIGRlZmluZWQgdGhlIGZ1bmN0aW9uIHRvX3ZpcnRp
b19tbWlvX2RldmljZSwKPiA+ID4gc28gdXNlIGl0IGluc3RlYWQgb2YgY29udGFpbmVyX29mKCkg
dG8gc2ltcGx5IGNvZGUuIEFuZCByZW1vdmUKPiA+ID4gc3VwZXJmbHVvdXMgYmxhbmsgbGluZXMg
aW4gdGhpcyBmaWxlLgo+ID4gPiAKPiA+ID4gU2lnbmVkLW9mZi1ieTogVGFuZyBCaW4gPHRhbmdi
aW5AY21zcy5jaGluYW1vYmlsZS5jb20+Cj4gPiA+IC0tLQo+ID4gPiDCoCBkcml2ZXJzL3ZpcnRp
by92aXJ0aW9fbW1pby5jIHwgMTYgKy0tLS0tLS0tLS0tLS0tLQo+ID4gPiDCoCAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDE1IGRlbGV0aW9ucygtKQo+ID4gPiAKPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlvLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fbW1pby5jCj4gPiA+IGluZGV4IDYyN2FjMDQ4Ny4uNDQ5ZDBmMjA5IDEwMDY0NAo+ID4gPiAt
LS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19tbWlvLmMKPiA+ID4gQEAgLTY5LDE0ICs2OSwxMCBAQAo+ID4gPiDCoCAjaW5j
bHVkZSA8dWFwaS9saW51eC92aXJ0aW9fbW1pby5oPgo+ID4gPiDCoCAjaW5jbHVkZSA8bGludXgv
dmlydGlvX3JpbmcuaD4KPiA+ID4gwqAgLQo+ID4gPiAtCj4gPiAKPiA+IAo+ID4gSXQncyBiZXR0
ZXIgbm90IG1peCB0aGUgcGF0Y2ggd2l0aCBzdHlsZSBjaGFuZ2VzLgo+ID4gCj4gPiBPdGhlciBs
b29rcyBnb29kLgo+ID4gCj4gPiBUaGFua3MKPiAKPiBXaGV0aGVyIHNob3VsZCBJIHNlbmQgcGF0
Y2ggVjLvvJ8KPiAKPiBUaGFua3MKCgpQbGVhc2UgZG8uCgo+ID4gCj4gPiAKPiA+ID4gwqAgLyog
VGhlIGFsaWdubWVudCB0byB1c2UgYmV0d2VlbiBjb25zdW1lciBhbmQgcHJvZHVjZXIgcGFydHMg
b2YgdnJpbmcuCj4gPiA+IMKgwqAgKiBDdXJyZW50bHkgaGFyZGNvZGVkIHRvIHRoZSBwYWdlIHNp
emUuICovCj4gPiA+IMKgICNkZWZpbmUgVklSVElPX01NSU9fVlJJTkdfQUxJR07CoMKgwqDCoMKg
wqDCoCBQQUdFX1NJWkUKPiA+ID4gwqAgLQo+ID4gPiAtCj4gPiA+IMKgICNkZWZpbmUgdG9fdmly
dGlvX21taW9fZGV2aWNlKF9wbGF0X2RldikgXAo+ID4gPiDCoMKgwqDCoMKgIGNvbnRhaW5lcl9v
ZihfcGxhdF9kZXYsIHN0cnVjdCB2aXJ0aW9fbW1pb19kZXZpY2UsIHZkZXYpCj4gPiA+IMKgIEBA
IC0xMDAsOCArOTYsNiBAQCBzdHJ1Y3QgdmlydGlvX21taW9fdnFfaW5mbyB7Cj4gPiA+IMKgwqDC
oMKgwqAgc3RydWN0IGxpc3RfaGVhZCBub2RlOwo+ID4gPiDCoCB9Owo+ID4gPiDCoCAtCj4gPiA+
IC0KPiA+ID4gwqAgLyogQ29uZmlndXJhdGlvbiBpbnRlcmZhY2UgKi8KPiA+ID4gwqAgwqAgc3Rh
dGljIHU2NCB2bV9nZXRfZmVhdHVyZXMoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPiA+
IEBAIC0yNjQsOCArMjU4LDYgQEAgc3RhdGljIHZvaWQgdm1fcmVzZXQoc3RydWN0IHZpcnRpb19k
ZXZpY2UgKnZkZXYpCj4gPiA+IMKgwqDCoMKgwqAgd3JpdGVsKDAsIHZtX2Rldi0+YmFzZSArIFZJ
UlRJT19NTUlPX1NUQVRVUyk7Cj4gPiA+IMKgIH0KPiA+ID4gwqAgLQo+ID4gPiAtCj4gPiA+IMKg
IC8qIFRyYW5zcG9ydCBpbnRlcmZhY2UgKi8KPiA+ID4gwqAgwqAgLyogdGhlIG5vdGlmeSBmdW5j
dGlvbiB1c2VkIHdoZW4gY3JlYXRpbmcgYSB2aXJ0IHF1ZXVlICovCj4gPiA+IEBAIC0zMDcsOCAr
Mjk5LDYgQEAgc3RhdGljIGlycXJldHVybl90IHZtX2ludGVycnVwdChpbnQgaXJxLCB2b2lkCj4g
PiA+ICpvcGFxdWUpCj4gPiA+IMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPiA+ID4gwqAgfQo+ID4g
PiDCoCAtCj4gPiA+IC0KPiA+ID4gwqAgc3RhdGljIHZvaWQgdm1fZGVsX3ZxKHN0cnVjdCB2aXJ0
cXVldWUgKnZxKQo+ID4gPiDCoCB7Cj4gPiA+IMKgwqDCoMKgwqAgc3RydWN0IHZpcnRpb19tbWlv
X2RldmljZSAqdm1fZGV2ID0KPiA+ID4gdG9fdmlydGlvX21taW9fZGV2aWNlKHZxLT52ZGV2KTsK
PiA+ID4gQEAgLTUxMiwxMyArNTAyLDExIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmlydGlvX2Nv
bmZpZ19vcHMKPiA+ID4gdmlydGlvX21taW9fY29uZmlnX29wcyA9IHsKPiA+ID4gwqDCoMKgwqDC
oCAuYnVzX25hbWXCoMKgwqAgPSB2bV9idXNfbmFtZSwKPiA+ID4gwqAgfTsKPiA+ID4gwqAgLQo+
ID4gPiDCoCBzdGF0aWMgdm9pZCB2aXJ0aW9fbW1pb19yZWxlYXNlX2RldihzdHJ1Y3QgZGV2aWNl
ICpfZCkKPiA+ID4gwqAgewo+ID4gPiDCoMKgwqDCoMKgIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2
ZGV2ID0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGFpbmVyX29mKF9kLCBz
dHJ1Y3QgdmlydGlvX2RldmljZSwgZGV2KTsKPiA+ID4gLcKgwqDCoCBzdHJ1Y3QgdmlydGlvX21t
aW9fZGV2aWNlICp2bV9kZXYgPQo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250YWlu
ZXJfb2YodmRldiwgc3RydWN0IHZpcnRpb19tbWlvX2RldmljZSwgdmRldik7Cj4gPiA+ICvCoMKg
wqAgc3RydWN0IHZpcnRpb19tbWlvX2RldmljZSAqdm1fZGV2ID0gdG9fdmlydGlvX21taW9fZGV2
aWNlKHZkZXYpOwo+ID4gPiDCoMKgwqDCoMKgIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYg
PSB2bV9kZXYtPnBkZXY7Cj4gPiA+IMKgIMKgwqDCoMKgwqAgZGV2bV9rZnJlZSgmcGRldi0+ZGV2
LCB2bV9kZXYpOwo+ID4gPiBAQCAtNjA4LDggKzU5Niw2IEBAIHN0YXRpYyBpbnQgdmlydGlvX21t
aW9fcmVtb3ZlKHN0cnVjdAo+ID4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiA+IMKgwqDC
oMKgwqAgcmV0dXJuIDA7Cj4gPiA+IMKgIH0KPiA+ID4gwqAgLQo+ID4gPiAtCj4gPiA+IMKgIC8q
IERldmljZXMgbGlzdCBwYXJhbWV0ZXIgKi8KPiA+ID4gwqAgwqAgI2lmIGRlZmluZWQoQ09ORklH
X1ZJUlRJT19NTUlPX0NNRExJTkVfREVWSUNFUykKPiA+IAo+IAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
