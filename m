From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/2] tools/virtio: add kmalloc_array stub
Date: Mon, 30 Jul 2018 15:28:25 +0800
Message-ID: <4542b5ea-6c09-3dbf-e62e-c96f15e847c7__48904.0498891429$1532935589$gmane$org@redhat.com>
References: <20180725134057.113423-1-mst@redhat.com>
	<20180725134057.113423-2-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180725134057.113423-2-mst@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, khandual@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDfmnIgyNeaXpSAyMTo0NSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IEZpeGVzOiA2ZGEyZWM1NjA1OSAoInRyZWV3aWRlOiBrbWFsbG9jKCkgLT4ga21hbGxvY19hcnJh
eSgpIikKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29t
Pgo+IC0tLQo+ICAgdG9vbHMvdmlydGlvL2xpbnV4L2tlcm5lbC5oIHwgNSArKysrKwo+ICAgMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3ZpcnRp
by9saW51eC9rZXJuZWwuaCBiL3Rvb2xzL3ZpcnRpby9saW51eC9rZXJuZWwuaAo+IGluZGV4IGZj
YTgzODFiYmUwNC4uZmIyMmJjY2ZiYzhhIDEwMDY0NAo+IC0tLSBhL3Rvb2xzL3ZpcnRpby9saW51
eC9rZXJuZWwuaAo+ICsrKyBiL3Rvb2xzL3ZpcnRpby9saW51eC9rZXJuZWwuaAo+IEBAIC01Miw2
ICs1MiwxMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgKmttYWxsb2Moc2l6ZV90IHMsIGdmcF90IGdm
cCkKPiAgIAkJcmV0dXJuIF9fa21hbGxvY19mYWtlOwo+ICAgCXJldHVybiBtYWxsb2Mocyk7Cj4g
ICB9Cj4gK3N0YXRpYyBpbmxpbmUgdm9pZCAqa21hbGxvY19hcnJheSh1bnNpZ25lZCBuLCBzaXpl
X3QgcywgZ2ZwX3QgZ2ZwKQo+ICt7Cj4gKwlyZXR1cm4ga21hbGxvYyhuICogcywgZ2ZwKTsKPiAr
fQo+ICsKPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCAqa3phbGxvYyhzaXplX3QgcywgZ2ZwX3QgZ2Zw
KQo+ICAgewo+ICAgCXZvaWQgKnAgPSBrbWFsbG9jKHMsIGdmcCk7CgpSZXZpZXdlZC1ieTogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
