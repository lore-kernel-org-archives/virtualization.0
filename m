From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH V2 4/9] vhost: reset invalidate_count in
	vhost_set_vring_num_addr()
Date: Wed, 31 Jul 2019 16:32:52 -0300
Message-ID: <20190731193252.GH3946__34152.1557931387$1564602247$gmane$org@ziepe.ca>
References: <20190731084655.7024-1-jasowang@redhat.com>
	<20190731084655.7024-5-jasowang@redhat.com>
	<20190731124124.GD3946@ziepe.ca>
	<31ef9ed4-d74a-3454-a57d-fa843a3a802b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <31ef9ed4-d74a-3454-a57d-fa843a3a802b@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

T24gV2VkLCBKdWwgMzEsIDIwMTkgYXQgMDk6Mjk6MjhQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDE5LzcvMzEg5LiL5Y2IODo0MSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+
ID4gT24gV2VkLCBKdWwgMzEsIDIwMTkgYXQgMDQ6NDY6NTBBTSAtMDQwMCwgSmFzb24gV2FuZyB3
cm90ZToKPiA+ID4gVGhlIHZob3N0X3NldF92cmluZ19udW1fYWRkcigpIGNvdWxkIGJlIGNhbGxl
ZCBpbiB0aGUgbWlkZGxlIG9mCj4gPiA+IGludmFsaWRhdGVfcmFuZ2Vfc3RhcnQoKSBhbmQgaW52
YWxpZGF0ZV9yYW5nZV9lbmQoKS4gSWYgd2UgZG9uJ3QgcmVzZXQKPiA+ID4gaW52YWxpZGF0ZV9j
b3VudCBhZnRlciB0aGUgdW4tcmVnaXN0ZXJpbmcgb2YgTU1VIG5vdGlmaWVyLCB0aGUKPiA+ID4g
aW52YWxpZGF0ZV9jb250IHdpbGwgcnVuIG91dCBvZiBzeW5jIChlLmcgbmV2ZXIgcmVhY2ggemVy
bykuIFRoaXMgd2lsbAo+ID4gPiBpbiBmYWN0IGRpc2FibGUgdGhlIGZhc3QgYWNjZXNzb3IgcGF0
aC4gRml4aW5nIGJ5IHJlc2V0IHRoZSBjb3VudCB0bwo+ID4gPiB6ZXJvLgo+ID4gPiAKPiA+ID4g
UmVwb3J0ZWQtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4gPiBEaWQg
TWljaGFlbCByZXBvcnQgdGhpcyBhcyB3ZWxsPwo+IAo+IAo+IENvcnJlY3QgbWUgaWYgSSB3YXMg
d3JvbmcuIEkgdGhpbmsgaXQncyBwb2ludCA0IGRlc2NyaWJlZCBpbgo+IGh0dHBzOi8vbGttbC5v
cmcvbGttbC8yMDE5LzcvMjEvMjUuCgpJJ20gbm90IHN1cmUgd2hhdCB0aGF0IGlzIHRhbGtpbmcg
YWJvdXQKCkJ1dCB0aGlzIGZpeGVzIHdoYXQgSSBkZXNjcmliZWQ6CgpodHRwczovL2xrbWwub3Jn
L2xrbWwvMjAxOS83LzIyLzU1NAoKSmFzb24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
