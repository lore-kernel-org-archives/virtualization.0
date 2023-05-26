Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CE3C77B7A
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 03:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39F146161F;
	Fri, 26 May 2023 03:36:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39F146161F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MdPJ+P51
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OkbIzRXpUpOH; Fri, 26 May 2023 03:36:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6817E6133E;
	Fri, 26 May 2023 03:36:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6817E6133E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D080C0036;
	Fri, 26 May 2023 03:36:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93689C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 03:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58DAD427CC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 03:36:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 58DAD427CC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MdPJ+P51
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BQH1RIH4t_8x
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 03:36:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C67642754
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C67642754
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 03:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685072191; x=1716608191;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=rvRqiG3xtRng4v0qM5e1RJpUvYVTNRqLWb7FNGr36FA=;
 b=MdPJ+P518EP0drpFm8y4ZI+3m8f7QW3xJgzn0vlW9ZBbTxxwwydVBrl+
 0EomkI5XDziGAV79sVhmL32REG56YYW/VB8PwdxxjsB1kijJeMo7d42MW
 z0m0gsvdpX8yK66tQdH4otBz6T5atzXxNgmPlKKzDinAuI1DGXNXen3Lv
 QN1pjwN7mjc+vElYzQwraQzO5KHxhCasMjBjS7C/HEKhgMalNpoTuPg9+
 EyAYja1CiYsUa3OA6t1UZXK8V3djxCSyDcHEamQ2YbqxUtsTyC4RU7oMS
 nH0R4NcBz9BCwr8dDG1R19mSaso8c6DzGbcT+wUtSIMt/hIx4GwWxDiGb Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="356486590"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="356486590"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 20:36:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="1035187732"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="1035187732"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.255.29.235])
 ([10.255.29.235])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 20:36:29 -0700
Message-ID: <7e355ae0-158a-e308-1e26-7c562a78c9d9@intel.com>
Date: Fri, 26 May 2023 11:36:27 +0800
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
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEtmSBhaMrVCLO6TLJ40_fY5pwa2p+jC6=Q0D09zUJRcOg@mail.gmail.com>
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

CgpPbiA1LzI2LzIwMjMgOTozNCBBTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBUaHUsIE1heSAy
NSwgMjAyMyBhdCA1OjM44oCvUE0gWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNv
bT4gd3JvdGU6Cj4+Cj4+Cj4+IE9uIDUvMjQvMjAyMyA0OjAzIFBNLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+Pj4gT24gTW9uLCBNYXkgOCwgMjAyMyBhdCA2OjA14oCvUE0gWmh1IExpbmdzaGFuIDxsaW5n
c2hhbi56aHVAaW50ZWwuY29tPiB3cm90ZToKPj4+PiBUaGlzIGNvbW1pdCBzeW5jaHJvbml6ZSBp
cnFzIG9mIHRoZSB2aXJ0cXVldWVzCj4+Pj4gYW5kIGNvbmZpZyBzcGFjZSBpbiB0aGUgcmVzZXQg
cm91dGluZS4KPj4+PiBUaHVzIGlmY3ZmX3N0b3BfaHcoKSBhbmQgcmVzZXQoKSBhcmUgcmVmYWN0
b3JlZCBhcyB3ZWxsLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5n
c2hhbi56aHVAaW50ZWwuY29tPgo+Pj4+IC0tLQo+Pj4+ICAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9iYXNlLmMgfCA0MSArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQo+Pj4+ICAgIGRy
aXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggfCAgMSArCj4+Pj4gICAgZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX21haW4uYyB8IDQ2ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQo+Pj4+ICAgIDMgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgNTAgZGVsZXRpb25z
KC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2Uu
YyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMKPj4+PiBpbmRleCA3OWUzMTNjNWUx
MGUuLjFmMzkyOTBiYWEzOCAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZj
dmZfYmFzZS5jCj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+Pj4+
IEBAIC0xNzAsMTIgKzE3MCw5IEBAIHZvaWQgaWZjdmZfc2V0X3N0YXR1cyhzdHJ1Y3QgaWZjdmZf
aHcgKmh3LCB1OCBzdGF0dXMpCj4+Pj4KPj4+PiAgICB2b2lkIGlmY3ZmX3Jlc2V0KHN0cnVjdCBp
ZmN2Zl9odyAqaHcpCj4+Pj4gICAgewo+Pj4+IC0gICAgICAgaHctPmNvbmZpZ19jYi5jYWxsYmFj
ayA9IE5VTEw7Cj4+Pj4gLSAgICAgICBody0+Y29uZmlnX2NiLnByaXZhdGUgPSBOVUxMOwo+Pj4+
IC0KPj4+PiAgICAgICAgICAgaWZjdmZfc2V0X3N0YXR1cyhodywgMCk7Cj4+Pj4gLSAgICAgICAv
KiBmbHVzaCBzZXRfc3RhdHVzLCBtYWtlIHN1cmUgVkYgaXMgc3RvcHBlZCwgcmVzZXQgKi8KPj4+
PiAtICAgICAgIGlmY3ZmX2dldF9zdGF0dXMoaHcpOwo+Pj4+ICsgICAgICAgd2hpbGUgKGlmY3Zm
X2dldF9zdGF0dXMoaHcpKQo+Pj4+ICsgICAgICAgICAgICAgICBtc2xlZXAoMSk7Cj4+Pj4gICAg
fQo+Pj4+Cj4+Pj4gICAgdTY0IGlmY3ZmX2dldF9od19mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcg
Kmh3KQo+Pj4+IEBAIC0zNjgsMjAgKzM2NSw0MiBAQCB2b2lkIGlmY3ZmX3NldF92cV9yZWFkeShz
dHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlkLCBib29sIHJlYWR5KQo+Pj4+ICAgICAgICAgICB2
cF9pb3dyaXRlMTYocmVhZHksICZjZmctPnF1ZXVlX2VuYWJsZSk7Cj4+Pj4gICAgfQo+Pj4+Cj4+
Pj4gLXN0YXRpYyB2b2lkIGlmY3ZmX2h3X2Rpc2FibGUoc3RydWN0IGlmY3ZmX2h3ICpodykKPj4+
PiArc3RhdGljIHZvaWQgaWZjdmZfcmVzZXRfdnJpbmcoc3RydWN0IGlmY3ZmX2h3ICpodykKPj4+
PiAgICB7Cj4+Pj4gLSAgICAgICB1MzIgaTsKPj4+PiArICAgICAgIHUxNiBxaWQ7Cj4+Pj4gKwo+
Pj4+ICsgICAgICAgZm9yIChxaWQgPSAwOyBxaWQgPCBody0+bnJfdnJpbmc7IHFpZCsrKSB7Cj4+
Pj4gKyAgICAgICAgICAgICAgIGh3LT52cmluZ1txaWRdLmNiLmNhbGxiYWNrID0gTlVMTDsKPj4+
PiArICAgICAgICAgICAgICAgaHctPnZyaW5nW3FpZF0uY2IucHJpdmF0ZSA9IE5VTEw7Cj4+Pj4g
KyAgICAgICAgICAgICAgIGlmY3ZmX3NldF92cV92ZWN0b3IoaHcsIHFpZCwgVklSVElPX01TSV9O
T19WRUNUT1IpOwo+Pj4+ICsgICAgICAgfQo+Pj4+ICt9Cj4+Pj4KPj4+PiArc3RhdGljIHZvaWQg
aWZjdmZfcmVzZXRfY29uZmlnX2hhbmRsZXIoc3RydWN0IGlmY3ZmX2h3ICpodykKPj4+PiArewo+
Pj4+ICsgICAgICAgaHctPmNvbmZpZ19jYi5jYWxsYmFjayA9IE5VTEw7Cj4+Pj4gKyAgICAgICBo
dy0+Y29uZmlnX2NiLnByaXZhdGUgPSBOVUxMOwo+Pj4+ICAgICAgICAgICBpZmN2Zl9zZXRfY29u
ZmlnX3ZlY3RvcihodywgVklSVElPX01TSV9OT19WRUNUT1IpOwo+Pj4+IC0gICAgICAgZm9yIChp
ID0gMDsgaSA8IGh3LT5ucl92cmluZzsgaSsrKSB7Cj4+Pj4gLSAgICAgICAgICAgICAgIGlmY3Zm
X3NldF92cV92ZWN0b3IoaHcsIGksIFZJUlRJT19NU0lfTk9fVkVDVE9SKTsKPj4+PiArfQo+Pj4+
ICsKPj4+PiArc3RhdGljIHZvaWQgaWZjdmZfc3luY2hyb25pemVfaXJxKHN0cnVjdCBpZmN2Zl9o
dyAqaHcpCj4+Pj4gK3sKPj4+PiArICAgICAgIHUzMiBudmVjdG9ycyA9IGh3LT5udW1fbXNpeF92
ZWN0b3JzOwo+Pj4+ICsgICAgICAgc3RydWN0IHBjaV9kZXYgKnBkZXYgPSBody0+cGRldjsKPj4+
PiArICAgICAgIGludCBpLCBpcnE7Cj4+Pj4gKwo+Pj4+ICsgICAgICAgZm9yIChpID0gMDsgaSA8
IG52ZWN0b3JzOyBpKyspIHsKPj4+PiArICAgICAgICAgICAgICAgaXJxID0gcGNpX2lycV92ZWN0
b3IocGRldiwgaSk7Cj4+Pj4gKyAgICAgICAgICAgICAgIGlmIChpcnEgPj0gMCkKPj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICBzeW5jaHJvbml6ZV9pcnEoaXJxKTsKPj4+PiAgICAgICAgICAg
fQo+Pj4+ICAgIH0KPj4+Pgo+Pj4+ICAgIHZvaWQgaWZjdmZfc3RvcF9odyhzdHJ1Y3QgaWZjdmZf
aHcgKmh3KQo+Pj4+ICAgIHsKPj4+PiAtICAgICAgIGlmY3ZmX2h3X2Rpc2FibGUoaHcpOwo+Pj4+
IC0gICAgICAgaWZjdmZfcmVzZXQoaHcpOwo+Pj4+ICsgICAgICAgaWZjdmZfc3luY2hyb25pemVf
aXJxKGh3KTsKPj4+PiArICAgICAgIGlmY3ZmX3Jlc2V0X3ZyaW5nKGh3KTsKPj4+PiArICAgICAg
IGlmY3ZmX3Jlc2V0X2NvbmZpZ19oYW5kbGVyKGh3KTsKPj4+IE5pdDoKPj4+Cj4+PiBTbyB0aGUg
bmFtZSBvZiB0aGlzIGZ1bmN0aW9uIGlzIGtpbmQgb2YgbWlzbGVhZGluZyBzaW5jZSBpcnEKPj4+
IHN5bmNocm9uaXphdGlvbiBhbmQgdmlydHF1ZXVlL2NvbmZpZyBoYW5kbGVyIGFyZSBub3QgYmVs
b25nIHRvCj4+PiBoYXJkd2FyZT8KPj4+Cj4+PiBNYXliZSBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8g
Y2FsbCBpdCBpZmN2Zl9zdG9wKCkuCj4+IFN1cmUsIEkgd2lsbCBzZW5kIGEgVjMgd2l0aCB0aGlz
IHJlbmFtaW5nLAo+PiBkbyB5b3UgYWNrIHBhdGNoIDEvNT8KPiBZZXMsIEkgdGhpbmsgSSd2ZSBh
Y2tlZCB0byB0aGF0IHBhdGNoLgpJIHdpbGwgc2VuZCBhIFYzIHdpdGggdGhpcyByZW5hbWluZyBh
bmQgeW91ciBhY2sgZm9yIHBhdGNoIDEvNQo+Cj4gVGhhbmtzCj4KPj4gVGhhbmtzCj4+IFpodSBM
aW5nc2hhbgo+Pj4gVGhhbmtzCj4+Pgo+Pj4+ICAgIH0KPj4+Pgo+Pj4+ICAgIHZvaWQgaWZjdmZf
bm90aWZ5X3F1ZXVlKHN0cnVjdCBpZmN2Zl9odyAqaHcsIHUxNiBxaWQpCj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggYi9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfYmFzZS5oCj4+Pj4gaW5kZXggZDM0ZDNiYzBkYmY0Li43NDMwZjgwNzc5YmUgMTAwNjQ0
Cj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+Pj4+ICsrKyBiL2Ry
aXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPj4+PiBAQCAtODIsNiArODIsNyBAQCBzdHJ1
Y3QgaWZjdmZfaHcgewo+Pj4+ICAgICAgICAgICBpbnQgdnFzX3JldXNlZF9pcnE7Cj4+Pj4gICAg
ICAgICAgIHUxNiBucl92cmluZzsKPj4+PiAgICAgICAgICAgLyogVklSVElPX1BDSV9DQVBfREVW
SUNFX0NGRyBzaXplICovCj4+Pj4gKyAgICAgICB1MzIgbnVtX21zaXhfdmVjdG9yczsKPj4+PiAg
ICAgICAgICAgdTMyIGNhcF9kZXZfY29uZmlnX3NpemU7Cj4+Pj4gICAgICAgICAgIHN0cnVjdCBw
Y2lfZGV2ICpwZGV2Owo+Pj4+ICAgIH07Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9p
ZmN2Zi9pZmN2Zl9tYWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+Pj4g
aW5kZXggOTY4Njg3MTU5ZTQ0Li4zNDAxYjk5MDFkZDIgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9tYWluLmMKPj4+PiBAQCAtMTI1LDYgKzEyNSw3IEBAIHN0YXRpYyB2b2lkIGlmY3ZmX2Zy
ZWVfaXJxKHN0cnVjdCBpZmN2Zl9odyAqdmYpCj4+Pj4gICAgICAgICAgIGlmY3ZmX2ZyZWVfdnFf
aXJxKHZmKTsKPj4+PiAgICAgICAgICAgaWZjdmZfZnJlZV9jb25maWdfaXJxKHZmKTsKPj4+PiAg
ICAgICAgICAgaWZjdmZfZnJlZV9pcnFfdmVjdG9ycyhwZGV2KTsKPj4+PiArICAgICAgIHZmLT5u
dW1fbXNpeF92ZWN0b3JzID0gMDsKPj4+PiAgICB9Cj4+Pj4KPj4+PiAgICAvKiBpZmN2ZiBNU0lY
IHZlY3RvcnMgYWxsb2NhdG9yLCB0aGlzIGhlbHBlciB0cmllcyB0byBhbGxvY2F0ZQo+Pj4+IEBA
IC0zNDMsMzYgKzM0NCwxMSBAQCBzdGF0aWMgaW50IGlmY3ZmX3JlcXVlc3RfaXJxKHN0cnVjdCBp
ZmN2Zl9odyAqdmYpCj4+Pj4gICAgICAgICAgIGlmIChyZXQpCj4+Pj4gICAgICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsKPj4+Pgo+Pj4+IC0gICAgICAgcmV0dXJuIDA7Cj4+Pj4gLX0KPj4+PiAt
Cj4+Pj4gLXN0YXRpYyBpbnQgaWZjdmZfc3RvcF9kYXRhcGF0aChzdHJ1Y3QgaWZjdmZfYWRhcHRl
ciAqYWRhcHRlcikKPj4+PiAtewo+Pj4+IC0gICAgICAgc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IGFk
YXB0ZXItPnZmOwo+Pj4+IC0gICAgICAgaW50IGk7Cj4+Pj4gLQo+Pj4+IC0gICAgICAgZm9yIChp
ID0gMDsgaSA8IHZmLT5ucl92cmluZzsgaSsrKQo+Pj4+IC0gICAgICAgICAgICAgICB2Zi0+dnJp
bmdbaV0uY2IuY2FsbGJhY2sgPSBOVUxMOwo+Pj4+IC0KPj4+PiAtICAgICAgIGlmY3ZmX3N0b3Bf
aHcodmYpOwo+Pj4+ICsgICAgICAgdmYtPm51bV9tc2l4X3ZlY3RvcnMgPSBudmVjdG9yczsKPj4+
Pgo+Pj4+ICAgICAgICAgICByZXR1cm4gMDsKPj4+PiAgICB9Cj4+Pj4KPj4+PiAtc3RhdGljIHZv
aWQgaWZjdmZfcmVzZXRfdnJpbmcoc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXIpCj4+Pj4g
LXsKPj4+PiAtICAgICAgIHN0cnVjdCBpZmN2Zl9odyAqdmYgPSBhZGFwdGVyLT52ZjsKPj4+PiAt
ICAgICAgIGludCBpOwo+Pj4+IC0KPj4+PiAtICAgICAgIGZvciAoaSA9IDA7IGkgPCB2Zi0+bnJf
dnJpbmc7IGkrKykgewo+Pj4+IC0gICAgICAgICAgICAgICB2Zi0+dnJpbmdbaV0ubGFzdF9hdmFp
bF9pZHggPSAwOwo+Pj4+IC0gICAgICAgICAgICAgICB2Zi0+dnJpbmdbaV0uY2IuY2FsbGJhY2sg
PSBOVUxMOwo+Pj4+IC0gICAgICAgICAgICAgICB2Zi0+dnJpbmdbaV0uY2IucHJpdmF0ZSA9IE5V
TEw7Cj4+Pj4gLSAgICAgICB9Cj4+Pj4gLQo+Pj4+IC0gICAgICAgaWZjdmZfcmVzZXQodmYpOwo+
Pj4+IC19Cj4+Pj4gLQo+Pj4+ICAgIHN0YXRpYyBzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqdmRwYV90
b19hZGFwdGVyKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4+Pj4gICAgewo+Pj4+ICAg
ICAgICAgICByZXR1cm4gY29udGFpbmVyX29mKHZkcGFfZGV2LCBzdHJ1Y3QgaWZjdmZfYWRhcHRl
ciwgdmRwYSk7Cj4+Pj4gQEAgLTQ2MiwyMyArNDM4LDE1IEBAIHN0YXRpYyB2b2lkIGlmY3ZmX3Zk
cGFfc2V0X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LCB1OCBzdGF0dXMpCj4+
Pj4KPj4+PiAgICBzdGF0aWMgaW50IGlmY3ZmX3ZkcGFfcmVzZXQoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZHBhX2RldikKPj4+PiAgICB7Cj4+Pj4gLSAgICAgICBzdHJ1Y3QgaWZjdmZfYWRhcHRlciAq
YWRhcHRlcjsKPj4+PiAtICAgICAgIHN0cnVjdCBpZmN2Zl9odyAqdmY7Cj4+Pj4gLSAgICAgICB1
OCBzdGF0dXNfb2xkOwo+Pj4+IC0KPj4+PiAtICAgICAgIHZmICA9IHZkcGFfdG9fdmYodmRwYV9k
ZXYpOwo+Pj4+IC0gICAgICAgYWRhcHRlciA9IHZkcGFfdG9fYWRhcHRlcih2ZHBhX2Rldik7Cj4+
Pj4gLSAgICAgICBzdGF0dXNfb2xkID0gaWZjdmZfZ2V0X3N0YXR1cyh2Zik7Cj4+Pj4gKyAgICAg
ICBzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gdmRwYV90b192Zih2ZHBhX2Rldik7Cj4+Pj4gKyAgICAg
ICB1OCBzdGF0dXMgPSBpZmN2Zl9nZXRfc3RhdHVzKHZmKTsKPj4+Pgo+Pj4+IC0gICAgICAgaWYg
KHN0YXR1c19vbGQgPT0gMCkKPj4+PiAtICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4+Pj4gKyAg
ICAgICBpZmN2Zl9zdG9wX2h3KHZmKTsKPj4+Pgo+Pj4+IC0gICAgICAgaWYgKHN0YXR1c19vbGQg
JiBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LKSB7Cj4+Pj4gLSAgICAgICAgICAgICAgIGlmY3Zm
X3N0b3BfZGF0YXBhdGgoYWRhcHRlcik7Cj4+Pj4gKyAgICAgICBpZiAoc3RhdHVzICYgVklSVElP
X0NPTkZJR19TX0RSSVZFUl9PSykKPj4+PiAgICAgICAgICAgICAgICAgICBpZmN2Zl9mcmVlX2ly
cSh2Zik7Cj4+Pj4gLSAgICAgICB9Cj4+Pj4KPj4+PiAtICAgICAgIGlmY3ZmX3Jlc2V0X3ZyaW5n
KGFkYXB0ZXIpOwo+Pj4+ICsgICAgICAgaWZjdmZfcmVzZXQodmYpOwo+Pj4+Cj4+Pj4gICAgICAg
ICAgIHJldHVybiAwOwo+Pj4+ICAgIH0KPj4+PiAtLQo+Pj4+IDIuMzkuMQo+Pj4+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
