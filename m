From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost: Fix vhost_copy_to_user()
Date: Wed, 11 Apr 2018 21:44:45 +0800
Message-ID: <85c033b9-b230-7ef9-744c-4e2799684609__45846.8428267681$1523454173$gmane$org@redhat.com>
References: <1523453438-4266-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1523453438-4266-1-git-send-email-eric.auger@redhat.com>
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
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com, kvmarm@lists.cs.columbia.edu
Cc: stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDTmnIgxMeaXpSAyMTozMCwgRXJpYyBBdWdlciB3cm90ZToKPiB2aG9zdF9j
b3B5X3RvX3VzZXIgaXMgdXNlZCB0byBjb3B5IHZyaW5nIHVzZWQgZWxlbWVudHMgdG8gdXNlcnNw
YWNlLgo+IFdlIHNob3VsZCB1c2UgVkhPU1RfQUREUl9VU0VEIGluc3RlYWQgb2YgVkhPU1RfQURE
Ul9ERVNDLgo+Cj4gRml4ZXM6IGY4ODk0OTEzODA1OCAoInZob3N0OiBpbnRyb2R1Y2UgTygxKSB2
cSBtZXRhZGF0YSBjYWNoZSIpCj4gU2lnbmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdl
ckByZWRoYXQuY29tPgo+Cj4gLS0tCj4KPiBUaGlzIGZpeGVzIGEgc3RhbGwgb2JzZXJ2ZWQgd2hl
biBydW5uaW5nIGFuIGFhcmNoNjQgZ3Vlc3Qgd2l0aAo+IHZpcnR1YWwgc21tdQo+IC0tLQo+ICAg
ZHJpdmVycy92aG9zdC92aG9zdC5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92aG9z
dC5jIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gaW5kZXggYmVjNzIyZS4uZjQ0YWVhZCAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3Zo
b3N0LmMKPiBAQCAtNzQ0LDcgKzc0NCw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfY29weV90b191c2Vy
KHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZxLCB2b2lkIF9fdXNlciAqdG8sCj4gICAJCXN0cnVj
dCBpb3ZfaXRlciB0Owo+ICAgCQl2b2lkIF9fdXNlciAqdWFkZHIgPSB2aG9zdF92cV9tZXRhX2Zl
dGNoKHZxLAo+ICAgCQkJCSAgICAgKHU2NCkodWludHB0cl90KXRvLCBzaXplLAo+IC0JCQkJICAg
ICBWSE9TVF9BRERSX0RFU0MpOwo+ICsJCQkJICAgICBWSE9TVF9BRERSX1VTRUQpOwo+ICAgCj4g
ICAJCWlmICh1YWRkcikKPiAgIAkJCXJldHVybiBfX2NvcHlfdG9fdXNlcih1YWRkciwgZnJvbSwg
c2l6ZSk7CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5r
cyEKClN0YWJsZSBtYXRlcmlhbCBJIHRoaW5rLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
