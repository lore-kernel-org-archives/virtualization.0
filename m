From: Nadav Amit via Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] mm/balloon_compaction: suppress allocation warnings
Date: Wed, 21 Aug 2019 16:34:47 +0000
Message-ID: <FC42B62F-167F-4D7D-ADC5-926B36347E82__32611.6450525419$1566405299$gmane$org@vmware.com>
References: <20190820091646.29642-1-namit@vmware.com>
	<ba01ec8c-19c3-847c-a315-2f70f4b1fe31@redhat.com>
	<5BBC6CB3-2DCD-4A95-90C9-7C23482F9B32@vmware.com>
	<85c72875-278f-fbab-69c9-92dc1873d407@redhat.com>
Reply-To: Nadav Amit <namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <85c72875-278f-fbab-69c9-92dc1873d407@redhat.com>
Content-Language: en-US
Content-ID: <E4FB9F0E191CCC4FBEC50321374661EC@namprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hildenbrand <david@redhat.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

PiBPbiBBdWcgMjEsIDIwMTksIGF0IDk6MjkgQU0sIERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEBy
ZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIDIxLjA4LjE5IDE4OjIzLCBOYWRhdiBBbWl0IHdy
b3RlOg0KPj4+IE9uIEF1ZyAyMSwgMjAxOSwgYXQgOTowNSBBTSwgRGF2aWQgSGlsZGVuYnJhbmQg
PGRhdmlkQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIDIwLjA4LjE5IDExOjE2LCBO
YWRhdiBBbWl0IHdyb3RlOg0KPj4+PiBUaGVyZSBpcyBubyByZWFzb24gdG8gcHJpbnQgd2Fybmlu
Z3Mgd2hlbiBiYWxsb29uIHBhZ2UgYWxsb2NhdGlvbiBmYWlscywNCj4+Pj4gYXMgdGhleSBhcmUg
ZXhwZWN0ZWQgYW5kIGNhbiBiZSBoYW5kbGVkIGdyYWNlZnVsbHkuICBTaW5jZSBWTXdhcmUNCj4+
Pj4gYmFsbG9vbiBub3cgdXNlcyBiYWxsb29uLWNvbXBhY3Rpb24gaW5mcmFzdHJ1Y3R1cmUsIGFu
ZCBzdXBwcmVzc2VkIHRoZXNlDQo+Pj4+IHdhcm5pbmdzIGJlZm9yZSwgaXQgaXMgYWxzbyBiZW5l
ZmljaWFsIHRvIHN1cHByZXNzIHRoZXNlIHdhcm5pbmdzIHRvDQo+Pj4+IGtlZXAgdGhlIHNhbWUg
YmVoYXZpb3IgdGhhdCB0aGUgYmFsbG9vbiBoYWQgYmVmb3JlLg0KPj4+IA0KPj4+IEkgYW0gbm90
IHN1cmUgaWYgdGhhdCdzIGEgZ29vZCBpZGVhLiBUaGUgYWxsb2NhdGlvbiB3YXJuaW5ncyBhcmUg
dXN1YWxseQ0KPj4+IHRoZSBvbmx5IHRyYWNlIG9mICJ0aGUgdXNlci9hZG1pbiBkaWQgc29tZXRo
aW5nIGJhZCBiZWNhdXNlIGhlL3NoZSB0cmllZA0KPj4+IHRvIGluZmxhdGUgdGhlIGJhbGxvb24g
dG8gYW4gdW5zYWZlIHZhbHVlIi4gQmVsaWV2ZSBtZSwgSSBwcm9jZXNzZWQgYQ0KPj4+IGNvdXBs
ZSBvZiBzdWNoIGJ1Z3JlcG9ydHMgcmVsYXRlZCB0byB2aXJ0aW8tYmFsbG9vbiBhbmQgdGhlIHdh
cm5pbmcgd2VyZQ0KPj4+IHZlcnkgaGVscGZ1bCBmb3IgdGhhdC4NCj4+IA0KPj4gT2ssIHNvIGEg
bWVzc2FnZSBpcyBuZWVkZWQsIGJ1dCBkb2VzIGl0IGhhdmUgdG8gYmUgYSBnZW5lcmljIGZyaWdo
dGVuaW5nDQo+PiB3YXJuaW5nPw0KPj4gDQo+PiBIb3cgYWJvdXQgdXNpbmcgX19HRlBfTk9XQVJO
LCBhbmQgaWYgYWxsb2NhdGlvbiBkbyBzb21ldGhpbmcgbGlrZToNCj4+IA0KPj4gIHByX3dhcm4o
4oCcQmFsbG9vbiBtZW1vcnkgYWxsb2NhdGlvbiBmYWlsZWTigJ0pOw0KPj4gDQo+PiBPciBldmVu
IHNvbWV0aGluZyBtb3JlIGluZm9ybWF0aXZlPyBUaGlzIHdvdWxkIHN1cmVseSBiZSBsZXNzIGlu
dGltaWRhdGluZw0KPj4gZm9yIGNvbW1vbiB1c2Vycy4NCj4gDQo+IHJhdGVsaW1pdCB3b3VsZCBt
YWtlIHNlbnNlIDopDQo+IA0KPiBBbmQgeWVzLCB0aGlzIHdvdWxkIGNlcnRhaW5seSBiZSBuaWNl
ci4NCg0KVGhhbmtzLiBJIHdpbGwgcG9zdCB2MiBvZiB0aGUgcGF0Y2guDQoNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
