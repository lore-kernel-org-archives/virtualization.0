From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] Revert "vhost: cache used event for better
	performance"
Date: Wed, 26 Jul 2017 18:21:56 +0300
Message-ID: <20170726162557-mutt-send-email-mst__31707.4133934968$1501082705$gmane$org@kernel.org>
References: <1501056197-3368-1-git-send-email-jasowang@redhat.com>
	<20170726155435-mutt-send-email-mst@kernel.org>
	<117542fc-eef9-c043-7c9e-daafceb7db4e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <117542fc-eef9-c043-7c9e-daafceb7db4e@redhat.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

T24gV2VkLCBKdWwgMjYsIDIwMTcgYXQgMDk6MTg6MDJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiAKPiBPbiAyMDE35bm0MDfmnIgyNuaXpSAyMDo1NywgTWljaGFlbCBTLiBUc2lya2lu
IHdyb3RlOgo+ID4gT24gV2VkLCBKdWwgMjYsIDIwMTcgYXQgMDQ6MDM6MTdQTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToKPiA+ID4gVGhpcyByZXZlcnRzIGNvbW1pdCA4MDllY2I5YmNhNmE5NDI0
Y2NkMzkyZDY3ZTM2ODE2MGY4Yjc2YzkyLiBTaW5jZSBpdAo+ID4gPiB3YXMgcmVwb3J0ZWQgdG8g
YnJlYWsgdmhvc3RfbmV0LiBXZSB3YW50IHRvIGNhY2hlIHVzZWQgZXZlbnQgYW5kIHVzZQo+ID4g
PiBpdCB0byBjaGVjayBmb3Igbm90aWZpY2F0aW9uLiBXZSB0cnkgdG8gdmFsaWQgY2FjaGVkIHVz
ZWQgZXZlbnQgYnkKPiA+ID4gY2hlY2tpbmcgd2hldGhlciBvciBub3QgaXQgd2FzIGFoZWFkIG9m
IG5ldywgYnV0IHRoaXMgaXMgbm90IGNvcnJlY3QKPiA+ID4gYWxsIHRoZSB0aW1lLCBpdCBjb3Vs
ZCBiZSBzdGFsZSBhbmQgdGhlcmUncyBubyB3YXkgdG8ga25vdyBhYm91dCB0aGlzLgo+ID4gPiAK
PiA+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZzxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4g
Q291bGQgeW91IHN1cHBseSBhIGJpdCBtb3JlIGRhdGEgaGVyZSBwbGVhc2U/ICBIb3cgZG9lcyBp
dCBnZXQgc3RhbGU/Cj4gPiBXaGF0IGRvZXMgZ3Vlc3QgbmVlZCB0byBkbyB0byBtYWtlIGl0IHN0
YWxlPyAgVGhpcyB3aWxsIGJlIGhlbHBmdWwgaWYKPiA+IGFueW9uZSB3YW50cyB0byBicmluZyBp
dCBiYWNrLCBvciBpZiB3ZSB3YW50IHRvIGV4dGVuZCB0aGUgcHJvdG9jb2wuCj4gPiAKPiAKPiBU
aGUgcHJvYmxlbSB3ZSBkb24ndCBrbm93IHdoZXRoZXIgb3Igbm90IGd1ZXN0IGhhcyBwdWJsaXNo
ZWQgYSBuZXcgdXNlZAo+IGV2ZW50LiBUaGUgY2hlY2sgdnJpbmdfbmVlZF9ldmVudCh2cS0+bGFz
dF91c2VkX2V2ZW50LCBuZXcgKyB2cS0+bnVtLCBuZXcpCj4gaXMgbm90IHN1ZmZpY2llbnQgdG8g
Y2hlY2sgZm9yIHRoaXMuCj4gCj4gVGhhbmtzCgpGaWd1cmVkIGl0IG91dCBhZnRlciBhbiBvZmZs
aW5lIGRpc2N1c3Npb24uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
