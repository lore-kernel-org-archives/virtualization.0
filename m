Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AA6C77B7A
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 06:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA8D8841CC;
	Fri, 26 May 2023 06:36:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA8D8841CC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GYYSyAXM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nha3KlsnQWJY; Fri, 26 May 2023 06:36:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5BBB984364;
	Fri, 26 May 2023 06:36:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5BBB984364
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D0DEC0036;
	Fri, 26 May 2023 06:36:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E0D7C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6572640A01
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:36:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6572640A01
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=GYYSyAXM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WRoD2o4eUFZX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:35:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B0867403AA
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B0867403AA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685082959; x=1716618959;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XtLJVxUDZ2pIk4i4jcar14/AqAzv/mwYc59dgZS5mWU=;
 b=GYYSyAXMre83S8k0Yr73Pbvt21Olgt0Sy03/Xf4GN/vMk6k9ZifDEN3A
 5qECkcVk0xRLanxpcgItJWy1OPCvMJMdiu6Ap3AIPQokGa+tKuhIAs0MN
 s0M9pXIqKtmwNV03Fn+cLG3LQPdEG6zYSIYloxRjyyT+uYGyNwdkoz91k
 dZCQULqVm9jmSJNEmpMvMgFXE/madZud6ZpAlB4O81TUa7iMTe90Zv+yV
 C5n8A3uCA/egIzMYIEilUXdMkiIlc2OZipikpglCGgTxuSAEnYr3jplBO
 LVBM7gOLVSwDsMhnfdytXEFk1r3LJD2IYNavxUjfcmCGRmTKuGmxl9ZA/ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="334480263"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="334480263"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 23:35:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="738140120"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="738140120"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.255.29.112])
 ([10.255.29.112])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 23:35:48 -0700
Message-ID: <875ea277-784a-0230-826f-4e46154ebbbe@intel.com>
Date: Fri, 26 May 2023 14:35:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V2 4/5] vDPA/ifcvf: synchronize irqs in the reset routine
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230508180512.17371-1-lingshan.zhu@intel.com>
 <20230508180512.17371-5-lingshan.zhu@intel.com>
 <CACGkMEsoBw3MGzoDBG2p6Txv+0c=6JuNQDV89tg1io04QdNK9A@mail.gmail.com>
 <20d83aaf-2439-7a21-cc75-7db2e0de4659@intel.com>
 <CACGkMEtmSBhaMrVCLO6TLJ40_fY5pwa2p+jC6=Q0D09zUJRcOg@mail.gmail.com>
 <7e355ae0-158a-e308-1e26-7c562a78c9d9@intel.com>
 <1ffe2d2b-e28b-11e3-e411-a875de1b3cc2@intel.com>
 <CACGkMEu37S6FXku3HYw5rRpmDn4mkYOq+bHNqmpD=gxie7VBUw@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEu37S6FXku3HYw5rRpmDn4mkYOq+bHNqmpD=gxie7VBUw@mail.gmail.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org
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

CgpPbiA1LzI2LzIwMjMgMjowOSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBGcmksIE1heSAy
NiwgMjAyMyBhdCAxOjMw4oCvUE0gWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNv
bT4gd3JvdGU6Cj4+Cj4+Cj4+IE9uIDUvMjYvMjAyMyAxMTozNiBBTSwgWmh1LCBMaW5nc2hhbiB3
cm90ZToKPj4+Cj4+PiBPbiA1LzI2LzIwMjMgOTozNCBBTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+
PiBPbiBUaHUsIE1heSAyNSwgMjAyMyBhdCA1OjM44oCvUE0gWmh1LCBMaW5nc2hhbgo+Pj4+IDxs
aW5nc2hhbi56aHVAaW50ZWwuY29tPiB3cm90ZToKPj4+Pj4KPj4+Pj4gT24gNS8yNC8yMDIzIDQ6
MDMgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+PiBPbiBNb24sIE1heSA4LCAyMDIzIGF0IDY6
MDXigK9QTSBaaHUgTGluZ3NoYW4KPj4+Pj4+IDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPiB3cm90
ZToKPj4+Pj4+PiBUaGlzIGNvbW1pdCBzeW5jaHJvbml6ZSBpcnFzIG9mIHRoZSB2aXJ0cXVldWVz
Cj4+Pj4+Pj4gYW5kIGNvbmZpZyBzcGFjZSBpbiB0aGUgcmVzZXQgcm91dGluZS4KPj4+Pj4+PiBU
aHVzIGlmY3ZmX3N0b3BfaHcoKSBhbmQgcmVzZXQoKSBhcmUgcmVmYWN0b3JlZCBhcyB3ZWxsLgo+
Pj4+Pj4+Cj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVA
aW50ZWwuY29tPgo+Pj4+Pj4+IC0tLQo+Pj4+Pj4+ICAgICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZj
dmZfYmFzZS5jIHwgNDEgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0KPj4+Pj4+PiAgICAg
ZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8ICAxICsKPj4+Pj4+PiAgICAgZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDQ2Cj4+Pj4+Pj4gKysrKystLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCj4+Pj4+Pj4gICAgIDMgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9u
cygrKSwgNTAgZGVsZXRpb25zKC0pCj4+Pj4+Pj4KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+Pj4+Pj4+IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lm
Y3ZmX2Jhc2UuYwo+Pj4+Pj4+IGluZGV4IDc5ZTMxM2M1ZTEwZS4uMWYzOTI5MGJhYTM4IDEwMDY0
NAo+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMKPj4+Pj4+PiAr
KysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4+Pj4+Pj4gQEAgLTE3MCwxMiAr
MTcwLDkgQEAgdm9pZCBpZmN2Zl9zZXRfc3RhdHVzKHN0cnVjdCBpZmN2Zl9odyAqaHcsIHU4Cj4+
Pj4+Pj4gc3RhdHVzKQo+Pj4+Pj4+Cj4+Pj4+Pj4gICAgIHZvaWQgaWZjdmZfcmVzZXQoc3RydWN0
IGlmY3ZmX2h3ICpodykKPj4+Pj4+PiAgICAgewo+Pj4+Pj4+IC0gICAgICAgaHctPmNvbmZpZ19j
Yi5jYWxsYmFjayA9IE5VTEw7Cj4+Pj4+Pj4gLSAgICAgICBody0+Y29uZmlnX2NiLnByaXZhdGUg
PSBOVUxMOwo+Pj4+Pj4+IC0KPj4+Pj4+PiAgICAgICAgICAgIGlmY3ZmX3NldF9zdGF0dXMoaHcs
IDApOwo+Pj4+Pj4+IC0gICAgICAgLyogZmx1c2ggc2V0X3N0YXR1cywgbWFrZSBzdXJlIFZGIGlz
IHN0b3BwZWQsIHJlc2V0ICovCj4+Pj4+Pj4gLSAgICAgICBpZmN2Zl9nZXRfc3RhdHVzKGh3KTsK
Pj4+Pj4+PiArICAgICAgIHdoaWxlIChpZmN2Zl9nZXRfc3RhdHVzKGh3KSkKPj4+Pj4+PiArICAg
ICAgICAgICAgICAgbXNsZWVwKDEpOwo+Pj4+Pj4+ICAgICB9Cj4+Pj4+Pj4KPj4+Pj4+PiAgICAg
dTY0IGlmY3ZmX2dldF9od19mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+Pj4+Pj4+IEBA
IC0zNjgsMjAgKzM2NSw0MiBAQCB2b2lkIGlmY3ZmX3NldF92cV9yZWFkeShzdHJ1Y3QgaWZjdmZf
aHcgKmh3LAo+Pj4+Pj4+IHUxNiBxaWQsIGJvb2wgcmVhZHkpCj4+Pj4+Pj4gICAgICAgICAgICB2
cF9pb3dyaXRlMTYocmVhZHksICZjZmctPnF1ZXVlX2VuYWJsZSk7Cj4+Pj4+Pj4gICAgIH0KPj4+
Pj4+Pgo+Pj4+Pj4+IC1zdGF0aWMgdm9pZCBpZmN2Zl9od19kaXNhYmxlKHN0cnVjdCBpZmN2Zl9o
dyAqaHcpCj4+Pj4+Pj4gK3N0YXRpYyB2b2lkIGlmY3ZmX3Jlc2V0X3ZyaW5nKHN0cnVjdCBpZmN2
Zl9odyAqaHcpCj4+Pj4+Pj4gICAgIHsKPj4+Pj4+PiAtICAgICAgIHUzMiBpOwo+Pj4+Pj4+ICsg
ICAgICAgdTE2IHFpZDsKPj4+Pj4+PiArCj4+Pj4+Pj4gKyAgICAgICBmb3IgKHFpZCA9IDA7IHFp
ZCA8IGh3LT5ucl92cmluZzsgcWlkKyspIHsKPj4+Pj4+PiArICAgICAgICAgICAgICAgaHctPnZy
aW5nW3FpZF0uY2IuY2FsbGJhY2sgPSBOVUxMOwo+Pj4+Pj4+ICsgICAgICAgICAgICAgICBody0+
dnJpbmdbcWlkXS5jYi5wcml2YXRlID0gTlVMTDsKPj4+Pj4+PiArICAgICAgICAgICAgICAgaWZj
dmZfc2V0X3ZxX3ZlY3RvcihodywgcWlkLCBWSVJUSU9fTVNJX05PX1ZFQ1RPUik7Cj4+Pj4+Pj4g
KyAgICAgICB9Cj4+Pj4+Pj4gK30KPj4+Pj4+Pgo+Pj4+Pj4+ICtzdGF0aWMgdm9pZCBpZmN2Zl9y
ZXNldF9jb25maWdfaGFuZGxlcihzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+Pj4+Pj4+ICt7Cj4+Pj4+
Pj4gKyAgICAgICBody0+Y29uZmlnX2NiLmNhbGxiYWNrID0gTlVMTDsKPj4+Pj4+PiArICAgICAg
IGh3LT5jb25maWdfY2IucHJpdmF0ZSA9IE5VTEw7Cj4+Pj4+Pj4gICAgICAgICAgICBpZmN2Zl9z
ZXRfY29uZmlnX3ZlY3RvcihodywgVklSVElPX01TSV9OT19WRUNUT1IpOwo+Pj4+Pj4+IC0gICAg
ICAgZm9yIChpID0gMDsgaSA8IGh3LT5ucl92cmluZzsgaSsrKSB7Cj4+Pj4+Pj4gLSAgICAgICAg
ICAgICAgIGlmY3ZmX3NldF92cV92ZWN0b3IoaHcsIGksIFZJUlRJT19NU0lfTk9fVkVDVE9SKTsK
Pj4+Pj4+PiArfQo+Pj4+Pj4+ICsKPj4+Pj4+PiArc3RhdGljIHZvaWQgaWZjdmZfc3luY2hyb25p
emVfaXJxKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4+Pj4+Pj4gK3sKPj4+Pj4+PiArICAgICAgIHUz
MiBudmVjdG9ycyA9IGh3LT5udW1fbXNpeF92ZWN0b3JzOwo+Pj4+Pj4+ICsgICAgICAgc3RydWN0
IHBjaV9kZXYgKnBkZXYgPSBody0+cGRldjsKPj4+Pj4+PiArICAgICAgIGludCBpLCBpcnE7Cj4+
Pj4+Pj4gKwo+Pj4+Pj4+ICsgICAgICAgZm9yIChpID0gMDsgaSA8IG52ZWN0b3JzOyBpKyspIHsK
Pj4+Pj4+PiArICAgICAgICAgICAgICAgaXJxID0gcGNpX2lycV92ZWN0b3IocGRldiwgaSk7Cj4+
Pj4+Pj4gKyAgICAgICAgICAgICAgIGlmIChpcnEgPj0gMCkKPj4+Pj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICBzeW5jaHJvbml6ZV9pcnEoaXJxKTsKPj4+Pj4+PiAgICAgICAgICAgIH0KPj4+
Pj4+PiAgICAgfQo+Pj4+Pj4+Cj4+Pj4+Pj4gICAgIHZvaWQgaWZjdmZfc3RvcF9odyhzdHJ1Y3Qg
aWZjdmZfaHcgKmh3KQo+Pj4+Pj4+ICAgICB7Cj4+Pj4+Pj4gLSAgICAgICBpZmN2Zl9od19kaXNh
YmxlKGh3KTsKPj4+Pj4+PiAtICAgICAgIGlmY3ZmX3Jlc2V0KGh3KTsKPj4+Pj4+PiArICAgICAg
IGlmY3ZmX3N5bmNocm9uaXplX2lycShodyk7Cj4+Pj4+Pj4gKyAgICAgICBpZmN2Zl9yZXNldF92
cmluZyhodyk7Cj4+Pj4+Pj4gKyAgICAgICBpZmN2Zl9yZXNldF9jb25maWdfaGFuZGxlcihodyk7
Cj4+Pj4+PiBOaXQ6Cj4+Pj4+Pgo+Pj4+Pj4gU28gdGhlIG5hbWUgb2YgdGhpcyBmdW5jdGlvbiBp
cyBraW5kIG9mIG1pc2xlYWRpbmcgc2luY2UgaXJxCj4+Pj4+PiBzeW5jaHJvbml6YXRpb24gYW5k
IHZpcnRxdWV1ZS9jb25maWcgaGFuZGxlciBhcmUgbm90IGJlbG9uZyB0bwo+Pj4+Pj4gaGFyZHdh
cmU/Cj4+Pj4+Pgo+Pj4+Pj4gTWF5YmUgaXQgd291bGQgYmUgYmV0dGVyIHRvIGNhbGwgaXQgaWZj
dmZfc3RvcCgpLgo+Pj4+PiBTdXJlLCBJIHdpbGwgc2VuZCBhIFYzIHdpdGggdGhpcyByZW5hbWlu
ZywKPj4+Pj4gZG8geW91IGFjayBwYXRjaCAxLzU/Cj4+Pj4gWWVzLCBJIHRoaW5rIEkndmUgYWNr
ZWQgdG8gdGhhdCBwYXRjaC4KPj4+IEkgd2lsbCBzZW5kIGEgVjMgd2l0aCB0aGlzIHJlbmFtaW5n
IGFuZCB5b3VyIGFjayBmb3IgcGF0Y2ggMS81Cj4+IEJ5IHRoZSB3YXksIGRvIHlvdSBhY2sgdGhp
cyBvbmUgYWZ0ZXIgdGhpcyBmdW5jdGlvbiByZW5hbWluZz8KPj4gSWYgc28sIEkgd2lsbCBhbHNv
IGluY2x1ZGUgeW91ciBhY2sgaW4gVjMsIHNvIHdlIGRvbid0IG5lZWQgYW5vdGhlcgo+PiByZXZp
ZXcgcHJvY2VzcywgSSB3aWxsIHBpbmcgTWljaGFlbCBmb3IgYSBtZXJnZS4KPiBIYXZlIHlvdSBz
ZWVuIHRoZSBhY2sgaGVyZT8KPgo+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9w
aXBlcm1haWwvdmlydHVhbGl6YXRpb24vMjAyMy1NYXkvMDY2ODkwLmh0bWwKU29ycnkgSSBtaXNz
ZWQgdGhpcywgYSBwYXRjaCBvbmx5IHJlbmFtZXMgYSBmdW5jdGlvbiBtYXkgYmUgdHJpdmlhbCwg
c28gCkkgd2lsbApyZWJhc2UgdGhpcyA0LzUgd2l0aCB5b3VyIGFjay4gU28gYWxsIHBhdGNoZXMg
YXJlIGFjay1lZCwgdGhhbmtzIQo+Cj4gVGhhbmtzCj4KPj4+PiBUaGFua3MKPj4+Pgo+Pj4+PiBU
aGFua3MKPj4+Pj4gWmh1IExpbmdzaGFuCj4+Pj4+PiBUaGFua3MKPj4+Pj4+Cj4+Pj4+Pj4gICAg
IH0KPj4+Pj4+Pgo+Pj4+Pj4+ICAgICB2b2lkIGlmY3ZmX25vdGlmeV9xdWV1ZShzdHJ1Y3QgaWZj
dmZfaHcgKmh3LCB1MTYgcWlkKQo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5oCj4+Pj4+Pj4gYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5o
Cj4+Pj4+Pj4gaW5kZXggZDM0ZDNiYzBkYmY0Li43NDMwZjgwNzc5YmUgMTAwNjQ0Cj4+Pj4+Pj4g
LS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+Pj4+Pj4+ICsrKyBiL2RyaXZl
cnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPj4+Pj4+PiBAQCAtODIsNiArODIsNyBAQCBzdHJ1
Y3QgaWZjdmZfaHcgewo+Pj4+Pj4+ICAgICAgICAgICAgaW50IHZxc19yZXVzZWRfaXJxOwo+Pj4+
Pj4+ICAgICAgICAgICAgdTE2IG5yX3ZyaW5nOwo+Pj4+Pj4+ICAgICAgICAgICAgLyogVklSVElP
X1BDSV9DQVBfREVWSUNFX0NGRyBzaXplICovCj4+Pj4+Pj4gKyAgICAgICB1MzIgbnVtX21zaXhf
dmVjdG9yczsKPj4+Pj4+PiAgICAgICAgICAgIHUzMiBjYXBfZGV2X2NvbmZpZ19zaXplOwo+Pj4+
Pj4+ICAgICAgICAgICAgc3RydWN0IHBjaV9kZXYgKnBkZXY7Cj4+Pj4+Pj4gICAgIH07Cj4+Pj4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4+Pj4+PiBi
L2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4+Pj4+PiBpbmRleCA5Njg2ODcxNTll
NDQuLjM0MDFiOTkwMWRkMiAxMDA2NDQKPj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfbWFpbi5jCj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4u
Ywo+Pj4+Pj4+IEBAIC0xMjUsNiArMTI1LDcgQEAgc3RhdGljIHZvaWQgaWZjdmZfZnJlZV9pcnEo
c3RydWN0IGlmY3ZmX2h3ICp2ZikKPj4+Pj4+PiAgICAgICAgICAgIGlmY3ZmX2ZyZWVfdnFfaXJx
KHZmKTsKPj4+Pj4+PiAgICAgICAgICAgIGlmY3ZmX2ZyZWVfY29uZmlnX2lycSh2Zik7Cj4+Pj4+
Pj4gICAgICAgICAgICBpZmN2Zl9mcmVlX2lycV92ZWN0b3JzKHBkZXYpOwo+Pj4+Pj4+ICsgICAg
ICAgdmYtPm51bV9tc2l4X3ZlY3RvcnMgPSAwOwo+Pj4+Pj4+ICAgICB9Cj4+Pj4+Pj4KPj4+Pj4+
PiAgICAgLyogaWZjdmYgTVNJWCB2ZWN0b3JzIGFsbG9jYXRvciwgdGhpcyBoZWxwZXIgdHJpZXMg
dG8gYWxsb2NhdGUKPj4+Pj4+PiBAQCAtMzQzLDM2ICszNDQsMTEgQEAgc3RhdGljIGludCBpZmN2
Zl9yZXF1ZXN0X2lycShzdHJ1Y3QgaWZjdmZfaHcKPj4+Pj4+PiAqdmYpCj4+Pj4+Pj4gICAgICAg
ICAgICBpZiAocmV0KQo+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Owo+Pj4+
Pj4+Cj4+Pj4+Pj4gLSAgICAgICByZXR1cm4gMDsKPj4+Pj4+PiAtfQo+Pj4+Pj4+IC0KPj4+Pj4+
PiAtc3RhdGljIGludCBpZmN2Zl9zdG9wX2RhdGFwYXRoKHN0cnVjdCBpZmN2Zl9hZGFwdGVyICph
ZGFwdGVyKQo+Pj4+Pj4+IC17Cj4+Pj4+Pj4gLSAgICAgICBzdHJ1Y3QgaWZjdmZfaHcgKnZmID0g
YWRhcHRlci0+dmY7Cj4+Pj4+Pj4gLSAgICAgICBpbnQgaTsKPj4+Pj4+PiAtCj4+Pj4+Pj4gLSAg
ICAgICBmb3IgKGkgPSAwOyBpIDwgdmYtPm5yX3ZyaW5nOyBpKyspCj4+Pj4+Pj4gLSAgICAgICAg
ICAgICAgIHZmLT52cmluZ1tpXS5jYi5jYWxsYmFjayA9IE5VTEw7Cj4+Pj4+Pj4gLQo+Pj4+Pj4+
IC0gICAgICAgaWZjdmZfc3RvcF9odyh2Zik7Cj4+Pj4+Pj4gKyAgICAgICB2Zi0+bnVtX21zaXhf
dmVjdG9ycyA9IG52ZWN0b3JzOwo+Pj4+Pj4+Cj4+Pj4+Pj4gICAgICAgICAgICByZXR1cm4gMDsK
Pj4+Pj4+PiAgICAgfQo+Pj4+Pj4+Cj4+Pj4+Pj4gLXN0YXRpYyB2b2lkIGlmY3ZmX3Jlc2V0X3Zy
aW5nKHN0cnVjdCBpZmN2Zl9hZGFwdGVyICphZGFwdGVyKQo+Pj4+Pj4+IC17Cj4+Pj4+Pj4gLSAg
ICAgICBzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gYWRhcHRlci0+dmY7Cj4+Pj4+Pj4gLSAgICAgICBp
bnQgaTsKPj4+Pj4+PiAtCj4+Pj4+Pj4gLSAgICAgICBmb3IgKGkgPSAwOyBpIDwgdmYtPm5yX3Zy
aW5nOyBpKyspIHsKPj4+Pj4+PiAtICAgICAgICAgICAgICAgdmYtPnZyaW5nW2ldLmxhc3RfYXZh
aWxfaWR4ID0gMDsKPj4+Pj4+PiAtICAgICAgICAgICAgICAgdmYtPnZyaW5nW2ldLmNiLmNhbGxi
YWNrID0gTlVMTDsKPj4+Pj4+PiAtICAgICAgICAgICAgICAgdmYtPnZyaW5nW2ldLmNiLnByaXZh
dGUgPSBOVUxMOwo+Pj4+Pj4+IC0gICAgICAgfQo+Pj4+Pj4+IC0KPj4+Pj4+PiAtICAgICAgIGlm
Y3ZmX3Jlc2V0KHZmKTsKPj4+Pj4+PiAtfQo+Pj4+Pj4+IC0KPj4+Pj4+PiAgICAgc3RhdGljIHN0
cnVjdCBpZmN2Zl9hZGFwdGVyICp2ZHBhX3RvX2FkYXB0ZXIoc3RydWN0IHZkcGFfZGV2aWNlCj4+
Pj4+Pj4gKnZkcGFfZGV2KQo+Pj4+Pj4+ICAgICB7Cj4+Pj4+Pj4gICAgICAgICAgICByZXR1cm4g
Y29udGFpbmVyX29mKHZkcGFfZGV2LCBzdHJ1Y3QgaWZjdmZfYWRhcHRlciwgdmRwYSk7Cj4+Pj4+
Pj4gQEAgLTQ2MiwyMyArNDM4LDE1IEBAIHN0YXRpYyB2b2lkIGlmY3ZmX3ZkcGFfc2V0X3N0YXR1
cyhzdHJ1Y3QKPj4+Pj4+PiB2ZHBhX2RldmljZSAqdmRwYV9kZXYsIHU4IHN0YXR1cykKPj4+Pj4+
Pgo+Pj4+Pj4+ICAgICBzdGF0aWMgaW50IGlmY3ZmX3ZkcGFfcmVzZXQoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZHBhX2RldikKPj4+Pj4+PiAgICAgewo+Pj4+Pj4+IC0gICAgICAgc3RydWN0IGlmY3Zm
X2FkYXB0ZXIgKmFkYXB0ZXI7Cj4+Pj4+Pj4gLSAgICAgICBzdHJ1Y3QgaWZjdmZfaHcgKnZmOwo+
Pj4+Pj4+IC0gICAgICAgdTggc3RhdHVzX29sZDsKPj4+Pj4+PiAtCj4+Pj4+Pj4gLSAgICAgICB2
ZiAgPSB2ZHBhX3RvX3ZmKHZkcGFfZGV2KTsKPj4+Pj4+PiAtICAgICAgIGFkYXB0ZXIgPSB2ZHBh
X3RvX2FkYXB0ZXIodmRwYV9kZXYpOwo+Pj4+Pj4+IC0gICAgICAgc3RhdHVzX29sZCA9IGlmY3Zm
X2dldF9zdGF0dXModmYpOwo+Pj4+Pj4+ICsgICAgICAgc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZk
cGFfdG9fdmYodmRwYV9kZXYpOwo+Pj4+Pj4+ICsgICAgICAgdTggc3RhdHVzID0gaWZjdmZfZ2V0
X3N0YXR1cyh2Zik7Cj4+Pj4+Pj4KPj4+Pj4+PiAtICAgICAgIGlmIChzdGF0dXNfb2xkID09IDAp
Cj4+Pj4+Pj4gLSAgICAgICAgICAgICAgIHJldHVybiAwOwo+Pj4+Pj4+ICsgICAgICAgaWZjdmZf
c3RvcF9odyh2Zik7Cj4+Pj4+Pj4KPj4+Pj4+PiAtICAgICAgIGlmIChzdGF0dXNfb2xkICYgVklS
VElPX0NPTkZJR19TX0RSSVZFUl9PSykgewo+Pj4+Pj4+IC0gICAgICAgICAgICAgICBpZmN2Zl9z
dG9wX2RhdGFwYXRoKGFkYXB0ZXIpOwo+Pj4+Pj4+ICsgICAgICAgaWYgKHN0YXR1cyAmIFZJUlRJ
T19DT05GSUdfU19EUklWRVJfT0spCj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgIGlmY3ZmX2Zy
ZWVfaXJxKHZmKTsKPj4+Pj4+PiAtICAgICAgIH0KPj4+Pj4+Pgo+Pj4+Pj4+IC0gICAgICAgaWZj
dmZfcmVzZXRfdnJpbmcoYWRhcHRlcik7Cj4+Pj4+Pj4gKyAgICAgICBpZmN2Zl9yZXNldCh2Zik7
Cj4+Pj4+Pj4KPj4+Pj4+PiAgICAgICAgICAgIHJldHVybiAwOwo+Pj4+Pj4+ICAgICB9Cj4+Pj4+
Pj4gLS0KPj4+Pj4+PiAyLjM5LjEKPj4+Pj4+Pgo+Pj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPj4+IFZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdAo+
Pj4gVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPj4+IGh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
