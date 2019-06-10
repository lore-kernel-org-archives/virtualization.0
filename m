From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 0/6] vhost: accelerate metadata access
Date: Mon, 10 Jun 2019 11:50:45 +0800
Message-ID: <c233324c-cb66-c0ab-45c4-6e6e0499bb22__37274.5960879669$1560138669$gmane$org@redhat.com>
References: <20190524081218.2502-1-jasowang@redhat.com>
	<20190605162631-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190605162631-mutt-send-email-mst@kernel.org>
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
Cc: hch@infradead.org, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, James.Bottomley@hansenpartnership.com, linux-mm@kvack.org, jglisse@redhat.com, jrdr.linux@gmail.com, davem@davemloft.net, linux-arm-kernel@lists.infradead.org, christophe.de.dinechin@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvNi82IOS4iuWNiDQ6MjcsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBG
cmksIE1heSAyNCwgMjAxOSBhdCAwNDoxMjoxMkFNIC0wNDAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiBIaToKPj4KPj4gVGhpcyBzZXJpZXMgdHJpZXMgdG8gYWNjZXNzIHZpcnRxdWV1ZSBtZXRhZGF0
YSB0aHJvdWdoIGtlcm5lbCB2aXJ0dWFsCj4+IGFkZHJlc3MgaW5zdGVhZCBvZiBjb3B5X3VzZXIo
KSBmcmllbmRzIHNpbmNlIHRoZXkgaGFkIHRvbyBtdWNoCj4+IG92ZXJoZWFkcyBsaWtlIGNoZWNr
cywgc3BlYyBiYXJyaWVycyBvciBldmVuIGhhcmR3YXJlIGZlYXR1cmUKPj4gdG9nZ2xpbmcgbGlr
ZSBTTUFQLiBUaGlzIGlzIGRvbmUgdGhyb3VnaCBzZXR1cCBrZXJuZWwgYWRkcmVzcyB0aHJvdWdo
Cj4+IGRpcmVjdCBtYXBwaW5nIGFuZCBjby1vcHJlYXRlIFZNIG1hbmFnZW1lbnQgd2l0aCBNTVUg
bm90aWZpZXJzLgo+Pgo+PiBUZXN0IHNob3dzIGFib3V0IDIzJSBpbXByb3ZlbWVudCBvbiBUWCBQ
UFMuIFRDUF9TVFJFQU0gZG9lc24ndCBzZWUKPj4gb2J2aW91cyBpbXByb3ZlbWVudC4KPj4KPj4g
VGhhbmtzCj4gVGhhbmtzIHRoaXMgaXMgcXVldWVkIGZvciBuZXh0Lgo+Cj4gRGlkIHlvdSB3YW50
IHRvIHJlYmFzZSBhbmQgcmVwb3N0IHBhY2tlZCByaW5nIHN1cHBvcnQgb24gdG9wPwo+IElJVUMg
aXQncyBvbiBwYXIgd2l0aCBzcGxpdCByaW5nIHdpdGggdGhlc2UgcGF0Y2hlcy4KPgo+CgpZZXMs
IGl0J3Mgb24gdGhlIHdheS4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
