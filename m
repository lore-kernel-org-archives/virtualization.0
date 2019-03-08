From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Fri, 8 Mar 2019 16:31:29 +0800
Message-ID: <92dfa6cc-a86c-0cef-6384-98aeb8b9e567__32332.2198282526$1552033910$gmane$org@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<1551856692-3384-6-git-send-email-jasowang@redhat.com>
	<20190306092837-mutt-send-email-mst@kernel.org>
	<15105894-4ec1-1ed0-1976-7b68ed9eeeda@redhat.com>
	<20190307101708-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190307101708-mutt-send-email-mst@kernel.org>
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
Cc: aarcange@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMy83IOS4i+WNiDExOjM0LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
VGh1LCBNYXIgMDcsIDIwMTkgYXQgMTA6NDU6NTdBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gT24gMjAxOS8zLzcg5LiK5Y2IMTI6MzEsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+
PiArc3RhdGljIHZvaWQgdmhvc3Rfc2V0X3ZtYXBfZGlydHkoc3RydWN0IHZob3N0X3ZtYXAgKnVz
ZWQpCj4+Pj4gK3sKPj4+PiArCWludCBpOwo+Pj4+ICsKPj4+PiArCWZvciAoaSA9IDA7IGkgPCB1
c2VkLT5ucGFnZXM7IGkrKykKPj4+PiArCQlzZXRfcGFnZV9kaXJ0eV9sb2NrKHVzZWQtPnBhZ2Vz
W2ldKTsKPj4+IFRoaXMgc2VlbXMgdG8gcmVseSBvbiBwYWdlIGxvY2sgdG8gbWFyayBwYWdlIGRp
cnR5Lgo+Pj4KPj4+IENvdWxkIGl0IGhhcHBlbiB0aGF0IHBhZ2Ugd3JpdGViYWNrIHdpbGwgY2hl
Y2sgdGhlCj4+PiBwYWdlLCBmaW5kIGl0IGNsZWFuLCBhbmQgdGhlbiB5b3UgbWFyayBpdCBkaXJ0
eSBhbmQgdGhlbgo+Pj4gaW52YWxpZGF0ZSBjYWxsYmFjayBpcyBjYWxsZWQ/Cj4+Pgo+Pj4KPj4g
WWVzLiBCdXQgZG9lcyB0aGlzIGJyZWFrIGFueXRoaW5nPwo+PiBUaGUgcGFnZSBpcyBzdGlsbCB0
aGVyZSwgd2UganVzdCByZW1vdmUgYQo+PiBrZXJuZWwgbWFwcGluZyB0byBpdC4KPj4KPj4gVGhh
bmtzCj4gWWVzIGl0J3MgdGhlIHNhbWUgcHJvYmxlbSBhcyBlLmcuIFJETUE6Cj4gCXdlJ3ZlIGp1
c3QgbWFya2VkIHRoZSBwYWdlIGFzIGRpcnR5IHdpdGhvdXQgaGF2aW5nIGJ1ZmZlcnMuCj4gCUV2
ZW50dWFsbHkgd3JpdGViYWNrIHdpbGwgZmluZCBpdCBhbmQgZmlsZXN5c3RlbSB3aWxsIGNvbXBs
YWluLi4uCj4gCVNvIGlmIHRoZSBwYWdlcyBhcmUgYmFja2VkIGJ5IGEgbm9uLVJBTS1iYXNlZCBm
aWxlc3lzdGVtLCBpdOKAmXMgYWxsIGp1c3QgYnJva2VuLgoKClllcywgd2UgY2FuJ3QgZGVwZW5k
IG9uIHRoZSBwYWdlcyB0aGF0IG1pZ2h0IGhhdmUgYmVlbiBpbnZhbGlkYXRlZC4gQXMgCnN1Z2dl
c3RlZCwgdGhlIG9ubHkgc3VpdGFibGUgcGxhY2UgaXMgdGhlIE1NVSBub3RpZmllciBjYWxsYmFj
a3MuCgpUaGFua3MKCgo+IG9uZSBjYW4gaG9wZSB0aGF0IFJETUEgZ3V5cyB3aWxsIGZpeCBpdCBp
biBzb21lIHdheSBldmVudHVhbGx5Lgo+IEZvciBub3csIG1heWJlIGFkZCBhIGZsYWcgaW4gZS5n
LiBWTUEgdGhhdCBzYXlzIHRoYXQgdGhlcmUncyBubwo+IHdyaXRlYmFjayBzbyBpdCdzIHNhZmUg
dG8gbWFyayBwYWdlIGRpcnR5IGF0IGFueSBwb2ludD8KPgo+Cj4KPgo+Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
