Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AB9C433E0
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 03:43:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9737E64ECD
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 03:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9737E64ECD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5BC778708D;
	Mon, 22 Feb 2021 03:43:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p6lHSwzSeJUf; Mon, 22 Feb 2021 03:42:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9C8228707C;
	Mon, 22 Feb 2021 03:42:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D6BAC000B;
	Mon, 22 Feb 2021 03:42:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A072C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:42:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 537D66F4E7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:42:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cQDpoLDLPSqk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:42:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 093E76F478
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613965374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5FgwOcgARw510tfV3ROtFeyWaKvqfB9V+RtxJnvgu0=;
 b=T6ZR1+u0PUdF+XcRKFtZdnRCe/w0hArMxwvQjuSnWqHj2Xc+585Aevpj+5EtDRPxyXPY0t
 zm0/UG9LT3UDh0bE27ZepNZmn+Ho5GsTNGvkdGJG5T9vNqGPr3/P/NOgZ+5Fo85b6oSx7+
 4K6+dRmrUFcKyxQoy1PWbnq4p7GN2bA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-YdGSBIKFOyG22CGdpSMG_w-1; Sun, 21 Feb 2021 22:42:52 -0500
X-MC-Unique: YdGSBIKFOyG22CGdpSMG_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB59410066EE;
 Mon, 22 Feb 2021 03:42:50 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-112.pek2.redhat.com
 [10.72.13.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABAB2614FD;
 Mon, 22 Feb 2021 03:42:45 +0000 (UTC)
Subject: Re: [PATCH] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
To: Guenter Roeck <linux@roeck-us.net>, mst@redhat.com
References: <20210219084509.48269-1-jasowang@redhat.com>
 <4b2378d8-0061-c6ed-f377-492649869581@roeck-us.net>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2cf598ee-38cf-3c1c-33a9-1890e892a8e6@redhat.com>
Date: Mon, 22 Feb 2021 11:42:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4b2378d8-0061-c6ed-f377-492649869581@roeck-us.net>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Anders Roxell <anders.roxell@linaro.org>, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi8xOSAxMTozOCDkuIvljYgsIEd1ZW50ZXIgUm9lY2sgd3JvdGU6Cj4gT24gMi8x
OS8yMSAxMjo0NSBBTSwgSmFzb24gV2FuZyB3cm90ZToKPj4gV2UgdXNlZCB0byBwcm9tcHQgQ09O
RklHX1ZJUlRJT19QQ0lfTU9ERVJOIHRvIHVzZXIgd2hpY2ggbWF5IGJyaW5nIGEKPj4gbG90IG9m
IGNvbmZ1c2lvbi4gRS5nIGl0IG1heSBicmVhayB2YXJpb3VzIGRlZmF1bHQgY29uZmlncyB3aGlj
aCB3YW50Cj4+IHZpcnRpbyBkZXZpY2VzLgo+Pgo+PiBTbyB0aGlzIHBhdGNoIGZpeGVzIHRoaXMg
YnkgaGlkZSB0aGUgcHJvbXBvdCBhbmQgZG9jdW1lbnQgdGhlCj4gLi4uIGJ5IGhpZGluZyB0aGUg
cHJvbXB0IGFuZCBkb2N1bWVudGluZyAuLi4KCgpIaSBNaWNoYWVsOgoKV291bGQgeW91IGxpa2Ug
bWUgdG8gcG9zdCBhIG5ldyB2ZXJzaW9uIG9yIHlvdSBjYW4gZml4IHRob3NlIHR5cG9zIHdoZW4g
CmFwcGx5aW5nIHRoZSBwYXRjaD8KClRoYW5rcwoKCj4KPj4gZGVwZW5kZW5jeS4KPj4KPj4gQ2M6
IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+Cj4+IENjOiBBbmRlcnMgUm94ZWxsIDxhbmRl
cnMucm94ZWxsQGxpbmFyby5vcmc+Cj4+IENjOiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11
cy5uZXQ+Cj4+IFJlcG9ydGVkLWJ5OiBOYXJlc2ggS2FtYm9qdSA8bmFyZXNoLmthbWJvanVAbGlu
YXJvLm9yZz4KPj4gRml4ZXM6IDg2Yjg3YzlkODU4YjYgKCJ2aXJ0aW8tcGNpOiBpbnRyb2R1Y2Ug
bW9kZXJuIGRldmljZSBtb2R1bGUiKQo+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPgo+IFJldmlld2VkLWJ5OiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vj
ay11cy5uZXQ+Cj4KPj4gLS0tCj4+ICAgZHJpdmVycy92aXJ0aW8vS2NvbmZpZyB8IDkgKysrKyst
LS0tCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
Pj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL0tjb25maWcgYi9kcml2ZXJzL3ZpcnRp
by9LY29uZmlnCj4+IGluZGV4IDZiOWI4MWY0YjhjMi4uYmU3ZGYzNjliYzJiIDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL3ZpcnRpby9LY29uZmlnCj4+ICsrKyBiL2RyaXZlcnMvdmlydGlvL0tjb25m
aWcKPj4gQEAgLTEzLDEyICsxMywxMiBAQCBjb25maWcgQVJDSF9IQVNfUkVTVFJJQ1RFRF9WSVJU
SU9fTUVNT1JZX0FDQ0VTUwo+PiAgIAkgIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STQo+PiAgIAo+
PiAgIGNvbmZpZyBWSVJUSU9fUENJX01PREVSTgo+PiAtCXRyaXN0YXRlICJNb2Rlcm4gVmlydGlv
IFBDSSBEZXZpY2UiCj4+IC0JZGVwZW5kcyBvbiBQQ0kKPj4gKwl0cmlzdGF0ZQo+PiAgIAloZWxw
Cj4+ICAgCSAgTW9kZXJuIFBDSSBkZXZpY2UgaW1wbGVtZW50YXRpb24uIFRoaXMgbW9kdWxlIGlt
cGxlbWVudHMgdGhlCj4+ICAgCSAgYmFzaWMgcHJvYmUgYW5kIGNvbnRyb2wgZm9yIGRldmljZXMg
d2hpY2ggYXJlIGJhc2VkIG9uIG1vZGVybgo+PiAtCSAgUENJIGRldmljZSB3aXRoIHBvc3NpYmxl
IHZlbmRvciBzcGVjaWZpYyBleHRlbnNpb25zLgo+PiArCSAgUENJIGRldmljZSB3aXRoIHBvc3Np
YmxlIHZlbmRvciBzcGVjaWZpYyBleHRlbnNpb25zLiBBbnkKPj4gKwkgIG1vZHVsZSB0aGF0IHNl
bGVjdHMgdGhpcyBtb2R1bGUgbXVzdCBkZXBlbmQgb24gUENJLgo+PiAgIAo+PiAgIG1lbnVjb25m
aWcgVklSVElPX01FTlUKPj4gICAJYm9vbCAiVmlydGlvIGRyaXZlcnMiCj4+IEBAIC0yOCw3ICsy
OCw4IEBAIGlmIFZJUlRJT19NRU5VCj4+ICAgCj4+ICAgY29uZmlnIFZJUlRJT19QQ0kKPj4gICAJ
dHJpc3RhdGUgIlBDSSBkcml2ZXIgZm9yIHZpcnRpbyBkZXZpY2VzIgo+PiAtCWRlcGVuZHMgb24g
VklSVElPX1BDSV9NT0RFUk4KPj4gKwlkZXBlbmRzIG9uIFBDSQo+PiArCXNlbGVjdCBWSVJUSU9f
UENJX01PREVSTgo+PiAgIAlzZWxlY3QgVklSVElPCj4+ICAgCWhlbHAKPj4gICAJICBUaGlzIGRy
aXZlciBwcm92aWRlcyBzdXBwb3J0IGZvciB2aXJ0aW8gYmFzZWQgcGFyYXZpcnR1YWwgZGV2aWNl
Cj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
