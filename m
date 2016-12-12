From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 08/10] vsock/virtio: mark an internal function static
Date: Mon, 12 Dec 2016 09:56:43 +0800
Message-ID: <6ca97f10-338f-ef7c-d07c-943e44ef7f23__1532.1435676471$1481507815$gmane$org@redhat.com>
References: <1481038106-24899-1-git-send-email-mst@redhat.com>
	<1481038106-24899-9-git-send-email-mst@redhat.com>
	<487d3d4a-7a53-cb45-2cfd-5eb68d9b73f0@redhat.com>
	<20161208162458-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161208162458-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE25bm0MTLmnIgwOOaXpSAyMjoyNSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IE9uIFdlZCwgRGVjIDA3LCAyMDE2IGF0IDEyOjIxOjIyUE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+Cj4+IE9uIDIwMTblubQxMuaciDA25pelIDIzOjQxLCBNaWNoYWVsIFMuIFRzaXJraW4g
d3JvdGU6Cj4+PiB2aXJ0aW9fdHJhbnNwb3J0X2FsbG9jX3BrdCBpcyBvbmx5IHVzZWQgbG9jYWxs
eSwgbWFrZSBpdCBzdGF0aWMuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBTLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT4KPj4+IC0tLQo+Pj4gICAgbmV0L3Ztd192c29jay92aXJ0aW9f
dHJhbnNwb3J0X2NvbW1vbi5jIHwgMiArLQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL25ldC92bXdfdnNvY2sv
dmlydGlvX3RyYW5zcG9ydF9jb21tb24uYyBiL25ldC92bXdfdnNvY2svdmlydGlvX3RyYW5zcG9y
dF9jb21tb24uYwo+Pj4gaW5kZXggYTUzYjNhMS4uNjEyMDM4NCAxMDA2NDQKPj4+IC0tLSBhL25l
dC92bXdfdnNvY2svdmlydGlvX3RyYW5zcG9ydF9jb21tb24uYwo+Pj4gKysrIGIvbmV0L3Ztd192
c29jay92aXJ0aW9fdHJhbnNwb3J0X2NvbW1vbi5jCj4+PiBAQCAtMzIsNyArMzIsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHZpcnRpb190cmFuc3BvcnQgKnZpcnRpb190cmFuc3BvcnRfZ2V0X29w
cyh2b2lkKQo+Pj4gICAgCXJldHVybiBjb250YWluZXJfb2YodCwgc3RydWN0IHZpcnRpb190cmFu
c3BvcnQsIHRyYW5zcG9ydCk7Cj4+PiAgICB9Cj4+PiAtc3RydWN0IHZpcnRpb192c29ja19wa3Qg
Kgo+Pj4gK3N0YXRpYyBzdHJ1Y3QgdmlydGlvX3Zzb2NrX3BrdCAqCj4+PiAgICB2aXJ0aW9fdHJh
bnNwb3J0X2FsbG9jX3BrdChzdHJ1Y3QgdmlydGlvX3Zzb2NrX3BrdF9pbmZvICppbmZvLAo+Pj4g
ICAgCQkJICAgc2l6ZV90IGxlbiwKPj4+ICAgIAkJCSAgIHUzMiBzcmNfY2lkLAo+PiBHaXQgZ3Jl
cCBzaG93cyBpdCB3YXMgdXNlZCBieSB0cmFjaW5nLgo+IFRydWUgYnV0IHRyYWNlX3ZpcnRpb190
cmFuc3BvcnRfYWxsb2NfcGt0IGlzIGFsc28gbG9jYWwgdG8KPiB2aXJ0aW9fdHJhbnNwb3J0X2Nv
bW1vbi5jCj4KCkkgc2VlLCBzbyBsZXQncyByZW1vdmUgdGhlIEVYUE9SVF9TWU1CT0xfR1BMKCkg
dG9vPwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
