From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 14/92] kvm: introspection: handle introspection
	commands before returning to guest
Date: Tue, 13 Aug 2019 16:45:11 +0200
Message-ID: <97cdf9cb-286c-2387-6cb5-003b30f74c7e@redhat.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-15-alazar@bitdefender.com>
	<645d86f5-67f6-f5d3-3fbb-5ee9898a7ef8@redhat.com>
	<5d52c10e.1c69fb81.26904.fd34SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d52c10e.1c69fb81.26904.fd34SMTPIN_ADDED_BROKEN@mx.google.com>
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

T24gMTMvMDgvMTkgMTU6NTQsIEFkYWxiZXJ0IExhesSDciB3cm90ZToKPiAgICAgTGVhdmluZyBr
dm1fdmNwdV9ibG9jaygpIGluIG9yZGVyIHRvIGhhbmRsZSBhIHJlcXVlc3Qgc3VjaCBhcyAncGF1
c2UnLAo+ICAgICB3b3VsZCBjYXVzZSB0aGUgdkNQVSB0byBlbnRlciB0aGUgZ3Vlc3Qgd2hlbiBy
ZXN1bWVkLiBNb3N0IG9mIHRoZQo+ICAgICB0aW1lIHRoaXMgZG9lcyBub3QgYXBwZWFyIHRvIGJl
IGFuIGlzc3VlLCBidXQgZHVyaW5nIGVhcmx5IGJvb3QgaXQKPiAgICAgY2FuIGhhcHBlbiBmb3Ig
YSBub24tYm9vdCB2Q1BVIHRvIHN0YXJ0IGV4ZWN1dGluZyBjb2RlIGZyb20gYXJlYXMgdGhhdAo+
ICAgICBmaXJzdCBuZWVkZWQgdG8gYmUgc2V0IHVwIGJ5IHZDUFUgIzAuCj4gICAgIAo+ICAgICBJ
biBhIHBhcnRpY3VsYXIgY2FzZSwgdkNQVSAjMSBleGVjdXRlZCBjb2RlIHdoaWNoIHJlc2lkZWQg
aW4gYW4gYXJlYQo+ICAgICBub3QgY292ZXJlZCBieSBhIG1lbXNsb3QsIHdoaWNoIGNhdXNlZCBh
biBFUFQgdmlvbGF0aW9uIHRoYXQgZ290Cj4gICAgIHR1cm5lZCBpbiBtbXVfc2V0X3NwdGUoKSBp
bnRvIGEgTU1JTyByZXF1ZXN0IHRoYXQgcmVxdWlyZWQgZW11bGF0aW9uLgo+ICAgICBVbmZvcnR1
bmF0ZWxseSwgdGhlIGVtdWxhdG9yIHRyaXBwZWQsIGV4aXRlZCB0byB1c2Vyc3BhY2UgYW5kIHRo
ZSBWTQo+ICAgICB3YXMgYWJvcnRlZC4KCk9rYXksIHRoaXMgbWFrZXMgc2Vuc2UuICBNYXliZSB5
b3Ugd2FudCB0byBoYW5kbGUgS1ZNX1JFUV9JTlRST1NQRUNUSU9OCmluIHZjcHVfcnVuIHJhdGhl
ciB0aGFuIHZjcHVfZW50ZXJfZ3Vlc3Q/CgpQYW9sbwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
