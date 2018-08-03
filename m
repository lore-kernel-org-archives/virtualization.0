From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v7 3/4] net: vhost: factor out busy polling logic
	to vhost_net_busy_poll()
Date: Fri, 3 Aug 2018 11:07:00 +0800
Message-ID: <90c0deec-6a7b-9787-b62f-7ea76a5cbd7c__13460.587783675$1533265508$gmane$org@redhat.com>
References: <1533092454-37196-1-git-send-email-xiangxia.m.yue@gmail.com>
	<1533092454-37196-4-git-send-email-xiangxia.m.yue@gmail.com>
	<30e62749-3cbd-ae88-6582-c20087884b20@redhat.com>
	<CAMDZJNWX7L4P0yO+-PeDFu_tmtLSntihO7rcLPB2GK4eN9zbwQ@mail.gmail.com>
	<b4ffd376-6fa8-4d0c-5c3a-82d1b6e924d6@redhat.com>
	<ca040549-5eda-4a03-4295-17e6d7d44dd5@lab.ntt.co.jp>
	<3272c3b4-a44c-8554-329e-8a5e1a59aafd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <3272c3b4-a44c-8554-329e-8a5e1a59aafd@redhat.com>
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
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>, Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDjmnIgwMuaXpSAxNzoyMywgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+Cj4+
Pj4+IE5vIG5lZWQgdG8gZW5hYmxlIHJ4IHZpcnRxdWV1ZSwgaWYgd2UgYXJlIHN1cmUgaGFuZGxl
X3J4KCkgd2lsbCBiZQo+Pj4+PiBjYWxsZWQgc29vbi4KPj4+PiBJZiB3ZSBkaXNhYmxlIHJ4IHZp
cnRxdWV1ZSBpbiBoYW5kbGVfdHggYW5kIGRvbid0IHNlbmQgcGFja2V0cyBmcm9tCj4+Pj4gZ3Vl
c3QgYW55bW9yZShoYW5kbGVfdHggaXMgbm90IGNhbGxlZCksIHNvIHdlIGNhbiB3YWtlIHVwIGZv
ciBzb2NrIHJ4Lgo+Pj4+IHNvIHRoZSBuZXR3b3JrIGlzIGJyb2tlbi4KPj4+IE5vdCBzdXJlIEkg
dW5kZXJzdGFuZCBoZXJlLiBJIG1lYW4gaXMgd2Ugc2NoZWR1bGUgd29yayBmb3IgaGFuZGxlX3J4
KCksCj4+PiB0aGVyZSdzIG5vIG5lZWQgdG8gZW5hYmxlIGl0IHNpbmNlIGhhbmRsZV9yeCgpIHdp
bGwgZG8gdGhpcyBmb3IgdXMuCj4+IExvb2tzIGxpa2UgaW4gdGhlIGxhc3QgImVsc2UiIGJsb2Nr
IGluIHZob3N0X25ldF9idXN5X3BvbGxfY2hlY2soKSB3ZQo+PiBuZWVkIHRvIGVuYWJsZSB2cSBz
aW5jZSBpbiB0aGF0IGNhc2Ugd2UgaGF2ZSBubyByeCBkYXRhIGFuZCBoYW5kbGVfcngoKQo+PiBp
cyBub3Qgc2NoZWR1bGVkLgo+Pgo+Cj4gWWVzLgo+Cj4gVGhhbmtzIAoKUmV0aGluayBhYm91dCB0
aGlzLCBsb29rcyBub3QuIFdlIGVuYWJsZSByeCB3YWtldXBzIGluIHRoaXMgY2FzZSwgc28gaWYg
CnRoZXJlJ3MgcGVuZGluZyBkYXRhLCBoYW5kbGVfcngoKSB3aWxsIGJlIHNjaGVkdWxlIGFmdGVy
IAp2aG9zdF9uZXRfZW5hYmxlX3ZxKCkuCgpUaGFua3MKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
