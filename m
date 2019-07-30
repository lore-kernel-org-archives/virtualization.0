From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 0/5] vsock/virtio: optimizations to increase the
	throughput
Date: Tue, 30 Jul 2019 18:03:24 +0800
Message-ID: <fc568e3d-7af5-5895-89e8-32e35b0f9af4__13870.3765160002$1564481377$gmane$org@redhat.com>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190729095743-mutt-send-email-mst@kernel.org>
	<20190730094013.ruqjllqrjmkdnh5y@steredhat>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190730094013.ruqjllqrjmkdnh5y@steredhat>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvNy8zMCDkuIvljYg1OjQwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gT24g
TW9uLCBKdWwgMjksIDIwMTkgYXQgMDk6NTk6MjNBTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2lu
IHdyb3RlOgo+PiBPbiBXZWQsIEp1bCAxNywgMjAxOSBhdCAwMTozMDoyNVBNICswMjAwLCBTdGVm
YW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4+PiBUaGlzIHNlcmllcyB0cmllcyB0byBpbmNyZWFzZSB0
aGUgdGhyb3VnaHB1dCBvZiB2aXJ0aW8tdnNvY2sgd2l0aCBzbGlnaHQKPj4+IGNoYW5nZXMuCj4+
PiBXaGlsZSBJIHdhcyB0ZXN0aW5nIHRoZSB2MiBvZiB0aGlzIHNlcmllcyBJIGRpc2NvdmVyZWQg
YW4gaHVnZSB1c2Ugb2YgbWVtb3J5LAo+Pj4gc28gSSBhZGRlZCBwYXRjaCAxIHRvIG1pdGlnYXRl
IHRoaXMgaXNzdWUuIEkgcHV0IGl0IGluIHRoaXMgc2VyaWVzIGluIG9yZGVyCj4+PiB0byBiZXR0
ZXIgdHJhY2sgdGhlIHBlcmZvcm1hbmNlIHRyZW5kcy4KPj4gU2VyaWVzOgo+Pgo+PiBBY2tlZC1i
eTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPj4KPj4gQ2FuIHRoaXMgZ28g
aW50byBuZXQtbmV4dD8KPj4KPiBJIHRoaW5rIHNvLgo+IE1pY2hhZWwsIFN0ZWZhbiB0aGFua3Mg
dG8gYWNrIHRoZSBzZXJpZXMhCj4KPiBTaG91bGQgSSByZXNlbmQgaXQgd2l0aCBuZXQtbmV4dCB0
YWc/Cj4KPiBUaGFua3MsCj4gU3RlZmFubwoKCkkgdGhpbmsgc28uCgpUaGFua3MKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
