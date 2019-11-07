From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V9 6/6] docs: sample driver to demonstrate how to
	implement virtio-mdev framework
Date: Thu, 7 Nov 2019 22:30:37 +0800
Message-ID: <1b26d298-0223-c5cc-9dd6-c4005139e32a__13143.2536685438$1573137090$gmane$org@redhat.com>
References: <20191106070548.18980-1-jasowang@redhat.com>
	<20191106070548.18980-7-jasowang@redhat.com>
	<88efad07-70aa-3879-31e7-ace4d2ad63a1@infradead.org>
	<20191106155800.0b8418ec@x1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191106155800.0b8418ec@x1.home>
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
To: Alex Williamson <alex.williamson@redhat.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: stefanha@redhat.com, christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.ke
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTEvNyDkuIrljYg2OjU4LCBBbGV4IFdpbGxpYW1zb24gd3JvdGU6Cj4gT24gV2Vk
LCA2IE5vdiAyMDE5IDE0OjUwOjMwIC0wODAwCj4gUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJh
ZGVhZC5vcmc+IHdyb3RlOgo+Cj4+IE9uIDExLzUvMTkgMTE6MDUgUE0sIEphc29uIFdhbmcgd3Jv
dGU6Cj4+PiBkaWZmIC0tZ2l0IGEvc2FtcGxlcy9LY29uZmlnIGIvc2FtcGxlcy9LY29uZmlnCj4+
PiBpbmRleCBjOGRhY2I0ZGRhODAuLjEzYTI0NDNlMThlMCAxMDA2NDQKPj4+IC0tLSBhL3NhbXBs
ZXMvS2NvbmZpZwo+Pj4gKysrIGIvc2FtcGxlcy9LY29uZmlnCj4+PiBAQCAtMTMxLDYgKzEzMSwx
NiBAQCBjb25maWcgU0FNUExFX1ZGSU9fTURFVl9NRFBZCj4+PiAgIAkgIG1lZGlhdGVkIGRldmlj
ZS4gIEl0IGlzIGEgc2ltcGxlIGZyYW1lYnVmZmVyIGFuZCBzdXBwb3J0cwo+Pj4gICAJICB0aGUg
cmVnaW9uIGRpc3BsYXkgaW50ZXJmYWNlIChWRklPX0dGWF9QTEFORV9UWVBFX1JFR0lPTikuCj4+
PiAgIAo+Pj4gK2NvbmZpZyBTQU1QTEVfVklSVElPX01ERVZfTkVUCj4+PiArCXRyaXN0YXRlICJC
dWlsZCBWSVJUSU8gbmV0IGV4YW1wbGUgbWVkaWF0ZWQgZGV2aWNlIHNhbXBsZSBjb2RlIC0tIGxv
YWRhYmxlIG1vZHVsZXMgb25seSIKPj4+ICsJZGVwZW5kcyBvbiBWSVJUSU9fTURFViAmJiBWSE9T
VF9SSU5HICYmIG0KPj4+ICsJaGVscAo+Pj4gKwkgIEJ1aWxkIGEgbmV0d29ya2luZyBzYW1wbGUg
ZGV2aWNlIGZvciB1c2UgYXMgYSB2aXJ0aW8KPj4+ICsJICBtZWRpYXRlZCBkZXZpY2UuIFRoZSBk
ZXZpY2UgY29vcHJlYXRlcyB3aXRoIHZpcnRpby1tZGV2IGJ1cwo+PiB0eXBvIGhlcmU6Cj4+IAkg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb29wZXJhdGVzCj4+Cj4gSSBjYW4gZml4IHRo
aXMgb24gY29tbWl0IHJlbGF0aXZlIHRvIFYxMCBpZiB0aGVyZSBhcmUgbm8gb3RoZXIgaXNzdWVz
Cj4gcmFpc2VkOgo+Cj4gZGlmZiAtLWdpdCBhL3NhbXBsZXMvS2NvbmZpZyBiL3NhbXBsZXMvS2Nv
bmZpZwo+IGluZGV4IDEzYTI0NDNlMThlMC4uYjcxMTZkOTdjYmJlIDEwMDY0NAo+IC0tLSBhL3Nh
bXBsZXMvS2NvbmZpZwo+ICsrKyBiL3NhbXBsZXMvS2NvbmZpZwo+IEBAIC0xMzYsNyArMTM2LDcg
QEAgY29uZmlnIFNBTVBMRV9WSVJUSU9fTURFVl9ORVQKPiAgICAgICAgICBkZXBlbmRzIG9uIFZJ
UlRJT19NREVWICYmIFZIT1NUX1JJTkcgJiYgbQo+ICAgICAgICAgIGhlbHAKPiAgICAgICAgICAg
IEJ1aWxkIGEgbmV0d29ya2luZyBzYW1wbGUgZGV2aWNlIGZvciB1c2UgYXMgYSB2aXJ0aW8KPiAt
ICAgICAgICAgbWVkaWF0ZWQgZGV2aWNlLiBUaGUgZGV2aWNlIGNvb3ByZWF0ZXMgd2l0aCB2aXJ0
aW8tbWRldiBidXMKPiArICAgICAgICAgbWVkaWF0ZWQgZGV2aWNlLiBUaGUgZGV2aWNlIGNvb3Bl
cmF0ZXMgd2l0aCB2aXJ0aW8tbWRldiBidXMKPiAgICAgICAgICAgIGRyaXZlciB0byBwcmVzZW50
IGFuIHZpcnRpbyBldGhlcm5ldCBkcml2ZXIgZm9yCj4gICAgICAgICAgICBrZXJuZWwuIEl0IHNp
bXBseSBsb29wYmFja3MgYWxsIHBhY2tldHMgZnJvbSBpdHMgVFgKPiAgICAgICAgICAgIHZpcnRx
dWV1ZSB0byBpdHMgUlggdmlydHF1ZXVlLgo+Cj4gVGhhbmtzLAo+IEFsZXgKCgpUaGFua3MsIHBl
ciBNaWNoYWVsIHJlcXVlc3QsIEkgd291bGQgcmVuYW1lIG12bmV0IGFuZCBpbmNsdWRlIHRoaXMg
Zml4IAppbiBWMTEuCgoKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
