From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v4 1/5] vsock/virtio: limit the memory used per-socket
Date: Mon, 14 Oct 2019 10:38:36 +0200
Message-ID: <20191014083836.fumqbp4sfn5usys6__35562.840143551$1571043186$gmane$org@steredhat>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190717113030.163499-2-sgarzare@redhat.com>
	<20190729095956-mutt-send-email-mst@kernel.org>
	<20190830094059.c7qo5cxrp2nkrncd@steredhat>
	<20190901024525-mutt-send-email-mst@kernel.org>
	<CAGxU2F7fA5UtkuMQbOHHy0noOGZUtpepBNKFg5afD81bynMVUQ@mail.gmail.com>
	<20191014081724.GD22963@stefanha-x1.localdomain>
	<2398c960-b6d7-8af3-fa25-d75344335db7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <2398c960-b6d7-8af3-fa25-d75344335db7@redhat.com>
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
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

T24gTW9uLCBPY3QgMTQsIDIwMTkgYXQgMDQ6MjE6MzVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiAyMDE5LzEwLzE0IOS4i+WNiDQ6MTcsIFN0ZWZhbiBIYWpub2N6aSB3cm90ZToKPiA+
IFNPX1ZNX1NPQ0tFVFNfQlVGRkVSX1NJWkUgbWlnaHQgaGF2ZSBiZWVuIHVzZWZ1bCBmb3IgVk1D
SS1zcGVjaWZpYwo+ID4gYXBwbGljYXRpb25zLCBidXQgd2Ugc2hvdWxkIHVzZSBTT19SQ1ZCVUYg
YW5kIFNPX1NOREJVRiBmb3IgcG9ydGFibGUKPiA+IGFwcGxpY2F0aW9ucyBpbiB0aGUgZnV0dXJl
LiAgVGhvc2Ugc29ja2V0IG9wdGlvbnMgYWxzbyB3b3JrIHdpdGggb3RoZXIKPiA+IGFkZHJlc3Mg
ZmFtaWxpZXMuCj4gPiAKCkkgdGhpbmsgaHlwZXJ2X3RyYW5zcG9ydCBzdGFydGVkIHRvIHVzZSBp
dCBpbiB0aGlzIHBhdGNoOgphYzM4M2Y1OGYzYzkgIGh2X3NvY2s6IHBlcmY6IEFsbG93IHRoZSBz
b2NrZXQgYnVmZmVyIHNpemUgb3B0aW9ucyB0byBpbmZsdWVuY2UKICAgICAgICAgICAgICB0aGUg
YWN0dWFsIHNvY2tldCBidWZmZXJzCgoKPiA+IEkgZ3Vlc3MgdGhlc2Ugc29ja29wdHMgYXJlIGJ5
cGFzc2VkIGJ5IEFGX1ZTT0NLIGJlY2F1c2UgaXQgZG9lc24ndCB1c2UKPiA+IHRoZSBjb21tb24g
c2tiIHF1ZXVpbmcgY29kZSBpbiBuZXQvY29yZS9zb2NrLmM6KC4gIEJ1dCBvbmUgZGF5IHdlIG1p
Z2h0Cj4gPiBtaWdyYXRlIHRvIGl0Li4uCj4gPiAKPiA+IFN0ZWZhbgo+IAo+IAo+ICsxLCB3ZSBz
aG91bGQgcmVhbGx5IGNvbnNpZGVyIHRvIHJldXNlIHRoZSBleGlzdCBzb2NrZXQgbWVjaGFuaXNt
IGluc3RlYWQgb2YKPiByZS1pbnZlbnRpbmcgd2hlZWxzLgoKKzEsIEkgdG90YWxseSBhZ3JlZS4g
SSdsbCBnbyB0aGlzIHdheS4KCkd1eXMsIHRoYW5rIHlvdSBhbGwgZm9yIHlvdXIgc3VnZ2VzdGlv
bnMhCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
