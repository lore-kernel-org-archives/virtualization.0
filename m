From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC PATCH v6 55/92] kvm: introspection: add KVMI_CONTROL_MSR
	and KVMI_EVENT_MSR
Date: Wed, 21 Aug 2019 08:18:46 -0700
Message-ID: <20190821151846.GD29345@linux.intel.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-56-alazar@bitdefender.com>
	<20190812210501.GD1437@linux.intel.com>
	<f9e94e9649f072911cc20129c2b633747d5c1df5.camel@bitdefender.com>
	<20190819183643.GB1916@linux.intel.com>
	<6854bfcc2bff3ffdaadad8708bd186a071ad682c.camel@bitdefender.com>
	<72df8b3ea66bb5bc7bb9c17e8bf12e12320358e1.camel@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <72df8b3ea66bb5bc7bb9c17e8bf12e12320358e1.camel@bitdefender.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>
Cc: Nicusor CITU <ncitu@bitdefender.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C <yu.c.zhang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel =?iso-8859-1?Q?Laur=E9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Zhang@vger.kernel.org" <Zhang@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Patrick Colp <patrick.colp@oracle.com>, Tamas K Lengyel <tamas@tklengyel.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlLCBBdWcgMjAsIDIwMTkgYXQgMDI6NDM6MzJQTSArMDMwMCwgTWloYWkgRG9uyJt1IHdy
b3RlOgo+IE9uIFR1ZSwgMjAxOS0wOC0yMCBhdCAwODo0NCArMDAwMCwgTmljdXNvciBDSVRVIHdy
b3RlOgo+ID4gPiA+ID4gPiArc3RhdGljIHZvaWQgdm14X21zcl9pbnRlcmNlcHQoc3RydWN0IGt2
bV92Y3B1ICp2Y3B1LCB1bnNpZ25lZAo+ID4gPiA+ID4gPiBpbnQKPiA+ID4gPiA+ID4gbXNyLAo+
ID4gPiA+ID4gPiArCQkJICAgICAgYm9vbCBlbmFibGUpCj4gPiA+ID4gPiA+ICt7Cj4gPiA+ID4g
PiA+ICsJc3RydWN0IHZjcHVfdm14ICp2bXggPSB0b192bXgodmNwdSk7Cj4gPiA+ID4gPiA+ICsJ
dW5zaWduZWQgbG9uZyAqbXNyX2JpdG1hcCA9IHZteC0+dm1jczAxLm1zcl9iaXRtYXA7Cj4gPiA+
IAo+ID4gPiBJcyBLVk1JIGludGVuZGVkIHRvIHBsYXkgbmljZSB3aXRoIG5lc3RlZCB2aXJ0dWFs
aXphdGlvbj8gVW5jb25kaXRpb25hbGx5Cj4gPiA+IHVwZGF0aW5nIHZtY3MwMS5tc3JfYml0bWFw
IGlzIGNvcnJlY3QgcmVnYXJkbGVzcyBvZiB3aGV0aGVyIHRoZSB2Q1BVCj4gPiA+IGlzIGluIEwx
IG9yIEwyLCBidXQgaWYgdGhlIHZDUFUgaXMgY3VycmVudGx5IGluIEwyIHRoZW4gdGhlIGVmZmVj
dGl2ZQo+ID4gPiBiaXRtYXAsIGkuZS4gdm1jczAyLm1zcl9iaXRtYXAsIHdvbid0IGJlIHVwZGF0
ZWQgdW50aWwgdGhlIG5leHQgbmVzdGVkIFZNLQo+ID4gPiBFbnRlci4KPiA+IAo+ID4gT3VyIGlu
aXRpYWwgcHJvb2Ygb2YgY29uY2VwdCB3YXMgcnVubmluZyB3aXRoIHN1Y2Nlc3MgaW4gbmVzdGVk
Cj4gPiB2aXJ0dWFsaXphdGlvbi4gQnV0IG1vc3Qgb2Ygb3VyIHRlc3RzIHdlcmUgZG9uZSBvbiBi
YXJlLW1ldGFsLgo+ID4gV2UgZG8gaG93ZXZlciBpbnRlbmQgdG8gbWFrZSBpdCBmdWxseSBmdW5j
dGlvbmluZyBvbiBuZXN0ZWQgc3lzdGVtcwo+ID4gdG9vLgo+ID4gCj4gPiBFdmVuIHRob3VnaHQs
IGZyb20gS1ZNSSBwb2ludCBvZiB2aWV3LCB0aGUgTVNSIGludGVyY2VwdGlvbgo+ID4gY29uZmln
dXJhdGlvbiB3b3VsZCBiZSBqdXN0IGZpbmUgaWYgaXQgZ2V0cyB1cGRhdGVkIGJlZm9yZSB0aGUg
dmNwdSBpcwo+ID4gYWN0dWFsbHkgZW50ZXJpbmcgdG8gbmVzdGVkIFZNLgo+ID4gCj4gCj4gSSBi
ZWxpZXZlIFNlYW4gaXMgcmVmZXJyaW5nIGhlcmUgdG8gdGhlIGNhc2Ugd2hlcmUgdGhlIGd1ZXN0
IGJlaW5nCj4gaW50cm9zcGVjdGVkIGlzIGEgaHlwZXJ2aXNvciAoZWcuIFdpbmRvd3MgMTAgd2l0
aCBkZXZpY2UgZ3VhcmQpLgoKWWVwLgoKPiBFdmVuIHRob3VnaCB3ZSBhcmUgbG9va2luZyBhdCBo
b3cgdG8gYXBwcm9hY2ggdGhpcyBzY2VuYXJpbywgdGhlCj4gaW50cm9zcGVjdGlvbiB0b29scyB3
ZSBoYXZlIGJ1aWx0IHdpbGwgcmVmdXNlIHRvIGF0dGFjaCB0byBhCj4gaHlwZXJ2aXNvci4KCklu
IHRoYXQgY2FzZSwgaXQncyBwcm9iYWJseSBhIGdvb2QgaWRlYSB0byBtYWtlIEtWTUkgbXV0dWFs
bHkgZXhjbHVzaXZlCndpdGggbmVzdGVkIHZpcnR1YWxpemF0aW9uLiAgRG9pbmcgc28gc2hvdWxk
LCBpbiB0aGVvcnksIHNpbXBsaWZ5IHRoZQppbXBsZW1lbnRhdGlvbiBhbmQgZXhwZWRpdGUgdXBz
dHJlYW1pbmcsIGUuZy4gcmV2aWV3ZXJzIGRvbid0IGhhdmUgdG8Kbml0cGljayBlZGdlIGNhc2Vz
IHJlbGF0ZWQgdG8gbmVzdGVkIHZpcnQuICBNeSBvbmx5IGhlc2l0YXRpb24gaW4KZGlzYWJsaW5n
IEtWTUkgd2hlbiBuZXN0ZWQgdmlydCBpcyBlbmFibGVkIGlzIHRoYXQgaXQgY291bGQgbWFrZSBp
dCBtdWNoCm1vcmUgZGlmZmljdWx0IHRvIChyZSllbmFibGUgdGhlIGNvbWJpbmF0aW9uIGluIHRo
ZSBmdXR1cmUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
