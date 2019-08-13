From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 26/92] kvm: x86: add kvm_mmu_nested_pagefault()
Date: Tue, 13 Aug 2019 10:12:54 +0200
Message-ID: <a35a1d7c-fa36-c4f2-e8e6-7a242789364e@redhat.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-27-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190809160047.8319-27-alazar@bitdefender.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?UTF-8?Q?Adalbert_Laz=c4=83r?= <alazar@bitdefender.com>, kvm@vger.kernel.org
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C Zhang <yu.c.zhang@intel.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Samuel_Laur=c3=a9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, =?UTF-8?B?TmljdciZb3IgQ8OuyJt1?= <ncitu@bitdefender.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMDkvMDgvMTkgMTc6NTksIEFkYWxiZXJ0IExhesSDciB3cm90ZToKPiArc3RhdGljIGJvb2wg
dm14X25lc3RlZF9wYWdlZmF1bHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQo+ICt7Cj4gKwlpZiAo
dmNwdS0+YXJjaC5leGl0X3F1YWxpZmljYXRpb24gJiBFUFRfVklPTEFUSU9OX0dWQV9UUkFOU0xB
VEVEKQo+ICsJCXJldHVybiBmYWxzZTsKPiArCXJldHVybiB0cnVlOwo+ICt9Cj4gKwoKVGhpcyBo
b29rIGlzIG1pc25hbWVkOyBpdCBoYXMgbm90aGluZyB0byBkbyB3aXRoIG5lc3RlZCB2aXJ0dWFs
aXphdGlvbi4KIFJhdGhlciwgaXQgcmV0dXJucyB0cnVlIGlmIGl0IHRoZSBmYWlsdXJlIGhhcHBl
bmVkIHdoaWxlIHRyYW5zbGF0aW5nCnRoZSBhZGRyZXNzIG9mIGEgZ3Vlc3QgcGFnZSB0YWJsZS4K
ClNWTSBtYWtlcyB0aGUgc2FtZSBpbmZvcm1hdGlvbiBhdmFpbGFibGUgaW4gRVhJVElORk9bMzNd
LgoKUGFvbG8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
