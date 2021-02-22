Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA79C433E0
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 09:06:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F6664E77
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 09:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F6664E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B801C86FC9;
	Mon, 22 Feb 2021 09:06:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C8VsTer05QA5; Mon, 22 Feb 2021 09:06:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 267B1865D5;
	Mon, 22 Feb 2021 09:06:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14C34C000B;
	Mon, 22 Feb 2021 09:06:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38647C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 09:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 18534605DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 09:06:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id arq79e5S8GLR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 09:06:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDA7060590
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 09:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613984807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KO2eAxv01FOB+ShIuZKE9lvyTzxRP1g6QCSFRiLbDqI=;
 b=Y1j5jNE7s7lIT+zfj7vpDfVNBntzkk8q4NqaNqPcyVtdrhYX72vtj9CYjgd0NUkSE3WqQG
 TyZalEGVnxfkE9fUiEiNW2TmaWGHq4rWVzKBpLG9iA6kX+JBJPm1FZd+F0BkwPhypf5jVv
 O0MfHYQTGJQ3++GFICv3mD8X4fbsatw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-JJuZURN-PpCo1tLSn0cESA-1; Mon, 22 Feb 2021 04:06:43 -0500
X-MC-Unique: JJuZURN-PpCo1tLSn0cESA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF59A80402C;
 Mon, 22 Feb 2021 09:06:41 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-244.pek2.redhat.com
 [10.72.12.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC0AF57;
 Mon, 22 Feb 2021 09:06:35 +0000 (UTC)
Subject: Re: [PATCH] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210219084509.48269-1-jasowang@redhat.com>
 <4b2378d8-0061-c6ed-f377-492649869581@roeck-us.net>
 <2cf598ee-38cf-3c1c-33a9-1890e892a8e6@redhat.com>
 <20210222022550-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <48cc339b-a23e-7e56-5234-5b439173209e@redhat.com>
Date: Mon, 22 Feb 2021 17:06:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222022550-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
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

Ck9uIDIwMjEvMi8yMiAzOjI5IOS4i+WNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IE1vbiwgRmViIDIyLCAyMDIxIGF0IDExOjQyOjQ0QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+IE9uIDIwMjEvMi8xOSAxMTozOCDkuIvljYgsIEd1ZW50ZXIgUm9lY2sgd3JvdGU6Cj4+PiBP
biAyLzE5LzIxIDEyOjQ1IEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+IFdlIHVzZWQgdG8gcHJv
bXB0IENPTkZJR19WSVJUSU9fUENJX01PREVSTiB0byB1c2VyIHdoaWNoIG1heSBicmluZyBhCj4+
Pj4gbG90IG9mIGNvbmZ1c2lvbi4gRS5nIGl0IG1heSBicmVhayB2YXJpb3VzIGRlZmF1bHQgY29u
ZmlncyB3aGljaCB3YW50Cj4+Pj4gdmlydGlvIGRldmljZXMuCj4+Pj4KPj4+PiBTbyB0aGlzIHBh
dGNoIGZpeGVzIHRoaXMgYnkgaGlkZSB0aGUgcHJvbXBvdCBhbmQgZG9jdW1lbnQgdGhlCj4+PiAu
Li4gYnkgaGlkaW5nIHRoZSBwcm9tcHQgYW5kIGRvY3VtZW50aW5nIC4uLgo+Pgo+PiBIaSBNaWNo
YWVsOgo+Pgo+PiBXb3VsZCB5b3UgbGlrZSBtZSB0byBwb3N0IGEgbmV3IHZlcnNpb24gb3IgeW91
IGNhbiBmaXggdGhvc2UgdHlwb3Mgd2hlbgo+PiBhcHBseWluZyB0aGUgcGF0Y2g/Cj4+Cj4+IFRo
YW5rcwo+Cj4gQSBuZXcgdmVyc2lvbi4gSG93ZXZlciBJIGhhdmUgYSBzdWdnZXN0aW9uLgo+Cj4g
SG93IGFib3V0IHdlIGNhbGwgdGhlIG5ldyBsaWJyYXJ5IFZJUlRJT19QQ0lfTElCPyBUaGF0IHdv
dWxkIGJlCj4gYSBuZXcgYXV0by1zZWxlY3RlZCBzeW1ib2wuCj4KPiBXZSBjYW4gdGhlbiBrZWVw
IFZJUlRJT19QQ0kgYXMgYSBzeW1ib2wgZW5hYmxpbmcgdGhlIGFjdHVhbCBkcml2ZXIuCgoKT2ss
IHdpbGwgZG8uCgpUaGFua3MKCgo+Cj4KPgo+Pj4+IGRlcGVuZGVuY3kuCj4+Pj4KPj4+PiBDYzog
QXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPj4+PiBDYzogQW5kZXJzIFJveGVsbCA8YW5k
ZXJzLnJveGVsbEBsaW5hcm8ub3JnPgo+Pj4+IENjOiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vj
ay11cy5uZXQ+Cj4+Pj4gUmVwb3J0ZWQtYnk6IE5hcmVzaCBLYW1ib2p1IDxuYXJlc2gua2FtYm9q
dUBsaW5hcm8ub3JnPgo+Pj4+IEZpeGVzOiA4NmI4N2M5ZDg1OGI2ICgidmlydGlvLXBjaTogaW50
cm9kdWNlIG1vZGVybiBkZXZpY2UgbW9kdWxlIikKPj4+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Pj4gUmV2aWV3ZWQtYnk6IEd1ZW50ZXIgUm9lY2sg
PGxpbnV4QHJvZWNrLXVzLm5ldD4KPj4+Cj4+Pj4gLS0tCj4+Pj4gICAgZHJpdmVycy92aXJ0aW8v
S2NvbmZpZyB8IDkgKysrKystLS0tCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRp
by9LY29uZmlnIGIvZHJpdmVycy92aXJ0aW8vS2NvbmZpZwo+Pj4+IGluZGV4IDZiOWI4MWY0Yjhj
Mi4uYmU3ZGYzNjliYzJiIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL0tjb25maWcK
Pj4+PiArKysgYi9kcml2ZXJzL3ZpcnRpby9LY29uZmlnCj4+Pj4gQEAgLTEzLDEyICsxMywxMiBA
QCBjb25maWcgQVJDSF9IQVNfUkVTVFJJQ1RFRF9WSVJUSU9fTUVNT1JZX0FDQ0VTUwo+Pj4+ICAg
IAkgIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STQo+Pj4+ICAgIGNvbmZpZyBWSVJUSU9fUENJX01P
REVSTgo+Pj4+IC0JdHJpc3RhdGUgIk1vZGVybiBWaXJ0aW8gUENJIERldmljZSIKPj4+PiAtCWRl
cGVuZHMgb24gUENJCj4+Pj4gKwl0cmlzdGF0ZQo+Pj4+ICAgIAloZWxwCj4+Pj4gICAgCSAgTW9k
ZXJuIFBDSSBkZXZpY2UgaW1wbGVtZW50YXRpb24uIFRoaXMgbW9kdWxlIGltcGxlbWVudHMgdGhl
Cj4+Pj4gICAgCSAgYmFzaWMgcHJvYmUgYW5kIGNvbnRyb2wgZm9yIGRldmljZXMgd2hpY2ggYXJl
IGJhc2VkIG9uIG1vZGVybgo+Pj4+IC0JICBQQ0kgZGV2aWNlIHdpdGggcG9zc2libGUgdmVuZG9y
IHNwZWNpZmljIGV4dGVuc2lvbnMuCj4+Pj4gKwkgIFBDSSBkZXZpY2Ugd2l0aCBwb3NzaWJsZSB2
ZW5kb3Igc3BlY2lmaWMgZXh0ZW5zaW9ucy4gQW55Cj4+Pj4gKwkgIG1vZHVsZSB0aGF0IHNlbGVj
dHMgdGhpcyBtb2R1bGUgbXVzdCBkZXBlbmQgb24gUENJLgo+Pj4+ICAgIG1lbnVjb25maWcgVklS
VElPX01FTlUKPj4+PiAgICAJYm9vbCAiVmlydGlvIGRyaXZlcnMiCj4+Pj4gQEAgLTI4LDcgKzI4
LDggQEAgaWYgVklSVElPX01FTlUKPj4+PiAgICBjb25maWcgVklSVElPX1BDSQo+Pj4+ICAgIAl0
cmlzdGF0ZSAiUENJIGRyaXZlciBmb3IgdmlydGlvIGRldmljZXMiCj4+Pj4gLQlkZXBlbmRzIG9u
IFZJUlRJT19QQ0lfTU9ERVJOCj4+Pj4gKwlkZXBlbmRzIG9uIFBDSQo+Pj4+ICsJc2VsZWN0IFZJ
UlRJT19QQ0lfTU9ERVJOCj4+Pj4gICAgCXNlbGVjdCBWSVJUSU8KPj4+PiAgICAJaGVscAo+Pj4+
ICAgIAkgIFRoaXMgZHJpdmVyIHByb3ZpZGVzIHN1cHBvcnQgZm9yIHZpcnRpbyBiYXNlZCBwYXJh
dmlydHVhbCBkZXZpY2UKPj4+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
