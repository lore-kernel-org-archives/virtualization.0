Return-Path: <SRS0=ogTN=GW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121F6C433DB
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 04:06:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D9220867
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 04:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D9220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5422F232D2;
	Tue, 19 Jan 2021 04:06:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QlWZLCqx8ija; Tue, 19 Jan 2021 04:06:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C6BBD233B0;
	Tue, 19 Jan 2021 04:06:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37354C088B;
	Tue, 19 Jan 2021 04:06:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F452C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 04:06:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 127F3233B0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 04:06:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EifNd5Q1bWW4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 04:06:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 4282B232D2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 04:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611029204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XxjUqcN38hjRWlI1UqqG9yx1inb5rkEhsdJ3OcF1xYs=;
 b=eGeY2KN2eBbq0SSlaqOv8AWppqYCmKBf4UUW/eOnVnurWPOjsjin3FmpUuF9LpWxHg93x5
 eVbxMU2ul8EqnXT5uo+mCQyl1jDwAdeHg/Sg0zccJosk9qDr0hLErNNYiwpTkJyGo1G1pH
 siplLxY8LB8OfVgSclZYIwqrUB3+Urw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-peZjWp4XPnOEOApiswON6g-1; Mon, 18 Jan 2021 23:06:42 -0500
X-MC-Unique: peZjWp4XPnOEOApiswON6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35B6515723;
 Tue, 19 Jan 2021 04:06:41 +0000 (UTC)
Received: from [10.72.13.139] (ovpn-13-139.pek2.redhat.com [10.72.13.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4197B62688;
 Tue, 19 Jan 2021 04:06:35 +0000 (UTC)
Subject: Re: [PATCH RFC] virtio-blk: support per-device queue depth
To: JeffleXu <jefflexu@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
 <ab4cbc06-b629-dd35-52ac-1246d500d1c4@redhat.com>
 <4141645d-6dfc-110c-bfcd-03641df8332c@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <46f2f81f-9906-e1f7-d8fd-6da2c61683ba@redhat.com>
Date: Tue, 19 Jan 2021 12:06:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4141645d-6dfc-110c-bfcd-03641df8332c@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMS8xOSDkuIrljYg5OjMzLCBKZWZmbGVYdSB3cm90ZToKPgo+IE9uIDEvMTgvMjEg
MToyNSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4gT24gMjAyMS8xLzE4IOS4iuWNiDExOjU4LCBK
b3NlcGggUWkgd3JvdGU6Cj4+PiBtb2R1bGUgcGFyYW1ldGVyICd2aXJ0YmxrX3F1ZXVlX2RlcHRo
JyB3YXMgZmlyc3RseSBpbnRyb2R1Y2VkIGZvcgo+Pj4gdGVzdGluZy9iZW5jaG1hcmtpbmcgcHVy
cG9zZXMgZGVzY3JpYmVkIGluIGNvbW1pdCBmYzQzMjRiNDU5N2MKPj4+ICgidmlydGlvLWJsazog
YmFzZSBxdWV1ZS1kZXB0aCBvbiB2aXJ0cXVldWUgcmluZ3NpemUgb3IgbW9kdWxlIHBhcmFtIiku
Cj4+PiBTaW5jZSB3ZSBoYXZlIGRpZmZlcmVudCB2aXJ0aW8tYmxrIGRldmljZXMgd2hpY2ggaGF2
ZSBkaWZmZXJlbnQKPj4+IGNhcGFiaWxpdGllcywgaXQgcmVxdWlyZXMgdGhhdCB3ZSBzdXBwb3J0
IHBlci1kZXZpY2UgcXVldWUgZGVwdGggaW5zdGVhZAo+Pj4gb2YgcGVyLW1vZHVsZS4gU28gZGVm
YXVsdGx5IHVzZSB2cSBmcmVlIGVsZW1lbnRzIGlmIG1vZHVsZSBwYXJhbWV0ZXIKPj4+ICd2aXJ0
YmxrX3F1ZXVlX2RlcHRoJyBpcyBub3Qgc2V0Lgo+Pgo+PiBJIHdvbmRlciBpZiBpdCdzIGJldHRl
ciB0byB1c2Ugc3lzZnMgaW5zdGVhZCAob3Igd2hldGhlciBpdCBoYXMgYWxyZWFkeQo+PiBoYWQg
c29tZXRoaW5nIGxpa2UgdGhpcyBpbiB0aGUgYmxvY2tlciBsYXllcikuCj4+Cj4gIi9zeXMvYmxv
Y2svPGRldj4vcXVldWUvbnJfcmVxdWVzdHMiIGluZGVlZCB3b3JrcywgYnV0IGlzbid0IGJldHRl
ciB0bwo+IHNldCBxdWV1ZV9kZXB0aCBhY2NvcmRpbmcgdG8gdGhlIGhhcmR3YXJlIGNhcGFiaWxp
dHkgYXQgdGhlIHZlcnkgZmlyc3Q/Cj4gQUZBSUssIG52bWUganVzdCBzZXQgcGVyLWRldmljZSBx
dWV1ZV9kZXB0aCBhdCBpbml0aWFsaXppbmcgcGhhc2UuCgoKSSBhZ3JlZSwgdGhlIHByb2JsZW0g
aXMgdGhhdCB0aGUgY3VycmVudCBjb2RlIG1heSBtb2RpZnkgbW9kdWxlIHBhcmFtZXRlci4KClRo
YW5rcwoKCj4KPiBUaGFua3MsCj4gSmVmZmxlCj4KPj4KPj4+IFNpZ25lZC1vZmYtYnk6IEpvc2Vw
aCBRaSA8am9zZXBoLnFpQGxpbnV4LmFsaWJhYmEuY29tPgo+Pj4gLS0tCj4+PiAgwqAgZHJpdmVy
cy9ibG9jay92aXJ0aW9fYmxrLmMgfCAxMiArKysrKysrLS0tLS0KPj4+ICDCoCAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyBiL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5j
Cj4+PiBpbmRleCAxNDU2MDZkLi5mODNhNDE3IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ibG9j
ay92aXJ0aW9fYmxrLmMKPj4+ICsrKyBiL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jCj4+PiBA
QCAtNzA1LDYgKzcwNSw3IEBAIHN0YXRpYyBpbnQgdmlydGJsa19wcm9iZShzdHJ1Y3QgdmlydGlv
X2RldmljZSAqdmRldikKPj4+ICDCoMKgwqDCoMKgIHUzMiB2LCBibGtfc2l6ZSwgbWF4X3NpemUs
IHNnX2VsZW1zLCBvcHRfaW9fc2l6ZTsKPj4+ICDCoMKgwqDCoMKgIHUxNiBtaW5faW9fc2l6ZTsK
Pj4+ICDCoMKgwqDCoMKgIHU4IHBoeXNpY2FsX2Jsb2NrX2V4cCwgYWxpZ25tZW50X29mZnNldDsK
Pj4+ICvCoMKgwqAgdW5zaWduZWQgaW50IHF1ZXVlX2RlcHRoOwo+Pj4gIMKgIMKgwqDCoMKgwqAg
aWYgKCF2ZGV2LT5jb25maWctPmdldCkgewo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJy
KCZ2ZGV2LT5kZXYsICIlcyBmYWlsdXJlOiBjb25maWcgYWNjZXNzIGRpc2FibGVkXG4iLAo+Pj4g
QEAgLTc1NSwxNyArNzU2LDE4IEBAIHN0YXRpYyBpbnQgdmlydGJsa19wcm9iZShzdHJ1Y3Qgdmly
dGlvX2RldmljZQo+Pj4gKnZkZXYpCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X2Zy
ZWVfdnE7Cj4+PiAgwqDCoMKgwqDCoCB9Cj4+PiAgwqAgLcKgwqDCoCAvKiBEZWZhdWx0IHF1ZXVl
IHNpemluZyBpcyB0byBmaWxsIHRoZSByaW5nLiAqLwo+Pj4gLcKgwqDCoCBpZiAoIXZpcnRibGtf
cXVldWVfZGVwdGgpIHsKPj4+IC3CoMKgwqDCoMKgwqDCoCB2aXJ0YmxrX3F1ZXVlX2RlcHRoID0g
dmJsay0+dnFzWzBdLnZxLT5udW1fZnJlZTsKPj4+ICvCoMKgwqAgaWYgKGxpa2VseSghdmlydGJs
a19xdWV1ZV9kZXB0aCkpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBxdWV1ZV9kZXB0aCA9IHZibGst
PnZxc1swXS52cS0+bnVtX2ZyZWU7Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIC4uLiBidXQg
d2l0aG91dCBpbmRpcmVjdCBkZXNjcywgd2UgdXNlIDIgZGVzY3MgcGVyIHJlcSAqLwo+Pj4gIMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoIXZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fUklO
R19GX0lORElSRUNUX0RFU0MpKQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmlydGJsa19x
dWV1ZV9kZXB0aCAvPSAyOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcXVldWVfZGVwdGgg
Lz0gMjsKPj4+ICvCoMKgwqAgfSBlbHNlIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBxdWV1ZV9kZXB0
aCA9IHZpcnRibGtfcXVldWVfZGVwdGg7Cj4+PiAgwqDCoMKgwqDCoCB9Cj4+PiAgwqAgwqDCoMKg
wqDCoCBtZW1zZXQoJnZibGstPnRhZ19zZXQsIDAsIHNpemVvZih2YmxrLT50YWdfc2V0KSk7Cj4+
PiAgwqDCoMKgwqDCoCB2YmxrLT50YWdfc2V0Lm9wcyA9ICZ2aXJ0aW9fbXFfb3BzOwo+Pj4gLcKg
wqDCoCB2YmxrLT50YWdfc2V0LnF1ZXVlX2RlcHRoID0gdmlydGJsa19xdWV1ZV9kZXB0aDsKPj4+
ICvCoMKgwqAgdmJsay0+dGFnX3NldC5xdWV1ZV9kZXB0aCA9IHF1ZXVlX2RlcHRoOwo+Pj4gIMKg
wqDCoMKgwqAgdmJsay0+dGFnX3NldC5udW1hX25vZGUgPSBOVU1BX05PX05PREU7Cj4+PiAgwqDC
oMKgwqDCoCB2YmxrLT50YWdfc2V0LmZsYWdzID0gQkxLX01RX0ZfU0hPVUxEX01FUkdFOwo+Pj4g
IMKgwqDCoMKgwqAgdmJsay0+dGFnX3NldC5jbWRfc2l6ZSA9CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
