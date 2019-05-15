From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] vhost_net: fix possible infinite loop
Date: Wed, 15 May 2019 10:57:27 +0800
Message-ID: <4b51161e-37b1-cf76-d418-1574b8f6e73b__9846.20646793104$1557889063$gmane$org@redhat.com>
References: <1556177599-56248-1-git-send-email-jasowang@redhat.com>
	<20190425131021-mutt-send-email-mst@kernel.org>
	<f4b4ff70-d64f-c3fb-fe2e-97ef6c55bda0@redhat.com>
	<999ef863-2994-e0c0-fbb1-a6e92de3fd24@redhat.com>
	<20190512125959-mutt-send-email-mst@kernel.org>
	<a0d99d7a-2323-a6a8-262d-9fdc5d926384@redhat.com>
	<20190514173016-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190514173016-mutt-send-email-mst@kernel.org>
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
Cc: netdev@vger.kernel.org, ppandit@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvNS8xNSDkuIrljYg1OjM5LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gTGV0
IG1lIHRyeSB0byBleHBsYWluIGFnYWluLgo+IEF0IHRoZSBtb21lbnQgaG93IGRvZXMgaGFuZGxl
X3R4X2NvcHkgZXhpdD8KPiBJdCdzIGZvcig7Oykgc28geW91IGtub3cgeW91IG5lZWQgdG8gbG9v
ayBmb3IgYSBicmVhay4KPgo+IFdoZW4gcmVhZGluZyBjb2RlIHlvdSBhbHNvIG5vdGljZSB0aGVy
ZSdzIGEgZ290byBkb25lCj4gd2hpY2ggY291bGQgZXhpdCB0aGUgbG9vcC4gaWYgeW91IHNjYW4g
Zm9yd2FyZAo+IHlvdSBub3RpY2UgdGhhdCBpdCBkb2VzIG5vdC4KPiBUaGlzIGlzIGNvbmZ1c2lu
ZywgYnV0IG9oIHdlbGwuIFdvcnRoIGZpeGluZyBtYXliZSAuLi4KPgo+IE5vdyB5b3UgYWRkIHRo
ZSBuZXh0IHJvdW5kIGNoZWNrLgo+IEFuZCB0aGVyZSBpcyBhbHNvIHNwZWNpYWwgY29kZSB0aGF0
Cj4gZGV0ZWN0cyB3aGV0aGVyIHlvdSBleGl0ZWQgd2l0aCBicmVhawo+IGFuZCB3aGVuZXZlciB5
b3UgZGlkIGl0IGFjdHMgc3BlY2lhbGx5Lgo+Cj4gWWVhIGl0IHdvcmtzLiBCdXQgSSB0aGluayBp
dCdzIGNsZWFyZXIgaWYgd2UKPiBqdXN0IG1ha2UgdGhpbmdzIG9idmlvdXMuCj4gSWYgd2Ugd2Fu
dCBzb21ldGhpbmcgdG8gaGFwcGVuIG9uIGVycm9yIHRoZW4KPgo+IAlpZiAoZXJyb3IpCj4gCQlo
YW5kbGUKPiAJCWJyZWFrCj4KPiBpcyBpbWhvIGNsZWFyZXIgdGhhbgo+Cj4gCWZsYWcgPSB0cnVl
Cj4gCWlmIChlcnJvcikKPiAJCWJyZWFrCj4gCWZsYWcgPSBmYWxzZQo+Cj4KPiBpZiAoZmxhZykK
PiAJaGFuZGxlCj4KPiBpbiBwYXJ0dWN1bGFyIC0gbGVzcyBicmFuY2hlcyBvbiBkYXRhIHBhdGgu
Cj4KPiB5b3UgcG9pbnQgb3V0IGNvZGUgZHVwbGljYXRpb24gY29ycmVjdGx5LAo+IGJ1dCB3ZSBj
YW4gc29sdmUgaXQganVzdCBieSBhZGRpbmcgZnVuY3Rpb25zLgo+IGxpa2UgaSBzdWdnZXN0ZWQu
CgoKT2ssIEkgdGhpbmsgSSBnZXQgeW91LgoKV2lsbCB0cnkgaW4gbmV4dCB2ZXJzaW9uLgoKVGhh
bmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
