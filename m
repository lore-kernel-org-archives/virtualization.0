From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC 2/2] vhost: IFC VF vdpa layer
Date: Tue, 22 Oct 2019 21:05:57 +0800
Message-ID: <b2adaab0-bbc3-b7f0-77da-e1e3cab93b76__41112.9617759556$1571749604$gmane$org@redhat.com>
References: <20191016013050.3918-1-lingshan.zhu@intel.com>
	<20191016013050.3918-3-lingshan.zhu@intel.com>
	<9495331d-3c65-6f49-dcd9-bfdb17054cf0@redhat.com>
	<f65358e9-6728-8260-74f7-176d7511e989@intel.com>
	<1cae60b6-938d-e2df-2dca-fbf545f06853@redhat.com>
	<ddf412c6-69e2-b3ca-d0c8-75de1db78ed9@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <ddf412c6-69e2-b3ca-d0c8-75de1db78ed9@linux.intel.com>
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
To: Zhu Lingshan <lingshan.zhu@linux.intel.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com, alex.williamson@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, zhiyuan.lv@intel.com, jason.zeng@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTAvMjIg5LiL5Y2IMjo1MywgWmh1IExpbmdzaGFuIHdyb3RlOgo+Cj4gT24gMTAv
MjEvMjAxOSA2OjE5IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiBPbiAyMDE5LzEwLzIxIOS4
i+WNiDU6NTMsIFpodSwgTGluZ3NoYW4gd3JvdGU6Cj4+Pgo+Pj4gT24gMTAvMTYvMjAxOSA2OjE5
IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Cj4+Pj4gT24gMjAxOS8xMC8xNiDkuIrljYg5OjMw
LCBaaHUgTGluZ3NoYW4gd3JvdGU6Cj4+Pj4+IFRoaXMgY29tbWl0IGludHJvZHVjZWQgSUZDIFZG
IG9wZXJhdGlvbnMgZm9yIHZkcGEsIHdoaWNoIGNvbXBseXMgdG8KPj4+Pj4gdmhvc3RfbWRldiBp
bnRlcmZhY2VzLCBoYW5kbGVzIElGQyBWRiBpbml0aWFsaXphdGlvbiwKPj4+Pj4gY29uZmlndXJh
dGlvbiBhbmQgcmVtb3ZhbC4KPj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFu
IDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+Pj4+PiAtLS0KCgpbLi4uXQoKCj4+Cj4+Cj4+Pgo+
Pj4+Cj4+Pj4KPj4+Pj4gK30KPj4+Pj4gKwo+Pj4+PiArc3RhdGljIGludCBpZmN2Zl9tZGV2X3Nl
dF9mZWF0dXJlcyhzdHJ1Y3QgbWRldl9kZXZpY2UgKm1kZXYsIHU2NCAKPj4+Pj4gZmVhdHVyZXMp
Cj4+Pj4+ICt7Cj4+Pj4+ICvCoMKgwqAgc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXIgPSBt
ZGV2X2dldF9kcnZkYXRhKG1kZXYpOwo+Pj4+PiArwqDCoMKgIHN0cnVjdCBpZmN2Zl9odyAqdmYg
PSBJRkNfUFJJVkFURV9UT19WRihhZGFwdGVyKTsKPj4+Pj4gKwo+Pj4+PiArwqDCoMKgIHZmLT5y
ZXFfZmVhdHVyZXMgPSBmZWF0dXJlczsKPj4+Pj4gKwo+Pj4+PiArwqDCoMKgIHJldHVybiAwOwo+
Pj4+PiArfQo+Pj4+PiArCj4+Pj4+ICtzdGF0aWMgdTY0IGlmY3ZmX21kZXZfZ2V0X3ZxX3N0YXRl
KHN0cnVjdCBtZGV2X2RldmljZSAqbWRldiwgdTE2IAo+Pj4+PiBxaWQpCj4+Pj4+ICt7Cj4+Pj4+
ICvCoMKgwqAgc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXIgPSBtZGV2X2dldF9kcnZkYXRh
KG1kZXYpOwo+Pj4+PiArwqDCoMKgIHN0cnVjdCBpZmN2Zl9odyAqdmYgPSBJRkNfUFJJVkFURV9U
T19WRihhZGFwdGVyKTsKPj4+Pj4gKwo+Pj4+PiArwqDCoMKgIHJldHVybiB2Zi0+dnJpbmdbcWlk
XS5sYXN0X2F2YWlsX2lkeDsKPj4+Pgo+Pj4+Cj4+Pj4gRG9lcyB0aGlzIHJlYWxseSB3b3JrPyBJ
J2QgZXhwZWN0IGl0IHNob3VsZCBiZSBmZXRjaGVkIGZyb20gaHcgCj4+Pj4gc2luY2UgaXQncyBh
biBpbnRlcm5hbCBzdGF0ZS4KPj4+IGZvciBub3csIGl0J3Mgd29ya2luZywgd2UgaW50ZW5kIHRv
IHN1cHBvcnQgTE0gaW4gbmV4dCB2ZXJzaW9uIGRyaXZlcnMuCj4+Cj4+Cj4+IEknbSBub3Qgc3Vy
ZSBJIHVuZGVyc3RhbmQgaGVyZSwgSSBkb24ndCBzZWUgYW55IHN5bmNocm9uaXphdGlvbiAKPj4g
YmV0d2VlbiB0aGUgaGFyZHdhcmUgYW5kIGxhc3RfYXZhaWxfaWR4LCBzbyBsYXN0X2F2YWlsX2lk
eCBzaG91bGQgbm90IAo+PiBjaGFuZ2UuCj4+Cj4+IEJ0dywgd2hhdCBkaWQgIkxNIiBtZWFuIDop
ID8KPgo+IEkgY2FuIGFkZCBiYXIgSU8gb3BlcmF0aW9ucyBoZXJlLCBMTSA9IGxpdmUgbWlncmF0
aW9uLCBzb3JyeSBmb3IgdGhlIAo+IGFiYnJldmlhdGlvbi4KCgpKdXN0IG1ha2Ugc3VyZSBJIHVu
ZGVyc3RhbmQgaGVyZSwgSSBiZWxpZXZlIHlvdSBtZWFuIHJlYWRpbmcgCmxhc3RfYXZhaWxfaWR4
IHRocm91Z2ggSU8gYmFyIGhlcmU/CgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
