From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v1 4/5] virtio_ring: add event idx support in
	packed ring
Date: Tue, 10 Jul 2018 13:50:03 +0800
Message-ID: <9ee31221-9f4a-f1c5-0f0b-8d178bb536e9__34462.105742614$1531201690$gmane$org@redhat.com>
References: <20180709072241.8886-1-tiwei.bie@intel.com>
	<20180709072241.8886-5-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180709072241.8886-5-tiwei.bie@intel.com>
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
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDfmnIgwOeaXpSAxNToyMiwgVGl3ZWkgQmllIHdyb3RlOgo+IEBAIC0xMDU5
LDkgKzEwNTksMTkgQEAgc3RhdGljIGJvb2wgdmlydHF1ZXVlX2tpY2tfcHJlcGFyZV9wYWNrZWQo
c3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+ICAgCSAqIHN1cHByZXNzaW9ucy4gKi8KPiAgIAl2aXJ0
aW9fbWIodnEtPndlYWtfYmFycmllcnMpOwo+ICAgCj4gKwlvbGQgPSB2cS0+bmV4dF9hdmFpbF9p
ZHggLSB2cS0+bnVtX2FkZGVkOwo+ICsJbmV3ID0gdnEtPm5leHRfYXZhaWxfaWR4Owo+ICsJdnEt
Pm51bV9hZGRlZCA9IDA7Cj4gKwo+ICAgCXNuYXBzaG90ID0gKih1MzIgKil2cS0+dnJpbmdfcGFj
a2VkLmRldmljZTsKCkkgdGhpbmsgd2Ugc2hvdWxkIHVzZSBSRUFEX09OQ0UoKSB0byBwcmV2ZW50
IGNvbXBpbGVyIGZyb20gcmUtcmVhZGluZy4KCj4gKwlvZmZfd3JhcCA9IHZpcnRpbzE2X3RvX2Nw
dShfdnEtPnZkZXYsIChfX3ZpcnRpbzE2KShzbmFwc2hvdCAmIDB4ZmZmZikpOwo+ICAgCWZsYWdz
ID0gdmlydGlvMTZfdG9fY3B1KF92cS0+dmRldiwgKF9fdmlydGlvMTYpKHNuYXBzaG90ID4+IDE2
KSkgJiAweDM7Cj4gICAKPiArCXdyYXBfY291bnRlciA9IG9mZl93cmFwID4+IDE1Owo+ICsJZXZl
bnRfaWR4ID0gb2ZmX3dyYXAgJiB+KDEgPDwgMTUpOwo+ICsJaWYgKHdyYXBfY291bnRlciAhPSB2
cS0+YXZhaWxfd3JhcF9jb3VudGVyKQo+ICsJCWV2ZW50X2lkeCAtPSB2cS0+dnJpbmdfcGFja2Vk
Lm51bTsKClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
