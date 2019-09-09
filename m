From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/2] Revert and rework on the metadata accelreation
Date: Mon, 9 Sep 2019 10:29:04 +0800
Message-ID: <bc1da56e-6256-51a4-57f7-9080099021fb__9463.65847937472$1567996178$gmane$org@redhat.com>
References: <20190905122736.19768-1-jasowang@redhat.com>
	<20190905135907.GB6011@mellanox.com>
	<7785d39b-b4e7-8165-516c-ee6a08ac9c4e@redhat.com>
	<20190907150330.GC2940@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190907150330.GC2940@mellanox.com>
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

Ck9uIDIwMTkvOS83IOS4i+WNiDExOjAzLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gT24gRnJp
LCBTZXAgMDYsIDIwMTkgYXQgMDY6MDI6MzVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4g
T24gMjAxOS85LzUg5LiL5Y2IOTo1OSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+Pj4gT24gVGh1
LCBTZXAgMDUsIDIwMTkgYXQgMDg6Mjc6MzRQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+
PiBIaToKPj4+Pgo+Pj4+IFBlciByZXF1ZXN0IGZyb20gTWljaGFlbCBhbmQgSmFzb24sIHRoZSBt
ZXRhZGF0YSBhY2NlbHJlYXRpb24gaXMKPj4+PiByZXZlcnRlZCBpbiB0aGlzIHZlcnNpb24gYW5k
IHJld29yayBpbiBuZXh0IHZlcnNpb24uCj4+Pj4KPj4+PiBQbGVhc2UgcmV2aWV3Lgo+Pj4+Cj4+
Pj4gVGhhbmtzCj4+Pj4KPj4+PiBKYXNvbiBXYW5nICgyKToKPj4+PiAgICAgUmV2ZXJ0ICJ2aG9z
dDogYWNjZXNzIHZxIG1ldGFkYXRhIHRocm91Z2gga2VybmVsIHZpcnR1YWwgYWRkcmVzcyIKPj4+
PiAgICAgdmhvc3Q6IHJlLWludHJvZHVjaW5nIG1ldGFkYXRhIGFjY2VsZXJhdGlvbiB0aHJvdWdo
IGtlcm5lbCB2aXJ0dWFsCj4+Pj4gICAgICAgYWRkcmVzcwo+Pj4gVGhlcmUgYXJlIGEgYnVuY2gg
b2YgcGF0Y2hlcyBpbiB0aGUgcXVldWUgYWxyZWFkeSB0aGF0IHdpbGwgaGVscAo+Pj4gdmhvc3Qs
IGFuZCBJIGEgd29ya2luZyBvbiBvbmUgZm9yIG5leHQgY3ljbGUgdGhhdCB3aWxsIGhlbHAgYWxv
dCBtb3JlCj4+PiB0b28uCj4+Cj4+IEkgd2lsbCBjaGVjayB0aG9zZSBwYXRjaGVzLCBidXQgaWYg
eW91IGNhbiBnaXZlIG1lIHNvbWUgcG9pbnRlcnMgb3Iga2V5d29yZHMKPj4gaXQgd291bGQgYmUg
bXVjaCBhcHByZWNpYXRlZC4KPiBZb3UgY2FuIGxvb2sgaGVyZToKPgo+IGh0dHBzOi8vZ2l0aHVi
LmNvbS9qZ3VudGhvcnBlL2xpbnV4L2NvbW1pdHMvbW11X25vdGlmaWVyCj4KPiBUaGUgZmlyc3Qg
cGFydHMsIHRoZSBnZXQvcHV0IGFyZSBpbiB0aGUgaG1tIHRyZWUsIGFuZCB0aGUgbGFzdCBwYXJ0
LAo+IHRoZSBpbnRlcnZhbCB0cmVlIGluIHRoZSBsYXN0IGNvbW1pdCBpcyBzdGlsbCBhIFdJUCwg
YnV0IGl0IHdvdWxkCj4gcmVtb3ZlIGFsb3Qgb2YgdGhhdCBjb2RlIGZyb20gdmhvc3QgYXMgd2Vs
bC4KPgo+IEphc29uCgoKVGhhbmtzIGEgbG90LCB3aWxsIGhhdmUgYSBsb29rIGF0IHRoZXNlIGFu
ZCBjb21lIGJhY2sgaWYgSSBtZXQgYW55IGlzc3Vlcy4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
