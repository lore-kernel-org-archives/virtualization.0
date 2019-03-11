From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
	vmap()
Date: Mon, 11 Mar 2019 09:59:28 -0400
Message-ID: <20190311095405-mutt-send-email-mst__31513.3064448432$1552312788$gmane$org@kernel.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<20190308141220.GA21082@infradead.org>
	<56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
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
Cc: aarcange@redhat.com, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

T24gTW9uLCBNYXIgMTEsIDIwMTkgYXQgMDM6MTM6MTdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDE5LzMvOCDkuIvljYgxMDoxMiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6
Cj4gPiBPbiBXZWQsIE1hciAwNiwgMjAxOSBhdCAwMjoxODowN0FNIC0wNTAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiBUaGlzIHNlcmllcyB0cmllcyB0byBhY2Nlc3MgdmlydHF1ZXVlIG1ldGFk
YXRhIHRocm91Z2gga2VybmVsIHZpcnR1YWwKPiA+ID4gYWRkcmVzcyBpbnN0ZWFkIG9mIGNvcHlf
dXNlcigpIGZyaWVuZHMgc2luY2UgdGhleSBoYWQgdG9vIG11Y2gKPiA+ID4gb3ZlcmhlYWRzIGxp
a2UgY2hlY2tzLCBzcGVjIGJhcnJpZXJzIG9yIGV2ZW4gaGFyZHdhcmUgZmVhdHVyZQo+ID4gPiB0
b2dnbGluZy4gVGhpcyBpcyBkb25lIHRocm91Z2ggc2V0dXAga2VybmVsIGFkZHJlc3MgdGhyb3Vn
aCB2bWFwKCkgYW5kCj4gPiA+IHJlc2lndGVyIE1NVSBub3RpZmllciBmb3IgaW52YWxpZGF0aW9u
Lgo+ID4gPiAKPiA+ID4gVGVzdCBzaG93cyBhYm91dCAyNCUgaW1wcm92ZW1lbnQgb24gVFggUFBT
LiBUQ1BfU1RSRUFNIGRvZXNuJ3Qgc2VlCj4gPiA+IG9idmlvdXMgaW1wcm92ZW1lbnQuCj4gPiBI
b3cgaXMgdGhpcyBnb2luZyB0byB3b3JrIGZvciBDUFVzIHdpdGggdmlydHVhbGx5IHRhZ2dlZCBj
YWNoZXM/Cj4gCj4gCj4gQW55dGhpbmcgZGlmZmVyZW50IHRoYXQgeW91IHdvcnJ5PwoKSWYgY2Fj
aGVzIGhhdmUgdmlydHVhbCB0YWdzIHRoZW4ga2VybmVsIGFuZCB1c2Vyc3BhY2UgdmlldyBvZiBt
ZW1vcnkKbWlnaHQgbm90IGJlIGF1dG9tYXRpY2FsbHkgaW4gc3luYyBpZiB0aGV5IGFjY2VzcyBt
ZW1vcnkKdGhyb3VnaCBkaWZmZXJlbnQgdmlydHVhbCBhZGRyZXNzZXMuIFlvdSBuZWVkIHRvIGRv
IHRoaW5ncyBsaWtlCmZsdXNoX2NhY2hlX3BhZ2UsIHByb2JhYmx5IG11bHRpcGxlIHRpbWVzLgoK
PiBJIGNhbiBoYXZlIGEgdGVzdCBidXQgZG8geW91IGtub3cgYW55Cj4gYXJjaHMgdGhhdCB1c2Ug
dmlydHVhbCB0YWcgY2FjaGU/CgpzcGFyYyBJIGJlbGlldmUuCgo+IFRoYW5rcwoKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
