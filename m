From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net 3/7] virtio_net: Fix not restoring real_num_rx_queues
Date: Thu, 17 Jan 2019 20:39:52 +0800
Message-ID: <20c11700-f0a4-dbb8-1646-98da3b771d7f__25285.9080829241$1547754968$gmane$org@redhat.com>
References: <1547724045-2726-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<1547724045-2726-4-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1547724045-2726-4-git-send-email-makita.toshiaki@lab.ntt.co.jp>
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
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>, "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMS8xNyDkuIvljYg3OjIwLCBUb3NoaWFraSBNYWtpdGEgd3JvdGU6Cj4gV2hlbiBf
dmlydG5ldF9zZXRfcXVldWVzKCkgZmFpbGVkIHdlIGRpZCBub3QgcmVzdG9yZSByZWFsX251bV9y
eF9xdWV1ZXMuCj4gRml4IHRoaXMgYnkgcGxhY2luZyB0aGUgY2hhbmdlIG9mIHJlYWxfbnVtX3J4
X3F1ZXVlcyBhZnRlcgo+IF92aXJ0bmV0X3NldF9xdWV1ZXMoKS4KPiBUaGlzIG9yZGVyIGlzIGFs
c28gaW4gbGluZSB3aXRoIHZpcnRuZXRfc2V0X2NoYW5uZWxzKCkuCj4KPiBGaXhlczogNDk0MWQ0
NzJiZjk1ICgidmlydGlvLW5ldDogZG8gbm90IHJlc2V0IGR1cmluZyBYRFAgc2V0IikKPiBTaWdu
ZWQtb2ZmLWJ5OiBUb3NoaWFraSBNYWtpdGEgPG1ha2l0YS50b3NoaWFraUBsYWIubnR0LmNvLmpw
Pgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMiArLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXgg
N2QzNWU2ZC4uNjcwY2MxNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMjQyNywxMCArMjQyNywxMCBA
QCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX3NldChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBzdHJ1
Y3QgYnBmX3Byb2cgKnByb2csCj4gICAJCX0KPiAgIAl9Cj4gICAKPiAtCW5ldGlmX3NldF9yZWFs
X251bV9yeF9xdWV1ZXMoZGV2LCBjdXJyX3FwICsgeGRwX3FwKTsKPiAgIAllcnIgPSBfdmlydG5l
dF9zZXRfcXVldWVzKHZpLCBjdXJyX3FwICsgeGRwX3FwKTsKPiAgIAlpZiAoZXJyKQo+ICAgCQln
b3RvIGVycjsKPiArCW5ldGlmX3NldF9yZWFsX251bV9yeF9xdWV1ZXMoZGV2LCBjdXJyX3FwICsg
eGRwX3FwKTsKPiAgIAl2aS0+eGRwX3F1ZXVlX3BhaXJzID0geGRwX3FwOwo+ICAgCj4gICAJZm9y
IChpID0gMDsgaSA8IHZpLT5tYXhfcXVldWVfcGFpcnM7IGkrKykgewoKCkFja2VkLWJ5OiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
