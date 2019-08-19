From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC PATCH v6 55/92] kvm: introspection: add KVMI_CONTROL_MSR
	and KVMI_EVENT_MSR
Date: Mon, 19 Aug 2019 11:52:40 -0700
Message-ID: <20190819185240.GC1916@linux.intel.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-56-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190809160047.8319-56-alazar@bitdefender.com>
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
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C <yu.c.zhang@intel.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel =?iso-8859-1?Q?Laur=E9n?= <samuel.lauren@iki.fi>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Zhang@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCBBdWcgMDksIDIwMTkgYXQgMDc6MDA6MTBQTSArMDMwMCwgQWRhbGJlcnQgTGF6xINy
IHdyb3RlOgo+ICtpbnQga3ZtaV9hcmNoX2NtZF9jb250cm9sX21zcihzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUsCj4gKwkJCSAgICAgIGNvbnN0IHN0cnVjdCBrdm1pX2NvbnRyb2xfbXNyICpyZXEpCj4g
K3sKPiArCWludCBlcnI7Cj4gKwo+ICsJaWYgKHJlcS0+cGFkZGluZzEgfHwgcmVxLT5wYWRkaW5n
MikKPiArCQlyZXR1cm4gLUtWTV9FSU5WQUw7Cj4gKwo+ICsJZXJyID0gbXNyX2NvbnRyb2wodmNw
dSwgcmVxLT5tc3IsIHJlcS0+ZW5hYmxlKTsKPiArCj4gKwlpZiAoIWVyciAmJiByZXEtPmVuYWJs
ZSkKClRoaXMgbmVlZHMgYSBjb21tZW50IGV4cGxhaW5pbmcgdGhhdCBpdCBpbnRlbnRpb25hbGx5
IGNhbGxzIGludG8gYXJjaApjb2RlIG9ubHkgZm9yIHRoZSBlbmFibGUgY2FzZSBzbyBhcyB0byBh
dm9pZCBoYXZpbmcgdG8gZGVhbCB3aXRoIHRyYWNraW5nCndoZXRoZXIgb3Igbm90IGl0J3Mgc2Fm
ZSB0byBkaXNhYmxlIGludGVyY2VwdGlvbi4gIEF0IGZpcnN0IChhbmQgc2Vjb25kKQpnbGFuY2Ug
aXQgbG9vayBsaWtlIEtWTSBpcyBzaWxlbnRseSBpZ25vcmluZyB0aGUgQGVuYWJsZT1mYWxzZSBj
YXNlLgoKPiArCQlrdm1fYXJjaF9tc3JfaW50ZXJjZXB0KHZjcHUsIHJlcS0+bXNyLCByZXEtPmVu
YWJsZSk7CgpSZW5hbWluZyB0byBrdm1fYXJjaF9lbmFibGVfbXNyX2ludGVyY2VwdCgpIHdvdWxk
IGFsc28gaGVscCBjb21tdW5pY2F0ZQp0aGF0IEtWTUkgY2FuJ3QgYmUgdXNlZCB0byBkaXNhYmxl
IG1zciBpbnRlcmNlcHRpb24uICBUaGUgZnVuY3Rpb24gY2FuCmFsd2F5cyBiZSByZW5hbWVkIGlm
IHNvbWVvbmUgdGFrZXMgb24gdGhlIHRhc2sgb2YgZW5oYW5jaW5nIHRoZSBhcmNoIGNvZGUKdG8g
aGFuZGxpbmcgZGlzYWJsaW5nIGludGVyY2VwdGlvbi4KCj4gKwo+ICsJcmV0dXJuIGVycjsKPiAr
fQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
