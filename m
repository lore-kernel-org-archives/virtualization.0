From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v4 0/5] vsock/virtio: optimizations to increase the
	throughput
Date: Tue, 30 Jul 2019 17:38:03 +0200
Message-ID: <20190730153803.qxilmuvaylzyeqi4__1044.87315272621$1564501720$gmane$org@steredhat>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190729095743-mutt-send-email-mst@kernel.org>
	<20190730094013.ruqjllqrjmkdnh5y@steredhat>
	<fc568e3d-7af5-5895-89e8-32e35b0f9af4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <fc568e3d-7af5-5895-89e8-32e35b0f9af4@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlLCBKdWwgMzAsIDIwMTkgYXQgMDY6MDM6MjRQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDE5LzcvMzAg5LiL5Y2INTo0MCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3Rl
Ogo+ID4gT24gTW9uLCBKdWwgMjksIDIwMTkgYXQgMDk6NTk6MjNBTSAtMDQwMCwgTWljaGFlbCBT
LiBUc2lya2luIHdyb3RlOgo+ID4gPiBPbiBXZWQsIEp1bCAxNywgMjAxOSBhdCAwMTozMDoyNVBN
ICswMjAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gPiA+ID4gVGhpcyBzZXJpZXMgdHJp
ZXMgdG8gaW5jcmVhc2UgdGhlIHRocm91Z2hwdXQgb2YgdmlydGlvLXZzb2NrIHdpdGggc2xpZ2h0
Cj4gPiA+ID4gY2hhbmdlcy4KPiA+ID4gPiBXaGlsZSBJIHdhcyB0ZXN0aW5nIHRoZSB2MiBvZiB0
aGlzIHNlcmllcyBJIGRpc2NvdmVyZWQgYW4gaHVnZSB1c2Ugb2YgbWVtb3J5LAo+ID4gPiA+IHNv
IEkgYWRkZWQgcGF0Y2ggMSB0byBtaXRpZ2F0ZSB0aGlzIGlzc3VlLiBJIHB1dCBpdCBpbiB0aGlz
IHNlcmllcyBpbiBvcmRlcgo+ID4gPiA+IHRvIGJldHRlciB0cmFjayB0aGUgcGVyZm9ybWFuY2Ug
dHJlbmRzLgo+ID4gPiBTZXJpZXM6Cj4gPiA+IAo+ID4gPiBBY2tlZC1ieTogTWljaGFlbCBTLiBU
c2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiA+ID4gCj4gPiA+IENhbiB0aGlzIGdvIGludG8gbmV0
LW5leHQ/Cj4gPiA+IAo+ID4gSSB0aGluayBzby4KPiA+IE1pY2hhZWwsIFN0ZWZhbiB0aGFua3Mg
dG8gYWNrIHRoZSBzZXJpZXMhCj4gPiAKPiA+IFNob3VsZCBJIHJlc2VuZCBpdCB3aXRoIG5ldC1u
ZXh0IHRhZz8KPiA+IAo+ID4gVGhhbmtzLAo+ID4gU3RlZmFubwo+IAo+IAo+IEkgdGhpbmsgc28u
CgpPa2F5LCBJJ2xsIHJlc2VuZCBpdCEKClRoYW5rcywKU3RlZmFubwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
