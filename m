From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [RFC PATCH v6 69/92] kvm: x86: keep the page protected if
	tracked by the introspection tool
Date: Tue, 10 Sep 2019 10:26:42 -0400
Message-ID: <20190910142642.GC5879@char.us.oracle.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-70-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190809160047.8319-70-alazar@bitdefender.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C <yu.c.zhang@intel.com>, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel =?iso-8859-1?Q?Laur=E9n?= <samuel.lauren@iki.fi>, Zhang@pps.reinject, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCBBdWcgMDksIDIwMTkgYXQgMDc6MDA6MjRQTSArMDMwMCwgQWRhbGJlcnQgTGF6xINy
IHdyb3RlOgo+IFRoaXMgcGF0Y2ggbWlnaHQgYmUgb2Jzb2xldGUgdGhhbmtzIHRvIHNpbmdsZS1z
dGVwcGluZy4KCnNvb28gc2hvdWxkIGl0IGJlIHNraXBwZWQgZnJvbSB0aGlzIGxhcmdlIHBhdGNo
c2V0IHRvIGVhc3kKcmV2aWV3PwoKPiAKPiBTaWduZWQtb2ZmLWJ5OiBBZGFsYmVydCBMYXrEg3Ig
PGFsYXphckBiaXRkZWZlbmRlci5jb20+Cj4gLS0tCj4gIGFyY2gveDg2L2t2bS94ODYuYyB8IDkg
KysrKysrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS94ODYuYyBiL2FyY2gveDg2L2t2bS94
ODYuYwo+IGluZGV4IDJjMDZkZTczYTc4NC4uMDZmNDRjZThlZDA3IDEwMDY0NAo+IC0tLSBhL2Fy
Y2gveDg2L2t2bS94ODYuYwo+ICsrKyBiL2FyY2gveDg2L2t2bS94ODYuYwo+IEBAIC02MzExLDcg
KzYzMTEsOCBAQCBzdGF0aWMgYm9vbCByZWV4ZWN1dGVfaW5zdHJ1Y3Rpb24oc3RydWN0IGt2bV92
Y3B1ICp2Y3B1LCBndmFfdCBjcjIsCj4gIAkJaW5kaXJlY3Rfc2hhZG93X3BhZ2VzID0gdmNwdS0+
a3ZtLT5hcmNoLmluZGlyZWN0X3NoYWRvd19wYWdlczsKPiAgCQlzcGluX3VubG9jaygmdmNwdS0+
a3ZtLT5tbXVfbG9jayk7Cj4gIAo+IC0JCWlmIChpbmRpcmVjdF9zaGFkb3dfcGFnZXMpCj4gKwkJ
aWYgKGluZGlyZWN0X3NoYWRvd19wYWdlcwo+ICsJCSAgICAmJiAha3ZtaV90cmFja2VkX2dmbih2
Y3B1LCBncGFfdG9fZ2ZuKGdwYSkpKQo+ICAJCQlrdm1fbW11X3VucHJvdGVjdF9wYWdlKHZjcHUt
Pmt2bSwgZ3BhX3RvX2dmbihncGEpKTsKPiAgCj4gIAkJcmV0dXJuIHRydWU7Cj4gQEAgLTYzMjIs
NyArNjMyMyw4IEBAIHN0YXRpYyBib29sIHJlZXhlY3V0ZV9pbnN0cnVjdGlvbihzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUsIGd2YV90IGNyMiwKPiAgCSAqIGFuZCBpdCBmYWlsZWQgdHJ5IHRvIHVuc2hh
ZG93IHBhZ2UgYW5kIHJlLWVudGVyIHRoZQo+ICAJICogZ3Vlc3QgdG8gbGV0IENQVSBleGVjdXRl
IHRoZSBpbnN0cnVjdGlvbi4KPiAgCSAqLwo+IC0Ja3ZtX21tdV91bnByb3RlY3RfcGFnZSh2Y3B1
LT5rdm0sIGdwYV90b19nZm4oZ3BhKSk7Cj4gKwlpZiAoIWt2bWlfdHJhY2tlZF9nZm4odmNwdSwg
Z3BhX3RvX2dmbihncGEpKSkKPiArCQlrdm1fbW11X3VucHJvdGVjdF9wYWdlKHZjcHUtPmt2bSwg
Z3BhX3RvX2dmbihncGEpKTsKPiAgCj4gIAkvKgo+ICAJICogSWYgdGhlIGFjY2VzcyBmYXVsdHMg
b24gaXRzIHBhZ2UgdGFibGUsIGl0IGNhbiBub3QKPiBAQCAtNjM3NCw2ICs2Mzc2LDkgQEAgc3Rh
dGljIGJvb2wgcmV0cnlfaW5zdHJ1Y3Rpb24oc3RydWN0IHg4Nl9lbXVsYXRlX2N0eHQgKmN0eHQs
Cj4gIAlpZiAoIXZjcHUtPmFyY2gubW11LT5kaXJlY3RfbWFwKQo+ICAJCWdwYSA9IGt2bV9tbXVf
Z3ZhX3RvX2dwYV93cml0ZSh2Y3B1LCBjcjIsIE5VTEwpOwo+ICAKPiArCWlmIChrdm1pX3RyYWNr
ZWRfZ2ZuKHZjcHUsIGdwYV90b19nZm4oZ3BhKSkpCj4gKwkJcmV0dXJuIGZhbHNlOwo+ICsKPiAg
CWt2bV9tbXVfdW5wcm90ZWN0X3BhZ2UodmNwdS0+a3ZtLCBncGFfdG9fZ2ZuKGdwYSkpOwo+ICAK
PiAgCXJldHVybiB0cnVlOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
