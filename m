From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 6/8] mdev: introduce virtio device and its device ops
Date: Fri, 27 Sep 2019 16:37:06 +0800
Message-ID: <baa742f5-8d4e-f1f1-1194-f362cdf51fea__46703.3613867656$1569573470$gmane$org@redhat.com>
References: <20190924135332.14160-1-jasowang@redhat.com>
	<20190924135332.14160-7-jasowang@redhat.com>
	<20190924170640.1da03bae@x1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190924170640.1da03bae@x1.home>
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
Cc: christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, maxime.coque
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvOS8yNSDkuIrljYg3OjA2LCBBbGV4IFdpbGxpYW1zb24gd3JvdGU6Cj4gT24gVHVl
LCAyNCBTZXAgMjAxOSAyMTo1MzozMCArMDgwMAo+IEphc29uIFdhbmc8amFzb3dhbmdAcmVkaGF0
LmNvbT4gIHdyb3RlOgo+Cj4+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyBiYXNpYyBzdXBwb3J0IGZv
ciBtZGV2IGRyaXZlciB0aGF0IHN1cHBvcnRzCj4+IHZpcnRpbyB0cmFuc3BvcnQgZm9yIGtlcm5l
bCB2aXJ0aW8gZHJpdmVyLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nPGphc293YW5n
QHJlZGhhdC5jb20+Cj4+IC0tLQo+PiAgIGluY2x1ZGUvbGludXgvbWRldi5oICAgICAgICB8ICAg
MiArCj4+ICAgaW5jbHVkZS9saW51eC92aXJ0aW9fbWRldi5oIHwgMTQ1ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTQ3IGluc2VydGlv
bnMoKykKPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC92aXJ0aW9fbWRldi5o
Cj4+Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21kZXYuaCBiL2luY2x1ZGUvbGludXgv
bWRldi5oCj4+IGluZGV4IDM0MTQzMDczMTFmMS4uNzNhYzI3YjNiODY4IDEwMDY0NAo+PiAtLS0g
YS9pbmNsdWRlL2xpbnV4L21kZXYuaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L21kZXYuaAo+PiBA
QCAtMTI2LDYgKzEyNiw4IEBAIHN0cnVjdCBtZGV2X2RldmljZSAqbWRldl9mcm9tX2RldihzdHJ1
Y3QgZGV2aWNlICpkZXYpOwo+PiAgIAo+PiAgIGVudW0gewo+PiAgIAlNREVWX0lEX1ZGSU8gPSAx
LAo+PiArCU1ERVZfSURfVklSVElPID0gMiwKPj4gKwlNREVWX0lEX1ZIT1NUID0gMywKPiBNREVW
X0lEX1ZIT1NUIGlzbid0IHVzZWQgeWV0IGhlcmUuICBBbHNvLCBnaXZlbiB0aGUgc3Ryb25nCj4g
aW50ZXJkZXBlbmRlbmNlIGJldHdlZW4gdGhlIGNsYXNzX2lkIGFuZCB0aGUgb3BzIHN0cnVjdHVy
ZSwgd2UgbWlnaHQKPiB3YW5kIHRvIGRlZmluZSB0aGVtIGluIHRoZSBzYW1lIHBsYWNlLiAgVGhh
bmtzLAo+Cj4gQWxleAo+CgpSZXRoaW5rIGFib3V0IHRoaXMswqAgSSBiZWxpZXZlIGl0J3MgYmV0
dGVyIHRvIGRlZmluZSB0aGUgZGV2aWNlIG9wcyBpbiAKdGhlaXIgb3duIGhlYWRlcnMsIGFuZCBv
bmUgc2V0IG9mIGRldmljZSBvcHMgY291bGQgYmUgdXNlZCBmb3IgdHdvIApjbGFzc2VzIChlLmcg
Ym90aCB2aXJ0aW8gYW5kIHZob3N0KS4gQW5kIHRvIGF2b2lkIGEgZHVwbGljYXRlZCBJRCAKZGVm
aW5pdGlvbi4gSSB0ZW5kIHRvIGtlZXAgdGhpcyBpbiB0aGUgY29tbW9uIG1kZXYuaCBoZWFkZXIu
CgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
