From: Adalbert =?iso-8859-2?b?TGF643I=?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH v6 70/92] kvm: x86: filter out access rights only when
	tracked by the introspection tool
Date: Tue, 13 Aug 2019 19:06:43 +0300
Message-ID: <10168.3332746447$1565712388@news.gmane.org>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-71-alazar@bitdefender.com>
	<8cba6816-8d3a-2498-b3b0-2ce76a98ce12@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8cba6816-8d3a-2498-b3b0-2ce76a98ce12@redhat.com>
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
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C Zhang <yu.c.zhang@intel.com>, Radim =?iso-8859-2?b?S3LobeH4?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel =?iso-8859-1?q?Laur=E9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Mihai =?UTF-8?b?RG9uyJt1?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlLCAxMyBBdWcgMjAxOSAxMTowODozOSArMDIwMCwgUGFvbG8gQm9uemluaSA8cGJvbnpp
bmlAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gMDkvMDgvMTkgMTg6MDAsIEFkYWxiZXJ0IExhesSD
ciB3cm90ZToKPiA+IEl0IHNob3VsZCBjb21wbGV0ZSB0aGUgY29tbWl0IGZkMzRhOTUxODE3MyAo
Imt2bTogeDg2OiBjb25zdWx0IHRoZSBwYWdlIHRyYWNraW5nIGZyb20ga3ZtX21tdV9nZXRfcGFn
ZSgpIGFuZCBfX2RpcmVjdF9tYXAoKSIpCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEFkYWxiZXJ0
IExhesSDciA8YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4KPiA+IC0tLQo+ID4gIGFyY2gveDg2L2t2
bS9tbXUuYyB8IDMgKysrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+ID4g
Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL21tdS5jIGIvYXJjaC94ODYva3ZtL21tdS5j
Cj4gPiBpbmRleCA2NWI2YWNiYTgyZGEuLmZkNjRjZjExMTVkYSAxMDA2NDQKPiA+IC0tLSBhL2Fy
Y2gveDg2L2t2bS9tbXUuYwo+ID4gKysrIGIvYXJjaC94ODYva3ZtL21tdS5jCj4gPiBAQCAtMjY2
MCw2ICsyNjYwLDkgQEAgc3RhdGljIHZvaWQgY2xlYXJfc3Bfd3JpdGVfZmxvb2RpbmdfY291bnQo
dTY0ICpzcHRlKQo+ID4gIHN0YXRpYyB1bnNpZ25lZCBpbnQga3ZtX21tdV9wYWdlX3RyYWNrX2Fj
YyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGdmbl90IGdmbiwKPiA+ICAJCQkJCSAgIHVuc2lnbmVk
IGludCBhY2MpCj4gPiAgewo+ID4gKwlpZiAoIWt2bWlfdHJhY2tlZF9nZm4odmNwdSwgZ2ZuKSkK
PiA+ICsJCXJldHVybiBhY2M7Cj4gPiArCj4gPiAgCWlmIChrdm1fcGFnZV90cmFja19pc19hY3Rp
dmUodmNwdSwgZ2ZuLCBLVk1fUEFHRV9UUkFDS19QUkVSRUFEKSkKPiA+ICAJCWFjYyAmPSB+QUND
X1VTRVJfTUFTSzsKPiA+ICAJaWYgKGt2bV9wYWdlX3RyYWNrX2lzX2FjdGl2ZSh2Y3B1LCBnZm4s
IEtWTV9QQUdFX1RSQUNLX1BSRVdSSVRFKSB8fAo+ID4gCj4gCj4gSWYgdGhpcyBwYXRjaCBpcyBh
bHdheXMgbmVlZGVkLCB0aGVuIHRoZSBmdW5jdGlvbiBzaG91bGQgYmUgbmFtZWQKPiBzb21ldGhp
bmcgbGlrZSBrdm1fbW11X2FwcGx5X2ludHJvc3BlY3Rpb25fYWNjZXNzIGFuZCBrdm1pX3RyYWNr
ZWRfZ2ZuCj4gc2hvdWxkIGJlIHRlc3RlZCBmcm9tIHRoZSBtb21lbnQgaXQgaXMgaW50cm9kdWNl
ZC4KPiAKPiBCdXQgdGhlIGNvbW1pdCBtZXNzYWdlIHNheXMgbm90aGluZyBhYm91dCBfd2h5XyBp
dCBpcyBuZWVkZWQsIHNvIEkKPiBjYW5ub3QgZ3Vlc3MuICBJIHdvdWxkIHZlcnkgbXVjaCBhdm9p
ZCBpdCBob3dldmVyLiAgSXMgaXQganVzdCBhbgo+IG9wdGltaXphdGlvbj8KPiAKPiBQYW9sbwoK
V2UnbGwgcmV0ZXN0IHRvIHNlZSBpZiB3ZSBzdGlsbCBuZWVkIGt2bV9tbXVfcGFnZV90cmFja19h
Y2MoKS4KVGhlIGt2bWlfdHJhY2tlZF9nZm4oKSBjaGVjayB3YXMgdXNlZCB0byBrZWVwIHRoZSBL
Vk0gY29kZSBmbG93CiJ1bmNoYW5nZWQiIGFzIG11Y2ggYXMgcG9zc2libGUuIFByb2JhYmx5LCB3
ZSBjYW4gZ2V0IHJpZGUgb2YgaXQuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
