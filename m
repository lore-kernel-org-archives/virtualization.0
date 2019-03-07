From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Thu, 7 Mar 2019 10:34:39 -0500
Message-ID: <20190307101708-mutt-send-email-mst__8708.43339232437$1551972898$gmane$org@kernel.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<1551856692-3384-6-git-send-email-jasowang@redhat.com>
	<20190306092837-mutt-send-email-mst@kernel.org>
	<15105894-4ec1-1ed0-1976-7b68ed9eeeda@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <15105894-4ec1-1ed0-1976-7b68ed9eeeda@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: aarcange@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCBNYXIgMDcsIDIwMTkgYXQgMTA6NDU6NTdBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDE5LzMvNyDkuIrljYgxMjozMSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gPiArc3RhdGljIHZvaWQgdmhvc3Rfc2V0X3ZtYXBfZGlydHkoc3RydWN0IHZob3N0X3Zt
YXAgKnVzZWQpCj4gPiA+ICt7Cj4gPiA+ICsJaW50IGk7Cj4gPiA+ICsKPiA+ID4gKwlmb3IgKGkg
PSAwOyBpIDwgdXNlZC0+bnBhZ2VzOyBpKyspCj4gPiA+ICsJCXNldF9wYWdlX2RpcnR5X2xvY2so
dXNlZC0+cGFnZXNbaV0pOwo+ID4gVGhpcyBzZWVtcyB0byByZWx5IG9uIHBhZ2UgbG9jayB0byBt
YXJrIHBhZ2UgZGlydHkuCj4gPiAKPiA+IENvdWxkIGl0IGhhcHBlbiB0aGF0IHBhZ2Ugd3JpdGVi
YWNrIHdpbGwgY2hlY2sgdGhlCj4gPiBwYWdlLCBmaW5kIGl0IGNsZWFuLCBhbmQgdGhlbiB5b3Ug
bWFyayBpdCBkaXJ0eSBhbmQgdGhlbgo+ID4gaW52YWxpZGF0ZSBjYWxsYmFjayBpcyBjYWxsZWQ/
Cj4gPiAKPiA+IAo+IAo+IFllcy4gQnV0IGRvZXMgdGhpcyBicmVhayBhbnl0aGluZz8KPiBUaGUg
cGFnZSBpcyBzdGlsbCB0aGVyZSwgd2UganVzdCByZW1vdmUgYQo+IGtlcm5lbCBtYXBwaW5nIHRv
IGl0Lgo+IAo+IFRoYW5rcwoKWWVzIGl0J3MgdGhlIHNhbWUgcHJvYmxlbSBhcyBlLmcuIFJETUE6
Cgl3ZSd2ZSBqdXN0IG1hcmtlZCB0aGUgcGFnZSBhcyBkaXJ0eSB3aXRob3V0IGhhdmluZyBidWZm
ZXJzLgoJRXZlbnR1YWxseSB3cml0ZWJhY2sgd2lsbCBmaW5kIGl0IGFuZCBmaWxlc3lzdGVtIHdp
bGwgY29tcGxhaW4uLi4KCVNvIGlmIHRoZSBwYWdlcyBhcmUgYmFja2VkIGJ5IGEgbm9uLVJBTS1i
YXNlZCBmaWxlc3lzdGVtLCBpdOKAmXMgYWxsIGp1c3QgYnJva2VuLgoKb25lIGNhbiBob3BlIHRo
YXQgUkRNQSBndXlzIHdpbGwgZml4IGl0IGluIHNvbWUgd2F5IGV2ZW50dWFsbHkuCkZvciBub3cs
IG1heWJlIGFkZCBhIGZsYWcgaW4gZS5nLiBWTUEgdGhhdCBzYXlzIHRoYXQgdGhlcmUncyBubwp3
cml0ZWJhY2sgc28gaXQncyBzYWZlIHRvIG1hcmsgcGFnZSBkaXJ0eSBhdCBhbnkgcG9pbnQ/CgoK
CgoKLS0gCk1TVApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
