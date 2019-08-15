From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V5 0/9] Fixes for vhost metadata acceleration
Date: Thu, 15 Aug 2019 11:26:46 +0800
Message-ID: <74838e61-3a5e-0f51-2092-f4a16d144b45__42249.5704771549$1565839626$gmane$org@redhat.com>
References: <20190809054851.20118-1-jasowang@redhat.com>
	<20190810134948-mutt-send-email-mst@kernel.org>
	<360a3b91-1ac5-84c0-d34b-a4243fa748c4@redhat.com>
	<20190812054429-mutt-send-email-mst@kernel.org>
	<20190812130252.GE24457@ziepe.ca>
	<9a9641fe-b48f-f32a-eecc-af9c2f4fbe0e@redhat.com>
	<20190813115707.GC29508@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190813115707.GC29508@ziepe.ca>
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
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvOC8xMyDkuIvljYg3OjU3LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gT24gVHVl
LCBBdWcgMTMsIDIwMTkgYXQgMDQ6MzE6MDdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPgo+
PiBXaGF0IGtpbmQgb2YgaXNzdWVzIGRvIHlvdSBzZWU/IFNwaW5sb2NrIGlzIHRvIHN5bmNocm9u
aXplIEdVUCB3aXRoIE1NVQo+PiBub3RpZmllciBpbiB0aGlzIHNlcmllcy4KPiBBIEdVUCB0aGF0
IGNhbid0IHNsZWVwIGNhbid0IHBhZ2VmYXVsdCB3aGljaCBtYWtlcyBpdCBhIHJlYWxseSB3ZWly
ZAo+IHBhdHRlcm4KCgpNeSB1bmRlcnN0YW5kaW5nIGlzIF9fZ2V0X3VzZXJfcGFnZXNfZmFzdCgp
IGFzc3VtZXMgY2FsbGVyIGNhbiBmYWlsIG9yIApoYXZlIGZhbGxiYWNrLiBBbmQgd2UgaGF2ZSBn
cmFjZWZ1bCBmYWxsYmFjayB0byBjb3B5X3t0b3xmcm9tfV91c2VyKCkuCgoKPgo+PiBCdHcsIGJh
Y2sgdG8gdGhlIG9yaWdpbmFsIHF1ZXN0aW9uLiBNYXkgSSBrbm93IHdoeSBzeW5jaHJvbml6ZV9y
Y3UoKSBpcyBub3QKPj4gc3VpdGFibGU/IENvbnNpZGVyOgo+IFdlIGFscmVhZHkgd2VudCBvdmVy
IHRoaXMuIFlvdSdkIG5lZWQgdG8gZGV0ZXJtaW5lIGl0IGRvZXNuJ3Qgc29tZWhvdwo+IGRlYWRs
b2NrIHRoZSBtbSBvbiByZWNsYWltIHBhdGhzLiBNYXliZSBpdCBpcyBPSywgdGhlIHJjcV9ncV93
cSBpcwo+IG1hcmtlZCBXUV9NRU1fUkVDTEFJTSBhdCBsZWFzdC4uCgoKWWVzLCB3aWxsIHRha2Ug
YSBsb29rIGF0IHRoaXMuCgoKPgo+IEkgYWxzbyB0aGluayBNaWNoYWVsIHdhcyBjb25jZXJuZWQg
YWJvdXQgdGhlIGxhdGVuY3kgc3Bpa2VzIGEgbG9uZyBSQ1UKPiBkZWxheSB3b3VsZCBjYXVzZS4K
CgpJIGRvbid0IHRoaW5rIGl0J3MgYSByZWFsIHByb2JsZW0gY29uc2lkZXIgTU1VIG5vdGlmaWVy
IGNvdWxkIGJlIApwcmVlbXB0ZWQgb3IgYmxvY2tlZC4KClRoYW5rcwoKCj4KPiBKYXNvbgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
