From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 09/10] virtio/s390: use DMA memory for ccw I/O and
	classic notifiers
Date: Thu, 9 May 2019 20:30:28 +0200
Message-ID: <20190509203028.5b75eaa2.pasic@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
	<20190426183245.37939-10-pasic@linux.ibm.com>
	<a873909a-9846-d6d3-f03e-e86d53fd9c75@linux.ibm.com>
	<db036887-c238-9795-5f47-cfeb475074e4@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <db036887-c238-9795-5f47-cfeb475074e4@linux.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCA5IE1heSAyMDE5IDE1OjMwOjA4ICswMjAwClBpZXJyZSBNb3JlbCA8cG1vcmVsQGxp
bnV4LmlibS5jb20+IHdyb3RlOgoKPiBPbiAwOC8wNS8yMDE5IDE2OjQ2LCBQaWVycmUgTW9yZWwg
d3JvdGU6Cj4gPiBPbiAyNi8wNC8yMDE5IDIwOjMyLCBIYWxpbCBQYXNpYyB3cm90ZToKPiA+PiBC
ZWZvcmUgdmlydGlvLWNjdyBjb3VsZCBnZXQgYXdheSB3aXRoIG5vdCB1c2luZyBETUEgQVBJIGZv
ciB0aGUgcGllY2VzIG9mCj4gPj4gbWVtb3J5IGl0IGRvZXMgY2N3IEkvTyB3aXRoLiBXaXRoIHBy
b3RlY3RlZCB2aXJ0dWFsaXphdGlvbiB0aGlzIGhhcyB0bwo+ID4+IGNoYW5nZSwgc2luY2UgdGhl
IGh5cGVydmlzb3IgbmVlZHMgdG8gcmVhZCBhbmQgc29tZXRpbWVzIGFsc28gd3JpdGUgdGhlc2UK
PiA+PiBwaWVjZXMgb2YgbWVtb3J5Lgo+ID4+Cj4gPj4gVGhlIGh5cGVydmlzb3IgaXMgc3VwcG9z
ZWQgdG8gcG9rZSB0aGUgY2xhc3NpYyBub3RpZmllcnMsIGlmIHRoZXNlIGFyZQo+ID4+IHVzZWQs
IG91dCBvZiBiYW5kIHdpdGggcmVnYXJkcyB0byBjY3cgSS9PLiBTbyB0aGVzZSBuZWVkIHRvIGJl
IGFsbG9jYXRlZAo+ID4+IGFzIERNQSBtZW1vcnkgKHdoaWNoIGlzIHNoYXJlZCBtZW1vcnkgZm9y
IHByb3RlY3RlZCB2aXJ0dWFsaXphdGlvbgo+ID4+IGd1ZXN0cykuCj4gPj4KPiA+PiBMZXQgdXMg
ZmFjdG9yIG91dCBldmVyeXRoaW5nIGZyb20gc3RydWN0IHZpcnRpb19jY3dfZGV2aWNlIHRoYXQg
bmVlZHMgdG8KPiA+PiBiZSBETUEgbWVtb3J5IGluIGEgc2F0ZWxsaXRlIHRoYXQgaXMgYWxsb2Nh
dGVkIGFzIHN1Y2guCj4gPj4KPiAuLi4KPiA+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9mKGluZGljYXRvcnModmNkZXYpKSk7Cj4gPiAKPiA+IHNo
b3VsZCBiZSBzaXplb2YobG9uZykgPwoKSWYgc29tZXRoaW5nIGRpZmZlcmVudCB0aGVuIHNpemVv
Zih1NjQpIElNSE8uCj4gPiAKPiA+IFRoaXMgaXMgYSByZWN1cnJlbnQgZXJyb3IsIGJ1dCBpdCBp
cyBub3QgYW4gaXNzdWUgYmVjYXVzZSB0aGUgc2l6ZSBvZgo+ID4gdGhlIGluZGljYXRvcnMgaXMg
dW5zaWduZWQgbG9uZyBhcyB0aGUgc2l6ZSBvZiB0aGUgcG9pbnRlci4KCkkgZG9uJ3QgdGhpbmsg
dGhlcmUgaXMgYW4gZXJyb3IsIGxldCBhbG9uZSBhIHJlY3VycmVudCBvbmUuCgo+ID4gCj4gPiBS
ZWdhcmRzLAo+ID4gUGllcnJlCj4gPiAKPiAKPiBIZXJlIHRvbywgd2l0aCB0aGUgcHJvYmxlbSBv
ZiB0aGUgaW5kaWNhdG9yIHNpemUgaGFuZGxlZDoKCkkndmUgbGFpZCBvdXQgbXkgdmlldyBpbiBh
IHJlc3BvbnNlIHRvIHlvdXIgY29tbWVudCBvbiBwYXRjaCAjOC4KCj4gUmV2aWV3ZWQtYnk6IFBp
ZXJyZSBNb3JlbDxwbW9yZWxAbGludXguaWJtLmNvbT4KClRoYW5rcyEKSGFsaWwKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
