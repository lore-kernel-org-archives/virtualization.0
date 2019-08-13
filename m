From: Adalbert =?iso-8859-2?b?TGF643I=?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH v6 14/92] kvm: introspection: handle introspection
	commands before returning to guest
Date: Tue, 13 Aug 2019 16:54:42 +0300
Message-ID: <12145.2014240035$1565704476@news.gmane.org>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-15-alazar@bitdefender.com>
	<645d86f5-67f6-f5d3-3fbb-5ee9898a7ef8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <645d86f5-67f6-f5d3-3fbb-5ee9898a7ef8@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C Zhang <yu.c.zhang@intel.com>, Radim =?iso-8859-2?b?S3LobeH4?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel =?iso-8859-1?q?Laur=E9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Mircea =?iso-8859-1?q?C=EErjaliu?= <mcirjaliu@bitdefender.com>, Mihai =?UTF-8?b?RG9uyJt1?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlLCAxMyBBdWcgMjAxOSAxMDoyNjoyOSArMDIwMCwgUGFvbG8gQm9uemluaSA8cGJvbnpp
bmlAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gMDkvMDgvMTkgMTc6NTksIEFkYWxiZXJ0IExhesSD
ciB3cm90ZToKPiA+ICsJCQlwcmVwYXJlX3RvX3N3YWl0X2V4Y2x1c2l2ZSgmdmNwdS0+d3EsICZ3
YWl0LAo+ID4gKwkJCQkJCSAgIFRBU0tfSU5URVJSVVBUSUJMRSk7Cj4gPiArCj4gPiArCQkJaWYg
KGt2bV92Y3B1X2NoZWNrX2Jsb2NrKHZjcHUpIDwgMCkKPiA+ICsJCQkJYnJlYWs7Cj4gPiArCj4g
PiArCQkJd2FpdGVkID0gdHJ1ZTsKPiA+ICsJCQlzY2hlZHVsZSgpOwo+ID4gKwo+ID4gKwkJCWlm
IChrdm1fY2hlY2tfcmVxdWVzdChLVk1fUkVRX0lOVFJPU1BFQ1RJT04sIHZjcHUpKSB7Cj4gPiAr
CQkJCWRvX2t2bWlfd29yayA9IHRydWU7Cj4gPiArCQkJCWJyZWFrOwo+ID4gKwkJCX0KPiA+ICsJ
CX0KPiA+ICAKPiA+IC0JCXdhaXRlZCA9IHRydWU7Cj4gPiAtCQlzY2hlZHVsZSgpOwo+ID4gKwkJ
ZmluaXNoX3N3YWl0KCZ2Y3B1LT53cSwgJndhaXQpOwo+ID4gKwo+ID4gKwkJaWYgKGRvX2t2bWlf
d29yaykKPiA+ICsJCQlrdm1pX2hhbmRsZV9yZXF1ZXN0cyh2Y3B1KTsKPiA+ICsJCWVsc2UKPiA+
ICsJCQlicmVhazsKPiA+ICAJfQo+IAo+IElzIHRoaXMgbmVlZGVkPyAgT3IgY2FuIGl0IGp1c3Qg
Z28gYmFjayB0byBLVk1fUlVOIGFuZCBoYW5kbGUKPiBLVk1fUkVRX0lOVFJPU1BFQ1RJT04gdGhl
cmUgKGluIHdoaWNoIGNhc2UgaXQgd291bGQgYmUgYmFzaWNhbGx5Cj4gcHJlbWF0dXJlIG9wdGlt
aXphdGlvbik/Cj4gCgpJdCBtaWdodCBzdGlsbCBiZSBuZWVkZWQsIHVubGVzcyB3ZSBjYW4gZ2V0
IGJhY2sgdG8gdGhpcyBmdW5jdGlvbi4KClRoZSBvcmlnaW5hbCBjb21taXQgbWVzc2FnZSBmb3Ig
dGhpcyBjaGFuZ2Ugd2FzIHRoaXM6CgogICAga3ZtOiBkbyBub3QgYWJvcnQga3ZtX3ZjcHVfYmxv
Y2soKSBpbiBvcmRlciB0byBoYW5kbGUgS1ZNSSByZXF1ZXN0cwogICAgCiAgICBMZWF2aW5nIGt2
bV92Y3B1X2Jsb2NrKCkgaW4gb3JkZXIgdG8gaGFuZGxlIGEgcmVxdWVzdCBzdWNoIGFzICdwYXVz
ZScsCiAgICB3b3VsZCBjYXVzZSB0aGUgdkNQVSB0byBlbnRlciB0aGUgZ3Vlc3Qgd2hlbiByZXN1
bWVkLiBNb3N0IG9mIHRoZQogICAgdGltZSB0aGlzIGRvZXMgbm90IGFwcGVhciB0byBiZSBhbiBp
c3N1ZSwgYnV0IGR1cmluZyBlYXJseSBib290IGl0CiAgICBjYW4gaGFwcGVuIGZvciBhIG5vbi1i
b290IHZDUFUgdG8gc3RhcnQgZXhlY3V0aW5nIGNvZGUgZnJvbSBhcmVhcyB0aGF0CiAgICBmaXJz
dCBuZWVkZWQgdG8gYmUgc2V0IHVwIGJ5IHZDUFUgIzAuCiAgICAKICAgIEluIGEgcGFydGljdWxh
ciBjYXNlLCB2Q1BVICMxIGV4ZWN1dGVkIGNvZGUgd2hpY2ggcmVzaWRlZCBpbiBhbiBhcmVhCiAg
ICBub3QgY292ZXJlZCBieSBhIG1lbXNsb3QsIHdoaWNoIGNhdXNlZCBhbiBFUFQgdmlvbGF0aW9u
IHRoYXQgZ290CiAgICB0dXJuZWQgaW4gbW11X3NldF9zcHRlKCkgaW50byBhIE1NSU8gcmVxdWVz
dCB0aGF0IHJlcXVpcmVkIGVtdWxhdGlvbi4KICAgIFVuZm9ydHVuYXRlbGx5LCB0aGUgZW11bGF0
b3IgdHJpcHBlZCwgZXhpdGVkIHRvIHVzZXJzcGFjZSBhbmQgdGhlIFZNCiAgICB3YXMgYWJvcnRl
ZC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
