From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 00/15] Packed virtqueue support for vhost
Date: Wed, 17 Jul 2019 20:27:28 +0800
Message-ID: <af066030-96f1-4a8d-4864-7b6b903477a6__47731.3384924614$1563366471$gmane$org@redhat.com>
References: <20190717105255.63488-1-jasowang@redhat.com>
	<20190717070100-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190717070100-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvNy8xNyDkuIvljYg3OjAyLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
V2VkLCBKdWwgMTcsIDIwMTkgYXQgMDY6NTI6NDBBTSAtMDQwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gSGkgYWxsOgo+Pgo+PiBUaGlzIHNlcmllcyBpbXBsZW1lbnRzIHBhY2tlZCB2aXJ0cXVldWVz
IHdoaWNoIHdlcmUgZGVzY3JpYmVkCj4+IGF0IFsxXS4gSW4gdGhpcyB2ZXJzaW9uIHdlIHRyeSB0
byBhZGRyZXNzIHRoZSBwZXJmb3JtYW5jZSByZWdyZXNzaW9uCj4+IHNhdyBieSBWMi4gVGhlIHJv
b3QgY2F1c2UgaXMgcGFja2VkIHZpcnRxdWV1ZSBuZWVkIG1vcmUgdGltZXMgb2YKPj4gdXNlcnNw
YWNlIG1lbW9yeSBhY2Nlc3NzaW5nIHdoaWNoIHR1cm5zIG91dCB0byBiZSB2ZXJ5Cj4+IGV4cGVu
c2l2ZS4gVGhhbmtzIHRvIHRoZSBoZWxwIG9mIDdmNDY2MDMyZGM5ZSAoInZob3N0OiBhY2Nlc3Mg
dnEKPj4gbWV0YWRhdGEgdGhyb3VnaCBrZXJuZWwgdmlydHVhbCBhZGRyZXNzIiksIHN1Y2ggb3Zl
cmhlYWQgY29sZCBiZQo+PiBlbGltaW5hdGVkLiBTbyBpbiB0aGlzIHZlcnNpb24sIHdlIGNhbiBz
ZWUgYWJvdXQgMiUgaW1wcm92ZW1lbnQgZm9yCj4+IHBhY2tlZCB2aXJ0cXVldWUgb24gUFBTLgo+
IEdyZWF0IGpvYiwgdGhhbmtzIQo+IFBscyBhbGxvdyBhIGJpdCBtb3JlIHJldmlldyB0aW1lIHRo
YW4gdXN1YWwgYXMgdGhpcyBpcyBhIGJpZyBwYXRjaHNldC4KPiBTaG91bGQgYmUgZG9uZSBieSBU
dWVzZGF5Lgo+IC1uZXh0IG1hdGVyaWFsIGFueXdheS4KCgpTdXJlLCBqdXN0IHRvIGNvbmZpcm0s
IEkgdGhpbmsgdGhpcyBzaG91bGQgZ28gZm9yIHlvdXIgdmhvc3QgdHJlZT8uCgpUaGFua3MKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
