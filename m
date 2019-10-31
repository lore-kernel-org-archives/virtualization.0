From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V6 6/6] docs: sample driver to demonstrate how to
	implement virtio-mdev framework
Date: Thu, 31 Oct 2019 09:46:02 +0800
Message-ID: <d8266abb-391a-27d0-59ab-3e1412fe73da__24558.9427113131$1572486412$gmane$org@redhat.com>
References: <20191030064444.21166-1-jasowang@redhat.com>
	<20191030064444.21166-7-jasowang@redhat.com>
	<20191030212312.GA4251@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191030212312.GA4251@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: stefanha@redhat.com, christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, rodrigo.vivi@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.ke
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTAvMzEg5LiK5Y2INToyMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24g
V2VkLCBPY3QgMzAsIDIwMTkgYXQgMDI6NDQ6NDRQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gVGhpcyBzYW1wbGUgZHJpdmVyIGNyZWF0ZXMgbWRldiBkZXZpY2UgdGhhdCBzaW11bGF0ZSB2
aXJ0aW8gbmV0IGRldmljZQo+PiBvdmVyIHZpcnRpbyBtZGV2IHRyYW5zcG9ydC4gVGhlIGRldmlj
ZSBpcyBpbXBsZW1lbnRlZCB0aHJvdWdoIHZyaW5naAo+PiBhbmQgd29ya3F1ZXVlLiBBIGRldmlj
ZSBzcGVjaWZpYyBkbWEgb3BzIGlzIHRvIG1ha2Ugc3VyZSBIVkEgaXMgdXNlZAo+PiBkaXJlY3Rs
eSBhcyB0aGUgSU9WQS4gVGhpcyBzaG91bGQgYmUgc3VmZmljaWVudCBmb3Iga2VybmVsIHZpcnRp
bwo+PiBkcml2ZXIgdG8gd29yay4KPj4KPj4gT25seSAndmlydGlvJyB0eXBlIGlzIHN1cHBvcnRl
ZCByaWdodCBub3cuIEkgcGxhbiB0byBhZGQgJ3Zob3N0JyB0eXBlCj4+IG9uIHRvcCB3aGljaCBy
ZXF1aXJlcyBzb21lIHZpcnR1YWwgSU9NTVUgaW1wbGVtZW50ZWQgaW4gdGhpcyBzYW1wbGUKPj4g
ZHJpdmVyLgo+IENhbiB3ZSBwbGVhc2Ugc3VibWl0IGEgcmVhbCBkcml2ZXIgZm9yIGl0PyAgQSBt
b3JlIG9yIGxlc3MgdXNlbGVzcwo+IHNhbXBsZSBkcml2ZXIgZG9lc24ndCByZWFsbHkgcXVhbGlm
eSBmb3Igb3VyIG5vcm1hbCBrZXJuZWwgcmVxdWlyZW1lbnRzCj4gdGhhdCBpbmZyYXN0cnVjdHVy
ZSBzaG91bGQgaGF2ZSBhIHJlYWwgdXNlci4KCgpJbnRlbCBwb3N0ZWQgYSByZWFsIGRyaXZlciBo
ZXJlOiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS8xMC8xNS8xMjI2LgoKSSBwbGFuIHRvIHBv
c3QgYW5vdGhlciBkcml2ZXIgdGhhdCB3aXJlIHZpcml0by1wY2kgYmFjayB0byBtZGV2IGJ1cyBv
biAKdG9wIG9mIHRoaXMgc2VyaWVzIGFzIHdlbGwuCgpUaGFua3MKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
