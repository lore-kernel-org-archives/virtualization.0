From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 76/92] kvm: x86: disable EPT A/D bits if
	introspection is present
Date: Tue, 13 Aug 2019 11:18:23 +0200
Message-ID: <9f8b31c5-2252-ddc5-2371-9c0959ac5a18@redhat.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-77-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190809160047.8319-77-alazar@bitdefender.com>
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

T24gMDkvMDgvMTkgMTg6MDAsIEFkYWxiZXJ0IExhesSDciB3cm90ZToKPiBTaWduZWQtb2ZmLWJ5
OiBBZGFsYmVydCBMYXrEg3IgPGFsYXphckBiaXRkZWZlbmRlci5jb20+Cj4gLS0tCj4gIGFyY2gv
eDg2L2t2bS92bXgvdm14LmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5j
IGIvYXJjaC94ODYva3ZtL3ZteC92bXguYwo+IGluZGV4IGRjNjQ4YmE0N2RmMy4uMTUyYzU4YjYz
ZjY5IDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMKPiArKysgYi9hcmNoL3g4
Ni9rdm0vdm14L3ZteC5jCj4gQEAgLTc3MTgsNyArNzcxOCw3IEBAIHN0YXRpYyBfX2luaXQgaW50
IGhhcmR3YXJlX3NldHVwKHZvaWQpCj4gIAkgICAgIWNwdV9oYXNfdm14X2ludmVwdF9nbG9iYWwo
KSkKPiAgCQllbmFibGVfZXB0ID0gMDsKPiAgCj4gLQlpZiAoIWNwdV9oYXNfdm14X2VwdF9hZF9i
aXRzKCkgfHwgIWVuYWJsZV9lcHQpCj4gKwlpZiAoIWNwdV9oYXNfdm14X2VwdF9hZF9iaXRzKCkg
fHwgIWVuYWJsZV9lcHQgfHwga3ZtaV9pc19wcmVzZW50KCkpCj4gIAkJZW5hYmxlX2VwdF9hZF9i
aXRzID0gMDsKPiAgCj4gIAlpZiAoIWNwdV9oYXNfdm14X3VucmVzdHJpY3RlZF9ndWVzdCgpIHx8
ICFlbmFibGVfZXB0KQo+IAoKV2h5PwoKUGFvbG8KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
