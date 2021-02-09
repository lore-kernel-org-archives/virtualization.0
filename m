Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078E4C433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 03:44:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F58D64EAA
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 03:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F58D64EAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C610C86CB5;
	Tue,  9 Feb 2021 03:37:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 554OBpg9uEiA; Tue,  9 Feb 2021 03:37:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EBFE486C48;
	Tue,  9 Feb 2021 03:37:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9700C0174;
	Tue,  9 Feb 2021 03:37:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21908C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 10B418747C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sMWj2dRoljo4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:37:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6056D87473
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612841852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qXpTUfGjHXTgPLVJ/cRGBpFqZ3c/AyT0/M9azlEt+tE=;
 b=AZYW9Xmb2kjLdcLAhTgUcBDo0wDNyAul5LqG41G0RKhGJz2vkFI84fzR7rBM4P/ux+qiPT
 GK0P/dW4pvD68aD1D4V4Jx1qXOKYebGbEiNEavAFHaqSZPfaVyB8wFziPctIQGEsELuNXs
 rQi7XZF9Kn6XY7XvB1qqfW1A8QZ/qhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-ojgRJJiUN0mVCBrkrovz2A-1; Mon, 08 Feb 2021 22:37:29 -0500
X-MC-Unique: ojgRJJiUN0mVCBrkrovz2A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F318A6D4FE;
 Tue,  9 Feb 2021 03:37:25 +0000 (UTC)
Received: from [10.72.13.32] (ovpn-13-32.pek2.redhat.com [10.72.13.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4AC110013D7;
 Tue,  9 Feb 2021 03:37:23 +0000 (UTC)
Subject: Re: [PATCH 3/3] mlx5_vdpa: defer clear_virtqueues to until DRIVER_OK
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, elic@nvidia.com
References: <1612614564-4220-1-git-send-email-si-wei.liu@oracle.com>
 <1612614564-4220-3-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2e2bc8d7-5d64-c28c-9aa0-1df32c7dcef3@redhat.com>
Date: Tue, 9 Feb 2021 11:37:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1612614564-4220-3-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Ck9uIDIwMjEvMi82IOS4i+WNiDg6MjksIFNpLVdlaSBMaXUgd3JvdGU6Cj4gV2hpbGUgdmlydHEg
aXMgc3RvcHBlZCwgIGdldF92cV9zdGF0ZSgpIGlzIHN1cHBvc2VkIHRvCj4gYmUgIGNhbGxlZCB0
byAgZ2V0ICBzeW5jJ2VkICB3aXRoICB0aGUgbGF0ZXN0IGludGVybmFsCj4gYXZhaWxfaW5kZXgg
ZnJvbSBkZXZpY2UuIFRoZSBzYXZlZCBhdmFpbF9pbmRleCBpcyB1c2VkCj4gdG8gcmVzdGF0ZSAg
dGhlIHZpcnRxICBvbmNlIGRldmljZSBpcyBzdGFydGVkLiAgQ29tbWl0Cj4gYjM1Y2NlYmUzZWY3
IGludHJvZHVjZWQgdGhlIGNsZWFyX3ZpcnRxdWV1ZXMoKSByb3V0aW5lCj4gdG8gIHJlc2V0ICB0
aGUgc2F2ZWQgIGF2YWlsX2luZGV4LCAgaG93ZXZlciwgdGhlIGluZGV4Cj4gZ2V0cyBjbGVhcmVk
IGEgYml0IGVhcmxpZXIgYmVmb3JlIGdldF92cV9zdGF0ZSgpIHRyaWVzCj4gdG8gcmVhZCBpdC4g
VGhpcyB3b3VsZCBjYXVzZSBjb25zaXN0ZW5jeSBwcm9ibGVtcyB3aGVuCj4gdmlydHEgaXMgcmVz
dGFydGVkLCBlLmcuIHRocm91Z2ggYSBzZXJpZXMgb2YgbGluayBkb3duCj4gYW5kIGxpbmsgdXAg
ZXZlbnRzLiBXZSAgY291bGQgIGRlZmVyICB0aGUgIGNsZWFyaW5nIG9mCj4gYXZhaWxfaW5kZXgg
IHRvICB1bnRpbCAgdGhlICBkZXZpY2UgIGlzIHRvIGJlIHN0YXJ0ZWQsCj4gaS5lLiB1bnRpbCAg
VklSVElPX0NPTkZJR19TX0RSSVZFUl9PSyAgaXMgc2V0IGFnYWluIGluCj4gc2V0X3N0YXR1cygp
Lgo+Cj4gRml4ZXM6IGIzNWNjZWJlM2VmNyAoInZkcGEvbWx4NTogUmVzdG9yZSB0aGUgaGFyZHdh
cmUgdXNlZCBpbmRleCBhZnRlciBjaGFuZ2UgbWFwIikKPiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkg
TGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9u
ZXQvbWx4NV92bmV0LmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBpbmRleCBhYTZm
OGNkLi40NDRhYjU4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBAIC0xNzg1
LDcgKzE3ODUsNiBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkZXYsIHU4IHN0YXR1cykKPiAgIAlpZiAoIXN0YXR1cykgewo+ICAgCQltbHg1
X3ZkcGFfaW5mbyhtdmRldiwgInBlcmZvcm1pbmcgZGV2aWNlIHJlc2V0XG4iKTsKPiAgIAkJdGVh
cmRvd25fZHJpdmVyKG5kZXYpOwo+IC0JCWNsZWFyX3ZpcnRxdWV1ZXMobmRldik7Cj4gICAJCW1s
eDVfdmRwYV9kZXN0cm95X21yKCZuZGV2LT5tdmRldik7Cj4gICAJCW5kZXYtPm12ZGV2LnN0YXR1
cyA9IDA7Cj4gICAJCSsrbXZkZXYtPmdlbmVyYXRpb247Cj4gQEAgLTE3OTQsNiArMTc5Myw3IEBA
IHN0YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRl
diwgdTggc3RhdHVzKQo+ICAgCj4gICAJaWYgKChzdGF0dXMgXiBuZGV2LT5tdmRldi5zdGF0dXMp
ICYgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykgewo+ICAgCQlpZiAoc3RhdHVzICYgVklSVElP
X0NPTkZJR19TX0RSSVZFUl9PSykgewo+ICsJCQljbGVhcl92aXJ0cXVldWVzKG5kZXYpOwoKClJl
dGhpbmsgYWJvdXQgdGhpcy4gQXMgbWVudGlvbmVkIGluIGFub3RoZXIgdGhyZWFkLCB0aGlzIGlu
IGZhY3QgYnJlYWtzIApzZXRfdnFfc3RhdGUoKS7CoCAoU2VlIHZob3N0X3ZpcnRxdWV1ZV9zdGFy
dCgpIC0+IAp2aG9zdF92ZHBhX3NldF92cmluZ19iYXNlKCkgaW4gcWVtdSBjb2RlcykuCgpUaGUg
aXNzdWUgaXMgdGhhdCB0aGUgYXZhaWwgaWR4IGlzIGZvcmdvdCwgd2UgbmVlZCBrZWVwIGl0LgoK
VGhhbmtzCgoKPiAgIAkJCWVyciA9IHNldHVwX2RyaXZlcihuZGV2KTsKPiAgIAkJCWlmIChlcnIp
IHsKPiAgIAkJCQltbHg1X3ZkcGFfd2FybihtdmRldiwgImZhaWxlZCB0byBzZXR1cCBkcml2ZXJc
biIpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
