From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v7 3/4] net: vhost: factor out busy polling logic
	to vhost_net_busy_poll()
Date: Fri, 3 Aug 2018 10:38:36 +0800
Message-ID: <f61c8cde-ff31-2386-ad64-780588587301__1990.99602546102$1533263805$gmane$org@redhat.com>
References: <1533092454-37196-1-git-send-email-xiangxia.m.yue@gmail.com>
	<1533092454-37196-4-git-send-email-xiangxia.m.yue@gmail.com>
	<30e62749-3cbd-ae88-6582-c20087884b20@redhat.com>
	<CAMDZJNWX7L4P0yO+-PeDFu_tmtLSntihO7rcLPB2GK4eN9zbwQ@mail.gmail.com>
	<b4ffd376-6fa8-4d0c-5c3a-82d1b6e924d6@redhat.com>
	<ca040549-5eda-4a03-4295-17e6d7d44dd5@lab.ntt.co.jp>
	<3272c3b4-a44c-8554-329e-8a5e1a59aafd@redhat.com>
	<e2917cb0-f8dd-90c7-5a44-5333ad1d1ee8@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <e2917cb0-f8dd-90c7-5a44-5333ad1d1ee8@lab.ntt.co.jp>
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

CgpPbiAyMDE45bm0MDjmnIgwMuaXpSAxNzo1NywgVG9zaGlha2kgTWFraXRhIHdyb3RlOgo+IE9u
IDIwMTgvMDgvMDIgMTg6MjMsIEphc29uIFdhbmcgd3JvdGU6Cj4+IE9uIDIwMTjlubQwOOaciDAy
5pelIDE2OjQxLCBUb3NoaWFraSBNYWtpdGEgd3JvdGU6Cj4+PiBPbiAyMDE4LzA4LzAyIDE3OjE4
LCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+IE9uIDIwMTjlubQwOOaciDAx5pelIDE3OjUyLCBUb25n
aGFvIFpoYW5nIHdyb3RlOgo+Pj4+Pj4gK3N0YXRpYyB2b2lkIHZob3N0X25ldF9idXN5X3BvbGxf
Y2hlY2soc3RydWN0IHZob3N0X25ldCAqbmV0LAo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB2
aG9zdF92aXJ0cXVldWUgKnJ2cSwKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgdmhvc3Rfdmly
dHF1ZXVlICp0dnEsCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vbCByeCkKPj4+Pj4+ICt7Cj4+Pj4+
PiArwqDCoMKgwqAgc3RydWN0IHNvY2tldCAqc29jayA9IHJ2cS0+cHJpdmF0ZV9kYXRhOwo+Pj4+
Pj4gKwo+Pj4+Pj4gK8KgwqDCoMKgIGlmIChyeCkKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdmhvc3RfbmV0X2J1c3lfcG9sbF90cnlfcXVldWUobmV0LCB0dnEpOwo+Pj4+Pj4gK8Kg
wqDCoMKgIGVsc2UgaWYgKHNvY2sgJiYgc2tfaGFzX3J4X2RhdGEoc29jay0+c2spKQo+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2aG9zdF9uZXRfYnVzeV9wb2xsX3RyeV9xdWV1ZShu
ZXQsIHJ2cSk7Cj4+Pj4+PiArwqDCoMKgwqAgZWxzZSB7Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC8qIE9uIHR4IGhlcmUsIHNvY2sgaGFzIG5vIHJ4IGRhdGEsIHNvIHdlCj4+Pj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB3aWxsIHdhaXQgZm9yIHNvY2sgd2FrZXVw
IGZvciByeCwgYW5kCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB2aG9zdF9l
bmFibGVfbm90aWZ5KCkgaXMgbm90IG5lZWRlZC4gKi8KPj4+Pj4gQSBwb3NzaWJsZSBjYXNlIGlz
IHdlIGRvIGhhdmUgcnggZGF0YSBidXQgZ3Vlc3QgZG9lcyBub3QgcmVmaWxsIHRoZSByeAo+Pj4+
PiBxdWV1ZS4gSW4gdGhpcyBjYXNlIHdlIG1heSBsb3NlIG5vdGlmaWNhdGlvbnMgZnJvbSBndWVz
dC4KPj4+PiBZZXMsIHNob3VsZCBjb25zaWRlciB0aGlzIGNhc2UuIHRoYW5rcy4KPj4+IEknbSBh
IGJpdCBjb25mdXNlZC4gSXNuJ3QgdGhpcyBjb3ZlcmVkIGJ5IHRoZSBwcmV2aW91cwo+Pj4gImVs
c2UgaWYgKHNvY2sgJiYgc2tfaGFzX3J4X2RhdGEoLi4uKSkiIGJsb2NrPwo+PiBUaGUgcHJvYmxl
bSBpcyBpdCBkb2VzIG5vdGhpbmcgaWYgdmhvc3RfdnFfYXZhaWxfZW1wdHkoKSBpcyB0cnVlIGFu
ZAo+PiB2aG9zdF9lbmJsZV9ub3RpZnkoKSBpcyBmYWxzZS4KPiBJZiB2aG9zdF9lbmFibGVfbm90
aWZ5KCkgaXMgZmFsc2UsIGd1ZXN0IHdpbGwgZXZlbnR1YWxseSBraWNrcyB2cSwgbm8/Cj4KClll
cywgeW91IGFyZSByaWdodC4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
