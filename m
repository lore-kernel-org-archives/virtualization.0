From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 07/92] kvm: introspection: honor the reply option
	when handling the KVMI_GET_VERSION command
Date: Tue, 13 Aug 2019 11:16:01 +0200
Message-ID: <a5cdbbd4-6f25-a0a5-054e-5810b5828a48@redhat.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-8-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190809160047.8319-8-alazar@bitdefender.com>
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
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C Zhang <yu.c.zhang@intel.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Samuel_Laur=c3=a9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMDkvMDgvMTkgMTc6NTksIEFkYWxiZXJ0IExhesSDciB3cm90ZToKPiBPYnZpb3VzbHksIHRo
ZSBLVk1JX0dFVF9WRVJTSU9OIGNvbW1hbmQgbXVzdCBub3QgYmUgdXNlZCB3aGVuIHRoZSBjb21t
YW5kCj4gcmVwbHkgaXMgZGlzYWJsZWQgYnkgYSBwcmV2aW91cyBLVk1JX0NPTlRST0xfQ01EX1JF
U1BPTlNFIGNvbW1hbmQuCj4gCj4gVGhpcyBjb21taXQgY2hhbmdlcyB0aGUgY29kZSBwYXRoIGlu
IG9yZGVyIHRvIGNoZWNrIHRoZSByZXBseSBvcHRpb24KPiAoZW5hYmxlZC9kaXNhYmxlZCkgYmVm
b3JlIHRyeWluZyB0byByZXBseSB0byB0aGlzIGNvbW1hbmQuIElmIHRoZSBjb21tYW5kCj4gcmVw
bHkgaXMgZGlzYWJsZWQgaXQgd2lsbCByZXR1cm4gYW4gZXJyb3IgdG8gdGhlIGNhbGxlci4gSW4g
dGhlIGVuZCwgdGhlCj4gcmVjZWl2aW5nIHdvcmtlciB3aWxsIGZpbmlzaCBhbmQgdGhlIGludHJv
c3BlY3Rpb24gc29ja2V0IHdpbGwgYmUgY2xvc2VkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFkYWxi
ZXJ0IExhesSDciA8YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4KPiAtLS0KPiAgdmlydC9rdm0va3Zt
aV9tc2cuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3ZpcnQva3ZtL2t2bWlfbXNnLmMgYi92aXJ0L2t2bS9r
dm1pX21zZy5jCj4gaW5kZXggZWE1YzdlMjM2NjlhLi4yMjM3YTZlZDI1ZjYgMTAwNjQ0Cj4gLS0t
IGEvdmlydC9rdm0va3ZtaV9tc2cuYwo+ICsrKyBiL3ZpcnQva3ZtL2t2bWlfbXNnLmMKPiBAQCAt
MTY5LDcgKzE2OSw3IEBAIHN0YXRpYyBpbnQgaGFuZGxlX2dldF92ZXJzaW9uKHN0cnVjdCBrdm1p
ICppa3ZtLAo+ICAJbWVtc2V0KCZycGwsIDAsIHNpemVvZihycGwpKTsKPiAgCXJwbC52ZXJzaW9u
ID0gS1ZNSV9WRVJTSU9OOwo+ICAKPiAtCXJldHVybiBrdm1pX21zZ192bV9yZXBseShpa3ZtLCBt
c2csIDAsICZycGwsIHNpemVvZihycGwpKTsKPiArCXJldHVybiBrdm1pX21zZ192bV9tYXliZV9y
ZXBseShpa3ZtLCBtc2csIDAsICZycGwsIHNpemVvZihycGwpKTsKPiAgfQo+ICAKPiAgc3RhdGlj
IGJvb2wgaXNfY29tbWFuZF9hbGxvd2VkKHN0cnVjdCBrdm1pICppa3ZtLCBpbnQgaWQpCj4gCgpH
byBhaGVhZCBhbmQgc3F1YXNoIHRoaXMgaW4gdGhlIHByZXZpb3VzIHBhdGNoLgoKUGFvbG8KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
