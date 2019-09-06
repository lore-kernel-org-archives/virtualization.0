From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/2] Revert and rework on the metadata accelreation
Date: Fri, 6 Sep 2019 18:02:35 +0800
Message-ID: <7785d39b-b4e7-8165-516c-ee6a08ac9c4e__36226.355184202$1567764202$gmane$org@redhat.com>
References: <20190905122736.19768-1-jasowang@redhat.com>
	<20190905135907.GB6011@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905135907.GB6011@mellanox.com>
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
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "jglisse@redhat.com" <jglisse@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvOS81IOS4i+WNiDk6NTksIEphc29uIEd1bnRob3JwZSB3cm90ZToKPiBPbiBUaHUs
IFNlcCAwNSwgMjAxOSBhdCAwODoyNzozNFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBI
aToKPj4KPj4gUGVyIHJlcXVlc3QgZnJvbSBNaWNoYWVsIGFuZCBKYXNvbiwgdGhlIG1ldGFkYXRh
IGFjY2VscmVhdGlvbiBpcwo+PiByZXZlcnRlZCBpbiB0aGlzIHZlcnNpb24gYW5kIHJld29yayBp
biBuZXh0IHZlcnNpb24uCj4+Cj4+IFBsZWFzZSByZXZpZXcuCj4+Cj4+IFRoYW5rcwo+Pgo+PiBK
YXNvbiBXYW5nICgyKToKPj4gICAgUmV2ZXJ0ICJ2aG9zdDogYWNjZXNzIHZxIG1ldGFkYXRhIHRo
cm91Z2gga2VybmVsIHZpcnR1YWwgYWRkcmVzcyIKPj4gICAgdmhvc3Q6IHJlLWludHJvZHVjaW5n
IG1ldGFkYXRhIGFjY2VsZXJhdGlvbiB0aHJvdWdoIGtlcm5lbCB2aXJ0dWFsCj4+ICAgICAgYWRk
cmVzcwo+IFRoZXJlIGFyZSBhIGJ1bmNoIG9mIHBhdGNoZXMgaW4gdGhlIHF1ZXVlIGFscmVhZHkg
dGhhdCB3aWxsIGhlbHAKPiB2aG9zdCwgYW5kIEkgYSB3b3JraW5nIG9uIG9uZSBmb3IgbmV4dCBj
eWNsZSB0aGF0IHdpbGwgaGVscCBhbG90IG1vcmUKPiB0b28uCgoKSSB3aWxsIGNoZWNrIHRob3Nl
IHBhdGNoZXMsIGJ1dCBpZiB5b3UgY2FuIGdpdmUgbWUgc29tZSBwb2ludGVycyBvciAKa2V5d29y
ZHMgaXQgd291bGQgYmUgbXVjaCBhcHByZWNpYXRlZC4KCgo+Cj4gSSB0aGluayB5b3Ugc2hvdWxk
IGFwcGx5IHRoZSByZXZlcnQgdGhpcyBjeWNsZSBhbmQgcmViYXNlIHRoZSBvdGhlcgo+IHBhdGNo
IGZvciBuZXh0Li4KPgo+IEphc29uCgoKWWVzLCB0aGUgcGxhbiBpcyB0byByZXZlcnQgaW4gdGhp
cyByZWxlYXNlIGN5Y2xlLgoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
