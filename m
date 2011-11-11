From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCHv2 RFC] virtio-spec: flexible configuration layout
Date: Fri, 11 Nov 2011 13:06:57 +0000
Message-ID: <1321016817.3259.389.camel__1281.42147227681$1321323155$gmane$org@hornet.cambridge.arm.com>
References: <20111101124223.GA14060@redhat.com>
	<8739e7uy87.fsf@rustcorp.com.au> <20111102233110.GA20289@redhat.com>
	<20111108214021.GA4538@redhat.com> <20111109195901.GA28155@redhat.com>
	<1320870287.3730.6.camel@lappy> <20111109205208.GA28599@redhat.com>
	<1320872248.3730.11.camel@lappy> <87aa83qoao.fsf@rustcorp.com.au>
	<CA+1xoqeH3ErNCELD+NoJHz=eH6FtxersUffoJSj0yQx2o=4g0g@mail.gmail.com>
	<20111111125907.GB23902@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111111125907.GB23902@redhat.com>
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
Cc: Krishna Kumar <krkumar2@in.ibm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "penberg@kernel.org" <penberg@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Amit Shah <amit.shah@redhat.com>, "avi@redhat.com" <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

PiA+IEFsc28sIGFuIHVucmVsYXRlZCBxdWVzdGlvbnM6IFdpdGggUElPLCByZXF1ZXN0cyB3ZXJl
IG9yZGVyZWQsIHdoaWNoCj4gPiBtZWFucyB0aGF0IGlmIHdlIHdyb3RlIHRvIHRoZSBxdWV1ZSBz
ZWxlY3RvciBhbmQgdGhlbiByZWFkIGZyb20gYQo+ID4gcXVldWUgcmVnaXN0ZXIgd2Ugd291bGQg
cmVhZCB0aGUgY29ycmVjdCBxdWV1ZSBpbmZvLgo+ID4gSXMgdGhlIHNhbWUgdGhpbmcgYXNzdXJl
ZCB0byB1cyB3aXRoIE1NSU8/Cj4gCj4gRm9yIHJlYWwgUENJLCByZWFkcyBkbyBub3QgYnlwYXNz
IHdyaXRlcyBpbiBQQ0kuIEhvd2V2ZXIgdGhpcwo+IGlzIG9ubHkgdHJ1ZSBpZiBib3RoIGFyZSBN
TUlPIG9yIGJvdGggUElPIHJlYWRzLgo+IEkgZG9uJ3QgdGhpbmsgdGhlIG9yZGVyaW5nIG9mIE1N
SU8gdmVyc3VzIFBJTyBpcyBndWFyYW50ZWVkLgo+IAo+IE9uIEtWTSwgdGhlIGtlcm5lbCBkb2Vz
bid0IGRvIGFueXRoaW5nIHRvIGd1YXJhbnRlZSBvcmRlcmluZy4KPiBTbyB5b3UgZ2V0IHRoZSBu
YXR1cmFsIG9yZGVyaW5nIG9mIHRoZSBDUFUuCj4gCj4gPiBJZiB3ZSB3cml0ZSB0byBhIHF1ZXVl
Cj4gPiBzZWxlY3RvciBhbmQgaW1tZWRpYXRlbHkgcmVhZCBmcm9tIHF1ZXVlIGluZm8gd291bGQg
d2UgYmUgcmVhZGluZyB0aGUKPiA+IHJpZ2h0IGluZm8sIG9yIGlzIHRoZXJlIHRoZSBzbGlnaHQg
Y2hhbmNlIHRoYXQgaXQgd291bGQgZ2V0IHJlb3JkZXJlZAo+ID4gYW5kIHdlIHdvdWxkIGJlIHJl
YWRpbmcgcXVldWUgaW5mbyBmaXJzdCBhbmQgd3JpdGluZyB0byB0aGUgc2VsZWN0b3IKPiA+IGxh
dGVyPwo+IAo+IFRoZSB0aGluZyB0byByZWFsaXplIGlzIHRoYXQgd3JpdGUgdG8gcXVldWUgc2Vs
ZWN0b3Igd2l0aCBLVk0gaXMgaW4gdGhlCj4gZW5kIHBlcmZvcm1lZCBieSBob3N0LiBBbmQgcmVh
ZGluZyBxdWV1ZSBpbmZvIG1lYW5zIHRoYXQgaG9zdCB3aWxsIGJlCj4gcmVhZGluZyB0aGUgcXVl
dWUgc2VsZWN0b3IuIFNvIHRoaXMgaXMgYSB3cml0ZSBmb2xsb3dlZCBieSByZWFkCj4gZnJvbSB0
aGUgc2FtZSBhZGRyZXNzLiBBRkFJSyBubyBDUFVzIGNhbiByZW9yZGVyIHN1Y2ggYWNjZXNzZXMs
Cj4gc28geW91IGdldCB0aGUgcmlnaHQgaW5mby4KCihBcyBmYXIgYXMgSSB1bmRlcnN0YW5kIGFs
bCB0aGUgY29tcGxleGl0eSA7LSkgTWVtb3J5IG1hcHBlZCB1c2luZwppb3JlbWFwKCktbGlrZSBm
dW5jdGlvbnMgc2hvdWxkIHByZXNlcnZlIGFjY2VzcyBvcmRlci4gSW4gY2FzZSBvZiBBUk0KYXJj
aGl0ZWN0dXJlIHN1Y2ggbWVtb3J5IHJlZ2lvbiBpcyBkZWZpbmVkIChhdCB0aGUgcGFnZSB0YWJs
ZXMgbGV2ZWwpIGFzCmEgImRldmljZSBtZW1vcnkiIChjb250cmFyeSB0byAibm9ybWFsIG1lbW9y
eSIpIGFuZCB0aGUgcHJvY2Vzc29yIHdpbGwKbm90IHRyeSB0byBiZSBjbGV2ZXIgYWJvdXQgaXQu
IEkga25vdyBuZXh0LXRvLW5vdGhpbmcgYWJvdXQgeDg2LCBidXQgSQpzdXBwb3NlIHNpbWlsYXIg
aWRlYSBhcHBsaWVzLgoKQ2hlZXJzIQoKUGF3ZcWCCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
