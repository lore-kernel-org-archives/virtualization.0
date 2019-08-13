From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 14/92] kvm: introspection: handle introspection
	commands before returning to guest
Date: Tue, 13 Aug 2019 10:26:29 +0200
Message-ID: <645d86f5-67f6-f5d3-3fbb-5ee9898a7ef8@redhat.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-15-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190809160047.8319-15-alazar@bitdefender.com>
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
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C Zhang <yu.c.zhang@intel.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Samuel_Laur=c3=a9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Mircea_C=c3=aerjaliu?= <mcirjaliu@bitdefender.com>, =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMDkvMDgvMTkgMTc6NTksIEFkYWxiZXJ0IExhesSDciB3cm90ZToKPiArCQkJcHJlcGFyZV90
b19zd2FpdF9leGNsdXNpdmUoJnZjcHUtPndxLCAmd2FpdCwKPiArCQkJCQkJICAgVEFTS19JTlRF
UlJVUFRJQkxFKTsKPiArCj4gKwkJCWlmIChrdm1fdmNwdV9jaGVja19ibG9jayh2Y3B1KSA8IDAp
Cj4gKwkJCQlicmVhazsKPiArCj4gKwkJCXdhaXRlZCA9IHRydWU7Cj4gKwkJCXNjaGVkdWxlKCk7
Cj4gKwo+ICsJCQlpZiAoa3ZtX2NoZWNrX3JlcXVlc3QoS1ZNX1JFUV9JTlRST1NQRUNUSU9OLCB2
Y3B1KSkgewo+ICsJCQkJZG9fa3ZtaV93b3JrID0gdHJ1ZTsKPiArCQkJCWJyZWFrOwo+ICsJCQl9
Cj4gKwkJfQo+ICAKPiAtCQl3YWl0ZWQgPSB0cnVlOwo+IC0JCXNjaGVkdWxlKCk7Cj4gKwkJZmlu
aXNoX3N3YWl0KCZ2Y3B1LT53cSwgJndhaXQpOwo+ICsKPiArCQlpZiAoZG9fa3ZtaV93b3JrKQo+
ICsJCQlrdm1pX2hhbmRsZV9yZXF1ZXN0cyh2Y3B1KTsKPiArCQllbHNlCj4gKwkJCWJyZWFrOwo+
ICAJfQoKSXMgdGhpcyBuZWVkZWQ/ICBPciBjYW4gaXQganVzdCBnbyBiYWNrIHRvIEtWTV9SVU4g
YW5kIGhhbmRsZQpLVk1fUkVRX0lOVFJPU1BFQ1RJT04gdGhlcmUgKGluIHdoaWNoIGNhc2UgaXQg
d291bGQgYmUgYmFzaWNhbGx5CnByZW1hdHVyZSBvcHRpbWl6YXRpb24pPwoKUGFvbG8KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
