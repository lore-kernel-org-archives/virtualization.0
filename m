From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [virtio-dev] Re: [RFC PATCH net-next v2 2/2] virtio_net: Extend
	virtio to use VF datapath when available
Date: Fri, 26 Jan 2018 21:58:29 -0800
Message-ID: <20180126215829.7b3c6bac@cakuba.netronome.com>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
	<1515736720-39368-3-git-send-email-sridhar.samudrala@intel.com>
	<CADGSJ22BsdB-hDb0xebSyWrwDuBJaFACjb26PDoqAd2Ah+tsQg@mail.gmail.com>
	<20180122233205-mutt-send-email-mst@kernel.org>
	<CADGSJ209vrdjnEAweLg84FwN3sf+1W+APmvB=NjFkMNAhsOyrg@mail.gmail.com>
	<20180124004556-mutt-send-email-mst@kernel.org>
	<CADGSJ2308J=tb1B1zrPi0bFzqYSoLfJsRZxBg6wT+wuCfRO6vw@mail.gmail.com>
	<731db0a0-85e7-a88e-6e0e-c540086347b5@intel.com>
	<CADGSJ205yeyGV2nJ9Cr=FwPypxAHb12jx3WitS6UmWSJ9VP42Q@mail.gmail.com>
	<20180127000831-mutt-send-email-mst@kernel.org>
	<20180126144704.6e1a9628@cakuba.netronome.com>
	<5fa8c6c6-4a94-91fa-fdbb-ee7b624d703f@intel.com>
	<20180126183003.591cd5c5@cakuba.netronome.com>
	<e02e21a1-ab5d-132a-fb33-5e0ba42fc9ac@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <e02e21a1-ab5d-132a-fb33-5e0ba42fc9ac@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCAyNiBKYW4gMjAxOCAyMTozMzowMSAtMDgwMCwgU2FtdWRyYWxhLCBTcmlkaGFyIHdy
b3RlOgo+ID4+IDMgbmV0ZGV2IG1vZGVsIGJyZWFrcyB0aGlzIGNvbmZpZ3VyYXRpb24gc3RhcnRp
bmcgd2l0aCB0aGUgY3JlYXRpb24KPiA+PiBhbmQgbmFtaW5nIG9mIHRoZSAyIGRldmljZXMgdG8g
dWRldiBuZWVkaW5nIHRvIGJlIGF3YXJlIG9mIG1hc3RlciBhbmQKPiA+PiBzbGF2ZSB2aXJ0aW8t
bmV0IGRldmljZXMuICAKPiA+IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGlzIGNvbW1lbnQuICBUaGVy
ZSBpcyBvbmUgdmlydGlvLW5ldCBkZXZpY2UgYW5kCj4gPiBvbmUgInZpcnRpby1ib25kIiBuZXRk
ZXYuICBBbmQgdXNlciBzcGFjZSBoYXMgdG8gYmUgYXdhcmUgb2YgdGhlIHNwZWNpYWwKPiA+IGF1
dG9tYXRpYyBhcnJhbmdlbWVudCBhbnl3YXksIGJlY2F1c2UgaXQgY2FuJ3QgdG91Y2ggdGhlIFZG
LiAgSXQKPiA+IGRvZXNuJ3QgbWFrZSBhbnkgZGlmZmVyZW5jZSB3aGV0aGVyIGl0IGlnbm9yZXMg
dGhlIFZGIG9yIFBWIGFuZCBWRi4KPiA+IEl0IHNpbXBseSBjYW4ndCB0b3VjaCB0aGUgc2xhdmVz
LCBubyBtYXR0ZXIgaG93IG1hbnkgdGhlcmUgYXJlLiAgCj4gCj4gSWYgdGhlIHVzZXJzcGFjZSBp
cyBub3QgZXhwZWN0ZWQgdG8gdG91Y2ggdGhlIHNsYXZlcywgdGhlbiB3aHkgZG8gd2UgbmVlZCB0
bwo+IHRha2UgZXh0cmEgZWZmb3J0IHRvIGV4cG9zZSBhIG5ldGRldiB0aGF0IGlzIGp1c3Qgbm90
IHJlYWxseSB1c2VmdWwuCgpZb3Ugc2FpZDoKIlt1c2VyIHNwYWNlXSBuZWVkcyB0byBiZSBhd2Fy
ZSBvZiBtYXN0ZXIgYW5kIHNsYXZlIHZpcnRpby1uZXQgZGV2aWNlcy4iCgpJJ20gc2F5aW5nOgpJ
dCBoYXMgdG8gYmUgYXdhcmUgb2YgdGhlIHNwZWNpYWwgYXJyYW5nZW1lbnQgd2hldGhlciB0aGVy
ZSBpcyBhbgpleHBsaWNpdCBib25kIG5ldGRldiBvciBub3QuCgo+ID4+IEFsc28sIGZyb20gYSB1
c2VyIGV4cGVyaWVuY2UgcG9pbnQgb2YgdmlldywgbG9hZGluZyBhIHZpcnRpby1uZXQgd2l0aAo+
ID4+IEJBQ0tVUCBmZWF0dXJlIGVuYWJsZWQgd2lsbMKgbm93IHNob3cgMiB2aXJ0aW8tbmV0IG5l
dGRldnMuICAKPiA+IE9uZSB2aXJ0aW8tbmV0IGFuZCBvbmUgdmlydGlvLWJvbmQsIHdoaWNoIHJl
cHJlc2VudHMgd2hhdCdzIGhhcHBlbmluZy4gIAo+IFRoaXMgYWdhaW4gYXNzdW1lcyB0aGF0IHdl
IHdhbnQgdG8gcmVwcmVzZW50IGEgYm9uZCBzZXR1cC4gQ2FuJ3Qgd2UgCj4gdHJlYXQgdGhpcwo+
IGFzIHZpcnRpby1uZXQgcHJvdmlkaW5nIGFuIGFsdGVybmF0ZSBsb3ctbGF0ZW5jeSBkYXRhcGF0
aCBieSB0YWtpbmcgb3ZlciAKPiBWRiBkYXRhcGF0aD8KCkJvbmQgaXMganVzdCBhIGZhbWlsaWFy
IG5hbWUsIHdlIGNhbiBjYWxsIGl0IHNvbWV0aGluZyBlbHNlIGlmIHlvdQpwcmVmZXIuICBUaGUg
cG9pbnQgaXMgdGhlcmUgYXJlIHR3byBkYXRhIHBhdGhzIHdoaWNoIGNhbiBoYXZlCmluZGVwZW5k
ZW50IGxvdy1sZXZlbCBzZXR0aW5ncyBhbmQgYSBoaWdoZXIgbGV2ZWwgZW50aXR5IHdpdGgKZ2xv
YmFsIHNldHRpbmdzIHdoaWNoIHJlcHJlc2VudHMgYW55IHBhdGggdG8gdGhlIG91dHNpZGUgd29y
bGQuCgpIaWRpbmcgbG93LWxldmVsIG5ldGRldnMgZnJvbSBhIGxheSB1c2VyIHJlcXVpcmVzIGEg
Z2VuZXJpYyBzb2x1dGlvbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
