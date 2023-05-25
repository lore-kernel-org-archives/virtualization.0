Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6154C7EE2C
	for <virtualization@archiver.kernel.org>; Thu, 25 May 2023 09:38:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1D17040604;
	Thu, 25 May 2023 09:38:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D17040604
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pmr7I2NJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rn0SQngM9W9A; Thu, 25 May 2023 09:38:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 73F59400F1;
	Thu, 25 May 2023 09:38:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73F59400F1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 517F8C0036;
	Thu, 25 May 2023 09:38:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6010C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 09:38:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A52F403AA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 09:38:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A52F403AA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BeCvYvBX2a7Q
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 09:38:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48A0D400F1
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 48A0D400F1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 09:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685007507; x=1716543507;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=X3H1xaLyDeV18F16CTlYWlNYtJeUKC65lzmXvO3hI+Y=;
 b=Pmr7I2NJKOYOeqo5oz/jyKodx6Q/k4y3nU3Y74HBzVs1ZDGyzlyHgv3x
 hxtIcZZA13OXMqIxVxhXgZ4SfR4D0Pf29D2NCp2PVGX/3Uw4Ev0x0nB0S
 Bv71E76W0eV0CH3osJiooBDcOqdWbbxs6Os+VbKGw/11LLzLu+vmoyqaU
 pWAjvNM/U/rpQsdTGvYPKxzo8NQeisJw6xD024J4+oV6gTmv/o3uGtbj4
 3E1Ejozj3nk4jGq3vfq63M+I3gDpCPVTfiqJm8ZODoe6+PLY2x9m2pwid
 1xj04+aP6Iq1nAlw1CvrPDFLtfn7H94YmP7yzxDvoHGhvE6eIcYN1Cnf2 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="440197418"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; d="scan'208";a="440197418"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 02:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="1034905558"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; d="scan'208";a="1034905558"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.254.215.82])
 ([10.254.215.82])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 02:38:00 -0700
Message-ID: <20d83aaf-2439-7a21-cc75-7db2e0de4659@intel.com>
Date: Thu, 25 May 2023 17:37:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V2 4/5] vDPA/ifcvf: synchronize irqs in the reset routine
To: Jason Wang <jasowang@redhat.com>
References: <20230508180512.17371-1-lingshan.zhu@intel.com>
 <20230508180512.17371-5-lingshan.zhu@intel.com>
 <CACGkMEsoBw3MGzoDBG2p6Txv+0c=6JuNQDV89tg1io04QdNK9A@mail.gmail.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEsoBw3MGzoDBG2p6Txv+0c=6JuNQDV89tg1io04QdNK9A@mail.gmail.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiA1LzI0LzIwMjMgNDowMyBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBNb24sIE1heSA4
LCAyMDIzIGF0IDY6MDXigK9QTSBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+
IHdyb3RlOgo+PiBUaGlzIGNvbW1pdCBzeW5jaHJvbml6ZSBpcnFzIG9mIHRoZSB2aXJ0cXVldWVz
Cj4+IGFuZCBjb25maWcgc3BhY2UgaW4gdGhlIHJlc2V0IHJvdXRpbmUuCj4+IFRodXMgaWZjdmZf
c3RvcF9odygpIGFuZCByZXNldCgpIGFyZSByZWZhY3RvcmVkIGFzIHdlbGwuCj4+Cj4+IFNpZ25l
ZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4gLS0tCj4+
ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyB8IDQxICsrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tCj4+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8ICAxICsK
Pj4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgNDYgKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCsp
LCA1MCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9iYXNlLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4+IGluZGV4IDc5
ZTMxM2M1ZTEwZS4uMWYzOTI5MGJhYTM4IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5jCj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMK
Pj4gQEAgLTE3MCwxMiArMTcwLDkgQEAgdm9pZCBpZmN2Zl9zZXRfc3RhdHVzKHN0cnVjdCBpZmN2
Zl9odyAqaHcsIHU4IHN0YXR1cykKPj4KPj4gICB2b2lkIGlmY3ZmX3Jlc2V0KHN0cnVjdCBpZmN2
Zl9odyAqaHcpCj4+ICAgewo+PiAtICAgICAgIGh3LT5jb25maWdfY2IuY2FsbGJhY2sgPSBOVUxM
Owo+PiAtICAgICAgIGh3LT5jb25maWdfY2IucHJpdmF0ZSA9IE5VTEw7Cj4+IC0KPj4gICAgICAg
ICAgaWZjdmZfc2V0X3N0YXR1cyhodywgMCk7Cj4+IC0gICAgICAgLyogZmx1c2ggc2V0X3N0YXR1
cywgbWFrZSBzdXJlIFZGIGlzIHN0b3BwZWQsIHJlc2V0ICovCj4+IC0gICAgICAgaWZjdmZfZ2V0
X3N0YXR1cyhodyk7Cj4+ICsgICAgICAgd2hpbGUgKGlmY3ZmX2dldF9zdGF0dXMoaHcpKQo+PiAr
ICAgICAgICAgICAgICAgbXNsZWVwKDEpOwo+PiAgIH0KPj4KPj4gICB1NjQgaWZjdmZfZ2V0X2h3
X2ZlYXR1cmVzKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4+IEBAIC0zNjgsMjAgKzM2NSw0MiBAQCB2
b2lkIGlmY3ZmX3NldF92cV9yZWFkeShzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlkLCBib29s
IHJlYWR5KQo+PiAgICAgICAgICB2cF9pb3dyaXRlMTYocmVhZHksICZjZmctPnF1ZXVlX2VuYWJs
ZSk7Cj4+ICAgfQo+Pgo+PiAtc3RhdGljIHZvaWQgaWZjdmZfaHdfZGlzYWJsZShzdHJ1Y3QgaWZj
dmZfaHcgKmh3KQo+PiArc3RhdGljIHZvaWQgaWZjdmZfcmVzZXRfdnJpbmcoc3RydWN0IGlmY3Zm
X2h3ICpodykKPj4gICB7Cj4+IC0gICAgICAgdTMyIGk7Cj4+ICsgICAgICAgdTE2IHFpZDsKPj4g
Kwo+PiArICAgICAgIGZvciAocWlkID0gMDsgcWlkIDwgaHctPm5yX3ZyaW5nOyBxaWQrKykgewo+
PiArICAgICAgICAgICAgICAgaHctPnZyaW5nW3FpZF0uY2IuY2FsbGJhY2sgPSBOVUxMOwo+PiAr
ICAgICAgICAgICAgICAgaHctPnZyaW5nW3FpZF0uY2IucHJpdmF0ZSA9IE5VTEw7Cj4+ICsgICAg
ICAgICAgICAgICBpZmN2Zl9zZXRfdnFfdmVjdG9yKGh3LCBxaWQsIFZJUlRJT19NU0lfTk9fVkVD
VE9SKTsKPj4gKyAgICAgICB9Cj4+ICt9Cj4+Cj4+ICtzdGF0aWMgdm9pZCBpZmN2Zl9yZXNldF9j
b25maWdfaGFuZGxlcihzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+PiArewo+PiArICAgICAgIGh3LT5j
b25maWdfY2IuY2FsbGJhY2sgPSBOVUxMOwo+PiArICAgICAgIGh3LT5jb25maWdfY2IucHJpdmF0
ZSA9IE5VTEw7Cj4+ICAgICAgICAgIGlmY3ZmX3NldF9jb25maWdfdmVjdG9yKGh3LCBWSVJUSU9f
TVNJX05PX1ZFQ1RPUik7Cj4+IC0gICAgICAgZm9yIChpID0gMDsgaSA8IGh3LT5ucl92cmluZzsg
aSsrKSB7Cj4+IC0gICAgICAgICAgICAgICBpZmN2Zl9zZXRfdnFfdmVjdG9yKGh3LCBpLCBWSVJU
SU9fTVNJX05PX1ZFQ1RPUik7Cj4+ICt9Cj4+ICsKPj4gK3N0YXRpYyB2b2lkIGlmY3ZmX3N5bmNo
cm9uaXplX2lycShzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+PiArewo+PiArICAgICAgIHUzMiBudmVj
dG9ycyA9IGh3LT5udW1fbXNpeF92ZWN0b3JzOwo+PiArICAgICAgIHN0cnVjdCBwY2lfZGV2ICpw
ZGV2ID0gaHctPnBkZXY7Cj4+ICsgICAgICAgaW50IGksIGlycTsKPj4gKwo+PiArICAgICAgIGZv
ciAoaSA9IDA7IGkgPCBudmVjdG9yczsgaSsrKSB7Cj4+ICsgICAgICAgICAgICAgICBpcnEgPSBw
Y2lfaXJxX3ZlY3RvcihwZGV2LCBpKTsKPj4gKyAgICAgICAgICAgICAgIGlmIChpcnEgPj0gMCkK
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgc3luY2hyb25pemVfaXJxKGlycSk7Cj4+ICAgICAg
ICAgIH0KPj4gICB9Cj4+Cj4+ICAgdm9pZCBpZmN2Zl9zdG9wX2h3KHN0cnVjdCBpZmN2Zl9odyAq
aHcpCj4+ICAgewo+PiAtICAgICAgIGlmY3ZmX2h3X2Rpc2FibGUoaHcpOwo+PiAtICAgICAgIGlm
Y3ZmX3Jlc2V0KGh3KTsKPj4gKyAgICAgICBpZmN2Zl9zeW5jaHJvbml6ZV9pcnEoaHcpOwo+PiAr
ICAgICAgIGlmY3ZmX3Jlc2V0X3ZyaW5nKGh3KTsKPj4gKyAgICAgICBpZmN2Zl9yZXNldF9jb25m
aWdfaGFuZGxlcihodyk7Cj4gTml0Ogo+Cj4gU28gdGhlIG5hbWUgb2YgdGhpcyBmdW5jdGlvbiBp
cyBraW5kIG9mIG1pc2xlYWRpbmcgc2luY2UgaXJxCj4gc3luY2hyb25pemF0aW9uIGFuZCB2aXJ0
cXVldWUvY29uZmlnIGhhbmRsZXIgYXJlIG5vdCBiZWxvbmcgdG8KPiBoYXJkd2FyZT8KPgo+IE1h
eWJlIGl0IHdvdWxkIGJlIGJldHRlciB0byBjYWxsIGl0IGlmY3ZmX3N0b3AoKS4KU3VyZSwgSSB3
aWxsIHNlbmQgYSBWMyB3aXRoIHRoaXMgcmVuYW1pbmcsCmRvIHlvdSBhY2sgcGF0Y2ggMS81PwoK
VGhhbmtzClpodSBMaW5nc2hhbgo+Cj4gVGhhbmtzCj4KPj4gICB9Cj4+Cj4+ICAgdm9pZCBpZmN2
Zl9ub3RpZnlfcXVldWUoc3RydWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCkKPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggYi9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfYmFzZS5oCj4+IGluZGV4IGQzNGQzYmMwZGJmNC4uNzQzMGY4MDc3OWJlIDEwMDY0NAo+
PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4+ICsrKyBiL2RyaXZlcnMv
dmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPj4gQEAgLTgyLDYgKzgyLDcgQEAgc3RydWN0IGlmY3Zm
X2h3IHsKPj4gICAgICAgICAgaW50IHZxc19yZXVzZWRfaXJxOwo+PiAgICAgICAgICB1MTYgbnJf
dnJpbmc7Cj4+ICAgICAgICAgIC8qIFZJUlRJT19QQ0lfQ0FQX0RFVklDRV9DRkcgc2l6ZSAqLwo+
PiArICAgICAgIHUzMiBudW1fbXNpeF92ZWN0b3JzOwo+PiAgICAgICAgICB1MzIgY2FwX2Rldl9j
b25maWdfc2l6ZTsKPj4gICAgICAgICAgc3RydWN0IHBjaV9kZXYgKnBkZXY7Cj4+ICAgfTsKPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgYi9kcml2ZXJzL3Zk
cGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+IGluZGV4IDk2ODY4NzE1OWU0NC4uMzQwMWI5OTAxZGQy
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+ICsrKyBi
L2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4gQEAgLTEyNSw2ICsxMjUsNyBAQCBz
dGF0aWMgdm9pZCBpZmN2Zl9mcmVlX2lycShzdHJ1Y3QgaWZjdmZfaHcgKnZmKQo+PiAgICAgICAg
ICBpZmN2Zl9mcmVlX3ZxX2lycSh2Zik7Cj4+ICAgICAgICAgIGlmY3ZmX2ZyZWVfY29uZmlnX2ly
cSh2Zik7Cj4+ICAgICAgICAgIGlmY3ZmX2ZyZWVfaXJxX3ZlY3RvcnMocGRldik7Cj4+ICsgICAg
ICAgdmYtPm51bV9tc2l4X3ZlY3RvcnMgPSAwOwo+PiAgIH0KPj4KPj4gICAvKiBpZmN2ZiBNU0lY
IHZlY3RvcnMgYWxsb2NhdG9yLCB0aGlzIGhlbHBlciB0cmllcyB0byBhbGxvY2F0ZQo+PiBAQCAt
MzQzLDM2ICszNDQsMTEgQEAgc3RhdGljIGludCBpZmN2Zl9yZXF1ZXN0X2lycShzdHJ1Y3QgaWZj
dmZfaHcgKnZmKQo+PiAgICAgICAgICBpZiAocmV0KQo+PiAgICAgICAgICAgICAgICAgIHJldHVy
biByZXQ7Cj4+Cj4+IC0gICAgICAgcmV0dXJuIDA7Cj4+IC19Cj4+IC0KPj4gLXN0YXRpYyBpbnQg
aWZjdmZfc3RvcF9kYXRhcGF0aChzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqYWRhcHRlcikKPj4gLXsK
Pj4gLSAgICAgICBzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gYWRhcHRlci0+dmY7Cj4+IC0gICAgICAg
aW50IGk7Cj4+IC0KPj4gLSAgICAgICBmb3IgKGkgPSAwOyBpIDwgdmYtPm5yX3ZyaW5nOyBpKysp
Cj4+IC0gICAgICAgICAgICAgICB2Zi0+dnJpbmdbaV0uY2IuY2FsbGJhY2sgPSBOVUxMOwo+PiAt
Cj4+IC0gICAgICAgaWZjdmZfc3RvcF9odyh2Zik7Cj4+ICsgICAgICAgdmYtPm51bV9tc2l4X3Zl
Y3RvcnMgPSBudmVjdG9yczsKPj4KPj4gICAgICAgICAgcmV0dXJuIDA7Cj4+ICAgfQo+Pgo+PiAt
c3RhdGljIHZvaWQgaWZjdmZfcmVzZXRfdnJpbmcoc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0
ZXIpCj4+IC17Cj4+IC0gICAgICAgc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IGFkYXB0ZXItPnZmOwo+
PiAtICAgICAgIGludCBpOwo+PiAtCj4+IC0gICAgICAgZm9yIChpID0gMDsgaSA8IHZmLT5ucl92
cmluZzsgaSsrKSB7Cj4+IC0gICAgICAgICAgICAgICB2Zi0+dnJpbmdbaV0ubGFzdF9hdmFpbF9p
ZHggPSAwOwo+PiAtICAgICAgICAgICAgICAgdmYtPnZyaW5nW2ldLmNiLmNhbGxiYWNrID0gTlVM
TDsKPj4gLSAgICAgICAgICAgICAgIHZmLT52cmluZ1tpXS5jYi5wcml2YXRlID0gTlVMTDsKPj4g
LSAgICAgICB9Cj4+IC0KPj4gLSAgICAgICBpZmN2Zl9yZXNldCh2Zik7Cj4+IC19Cj4+IC0KPj4g
ICBzdGF0aWMgc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKnZkcGFfdG9fYWRhcHRlcihzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkcGFfZGV2KQo+PiAgIHsKPj4gICAgICAgICAgcmV0dXJuIGNvbnRhaW5lcl9v
Zih2ZHBhX2Rldiwgc3RydWN0IGlmY3ZmX2FkYXB0ZXIsIHZkcGEpOwo+PiBAQCAtNDYyLDIzICs0
MzgsMTUgQEAgc3RhdGljIHZvaWQgaWZjdmZfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRwYV9kZXYsIHU4IHN0YXR1cykKPj4KPj4gICBzdGF0aWMgaW50IGlmY3ZmX3ZkcGFf
cmVzZXQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPj4gICB7Cj4+IC0gICAgICAgc3Ry
dWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXI7Cj4+IC0gICAgICAgc3RydWN0IGlmY3ZmX2h3ICp2
ZjsKPj4gLSAgICAgICB1OCBzdGF0dXNfb2xkOwo+PiAtCj4+IC0gICAgICAgdmYgID0gdmRwYV90
b192Zih2ZHBhX2Rldik7Cj4+IC0gICAgICAgYWRhcHRlciA9IHZkcGFfdG9fYWRhcHRlcih2ZHBh
X2Rldik7Cj4+IC0gICAgICAgc3RhdHVzX29sZCA9IGlmY3ZmX2dldF9zdGF0dXModmYpOwo+PiAr
ICAgICAgIHN0cnVjdCBpZmN2Zl9odyAqdmYgPSB2ZHBhX3RvX3ZmKHZkcGFfZGV2KTsKPj4gKyAg
ICAgICB1OCBzdGF0dXMgPSBpZmN2Zl9nZXRfc3RhdHVzKHZmKTsKPj4KPj4gLSAgICAgICBpZiAo
c3RhdHVzX29sZCA9PSAwKQo+PiAtICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4+ICsgICAgICAg
aWZjdmZfc3RvcF9odyh2Zik7Cj4+Cj4+IC0gICAgICAgaWYgKHN0YXR1c19vbGQgJiBWSVJUSU9f
Q09ORklHX1NfRFJJVkVSX09LKSB7Cj4+IC0gICAgICAgICAgICAgICBpZmN2Zl9zdG9wX2RhdGFw
YXRoKGFkYXB0ZXIpOwo+PiArICAgICAgIGlmIChzdGF0dXMgJiBWSVJUSU9fQ09ORklHX1NfRFJJ
VkVSX09LKQo+PiAgICAgICAgICAgICAgICAgIGlmY3ZmX2ZyZWVfaXJxKHZmKTsKPj4gLSAgICAg
ICB9Cj4+Cj4+IC0gICAgICAgaWZjdmZfcmVzZXRfdnJpbmcoYWRhcHRlcik7Cj4+ICsgICAgICAg
aWZjdmZfcmVzZXQodmYpOwo+Pgo+PiAgICAgICAgICByZXR1cm4gMDsKPj4gICB9Cj4+IC0tCj4+
IDIuMzkuMQo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
