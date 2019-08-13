From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 27/92] kvm: introspection: use page track
Date: Tue, 13 Aug 2019 11:06:50 +0200
Message-ID: <0e6703cd-2d0b-ccd2-c353-c5f5de659837@redhat.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-28-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190809160047.8319-28-alazar@bitdefender.com>
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
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C Zhang <yu.c.zhang@intel.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Samuel_Laur=c3=a9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marian Rotariu <marian.c.rotariu@gmail.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, =?UTF-8?B?TmljdciZb3IgQ8OuyJt1?= <ncitu@bitdefender.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMDkvMDgvMTkgMTc6NTksIEFkYWxiZXJ0IExhesSDciB3cm90ZToKPiArCj4gKwkvKgo+ICsJ
ICogVGhpcyBmdW5jdGlvbiB1c2VzIGt2bS0+bW11X2xvY2sgc28gaXQncyBub3QgYWxsb3dlZCB0
byBiZQo+ICsJICogY2FsbGVkIHVuZGVyIGt2bWlfcHV0KCkuIEl0IGNhbiByZWFjaCBhIGRlYWRs
b2NrIGlmIGNhbGxlZAo+ICsJICogZnJvbSBrdm1fbW11X2xvYWQgLT4ga3ZtaV90cmFja2VkX2dm
biAtPiBrdm1pX3B1dC4KPiArCSAqLwo+ICsJa3ZtaV9jbGVhcl9tZW1fYWNjZXNzKGt2bSk7Cgpr
dm1pX3RyYWNrZWRfZ2ZuIGRvZXMgbm90IGV4aXN0IHlldC4KCk1vcmUgaW4gZ2VuZXJhbCwgdGhp
cyBjb21tZW50IHNheXMgd2h5IHlvdSBhcmUgY2FsbGluZyB0aGlzIGhlcmUsIGJ1dCBpdApzYXlz
IG5vdGhpbmcgYWJvdXQgdGhlIHNwbGl0IG9mIHJlc3BvbnNpYmlsaXR5IGJldHdlZW4Ka3ZtaV9l
bmRfaW50cm9zcGVjdGlvbiBhbmQga3ZtaV9yZWxlYXNlLiAgUGxlYXNlIGFkZCBhIGNvbW1lbnQg
Zm9yIHRoaXMKYXMgc29vbiBhcyB5b3UgYWRkIGt2bWlfZW5kX2ludHJvc3BlY3Rpb24gKHdoaWNo
IGFjY29yZGluZyB0byBteSBlYXJsaWVyCnJldmlldyBzaG91bGQgYmUgcGF0Y2ggMSkuCgpQYW9s
bwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
