From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 4/6] mdev: introduce virtio device and its device ops
Date: Fri, 18 Oct 2019 15:35:34 +0800
Message-ID: <24a96fca-926d-38ee-4dab-5f3715ef1433__22522.7882548765$1571384191$gmane$org@redhat.com>
References: <20191017104836.32464-1-jasowang@redhat.com>
	<20191017104836.32464-5-jasowang@redhat.com>
	<20191017115329.47d4a165@x1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191017115329.47d4a165@x1.home>
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: stefanha@redhat.com, christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.ke
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTAvMTgg5LiK5Y2IMTo1MywgQWxleCBXaWxsaWFtc29uIHdyb3RlOgo+IE9uIFRo
dSwgMTcgT2N0IDIwMTkgMTg6NDg6MzQgKzA4MDAKPiBKYXNvbiBXYW5nPGphc293YW5nQHJlZGhh
dC5jb20+ICB3cm90ZToKPgo+PiBUaGlzIHBhdGNoIGltcGxlbWVudHMgYmFzaWMgc3VwcG9ydCBm
b3IgbWRldiBkcml2ZXIgdGhhdCBzdXBwb3J0cwo+PiB2aXJ0aW8gdHJhbnNwb3J0IGZvciBrZXJu
ZWwgdmlydGlvIGRyaXZlci4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZzxqYXNvd2Fu
Z0ByZWRoYXQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL3ZmaW8vbWRldi9tZGV2X2NvcmUuYyB8
ICAxMiArKysKPj4gICBpbmNsdWRlL2xpbnV4L21kZXYuaCAgICAgICAgICB8ICAgNCArCj4+ICAg
aW5jbHVkZS9saW51eC92aXJ0aW9fbWRldi5oICAgfCAxNTEgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMTY3IGluc2VydGlvbnMoKykKPj4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC92aXJ0aW9fbWRldi5oCj4+Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZmaW8vbWRldi9tZGV2X2NvcmUuYyBiL2RyaXZlcnMvdmZpby9t
ZGV2L21kZXZfY29yZS5jCj4+IGluZGV4IGQwZjMxMTNjODA3MS4uNTgzNGY2YjdjN2E1IDEwMDY0
NAo+PiAtLS0gYS9kcml2ZXJzL3ZmaW8vbWRldi9tZGV2X2NvcmUuYwo+PiArKysgYi9kcml2ZXJz
L3ZmaW8vbWRldi9tZGV2X2NvcmUuYwo+PiBAQCAtNTcsNiArNTcsMTggQEAgdm9pZCBtZGV2X3Nl
dF92ZmlvX29wcyhzdHJ1Y3QgbWRldl9kZXZpY2UgKm1kZXYsCj4+ICAgfQo+PiAgIEVYUE9SVF9T
WU1CT0wobWRldl9zZXRfdmZpb19vcHMpOwo+PiAgIAo+PiArLyogU3BlY2lmeSB0aGUgdmlydGlv
IGRldmljZSBvcHMgZm9yIHRoZSBtZGV2IGRldmljZSwgdGhpcwo+PiArICogbXVzdCBiZSBjYWxs
ZWQgZHVyaW5nIGNyZWF0ZSgpIGNhbGxiYWNrIGZvciB2aXJ0aW8gbWRldiBkZXZpY2UuCj4+ICsg
Ki8KPj4gK3ZvaWQgbWRldl9zZXRfdmlydGlvX29wcyhzdHJ1Y3QgbWRldl9kZXZpY2UgKm1kZXYs
Cj4+ICsJCQkgY29uc3Qgc3RydWN0IHZpcnRpb19tZGV2X2RldmljZV9vcHMgKnZpcnRpb19vcHMp
Cj4+ICt7Cj4+ICsJQlVHX09OKG1kZXYtPmNsYXNzX2lkKTsKPiBOaXQsIHRoaXMgb25lIGlzIGEg
QlVHX09OLCBidXQgdGhlIHZmaW8gb25lIGlzIGEgV0FSTl9PTi4gIFRoYW5rcywKPgo+IEFsZXgK
CgpMZXQgbWUgZml4IGluIG5leHQgdmVyc2lvbi4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
