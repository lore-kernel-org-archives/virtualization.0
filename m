From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net V2] virtio-net: re enable XDP_REDIRECT for mergeable
	buffer
Date: Mon, 5 Mar 2018 10:39:14 +0800
Message-ID: <e8898264-a2a3-9b0b-d66c-d7b1ad4e139e__22044.6651838303$1520217480$gmane$org@redhat.com>
References: <1519982954-14360-1-git-send-email-jasowang@redhat.com>
	<20180302170758.332600d6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180302170758.332600d6@redhat.com>
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
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDPmnIgwM+aXpSAwMDowNywgSmVzcGVyIERhbmdhYXJkIEJyb3VlciB3cm90
ZToKPiBPbiBGcmksICAyIE1hciAyMDE4IDE3OjI5OjE0ICswODAwCj4gSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPj4gWERQX1JFRElSRUNUIHN1cHBvcnQgZm9yIG1l
cmdlYWJsZSBidWZmZXIgd2FzIHJlbW92ZWQgc2luY2UgY29tbWl0Cj4+IDczMjRmNTM5OWIwNiAo
InZpcnRpb19uZXQ6IGRpc2FibGUgWERQX1JFRElSRUNUIGluIHJlY2VpdmVfbWVyZ2VhYmxlKCkK
Pj4gY2FzZSIpLiBUaGlzIGlzIGJlY2F1c2Ugd2UgZG9uJ3QgcmVzZXJ2ZSBlbm91Z2ggdGFpbHJv
b20gZm9yIHN0cnVjdAo+PiBza2Jfc2hhcmVkX2luZm8gd2hpY2ggYnJlYWtzIFhEUCBhc3N1bXB0
aW9uLiBTbyB0aGlzIHBhdGNoIGZpeGVzIHRoaXMKPj4gYnkgcmVzZXJ2aW5nIGVub3VnaCB0YWls
cm9vbSBhbmQgdXNpbmcgZml4ZWQgc2l6ZSBvZiByeCBidWZmZXIuCj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+IC0tLQo+PiBDaGFuZ2VzIGZy
b20gVjE6Cj4+IC0gZG8gbm90IGFkZCBkdXBsaWNhdGVkIHRyYWNlcG9pbnQgd2hlbiByZWRpcmVj
dGlvbiBmYWlscwo+IEFja2VkLWJ5OiBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIDxicm91ZXJAcmVk
aGF0LmNvbT4KPgo+IEkgZ2F2ZSBpdCBhIHF1aWNrIHNwaW4gb24gbXkgdGVzdGxhYiwgYW5kIGNw
dW1hcCBzZWVtcyB0bwo+IHdvcmsvbm90LWNyYXNoIG5vdyAoaWYgSSBtYW5hZ2VkIHRvIHR1cm4g
YmFjayBjb25maWcgdG8KPiByZWNlaXZlX21lcmdlYWJsZSgpIGNvcnJlY3RseSA7LSkpLgo+CgoK
VGhhbmtzIGZvciB0aGUgdGVzdGluZyBhbmQgcmV2aWV3aW5nLgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
