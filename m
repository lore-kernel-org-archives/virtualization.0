From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V3 00/15] Packed virtqueue support for vhost
Date: Wed, 17 Jul 2019 10:28:35 -0400
Message-ID: <20190717102824-mutt-send-email-mst__11227.9901908309$1563373743$gmane$org@kernel.org>
References: <20190717105255.63488-1-jasowang@redhat.com>
	<20190717070100-mutt-send-email-mst@kernel.org>
	<af066030-96f1-4a8d-4864-7b6b903477a6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <af066030-96f1-4a8d-4864-7b6b903477a6@redhat.com>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

T24gV2VkLCBKdWwgMTcsIDIwMTkgYXQgMDg6Mjc6MjhQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDE5LzcvMTcg5LiL5Y2INzowMiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gV2VkLCBKdWwgMTcsIDIwMTkgYXQgMDY6NTI6NDBBTSAtMDQwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gSGkgYWxsOgo+ID4gPiAKPiA+ID4gVGhpcyBzZXJpZXMgaW1wbGVtZW50
cyBwYWNrZWQgdmlydHF1ZXVlcyB3aGljaCB3ZXJlIGRlc2NyaWJlZAo+ID4gPiBhdCBbMV0uIElu
IHRoaXMgdmVyc2lvbiB3ZSB0cnkgdG8gYWRkcmVzcyB0aGUgcGVyZm9ybWFuY2UgcmVncmVzc2lv
bgo+ID4gPiBzYXcgYnkgVjIuIFRoZSByb290IGNhdXNlIGlzIHBhY2tlZCB2aXJ0cXVldWUgbmVl
ZCBtb3JlIHRpbWVzIG9mCj4gPiA+IHVzZXJzcGFjZSBtZW1vcnkgYWNjZXNzc2luZyB3aGljaCB0
dXJucyBvdXQgdG8gYmUgdmVyeQo+ID4gPiBleHBlbnNpdmUuIFRoYW5rcyB0byB0aGUgaGVscCBv
ZiA3ZjQ2NjAzMmRjOWUgKCJ2aG9zdDogYWNjZXNzIHZxCj4gPiA+IG1ldGFkYXRhIHRocm91Z2gg
a2VybmVsIHZpcnR1YWwgYWRkcmVzcyIpLCBzdWNoIG92ZXJoZWFkIGNvbGQgYmUKPiA+ID4gZWxp
bWluYXRlZC4gU28gaW4gdGhpcyB2ZXJzaW9uLCB3ZSBjYW4gc2VlIGFib3V0IDIlIGltcHJvdmVt
ZW50IGZvcgo+ID4gPiBwYWNrZWQgdmlydHF1ZXVlIG9uIFBQUy4KPiA+IEdyZWF0IGpvYiwgdGhh
bmtzIQo+ID4gUGxzIGFsbG93IGEgYml0IG1vcmUgcmV2aWV3IHRpbWUgdGhhbiB1c3VhbCBhcyB0
aGlzIGlzIGEgYmlnIHBhdGNoc2V0Lgo+ID4gU2hvdWxkIGJlIGRvbmUgYnkgVHVlc2RheS4KPiA+
IC1uZXh0IG1hdGVyaWFsIGFueXdheS4KPiAKPiAKPiBTdXJlLCBqdXN0IHRvIGNvbmZpcm0sIEkg
dGhpbmsgdGhpcyBzaG91bGQgZ28gZm9yIHlvdXIgdmhvc3QgdHJlZT8uCj4gCj4gVGhhbmtzCgpJ
IHRoaW5rIHRoaXMgbWFrZXMgc2Vuc2UsIHllcy4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
