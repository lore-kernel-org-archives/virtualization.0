From: Nadav Amit via Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] mm/balloon_compaction: suppress allocation warnings
Date: Wed, 21 Aug 2019 16:23:22 +0000
Message-ID: <5BBC6CB3-2DCD-4A95-90C9-7C23482F9B32@vmware.com>
References: <20190820091646.29642-1-namit@vmware.com>
	<ba01ec8c-19c3-847c-a315-2f70f4b1fe31@redhat.com>
Reply-To: Nadav Amit <namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <ba01ec8c-19c3-847c-a315-2f70f4b1fe31@redhat.com>
Content-Language: en-US
Content-ID: <A6726210375C704692078D756D10D1B3@namprd05.prod.outlook.com>
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

PiBPbiBBdWcgMjEsIDIwMTksIGF0IDk6MDUgQU0sIERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEBy
ZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIDIwLjA4LjE5IDExOjE2LCBOYWRhdiBBbWl0IHdy
b3RlOg0KPj4gVGhlcmUgaXMgbm8gcmVhc29uIHRvIHByaW50IHdhcm5pbmdzIHdoZW4gYmFsbG9v
biBwYWdlIGFsbG9jYXRpb24gZmFpbHMsDQo+PiBhcyB0aGV5IGFyZSBleHBlY3RlZCBhbmQgY2Fu
IGJlIGhhbmRsZWQgZ3JhY2VmdWxseS4gIFNpbmNlIFZNd2FyZQ0KPj4gYmFsbG9vbiBub3cgdXNl
cyBiYWxsb29uLWNvbXBhY3Rpb24gaW5mcmFzdHJ1Y3R1cmUsIGFuZCBzdXBwcmVzc2VkIHRoZXNl
DQo+PiB3YXJuaW5ncyBiZWZvcmUsIGl0IGlzIGFsc28gYmVuZWZpY2lhbCB0byBzdXBwcmVzcyB0
aGVzZSB3YXJuaW5ncyB0bw0KPj4ga2VlcCB0aGUgc2FtZSBiZWhhdmlvciB0aGF0IHRoZSBiYWxs
b29uIGhhZCBiZWZvcmUuDQo+IA0KPiBJIGFtIG5vdCBzdXJlIGlmIHRoYXQncyBhIGdvb2QgaWRl
YS4gVGhlIGFsbG9jYXRpb24gd2FybmluZ3MgYXJlIHVzdWFsbHkNCj4gdGhlIG9ubHkgdHJhY2Ug
b2YgInRoZSB1c2VyL2FkbWluIGRpZCBzb21ldGhpbmcgYmFkIGJlY2F1c2UgaGUvc2hlIHRyaWVk
DQo+IHRvIGluZmxhdGUgdGhlIGJhbGxvb24gdG8gYW4gdW5zYWZlIHZhbHVlIi4gQmVsaWV2ZSBt
ZSwgSSBwcm9jZXNzZWQgYQ0KPiBjb3VwbGUgb2Ygc3VjaCBidWdyZXBvcnRzIHJlbGF0ZWQgdG8g
dmlydGlvLWJhbGxvb24gYW5kIHRoZSB3YXJuaW5nIHdlcmUNCj4gdmVyeSBoZWxwZnVsIGZvciB0
aGF0Lg0KDQpPaywgc28gYSBtZXNzYWdlIGlzIG5lZWRlZCwgYnV0IGRvZXMgaXQgaGF2ZSB0byBi
ZSBhIGdlbmVyaWMgZnJpZ2h0ZW5pbmcNCndhcm5pbmc/DQoNCkhvdyBhYm91dCB1c2luZyBfX0dG
UF9OT1dBUk4sIGFuZCBpZiBhbGxvY2F0aW9uIGRvIHNvbWV0aGluZyBsaWtlOg0KDQogIHByX3dh
cm4o4oCcQmFsbG9vbiBtZW1vcnkgYWxsb2NhdGlvbiBmYWlsZWTigJ0pOw0KDQpPciBldmVuIHNv
bWV0aGluZyBtb3JlIGluZm9ybWF0aXZlPyBUaGlzIHdvdWxkIHN1cmVseSBiZSBsZXNzIGludGlt
aWRhdGluZw0KZm9yIGNvbW1vbiB1c2Vycy4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
