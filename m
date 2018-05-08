From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v3 4/5] virtio_ring: add event idx support in packed ring
Date: Tue, 8 May 2018 13:40:40 +0800
Message-ID: <12ede490-f674-2b89-d639-266b5fe15466__32286.7732881152$1525757951$gmane$org@redhat.com>
References: <20180425051550.24342-5-tiwei.bie@intel.com>
	<34781052-df9f-e505-cd3f-08e460b34dcc@redhat.com>
	<20180502072819.mf5l3dypk6dwx2s7@debian>
	<20180502164828-mutt-send-email-mst@kernel.org>
	<20180502151255.h3x6rhszxa3euinl@debian>
	<20180502184015-mutt-send-email-mst@kernel.org>
	<20180503011116.qvoyblcpklinrk26@debian>
	<20180503044218-mutt-send-email-mst@kernel.org>
	<20180503020949.5u3qz32gsk33z6vk@debian>
	<9f0b4e37-63ff-42f9-f2e6-3747a19a0206@redhat.com>
	<20180503135430.lbtvn4p4lyu3ksqo@debian>
	<fbe06940-1618-5d34-7321-f4888c5dd1ee@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <fbe06940-1618-5d34-7321-f4888c5dd1ee@redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDXmnIgwOOaXpSAxMTowNSwgSmFzb24gV2FuZyB3cm90ZToKPj4KPj4gQmVj
YXVzZSBpbiB2aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5ZWQoKSwgd2UgbWF5IHNldCBhbgo+PiBl
dmVudF9vZmYgd2hpY2ggaXMgYmlnZ2VyIHRoYW4gbmV3IGFuZCBib3RoIG9mIHRoZW0gaGF2ZQo+
PiB3cmFwcGVkLiBBbmQgaW4gdGhpcyBjYXNlLCBhbHRob3VnaCBuZXcgaXMgc21hbGxlciB0aGFu
Cj4+IGV2ZW50X29mZiAoaS5lLiB0aGUgdGhpcmQgcGFyYW0gLS0gb2xkKSwgbmV3IHNob3VsZG4n
dAo+PiBhZGQgdnEtPm51bSwgYW5kIGFjdHVhbGx5IHdlIGFyZSBleHBlY3RpbmcgYSB2ZXJ5IGJp
Zwo+PiBpZHggZGlmZi4KPgo+IFllcywgc28gdG8gY2FsY3VsYXRlIGRpc3RhbmNlIGNvcnJlY3Rs
eSBiZXR3ZWVuIGV2ZW50IGFuZCBuZXcsIHdlIGp1c3QgCj4gbmVlZCB0byBjb21wYXJlIHRoZSB3
YXJwIGNvdW50ZXIgYW5kIHJldHVybiBmYWxzZSBpZiBpdCBkb2Vzbid0IG1hdGNoIAo+IHdpdGhv
dXQgdGhlIG5lZWQgdG8gdHJ5IHRvIGFkZCB2cS5udW0gaGVyZS4KPgo+IFRoYW5rcyAKClNvcnJ5
LCBsb29rcyBsaWtlIHRoZSBmb2xsb3dpbmcgc2hvdWxkIHdvcmssIHdlIG5lZWQgYWRkIHZxLm51
bSBpZiAKdXNlZF93cmFwX2NvdW50ZXIgZG9lcyBub3QgbWF0Y2g6CgpzdGF0aWMgYm9vbCB2aG9z
dF92cmluZ19wYWNrZWRfbmVlZF9ldmVudChzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICp2cSwKIMKg
wqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqAgX191MTYgb2ZmX3dyYXAsIF9fdTE2
IG5ldywKIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqAgX191MTYgb2xkKQp7
CiDCoMKgwqAgYm9vbCB3cmFwID0gb2ZmX3dyYXAgPj4gMTU7CiDCoMKgwqAgaW50IG9mZiA9IG9m
Zl93cmFwICYgfigxIDw8IDE1KTsKIMKgwqDCoCBfX3UxNiBkMSwgZDI7CgogwqDCoMKgIGlmICh3
cmFwICE9IHZxLT51c2VkX3dyYXBfY291bnRlcikKIMKgwqDCoCDCoMKgwqAgZDEgPSBuZXcgKyB2
cS0+bnVtIC0gb2ZmIC0gMTsKIMKgwqDCoCBlbHNlCiDCoMKgwqAgwqDCoMKgIGQxID0gbmV3IC0g
b2ZmIC0gMTsKCiDCoMKgwqAgaWYgKG5ldyA+IG9sZCkKIMKgwqDCoCDCoMKgwqAgZDIgPSBuZXcg
LSBvbGQ7CiDCoMKgwqAgZWxzZQogwqDCoMKgIMKgwqDCoCBkMiA9IG5ldyArIHZxLT5udW0gLSBv
bGQ7CgogwqDCoMKgIHJldHVybiBkMSA8IGQyOwp9CgpUaGFua3MKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
