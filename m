From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net 1/7] virtio_net: Don't enable NAPI when interface is
	down
Date: Thu, 17 Jan 2019 20:38:20 +0800
Message-ID: <6f315078-fbe1-07fc-e645-08a25d6c34c0__37007.2628175423$1547754935$gmane$org@redhat.com>
References: <1547724045-2726-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<1547724045-2726-2-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1547724045-2726-2-git-send-email-makita.toshiaki@lab.ntt.co.jp>
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

Ck9uIDIwMTkvMS8xNyDkuIvljYg3OjIwLCBUb3NoaWFraSBNYWtpdGEgd3JvdGU6Cj4gQ29tbWl0
IDRlMDlmZjUzNjI4NCAoInZpcnRpby1uZXQ6IGRpc2FibGUgTkFQSSBvbmx5IHdoZW4gZW5hYmxl
ZCBkdXJpbmcKPiBYRFAgc2V0IikgdHJpZWQgdG8gZml4IGluYXBwcm9wcmlhdGUgTkFQSSBlbmFi
bGluZy9kaXNhYmxpbmcgd2hlbgo+ICFuZXRpZl9ydW5uaW5nKCksIGJ1dCB3YXMgbm90IGNvbXBs
ZXRlLgo+Cj4gT24gZXJyb3IgcGF0aCB2aXJ0aW9fbmV0IGNvdWxkIGVuYWJsZSBOQVBJIGV2ZW4g
d2hlbiAhbmV0aWZfcnVubmluZygpLgo+IFRoaXMgY2FuIGNhdXNlIGVuYWJsaW5nIE5BUEkgdHdp
Y2Ugb24gdmlydG5ldF9vcGVuKCksIHdoaWNoIHdvdWxkCj4gdHJpZ2dlciBCVUdfT04oKSBpbiBu
YXBpX2VuYWJsZSgpLgo+Cj4gRml4ZXM6IDQ5NDFkNDcyYmY5NWIgKCJ2aXJ0aW8tbmV0OiBkbyBu
b3QgcmVzZXQgZHVyaW5nIFhEUCBzZXQiKQo+IFNpZ25lZC1vZmYtYnk6IFRvc2hpYWtpIE1ha2l0
YSA8bWFraXRhLnRvc2hpYWtpQGxhYi5udHQuY28uanA+Cj4gLS0tCj4gICBkcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgfCA2ICsrKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCAwMjM3MjUwLi5hMDhkYTllIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYwo+IEBAIC0yNDMwLDggKzI0MzAsMTAgQEAgc3RhdGljIGludCB2aXJ0bmV0
X3hkcF9zZXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3RydWN0IGJwZl9wcm9nICpwcm9nLAo+
ICAgCXJldHVybiAwOwo+ICAgCj4gICBlcnI6Cj4gLQlmb3IgKGkgPSAwOyBpIDwgdmktPm1heF9x
dWV1ZV9wYWlyczsgaSsrKQo+IC0JCXZpcnRuZXRfbmFwaV9lbmFibGUodmktPnJxW2ldLnZxLCAm
dmktPnJxW2ldLm5hcGkpOwo+ICsJaWYgKG5ldGlmX3J1bm5pbmcoZGV2KSkgewo+ICsJCWZvciAo
aSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspCj4gKwkJCXZpcnRuZXRfbmFwaV9l
bmFibGUodmktPnJxW2ldLnZxLCAmdmktPnJxW2ldLm5hcGkpOwo+ICsJfQo+ICAgCWlmIChwcm9n
KQo+ICAgCQlicGZfcHJvZ19zdWIocHJvZywgdmktPm1heF9xdWV1ZV9wYWlycyAtIDEpOwo+ICAg
CXJldHVybiBlcnI7CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
