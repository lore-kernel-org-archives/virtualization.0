From: Jason Wang <jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] vfio: blacklist legacy virtio devices
Date: Tue, 30 Aug 2016 11:16:25 +0800
Message-ID: <b3183b57-2335-9195-4cf1-bad7b9f30956@redhat.com>
References: <1472523968-9540-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1472523968-9540-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE25bm0MDjmnIgzMOaXpSAxMDoyNywgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IExlZ2FjeSB2aXJ0aW8gZGV2aWNlcyBhbHdheXMgYnlwYXNzZWQgYW4gSU9NTVUsIHNvIHVzaW5n
IHRoZW0gd2l0aCB2ZmlvIHdhcwo+IG5ldmVyIHNhZmUuCgpBbmQgaXQgYWN0dWFsbHkgd29uJ3Qg
d29yayBzaW5jZSBHUEEgaXMgYXNzdW1lZCBpbiB0aGUgZGV2aWNlLiBTbyBJJ20gCm5vdCBzdXJl
IHRoaXMgaXMgbXVzdCBzaW5jZSB3ZSBzaG91bGQgZ2V0IGEgSU9NTVUgZmF1bHQgaW4gdGhpcyBj
YXNlLgoKPiAgIFRoaXMgYWRkcyBhIHF1aXJrIGRldGVjdGluZyB0aGVzZSBhbmQgZGlzYWJsaW5n
IFZGSU8gdW5sZXNzIHRoZQo+IG5vaW9tbXUgbW9kZSBpcyB1c2VkLiAgQXQgdGhlIG1vbWVudCwg
dGhpcyBvbmx5IGFwcGxpZXMgdG8gdmlydGlvLXBjaSBkZXZpY2VzLgo+Cj4gVGhlIHBhdGNoIG1p
Z2h0IG1ha2Ugc2Vuc2Ugb24gc3RhYmxlIGFzIHdlbGwuCj4KPiBNaWNoYWVsIFMuIFRzaXJraW4g
KDIpOgo+ICAgIHZmaW86IHJlcG9ydCBncm91cCBub2lvbW11IHN0YXR1cwo+ICAgIHZmaW86IGFk
ZCB2aXJ0aW8gcGNpIHF1aXJrCj4KPiAgIGRyaXZlcnMvdmZpby9wY2kvdmZpb19wY2lfcHJpdmF0
ZS5oIHwgICAxICsKPiAgIGluY2x1ZGUvbGludXgvdmZpby5oICAgICAgICAgICAgICAgIHwgICAy
ICsKPiAgIGRyaXZlcnMvdmZpby9wY2kvdmZpb19wY2kuYyAgICAgICAgIHwgIDE0ICsrKysKPiAg
IGRyaXZlcnMvdmZpby9wY2kvdmZpb19wY2lfdmlydGlvLmMgIHwgMTQwICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwo+ICAgZHJpdmVycy92ZmlvL3ZmaW8uYyAgICAgICAgICAg
ICAgICAgfCAgMTIgKysrKwo+ICAgZHJpdmVycy92ZmlvL3BjaS9NYWtlZmlsZSAgICAgICAgICAg
fCAgIDEgKwo+ICAgNiBmaWxlcyBjaGFuZ2VkLCAxNzAgaW5zZXJ0aW9ucygrKQo+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmZpby9wY2kvdmZpb19wY2lfdmlydGlvLmMKPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
