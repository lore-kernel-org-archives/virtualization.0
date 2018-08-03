From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v7 3/4] net: vhost: factor out busy polling logic
	to vhost_net_busy_poll()
Date: Fri, 3 Aug 2018 11:44:11 +0800
Message-ID: <ace33be9-a004-f7be-4f73-911044eeae3f__5856.63614697314$1533267738$gmane$org@redhat.com>
References: <1533092454-37196-1-git-send-email-xiangxia.m.yue@gmail.com>
	<1533092454-37196-4-git-send-email-xiangxia.m.yue@gmail.com>
	<30e62749-3cbd-ae88-6582-c20087884b20@redhat.com>
	<CAMDZJNWX7L4P0yO+-PeDFu_tmtLSntihO7rcLPB2GK4eN9zbwQ@mail.gmail.com>
	<b4ffd376-6fa8-4d0c-5c3a-82d1b6e924d6@redhat.com>
	<ca040549-5eda-4a03-4295-17e6d7d44dd5@lab.ntt.co.jp>
	<3272c3b4-a44c-8554-329e-8a5e1a59aafd@redhat.com>
	<90c0deec-6a7b-9787-b62f-7ea76a5cbd7c@redhat.com>
	<74edb26a-e715-cb49-4e52-62e4b45638d1@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <74edb26a-e715-cb49-4e52-62e4b45638d1@lab.ntt.co.jp>
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

CgpPbiAyMDE45bm0MDjmnIgwM+aXpSAxMTozMiwgVG9zaGlha2kgTWFraXRhIHdyb3RlOgo+IE9u
IDIwMTgvMDgvMDMgMTI6MDcsIEphc29uIFdhbmcgd3JvdGU6Cj4+IE9uIDIwMTjlubQwOOaciDAy
5pelIDE3OjIzLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4+IE5vIG5lZWQgdG8gZW5hYmxlIHJ4
IHZpcnRxdWV1ZSwgaWYgd2UgYXJlIHN1cmUgaGFuZGxlX3J4KCkgd2lsbCBiZQo+Pj4+Pj4+IGNh
bGxlZCBzb29uLgo+Pj4+Pj4gSWYgd2UgZGlzYWJsZSByeCB2aXJ0cXVldWUgaW4gaGFuZGxlX3R4
IGFuZCBkb24ndCBzZW5kIHBhY2tldHMgZnJvbQo+Pj4+Pj4gZ3Vlc3QgYW55bW9yZShoYW5kbGVf
dHggaXMgbm90IGNhbGxlZCksIHNvIHdlIGNhbiB3YWtlIHVwIGZvciBzb2NrIHJ4Lgo+Pj4+Pj4g
c28gdGhlIG5ldHdvcmsgaXMgYnJva2VuLgo+Pj4+PiBOb3Qgc3VyZSBJIHVuZGVyc3RhbmQgaGVy
ZS4gSSBtZWFuIGlzIHdlIHNjaGVkdWxlIHdvcmsgZm9yIGhhbmRsZV9yeCgpLAo+Pj4+PiB0aGVy
ZSdzIG5vIG5lZWQgdG8gZW5hYmxlIGl0IHNpbmNlIGhhbmRsZV9yeCgpIHdpbGwgZG8gdGhpcyBm
b3IgdXMuCj4+Pj4gTG9va3MgbGlrZSBpbiB0aGUgbGFzdCAiZWxzZSIgYmxvY2sgaW4gdmhvc3Rf
bmV0X2J1c3lfcG9sbF9jaGVjaygpIHdlCj4+Pj4gbmVlZCB0byBlbmFibGUgdnEgc2luY2UgaW4g
dGhhdCBjYXNlIHdlIGhhdmUgbm8gcnggZGF0YSBhbmQgaGFuZGxlX3J4KCkKPj4+PiBpcyBub3Qg
c2NoZWR1bGVkLgo+Pj4+Cj4+IFJldGhpbmsgYWJvdXQgdGhpcywgbG9va3Mgbm90LiBXZSBlbmFi
bGUgcnggd2FrZXVwcyBpbiB0aGlzIGNhc2UsIHNvIGlmCj4+IHRoZXJlJ3MgcGVuZGluZyBkYXRh
LCBoYW5kbGVfcngoKSB3aWxsIGJlIHNjaGVkdWxlIGFmdGVyCj4+IHZob3N0X25ldF9lbmFibGVf
dnEoKS4KPiBZb3UgYXJlIHJpZ2h0LCBidXQgd2hhdCBJIHdhbnRlZCB0byBzYXkgaXMgdmhvc3Rf
bmV0X2VuYWJsZV92cSgpIHNob3VsZAo+IGJlIG5lZWRlZCAoSSB3YXMgdGFsa2luZyBhYm91dCB3
aGF0IHdvdWxkIGhhcHBlbiBpZgo+IHZob3N0X25ldF9lbmFibGVfdnEoKSB3ZXJlIHJlbW92ZWQp
LiBBbHNvLCBJIHRoaW5rIHdlIHNob3VsZCBtb3ZlCj4gdmhvc3RfbmV0X2VuYWJsZV92cSgpIGZy
b20gdmhvc3RfbmV0X2J1c3lfcG9sbCgpIHRvIHRoaXMgbGFzdCAiZWxzZSIKPiBibG9jayBiZWNh
dXNlIHRoaXMgaXMgdGhlIGNhc2Ugd2hlcmUgcnggd2FrZXVwcyBpcyByZXF1aXJlZC4KPiBBbnl3
YXkgdGhpcyBwYXJ0IHdpbGwgYmUgcmVmYWN0b3JlZCBzbyBsZXQncyBzZWUgd2hhdCB0aGlzIGNv
ZGUgd2lsbAo+IGxvb2sgbGlrZSBpbiBuZXh0IHZlcnNpb24uCj4KCkkgZ2V0IHlvdXIgcG9pbnQu
CgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
