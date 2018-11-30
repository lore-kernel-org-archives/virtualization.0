From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] Discuss about an new idea "Vsock over Virtio-net"
Date: Fri, 30 Nov 2018 08:34:54 -0500
Message-ID: <20181130083310-mutt-send-email-mst__3041.12083181298$1543584789$gmane$org@kernel.org>
References: <5BECEE53.7090408@huawei.com>
	<20181115015547-mutt-send-email-mst@kernel.org>
	<61d57505-7ff6-23c6-d26c-6a0062e08445@redhat.com>
	<20181129085049-mutt-send-email-mst@kernel.org>
	<7e78fc3d-0d5a-090f-476d-03ad490ff8a2@redhat.com>
	<20181130075134-mutt-send-email-mst@kernel.org>
	<55352308-9ceb-413e-44f6-e3dfd8f642cc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <55352308-9ceb-413e-44f6-e3dfd8f642cc@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCBOb3YgMzAsIDIwMTggYXQgMDg6NTU6MTdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDE4LzExLzMwIOS4i+WNiDg6NTIsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPiA+ID4gPiAgICBJZiB5b3Ugd2FudCB0byBjb21wYXJlIGl0IHdpdGgKPiA+ID4gPiBzb21l
dGhpbmcgdGhhdCB3b3VsZCBiZSBUQ1Agb3IgUVVJQy4gIFRoZSBmdW5kYW1lbnRhbCBkaWZmZXJl
bmNlIGJldHdlZW4KPiA+ID4gPiB2aXJ0aW8tdnNvY2sgYW5kIGUuZy4gVENQIGlzIHRoYXQgVENQ
IG9wZXJhdGVzIGluIGEgcGFja2V0IGxvc3MgZW52aXJvbm1lbnQuCj4gPiA+ID4gU28gdGhleSBh
cmUgdXNpbmcgdGltZXJzIGZvciByZWxpYWJpbGl0eSwgYW5kIHJlY2VpdmVyIGlzIGFsd2F5cyBm
cmVlIHRvCj4gPiA+ID4gZGlzY2FyZCBhbnkgdW5hY2tlZCBkYXRhLgo+ID4gPiBWaXJ0aW8tbmV0
IGtub3dzIG5vdGhpbmcgYWJvdmUgTDIsIHNvIHRoZXkgYXJlIHRvdGFsbHkgdHJhbnNwYXJlbnQg
dG8gZGV2aWNlCj4gPiA+IGl0c2VsZi4gSSBzdGlsbCBkb24ndCBnZXQgd2h5IG5vdCB1c2luZyB2
aXJ0aW8tbmV0IGluc3RlYWQuCj4gPiA+IAo+ID4gPiAKPiA+ID4gVGhhbmtzCj4gPiBJcyB5b3Vy
IHF1ZXN0aW9uIHdoeSBpcyB2aXJ0aW8tdnNvY2sgdXNlZCBpbnN0ZWFkIG9mIFRDUCBvbiB0b3Ag
b2YgSVAKPiA+IG9uIHRvcCBvZiB2aXJ0aW8tbmV0Pwo+ID4gCj4gPiAKPiAKPiBObywgbXkgcXVl
c3Rpb24gaXMgd2h5IG5vdCBkbyB2c29jayB0aHJvdWdoIHZpcnRpby1uZXQuCj4gCj4gVGhhbmtz
CgpCZWNhdXNlIGFwcHMgbmVlZCByZWxpYWJpbGl0eSwgbXVsdGlwbGV4aW5nIGFuZCBmbG93IGNv
bnRyb2wgYW5kCnZpcnRpby1uZXQgZG9lcyBub3QgcHJvdmlkZSBpdC4KCi0tIApNU1QKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
