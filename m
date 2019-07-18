From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v2] vhost: introduce mdev based hardware vhost backend
Date: Thu, 18 Jul 2019 18:31:36 +0800
Message-ID: <90e6a722-ce7b-2ab3-0d2d-19b2ca09f2d1__27233.9647913881$1563445940$gmane$org@redhat.com>
References: <20190703115245.GA22374@___>
	<64833f91-02cd-7143-f12e-56ab93b2418d@redhat.com>
	<20190703130817.GA1978@___>
	<b01b8e28-8d96-31dd-56f4-ca7793498c55@redhat.com>
	<20190704062134.GA21116@___> <20190705084946.67b8f9f5@x1.home>
	<20190708061625.GA15936@___>
	<deae5ede-57e9-41e6-ea42-d84e07ca480a@redhat.com>
	<20190709063317.GA29300@___>
	<9aafdc4d-0203-b96e-c205-043db132eb06@redhat.com>
	<20190710062233.GA16212@___>
	<1b49aa84-2c1f-eec2-2809-711e1f2dd7de@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1b49aa84-2c1f-eec2-2809-711e1f2dd7de@redhat.com>
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
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: idos@mellanox.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, zhihong.wang@intel.com, maxime.coquelin@redhat.com, Rob Miller <rob.miller@broadcom.com>
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvNy8xMCDkuIvljYgzOjIyLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBZZWFoLCB0aGF0
J3MgYSBtYWpvciBjb25jZXJuLiBJZiBpdCdzIHRydWUsIGlzIGl0IHNvbWV0aGluZwo+PiB0aGF0
J3Mgbm90IGFjY2VwdGFibGU/Cj4KPgo+IEkgdGhpbmsgbm90LCBidXQgSSBkb24ndCBrbm93IGlm
IGFueSBvdGhlciBvbmUgdGhhdCBjYXJlIHRoaXMuCj4KPgo+Pgo+Pj4gQW5kIEkgZG8gc2VlIHNv
bWUgbmV3IFJGQyBmb3IgVkZJTyB0byBhZGQgbW9yZSBETUEgQVBJLgo+PiBJcyB0aGVyZSBhbnkg
cG9pbnRlcnM/Cj4KPgo+IEkgZG9uJ3QgcmVtZW1iZXIgdGhlIGRldGFpbHMsIGJ1dCBpdCBzaG91
bGQgYmUgc29tZXRoaW5nIHJlbGF0ZWQgdG8gCj4gU1ZBIHN1cHBvcnQgaW4gcmVjZW50IGludGVs
IElPTU1VLgoKCkUuZyB0aGlzIHNlcmllczoKCmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3Rz
L2lvbW11L21zZzM3MTQ2Lmh0bWwKClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
