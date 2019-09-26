From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 6/8] mdev: introduce virtio device and its device ops
Date: Thu, 26 Sep 2019 16:12:07 +0800
Message-ID: <6ba16bf8-8e8a-343a-335d-ab77d7cda195__12313.1623071217$1569485586$gmane$org@redhat.com>
References: <20190924135332.14160-1-jasowang@redhat.com>
	<20190924135332.14160-7-jasowang@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D58F7DA@SHSMSX104.ccr.corp.intel.com>
	<2210d23d-38e4-e654-e53d-7867348de86a@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D590FE4@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D590FE4@SHSMSX104.ccr.corp.intel.com>
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
To: "Tian, Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "Bie, Tiwei" <tiwei.bie@intel.com>
Cc: "christophe.de.dinechin@gmail.com" <christophe.de.dinechin@gmail.com>, "sebott@linux.ibm.com" <sebott@linux.ibm.com>, "airlied@linux.ie" <airlied@linux.ie>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "lulu@redhat.com" <lulu@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "Wang,
	Zhi A" <zhi.a.wang@intel.com>, "farman@linux.ibm.com" <farman@linux.ibm.com>, "idos@mellanox.com" <idos@mellanox.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>Wa
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvOS8yNiDkuIrljYg4OjQ4LCBUaWFuLCBLZXZpbiB3cm90ZToKPj4+PiArfTsKPj4+
IEknbSBub3Qgc3VyZSBob3cgc3RhYmxlIGFib3ZlIG9wcyBhcmUuCj4+IEl0J3MgdGhlIGtlcm5l
bCBpbnRlcm5hbCBBUEksIHNvIHRoZXJlJ3Mgbm8gc3RyaWN0IHJlcXVpcmVtZW50IGZvciB0aGlz
Lgo+PiBXZSB3aWxsIGV4cG9ydCBhIHZlcnNpb24gdmFsdWUgZm9yIHVzZXJzcGFjZSBmb3IgY29t
cGF0aWJpbGl0eS4KPj4KPj4KPj4+IERvZXMgaXQgbWFrZSBzZW5zZSBpZiBkZWZpbmluZwo+Pj4g
anVzdCB0d28gY2FsbGJhY2tzIGhlcmUsIGUuZy4gdnFfY3RybCBhbmQgZGV2aWNlX2N0cmwsIGFu
ZCB0aGVuIGxldCB0aGUKPj4+IHZlbmRvciBkcml2ZXIgdG8gaGFuZGxlIHNwZWNpZmljIG9wcyBp
biBlYWNoIGNhdGVnb3J5IChzaW1pbGFyIHRvIGhvdwo+Pj4gaW9jdGwgd29ya3MpPwo+PiBNeSB1
bmRlcnN0YW5kaW5nIGlzIHRoYXQgaXQgaW50cm9kdWNlIGFub3RoZXIgaW5kaXJlY3Rpb24sIHlv
dSBzdGlsbAo+PiBuZWVkIHRvIGRpZmZlciBmcm9tIGRpZmZlcmVudCBjb21tYW5kLCBhbmQgaXQn
cyBsZXNzIGZsZXhpYmxlIHRoYW4KPj4gZGlyZWN0IGNhbGxiYWNrLgo+Pgo+PiBXaGF0J3MgdGhl
IHZhbHVlIG9mIGRvaW5nIHRoaXM/Cj4+Cj4gSSBqdXN0IHRob3VnaHQgZG9pbmcgc28gbWF5IHBy
b3ZpZGUgYmV0dGVyIGNvbXBhdGliaWxpdHkgdG8gdGhlCj4gcGFyZW50IGRyaXZlci4gRXZlbiB3
aGVuIG5ldyBvcCBpcyBpbnRyb2R1Y2VkLCBhIHBhcmVudCBkcml2ZXIKPiB0aGF0IHdhcyBkZXZl
bG9wZWQgYWdhaW5zdCB0aGUgb2xkIHNldCBjYW4gc3RpbGwgYmUgbG9hZGVkIGluIHRoZQo+IG5l
dyBrZXJuZWwuIEl0IGp1c3QgcmV0dXJucyBlcnJvciB3aGVuIHVucmVjb2duaXplZCBvcHMgYXJl
Cj4gcm91dGVkIHRocm91Z2ggdnFfY3RybCBhbmQgZGV2aWNlX2N0cmwsIGlmIHRoZSB1c2Vyc3Bh
Y2UgZG9lc24ndAo+IGZhdm9yIHRoZSBleHBvc2VkIHZlcnNpb24gdmFsdWUuIEJ1dCBpZiBhYm92
ZSBvcHMgc2V0IGlzIHByZXR0eQo+IHN0YWJsZSwgdGhlbiB0aGlzIGNvbW1lbnQgY2FuIGJlIGln
bm9yZWQuCgoKVGhpcyBpcyByZWFsbHkgZ29vZCBwb2ludCwgd2Ugc2hvdWxkIGtlZXAgaXQgc3Rh
YmxlIGFzIGEgcmVhbCB0cmFuc3BvcnQuIApBbmQgd2hlbiB0aGVyZSdzIG1ham9yIGNoYW5nZXMs
IHdlIHNob3VsZCBhZHZlcnRpc2UgdGhyb3VnaCB2ZXJzaW9uIHRoZW4gCndlIGNhbiBwcm92aWRl
IGEgbmV3IHNldCBvZiBmdW5jdGlvbnMuCgpUaGFua3MKCgo+Cj4gVGhhbmtzCj4gS2V2aW4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
