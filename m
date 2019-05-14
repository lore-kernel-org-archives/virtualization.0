From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2 8/8] vsock/virtio: make the RX buffer size tunable
Date: Tue, 14 May 2019 18:10:41 +0200
Message-ID: <20190514161041.y4exigcwwys34naf__41464.1620170855$1557850260$gmane$org@steredhat>
References: <20190510125843.95587-1-sgarzare@redhat.com>
	<20190510125843.95587-9-sgarzare@redhat.com>
	<eddb5a89-ed44-3a65-0181-84f7f27dd2cb@redhat.com>
	<8e72ef5e-cf6a-a635-3f76-bdeac95761b8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8e72ef5e-cf6a-a635-3f76-bdeac95761b8@redhat.com>
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

T24gTW9uLCBNYXkgMTMsIDIwMTkgYXQgMDg6NDY6MTlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDE5LzUvMTMg5LiL5Y2INjowNSwgSmFzb24gV2FuZyB3cm90ZToKPiA+IAo+
ID4gT24gMjAxOS81LzEwIOS4i+WNiDg6NTgsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiA+
ID4gVGhlIFJYIGJ1ZmZlciBzaXplIGRldGVybWluZXMgdGhlIG1lbW9yeSBjb25zdW1wdGlvbiBv
ZiB0aGUKPiA+ID4gdnNvY2svdmlydGlvIGd1ZXN0IGRyaXZlciwgc28gd2UgbWFrZSBpdCB0dW5h
YmxlIHRocm91Z2gKPiA+ID4gYSBtb2R1bGUgcGFyYW1ldGVyLgo+ID4gPiAKPiA+ID4gVGhlIHNp
emUgYWxsb3dlZCBhcmUgYmV0d2VlbiA0IEtCIGFuZCA2NCBLQiBpbiBvcmRlciB0byBiZQo+ID4g
PiBjb21wYXRpYmxlIHdpdGggb2xkIGhvc3QgZHJpdmVycy4KPiA+ID4gCj4gPiA+IFN1Z2dlc3Rl
ZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4gPiAKPiA+
IAo+ID4gSSBkb24ndCBzZWUgbXVjaCB2YWx1ZSBvZiBkb2luZyB0aGlzIHRocm91Z2gga2VybmVs
IGNvbW1hbmQgbGluZS4gV2UKPiA+IHNob3VsZCBkZWFsIHdpdGggdGhlbSBhdXRvbWF0aWNhbGx5
IGxpa2Ugd2hhdCB2aXJ0aW8tbmV0IGRpZC4gT3IgZXZlbiBhCj4gPiBtb2R1bGUgcGFyYW1ldGVy
IGlzIGJldHRlci4KPiA+IAo+ID4gVGhhbmtzCj4gCj4gCj4gU29ycnksIEkgbWlzcmVhZCB0aGUg
cGF0Y2guIEJ1dCBldmVuIG1vZHVsZSBwYXJhbWV0ZXIgaXMgc29tZXRoaW5nIG5vdAo+IGZsZXhp
YmxlIGVub3VnaC4gV2Ugc2hvdWxkIGRlYWwgd2l0aCB0aGVtIHRyYW5zcGFyZW50bHkuCj4gCgpP
a2F5LCBJJ2xsIHRyeSB0byB1bmRlcnN0YW5kIGhvdyB3ZSBjYW4gYXV0b21hdGljYWxseSBhZGFw
dCB0aGUgUlgKYnVmZmVyIHNpemUuIFNpbmNlIHRoZSBmbG93IGlzIHN0cmVhbSBiYXNlZCwgdGhl
IHJlY2VpdmVyIGRvZXNuJ3Qga25vdyB0aGUKb3JpZ2luYWwgcGFja2V0IHNpemUuCgpNYXliZSBJ
IGNhbiByZXVzZSB0aGUgRVdNQSBhcHByb2FjaCB0byB1bmRlcnN0YW5kIGlmIHRoZSBidWZmZXJz
IGFyZQplbnRpcmVseSBmaWxsZWQgb3Igbm90LgpJbiB0aGF0IGNhc2UgSSBjYW4gaW5jcmVhc2Ug
KGUuZy4gZG91YmxlKSBvciBkZWNyZWFzZSB0aGUgc2l6ZS4KCkknbGwgdHJ5IHRvIGRvIGl0IQoK
VGhhbmtzLApTdGVmYW5vCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
