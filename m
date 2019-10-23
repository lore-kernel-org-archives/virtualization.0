From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC 2/2] vhost: IFC VF vdpa layer
Date: Wed, 23 Oct 2019 14:39:15 +0800
Message-ID: <02d44f0a-687f-ed87-518b-7a4d3e83c5d3__33435.9964168229$1571812787$gmane$org@redhat.com>
References: <20191016013050.3918-1-lingshan.zhu@intel.com>
	<20191016013050.3918-3-lingshan.zhu@intel.com>
	<9495331d-3c65-6f49-dcd9-bfdb17054cf0@redhat.com>
	<f65358e9-6728-8260-74f7-176d7511e989@intel.com>
	<1cae60b6-938d-e2df-2dca-fbf545f06853@redhat.com>
	<ddf412c6-69e2-b3ca-d0c8-75de1db78ed9@linux.intel.com>
	<b2adaab0-bbc3-b7f0-77da-e1e3cab93b76@redhat.com>
	<6588d9f4-f357-ec78-16a4-ccaf0e3768e7@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <6588d9f4-f357-ec78-16a4-ccaf0e3768e7@intel.com>
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
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Zhu Lingshan <lingshan.zhu@linux.intel.com>, mst@redhat.com, alex.williamson@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, zhiyuan.lv@intel.com, jason.zeng@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTAvMjMg5LiL5Y2IMjoxOSwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPgo+IE9uIDEw
LzIyLzIwMTkgOTowNSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4KPj4gT24gMjAxOS8xMC8yMiDk
uIvljYgyOjUzLCBaaHUgTGluZ3NoYW4gd3JvdGU6Cj4+Pgo+Pj4gT24gMTAvMjEvMjAxOSA2OjE5
IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Cj4+Pj4gT24gMjAxOS8xMC8yMSDkuIvljYg1OjUz
LCBaaHUsIExpbmdzaGFuIHdyb3RlOgo+Pj4+Pgo+Pj4+PiBPbiAxMC8xNi8yMDE5IDY6MTkgUE0s
IEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+Pgo+Pj4+Pj4gT24gMjAxOS8xMC8xNiDkuIrljYg5OjMw
LCBaaHUgTGluZ3NoYW4gd3JvdGU6Cj4+Pj4+Pj4gVGhpcyBjb21taXQgaW50cm9kdWNlZCBJRkMg
VkYgb3BlcmF0aW9ucyBmb3IgdmRwYSwgd2hpY2ggY29tcGx5cyB0bwo+Pj4+Pj4+IHZob3N0X21k
ZXYgaW50ZXJmYWNlcywgaGFuZGxlcyBJRkMgVkYgaW5pdGlhbGl6YXRpb24sCj4+Pj4+Pj4gY29u
ZmlndXJhdGlvbiBhbmQgcmVtb3ZhbC4KPj4+Pj4+Pgo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpo
dSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4+Pj4+PiAtLS0KPj4KPj4KPj4g
Wy4uLl0KPj4KPj4KPj4+Pgo+Pj4+Cj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+PiArfQo+Pj4+
Pj4+ICsKPj4+Pj4+PiArc3RhdGljIGludCBpZmN2Zl9tZGV2X3NldF9mZWF0dXJlcyhzdHJ1Y3Qg
bWRldl9kZXZpY2UgKm1kZXYsIAo+Pj4+Pj4+IHU2NCBmZWF0dXJlcykKPj4+Pj4+PiArewo+Pj4+
Pj4+ICvCoMKgwqAgc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXIgPSBtZGV2X2dldF9kcnZk
YXRhKG1kZXYpOwo+Pj4+Pj4+ICvCoMKgwqAgc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IElGQ19QUklW
QVRFX1RPX1ZGKGFkYXB0ZXIpOwo+Pj4+Pj4+ICsKPj4+Pj4+PiArwqDCoMKgIHZmLT5yZXFfZmVh
dHVyZXMgPSBmZWF0dXJlczsKPj4+Pj4+PiArCj4+Pj4+Pj4gK8KgwqDCoCByZXR1cm4gMDsKPj4+
Pj4+PiArfQo+Pj4+Pj4+ICsKPj4+Pj4+PiArc3RhdGljIHU2NCBpZmN2Zl9tZGV2X2dldF92cV9z
dGF0ZShzdHJ1Y3QgbWRldl9kZXZpY2UgKm1kZXYsIAo+Pj4+Pj4+IHUxNiBxaWQpCj4+Pj4+Pj4g
K3sKPj4+Pj4+PiArwqDCoMKgIHN0cnVjdCBpZmN2Zl9hZGFwdGVyICphZGFwdGVyID0gbWRldl9n
ZXRfZHJ2ZGF0YShtZGV2KTsKPj4+Pj4+PiArwqDCoMKgIHN0cnVjdCBpZmN2Zl9odyAqdmYgPSBJ
RkNfUFJJVkFURV9UT19WRihhZGFwdGVyKTsKPj4+Pj4+PiArCj4+Pj4+Pj4gK8KgwqDCoCByZXR1
cm4gdmYtPnZyaW5nW3FpZF0ubGFzdF9hdmFpbF9pZHg7Cj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IERv
ZXMgdGhpcyByZWFsbHkgd29yaz8gSSdkIGV4cGVjdCBpdCBzaG91bGQgYmUgZmV0Y2hlZCBmcm9t
IGh3IAo+Pj4+Pj4gc2luY2UgaXQncyBhbiBpbnRlcm5hbCBzdGF0ZS4KPj4+Pj4gZm9yIG5vdywg
aXQncyB3b3JraW5nLCB3ZSBpbnRlbmQgdG8gc3VwcG9ydCBMTSBpbiBuZXh0IHZlcnNpb24gCj4+
Pj4+IGRyaXZlcnMuCj4+Pj4KPj4+Pgo+Pj4+IEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgaGVy
ZSwgSSBkb24ndCBzZWUgYW55IHN5bmNocm9uaXphdGlvbiAKPj4+PiBiZXR3ZWVuIHRoZSBoYXJk
d2FyZSBhbmQgbGFzdF9hdmFpbF9pZHgsIHNvIGxhc3RfYXZhaWxfaWR4IHNob3VsZCAKPj4+PiBu
b3QgY2hhbmdlLgo+Pj4+Cj4+Pj4gQnR3LCB3aGF0IGRpZCAiTE0iIG1lYW4gOikgPwo+Pj4KPj4+
IEkgY2FuIGFkZCBiYXIgSU8gb3BlcmF0aW9ucyBoZXJlLCBMTSA9IGxpdmUgbWlncmF0aW9uLCBz
b3JyeSBmb3IgdGhlIAo+Pj4gYWJicmV2aWF0aW9uLgo+Pgo+Pgo+PiBKdXN0IG1ha2Ugc3VyZSBJ
IHVuZGVyc3RhbmQgaGVyZSwgSSBiZWxpZXZlIHlvdSBtZWFuIHJlYWRpbmcgCj4+IGxhc3RfYXZh
aWxfaWR4IHRocm91Z2ggSU8gYmFyIGhlcmU/Cj4+Cj4+IFRoYW5rcwo+Cj4gSGkgSmFzb24sCj4K
PiBZZXMsIEkgbWVhbiBsYXN0X2F2YWlsX2lkeC4gaXMgdGhhdCBjb3JyZWN0Pwo+Cj4gVEhhbmtz
CgoKWWVzLgoKVGhhbmtzCgoKPgo+Pgo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
