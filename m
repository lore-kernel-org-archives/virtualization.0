Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA52C433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 04:39:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC89664E2F
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 04:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC89664E2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6E98C203CD;
	Mon,  8 Feb 2021 04:39:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mmzgAHxv2aBE; Mon,  8 Feb 2021 04:39:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CCCC520387;
	Mon,  8 Feb 2021 04:39:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0CEAC0174;
	Mon,  8 Feb 2021 04:39:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64547C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 51FAA87001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:39:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QgafG0TwqZK7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:38:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A48D786FFA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612759138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ua7Jkm4OPahNFhX/PVXIUgObMy5pUjSLw7j6xYHr7zs=;
 b=SIzGShHFNQg6+OkGw3LuVyPHAq7CPsjLXAfdmmXwXPCpln/7pnwQtKCbffq25JvdEWPtJo
 6UhSJuxSZbxLb2E+bN81dEdp4Acgzt0QsMjEeRGNXu8MDBHpuKDWMFSpr0Qy7UWvcnFTEn
 o2esBT94VlpmJCe6w5J7ep+kHy23ORE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-O8rd9CjoPXykP3ZI3MXqXQ-1; Sun, 07 Feb 2021 23:38:56 -0500
X-MC-Unique: O8rd9CjoPXykP3ZI3MXqXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B935801977;
 Mon,  8 Feb 2021 04:38:55 +0000 (UTC)
Received: from [10.72.13.185] (ovpn-13-185.pek2.redhat.com [10.72.13.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 528A75B4B5;
 Mon,  8 Feb 2021 04:38:48 +0000 (UTC)
Subject: Re: [PATCH 1/3] mlx5_vdpa: should exclude header length and fcs from
 mtu
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, elic@nvidia.com
References: <1612614564-4220-1-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <735a1b40-09f0-4fec-4d59-98e7c650297d@redhat.com>
Date: Mon, 8 Feb 2021 12:38:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1612614564-4220-1-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjEvMi82IOS4i+WNiDg6MjksIFNpLVdlaSBMaXUgd3JvdGU6Cj4gV2hlbiBmZWF0dXJl
IFZJUlRJT19ORVRfRl9NVFUgaXMgbmVnb3RpYXRlZCBvbiBtbHg1X3ZkcGEsCj4gMjIgZXh0cmEg
Ynl0ZXMgd29ydGggb2YgTVRVIGxlbmd0aCBpcyBzaG93biBpbiBndWVzdC4KPiBUaGlzIGlzIGJl
Y2F1c2UgdGhlIG1seDVfcXVlcnlfcG9ydF9tYXhfbXR1IEFQSSByZXR1cm5zCj4gdGhlICJoYXJk
d2FyZSIgTVRVIHZhbHVlLCB3aGljaCBkb2VzIG5vdCBqdXN0IGNvbnRhaW4gdGhlCj4gRXRoZXJu
ZXQgcGF5bG9hZCwgYnV0IGluY2x1ZGVzIGV4dHJhIGxlbmd0aHMgc3RhcnRpbmcKPiBmcm9tIHRo
ZSBFdGhlcm5ldCBoZWFkZXIgdXAgdG8gdGhlIEZDUyBhbHRvZ2V0aGVyLgo+Cj4gRml4IHRoZSBN
VFUgc28gcGFja2V0cyB3b24ndCBnZXQgZHJvcHBlZCBzaWxlbnRseS4KPgo+IFNpZ25lZC1vZmYt
Ynk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KCgpBY2tlZC1ieTogSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL21seDUv
Y29yZS9tbHg1X3ZkcGEuaCB8ICA0ICsrKysKPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYyAgfCAxNSArKysrKysrKysrKysrKy0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9t
bHg1L2NvcmUvbWx4NV92ZHBhLmggYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5o
Cj4gaW5kZXggMDhmNzQyZi4uYjZjYzUzYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4
NS9jb3JlL21seDVfdmRwYS5oCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3Zk
cGEuaAo+IEBAIC00LDkgKzQsMTMgQEAKPiAgICNpZm5kZWYgX19NTFg1X1ZEUEFfSF9fCj4gICAj
ZGVmaW5lIF9fTUxYNV9WRFBBX0hfXwo+ICAgCj4gKyNpbmNsdWRlIDxsaW51eC9ldGhlcmRldmlj
ZS5oPgo+ICsjaW5jbHVkZSA8bGludXgvaWZfdmxhbi5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L3Zk
cGEuaD4KPiAgICNpbmNsdWRlIDxsaW51eC9tbHg1L2RyaXZlci5oPgo+ICAgCj4gKyNkZWZpbmUg
TUxYNVZfRVRIX0hBUkRfTVRVIChFVEhfSExFTiArIFZMQU5fSExFTiArIEVUSF9GQ1NfTEVOKQo+
ICsKPiAgIHN0cnVjdCBtbHg1X3ZkcGFfZGlyZWN0X21yIHsKPiAgIAl1NjQgc3RhcnQ7Cj4gICAJ
dTY0IGVuZDsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gaW5kZXggZGM4ODU1OS4uYjg0
MTZjNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiAr
KysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBAQCAtMTkwNyw2ICsxOTA3
LDE5IEBAIHN0YXRpYyBpbnQgbWx4NV9nZXRfdnFfaXJxKHN0cnVjdCB2ZHBhX2RldmljZSAqdmR2
LCB1MTYgaWR4KQo+ICAgCS5mcmVlID0gbWx4NV92ZHBhX2ZyZWUsCj4gICB9Owo+ICAgCj4gK3N0
YXRpYyBpbnQgcXVlcnlfbXR1KHN0cnVjdCBtbHg1X2NvcmVfZGV2ICptZGV2LCB1MTYgKm10dSkK
PiArewo+ICsJdTE2IGh3X210dTsKPiArCWludCBlcnI7Cj4gKwo+ICsJZXJyID0gbWx4NV9xdWVy
eV9uaWNfdnBvcnRfbXR1KG1kZXYsICZod19tdHUpOwo+ICsJaWYgKGVycikKPiArCQlyZXR1cm4g
ZXJyOwo+ICsKPiArCSptdHUgPSBod19tdHUgLSBNTFg1Vl9FVEhfSEFSRF9NVFU7Cj4gKwlyZXR1
cm4gMDsKPiArfQo+ICsKPiAgIHN0YXRpYyBpbnQgYWxsb2NfcmVzb3VyY2VzKHN0cnVjdCBtbHg1
X3ZkcGFfbmV0ICpuZGV2KQo+ICAgewo+ICAgCXN0cnVjdCBtbHg1X3ZkcGFfbmV0X3Jlc291cmNl
cyAqcmVzID0gJm5kZXYtPnJlczsKPiBAQCAtMTk5Miw3ICsyMDA1LDcgQEAgc3RhdGljIGludCBt
bHg1dl9wcm9iZShzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAqYWRldiwKPiAgIAlpbml0X212cXMo
bmRldik7Cj4gICAJbXV0ZXhfaW5pdCgmbmRldi0+cmVzbG9jayk7Cj4gICAJY29uZmlnID0gJm5k
ZXYtPmNvbmZpZzsKPiAtCWVyciA9IG1seDVfcXVlcnlfbmljX3Zwb3J0X210dShtZGV2LCAmbmRl
di0+bXR1KTsKPiArCWVyciA9IHF1ZXJ5X210dShtZGV2LCAmbmRldi0+bXR1KTsKPiAgIAlpZiAo
ZXJyKQo+ICAgCQlnb3RvIGVycl9tdHU7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
