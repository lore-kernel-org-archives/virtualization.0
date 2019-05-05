From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH V3 0/6] vhost: accelerate metadata access
Date: Sun, 5 May 2019 17:20:31 +0800
Message-ID: <831c343f-c547-f68c-19fe-d89e8f259d87__39011.458509934$1557048094$gmane$org@redhat.com>
References: <20190423055420.26408-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190423055420.26408-1-jasowang@redhat.com>
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
To: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: aarcange@redhat.com, hch@infradead.org, christophe.de.dinechin@gmail.com, linux-parisc@vger.kernel.org, James.Bottomley@hansenpartnership.com, linux-mm@kvack.org, jglisse@redhat.com, jrdr.linux@gmail.com, davem@davemloft.net, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvNC8yMyDkuIvljYgxOjU0LCBKYXNvbiBXYW5nIHdyb3RlOgo+IFRoaXMgc2VyaWVz
IHRyaWVzIHRvIGFjY2VzcyB2aXJ0cXVldWUgbWV0YWRhdGEgdGhyb3VnaCBrZXJuZWwgdmlydHVh
bAo+IGFkZHJlc3MgaW5zdGVhZCBvZiBjb3B5X3VzZXIoKSBmcmllbmRzIHNpbmNlIHRoZXkgaGFk
IHRvbyBtdWNoCj4gb3ZlcmhlYWRzIGxpa2UgY2hlY2tzLCBzcGVjIGJhcnJpZXJzIG9yIGV2ZW4g
aGFyZHdhcmUgZmVhdHVyZQo+IHRvZ2dsaW5nLiBUaGlzIGlzIGRvbmUgdGhyb3VnaCBzZXR1cCBr
ZXJuZWwgYWRkcmVzcyB0aHJvdWdoIGRpcmVjdAo+IG1hcHBpbmcgYW5kIGNvLW9wcmVhdGUgVk0g
bWFuYWdlbWVudCB3aXRoIE1NVSBub3RpZmllcnMuCj4KPiBUZXN0IHNob3dzIGFib3V0IDIzJSBp
bXByb3ZlbWVudCBvbiBUWCBQUFMuIFRDUF9TVFJFQU0gZG9lc24ndCBzZWUKPiBvYnZpb3VzIGlt
cHJvdmVtZW50LgoKClBpbmcuIENvbW1lbnRzIGFyZSBtb3JlIHRoYW4gd2VsY29tZWQuCgpUaGFu
a3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
