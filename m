From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net V2 4/4] vhost: log dirty page correctly
Date: Fri, 14 Dec 2018 08:20:40 -0500
Message-ID: <20181214081821-mutt-send-email-mst__37540.8771950335$1544793554$gmane$org@kernel.org>
References: <20181212100819.21295-1-jasowang@redhat.com>
	<20181212100819.21295-5-jasowang@redhat.com>
	<20181212092435-mutt-send-email-mst@kernel.org>
	<0239c220-e7ca-c08f-be26-eb9be63fced3@redhat.com>
	<20181213092930-mutt-send-email-mst@kernel.org>
	<519ee6f7-06fc-ad49-03da-c096aeb24ced@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <519ee6f7-06fc-ad49-03da-c096aeb24ced@redhat.com>
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
Cc: Jintack Lim <jintack@cs.columbia.edu>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCBEZWMgMTQsIDIwMTggYXQgMTA6NDM6MDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDE4LzEyLzEzIOS4i+WNiDEwOjMxLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6Cj4gPiA+IEp1c3QgdG8gbWFrZSBzdXJlIEkgdW5kZXJzdGFuZCB0aGlzLiBJdCBsb29rcyB0
byBtZSB3ZSBzaG91bGQ6Cj4gPiA+IAo+ID4gPiAtIGFsbG93IHBhc3NpbmcgR0lPVkEtPkdQQSB0
aHJvdWdoIFVBUEkKPiA+ID4gCj4gPiA+IC0gY2FjaGUgR0lPVkEtPkdQQSBzb21ld2hlcmUgYnV0
IHN0aWxsIHVzZSBHSU9WQS0+SFZBIGluIGRldmljZSBJT1RMQiBmb3IKPiA+ID4gcGVyZm9ybWFu
Y2UKPiA+ID4gCj4gPiA+IElzIHRoaXMgd2hhdCB5b3Ugc3VnZ2VzdD8KPiA+ID4gCj4gPiA+IFRo
YW5rcwo+ID4gTm90IHJlYWxseS4gV2UgYWxyZWFkeSBoYXZlIEdQQS0+SFZBLCBzbyBJIHN1Z2dl
c3RlZCBhIGZsYWcgdG8gcGFzcwo+ID4gR0lPVkEtPkdQQSBpbiB0aGUgSU9UTEIuCj4gPiAKPiA+
IFRoaXMgaGFzIGFkdmFudGFnZXMgZm9yIHNlY3VyaXR5IHNpbmNlIGEgc2luZ2xlIHRhYmxlIG5l
ZWRzCj4gPiB0aGVuIHRvIGJlIHZhbGlkYXRlZCB0byBlbnN1cmUgZ3Vlc3QgZG9lcyBub3QgY29y
cnVwdAo+ID4gUUVNVSBtZW1vcnkuCj4gPiAKPiAKPiBJIHdvbmRlciBob3cgbXVjaCB3ZSBjYW4g
Z2FpbiB0aHJvdWdoIHRoaXMuIEN1cnJlbnRseSwgcWVtdSBJT01NVSBnaXZlcwo+IEdJT1ZBLT5H
UEEgbWFwcGluZywgYW5kIHFlbXUgdmhvc3QgY29kZSB3aWxsIHRyYW5zbGF0ZSBHUEEgdG8gSFZB
IHRoZW4gcGFzcwo+IEdJT1ZBLT5IVkEgdG8gdmhvc3QuIEl0IGxvb2tzIG5vIGRpZmZlcmVuY2Ug
dG8gbWUuCj4gCj4gVGhhbmtzCgpUaGUgZGlmZmVyZW5jZSBpcyBpbiBzZWN1cml0eSBub3QgaW4g
cGVyZm9ybWFuY2UuICBHZXR0aW5nIGEgYmFkIEhWQQpjb3JydXB0cyBRRU1VIG1lbW9yeSBhbmQg
aXQgbWlnaHQgYmUgZ3Vlc3QgY29udHJvbGxlZC4gVmVyeSByaXNreS4gIElmCnRyYW5zbGF0aW9u
cyB0byBIVkEgYXJlIGRvbmUgaW4gYSBzaW5nbGUgcGxhY2UgdGhyb3VnaCBhIHNpbmdsZSB0YWJs
ZQppdCdzIHNhZmVyIGFzIHRoZXJlJ3MgYSBzaW5nbGUgcmlza3kgcGxhY2UuCgotLSAKTVNUCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
