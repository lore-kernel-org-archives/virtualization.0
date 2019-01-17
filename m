From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net 6/7] virtio_net: Use xdp_return_frame to free
	xdp_frames on destroying vqs
Date: Thu, 17 Jan 2019 20:56:39 +0800
Message-ID: <fce18995-52c8-dadd-bab5-4683686e46a8__7842.31525981358$1547755022$gmane$org@redhat.com>
References: <1547724045-2726-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<1547724045-2726-7-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1547724045-2726-7-git-send-email-makita.toshiaki@lab.ntt.co.jp>
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
Cc: netdev@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMS8xNyDkuIvljYg3OjIwLCBUb3NoaWFraSBNYWtpdGEgd3JvdGU6Cj4gcHV0X3Bh
Z2UoKSBjYW4gd29yayBhcyBhIGZhbGxiYWNrIGZvciBmcmVlaW5nIHhkcF9mcmFtZXMsIGJ1dCB0
aGUKPiBhcHByb3ByaWF0ZSB3YXkgaXMgdG8gdXNlIHhkcF9yZXR1cm5fZnJhbWUoKS4KPgo+IEZp
eGVzOiBjYWMzMjBjODUwZWYgKCJ2aXJ0aW9fbmV0OiBjb252ZXJ0IHRvIHVzZSBnZW5lcmljIHhk
cF9mcmFtZSBhbmQgeGRwX3JldHVybl9mcmFtZSBBUEkiKQo+IFNpZ25lZC1vZmYtYnk6IFRvc2hp
YWtpIE1ha2l0YSA8bWFraXRhLnRvc2hpYWtpQGxhYi5udHQuY28uanA+Cj4gLS0tCj4gICBkcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCBhZTkzZjBlLi45OTZkZTY5
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+IEBAIC0yNjY4LDcgKzI2NjgsNyBAQCBzdGF0aWMgdm9pZCBmcmVl
X3VudXNlZF9idWZzKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+ICAgCQkJaWYgKCFpc194ZHBf
cmF3X2J1ZmZlcl9xdWV1ZSh2aSwgaSkpCj4gICAJCQkJZGV2X2tmcmVlX3NrYihidWYpOwo+ICAg
CQkJZWxzZQo+IC0JCQkJcHV0X3BhZ2UodmlydF90b19oZWFkX3BhZ2UoYnVmKSk7Cj4gKwkJCQl4
ZHBfcmV0dXJuX2ZyYW1lKGJ1Zik7Cj4gICAJCX0KPiAgIAl9Cj4gICAKCgpBY2tlZC1ieTogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
