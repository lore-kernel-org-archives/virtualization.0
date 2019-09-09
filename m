From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/2] Revert and rework on the metadata accelreation
Date: Mon, 9 Sep 2019 08:15:52 -0400
Message-ID: <20190909081537-mutt-send-email-mst__49610.7422791951$1568031376$gmane$org@kernel.org>
References: <20190905122736.19768-1-jasowang@redhat.com>
	<20190905135907.GB6011@mellanox.com>
	<7785d39b-b4e7-8165-516c-ee6a08ac9c4e@redhat.com>
	<20190906.151505.1486178691190611604.davem@davemloft.net>
	<bb9ae371-58b7-b7fc-b728-b5c5f55d3a91@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <bb9ae371-58b7-b7fc-b728-b5c5f55d3a91@redhat.com>
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
Cc: aarcange@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, jglisse@redhat.com, jgg@mellanox.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

T24gTW9uLCBTZXAgMDksIDIwMTkgYXQgMDM6MTg6MDFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDE5LzkvNiDkuIvljYg5OjE1LCBEYXZpZCBNaWxsZXIgd3JvdGU6Cj4gPiBG
cm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gRGF0ZTogRnJpLCA2IFNl
cCAyMDE5IDE4OjAyOjM1ICswODAwCj4gPiAKPiA+ID4gT24gMjAxOS85LzUg5LiL5Y2IOTo1OSwg
SmFzb24gR3VudGhvcnBlIHdyb3RlOgo+ID4gPiA+IEkgdGhpbmsgeW91IHNob3VsZCBhcHBseSB0
aGUgcmV2ZXJ0IHRoaXMgY3ljbGUgYW5kIHJlYmFzZSB0aGUgb3RoZXIKPiA+ID4gPiBwYXRjaCBm
b3IgbmV4dC4uCj4gPiA+ID4gCj4gPiA+ID4gSmFzb24KPiA+ID4gWWVzLCB0aGUgcGxhbiBpcyB0
byByZXZlcnQgaW4gdGhpcyByZWxlYXNlIGN5Y2xlLgo+ID4gVGhlbiB5b3Ugc2hvdWxkIHJlc2V0
IHBhdGNoICMxIGFsbCBieSBpdHNlbGYgdGFyZ2V0dGluZyAnbmV0Jy4KPiAKPiAKPiBUaGFua3Mg
Zm9yIHRoZSByZW1pbmRpbmcuIEkgd2FudCB0aGUgcGF0Y2ggdG8gZ28gdGhyb3VnaCBNaWNoYWVs
J3Mgdmhvc3QKPiB0cmVlLCB0aGF0J3Mgd2h5IEkgZG9uJ3QgcHV0ICduZXQnIHByZWZpeC4gRm9y
IG5leHQgdGltZSwgbWF5YmUgSSBjYW4gdXNlCj4gInZob3N0IiBhcyBhIHByZWZpeCBmb3IgY2xh
c3NpZmljYXRpb24/CgpUaGF0J3MgZmluZSBieSBtZS4KCi0tIApNU1QKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
