From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 6/7] virtio: introduce a mdev based transport
Date: Tue, 15 Oct 2019 11:29:07 +0800
Message-ID: <cf8fa583-fb2c-67c3-15d1-64efa8d73121@redhat.com>
References: <20191011081557.28302-1-jasowang@redhat.com>
	<20191011081557.28302-7-jasowang@redhat.com>
	<20191014173942.GB5359@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191014173942.GB5359@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, rodrigo.vivi@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, maxime.coque
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTAvMTUg5LiK5Y2IMTozOSwgU3RlZmFuIEhham5vY3ppIHdyb3RlOgo+IE9uIEZy
aSwgT2N0IDExLCAyMDE5IGF0IDA0OjE1OjU2UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
ICtzdHJ1Y3QgdmlydGlvX21kZXZfZGV2aWNlIHsKPj4gKwlzdHJ1Y3QgdmlydGlvX2RldmljZSB2
ZGV2Owo+PiArCXN0cnVjdCBtZGV2X2RldmljZSAqbWRldjsKPj4gKwl1bnNpZ25lZCBsb25nIHZl
cnNpb247Cj4+ICsKPj4gKwlzdHJ1Y3QgdmlydHF1ZXVlICoqdnFzOwo+PiArCS8qIFRoZSBsb2Nr
IHRvIHByb3RlY3QgdmlydHF1ZXVlIGxpc3QgKi8KPj4gKwlzcGlubG9ja190IGxvY2s7Cj4+ICsJ
c3RydWN0IGxpc3RfaGVhZCB2aXJ0cXVldWVzOwo+IElzIHRoaXMgYSBsaXN0IG9mIHN0cnVjdCB2
aXJ0aW9fbWRldl92cV9pbmZvPyAgUGxlYXNlIGRvY3VtZW50IHRoZQo+IGFjdHVhbCB0eXBlIGlu
IGEgY29tbWVudC4KCgpPay4KCgo+PiArc3RhdGljIGludCB2aXJ0aW9fbWRldl9maW5kX3Zxcyhz
dHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5zaWduZWQgbnZxcywKPj4gKwkJCQlzdHJ1Y3Qg
dmlydHF1ZXVlICp2cXNbXSwKPj4gKwkJCQl2cV9jYWxsYmFja190ICpjYWxsYmFja3NbXSwKPj4g
KwkJCQljb25zdCBjaGFyICogY29uc3QgbmFtZXNbXSwKPj4gKwkJCQljb25zdCBib29sICpjdHgs
Cj4+ICsJCQkJc3RydWN0IGlycV9hZmZpbml0eSAqZGVzYykKPj4gK3sKPj4gKwlzdHJ1Y3Qgdmly
dGlvX21kZXZfZGV2aWNlICp2bV9kZXYgPSB0b192aXJ0aW9fbWRldl9kZXZpY2UodmRldik7Cj4+
ICsJc3RydWN0IG1kZXZfZGV2aWNlICptZGV2ID0gdm1fZ2V0X21kZXYodmRldik7Cj4+ICsJY29u
c3Qgc3RydWN0IHZpcnRpb19tZGV2X2RldmljZV9vcHMgKm9wcyA9IG1kZXZfZ2V0X2Rldl9vcHMo
bWRldik7Cj4+ICsJc3RydWN0IHZpcnRpb19tZGV2X2NhbGxiYWNrIGNiOwo+PiArCWludCBpLCBl
cnIsIHF1ZXVlX2lkeCA9IDA7Cj4+ICsKPj4gKwl2bV9kZXYtPnZxcyA9IGttYWxsb2NfYXJyYXko
cXVldWVfaWR4LCBzaXplb2YoKnZtX2Rldi0+dnFzKSwKPj4gKwkJCQkgICAgR0ZQX0tFUk5FTCk7
Cj4ga21hbGxvY19hcnJheSgwLCAuLi4pPyAgSSB3b3VsZCBoYXZlIGV4cGVjdGVkIG52cXMgaW5z
dGVhZCBvZiBxdWV1ZV9pZHgKPiAoMCkuCj4KPiBXaGF0IGlzIHRoaXMgdGhlIHB1cnBvc2Ugb2Yg
dm1fZGV2LT52cXMgYW5kIGRvZXMgYW55dGhpbmcgZXZlciBhY2Nlc3MgaXQ/CgoKSXQncyB1c2Vs
ZXNzLCB3aWxsIHJlbW92ZSBpdC4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
