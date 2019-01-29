From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: Re: [PATCH v2 net 7/7] virtio_net: Differentiate sk_buff and
	xdp_frame on freeing
Date: Tue, 29 Jan 2019 11:35:08 +0900
Message-ID: <5f114c25-1f42-996b-134c-962b64597e74__28935.6407987484$1548742780$gmane$org@lab.ntt.co.jp>
References: <1548722759-2470-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<1548722759-2470-8-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<6267c42f-ce1e-1b63-2af9-84a76090f686@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <6267c42f-ce1e-1b63-2af9-84a76090f686@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

T24gMjAxOS8wMS8yOSAxMToyMywgSmFzb24gV2FuZyB3cm90ZToKPiBPbiAyMDE5LzEvMjkg5LiK
5Y2IODo0NSwgVG9zaGlha2kgTWFraXRhIHdyb3RlOgouLi4KPj4gQEAgLTI2NjYsMTAgKzI2OTYs
MTAgQEAgc3RhdGljIHZvaWQgZnJlZV91bnVzZWRfYnVmcyhzdHJ1Y3QKPj4gdmlydG5ldF9pbmZv
ICp2aSkKPj4gwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgdmktPm1heF9xdWV1ZV9wYWlyczsg
aSsrKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdmlydHF1ZXVlICp2cSA9IHZpLT5z
cVtpXS52cTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHdoaWxlICgoYnVmID0gdmlydHF1ZXVlX2Rl
dGFjaF91bnVzZWRfYnVmKHZxKSkgIT0gTlVMTCkgewo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAoIWlzX3hkcF9yYXdfYnVmZmVyX3F1ZXVlKHZpLCBpKSkKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKCFpc194ZHBfZnJhbWUoYnVmKSkKPiAKPiAKPiBJIGJlbGlldmUgdGhpcyBp
cyB0aGUgbGFzdCB1c2VyIG9mIGlzX3hkcF9yYXdfYnVmZmVyX3F1ZXVlKCksIG1heWJlIHlvdQo+
IGNhbiBzZW50IGEgcGF0Y2ggb24gdG9wIHRvIHJlbW92ZSBpdC4KCkFjdHVhbGx5IHBhdGNoMiBh
ZGRlZCBuZXcgdXNlcnMgb2YgaXQgOykKCj4gCj4gCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZGV2X2tmcmVlX3NrYihidWYpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBlbHNlCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeGRwX3JldHVybl9m
cmFtZShidWYpOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHhkcF9yZXR1cm5f
ZnJhbWUocHRyX3RvX3hkcChidWYpKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4gwqDCoMKg
wqDCoCB9Cj4+IMKgIAo+IAo+IAo+IEFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPgo+IAoKVGhhbmtzIQoKLS0gClRvc2hpYWtpIE1ha2l0YQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
