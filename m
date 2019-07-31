From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 4/9] vhost: reset invalidate_count in
	vhost_set_vring_num_addr()
Date: Wed, 31 Jul 2019 15:37:34 -0400
Message-ID: <20190731153640-mutt-send-email-mst__16275.3578669921$1564602719$gmane$org@kernel.org>
References: <20190731084655.7024-1-jasowang@redhat.com>
	<20190731084655.7024-5-jasowang@redhat.com>
	<20190731124124.GD3946@ziepe.ca>
	<31ef9ed4-d74a-3454-a57d-fa843a3a802b@redhat.com>
	<20190731193252.GH3946@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190731193252.GH3946@ziepe.ca>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

T24gV2VkLCBKdWwgMzEsIDIwMTkgYXQgMDQ6MzI6NTJQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IE9uIFdlZCwgSnVsIDMxLCAyMDE5IGF0IDA5OjI5OjI4UE0gKzA4MDAsIEphc29u
IFdhbmcgd3JvdGU6Cj4gPiAKPiA+IE9uIDIwMTkvNy8zMSDkuIvljYg4OjQxLCBKYXNvbiBHdW50
aG9ycGUgd3JvdGU6Cj4gPiA+IE9uIFdlZCwgSnVsIDMxLCAyMDE5IGF0IDA0OjQ2OjUwQU0gLTA0
MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gVGhlIHZob3N0X3NldF92cmluZ19udW1fYWRk
cigpIGNvdWxkIGJlIGNhbGxlZCBpbiB0aGUgbWlkZGxlIG9mCj4gPiA+ID4gaW52YWxpZGF0ZV9y
YW5nZV9zdGFydCgpIGFuZCBpbnZhbGlkYXRlX3JhbmdlX2VuZCgpLiBJZiB3ZSBkb24ndCByZXNl
dAo+ID4gPiA+IGludmFsaWRhdGVfY291bnQgYWZ0ZXIgdGhlIHVuLXJlZ2lzdGVyaW5nIG9mIE1N
VSBub3RpZmllciwgdGhlCj4gPiA+ID4gaW52YWxpZGF0ZV9jb250IHdpbGwgcnVuIG91dCBvZiBz
eW5jIChlLmcgbmV2ZXIgcmVhY2ggemVybykuIFRoaXMgd2lsbAo+ID4gPiA+IGluIGZhY3QgZGlz
YWJsZSB0aGUgZmFzdCBhY2Nlc3NvciBwYXRoLiBGaXhpbmcgYnkgcmVzZXQgdGhlIGNvdW50IHRv
Cj4gPiA+ID4gemVyby4KPiA+ID4gPiAKPiA+ID4gPiBSZXBvcnRlZC1ieTogTWljaGFlbCBTLiBU
c2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiA+ID4gRGlkIE1pY2hhZWwgcmVwb3J0IHRoaXMgYXMg
d2VsbD8KPiA+IAo+ID4gCj4gPiBDb3JyZWN0IG1lIGlmIEkgd2FzIHdyb25nLiBJIHRoaW5rIGl0
J3MgcG9pbnQgNCBkZXNjcmliZWQgaW4KPiA+IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5Lzcv
MjEvMjUuCj4gCj4gSSdtIG5vdCBzdXJlIHdoYXQgdGhhdCBpcyB0YWxraW5nIGFib3V0Cj4gCj4g
QnV0IHRoaXMgZml4ZXMgd2hhdCBJIGRlc2NyaWJlZDoKPiAKPiBodHRwczovL2xrbWwub3JnL2xr
bWwvMjAxOS83LzIyLzU1NAo+IAo+IEphc29uCgpUaGVzZSBhcmUgdHdvIHJlYXNvbnMgZm9yIGEg
cG9zc2libGUgY291bnRlciBpbWJhbGFuY2UuClVuc3VycHJpc2luZ2x5IHRoZXkgYXJlIGJvdGgg
Zml4ZWQgaWYgeW91IHJlc2V0IHRoZSBjb3VudGVyIHRvIDAuCgotLSAKTVNUCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
