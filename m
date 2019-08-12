From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC PATCH v6 00/92] VM introspection
Date: Mon, 12 Aug 2019 14:40:41 -0700
Message-ID: <20190812214041.GA4996@linux.intel.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190809160047.8319-1-alazar@bitdefender.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C <yu.c.zhang@intel.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel =?iso-8859-1?Q?Laur=E9n?= <samuel.lauren@iki.fi>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Zhang@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCBBdWcgMDksIDIwMTkgYXQgMDY6NTk6MTVQTSArMDMwMCwgQWRhbGJlcnQgTGF6xINy
IHdyb3RlOgo+ICA1NSBmaWxlcyBjaGFuZ2VkLCAxMzQ4NSBpbnNlcnRpb25zKCspLCAyMjUgZGVs
ZXRpb25zKC0pCgpUaGUgc2l6ZSBvZiB0aGlzIHNlcmllcyBpcyBvdmVyd2hlbG1pbmcsIHRvIHNh
eSB0aGUgbGVhc3QuICBUaGUgcmVtb3RlCnBhZ2VzIGNvbmNlcHQgYW5kIFNQUCBwYXRjaGVzIG9u
IHRoZWlyIG93biB3b3VsZCBiZSBoZWZ0eSBzZXJpZXMgdG8gcmV2aWV3LgoKSXQgd291bGQgYmUg
dmVyeSBoZWxwZnVsIHRvIHJldmlld2VycyB0byByZW9yZGVyIHRoZSBwYXRjaGVzIGFuZCBvbmx5
IHNlbmQKdGhlIGJpdHMgdGhhdCBhcmUgYWJzb2x1dGVseSBtYW5kYXRvcnkgZm9yIGluaXRpYWwg
c3VwcG9ydC4gIEZvciBleGFtcGxlLApBRkFJQ1QgdGhlIFNQUCBzdXBwb3J0IGFuZCByZW1vdGUg
cGFnZXMgY29uY2VwdCBhcmUgbGFyZ2VseSBwZXJmb3JtYW5jZQpyZWxhdGVkIGFuZCBub3QgZnVu
Y3Rpb25hbGx5IHJlcXVpcmVkLgoKTm90ZSwgdGhpcyB3b3VsZG4ndCBwcmV2ZW50IHlvdSBmcm9t
IGNhcnJ5aW5nIHRoZSBzZXJpZXMgaW4gaXRzIGVudGlyZXR5CmluIHlvdXIgb3duIGJyYW5jaGVz
LgoKUG9zc2libGUgcmVvcmRlcmluZzoKCiAgLSBCdWcgZml4ZXMgKGlmIGFueSBwYXRjaGVzIHF1
YWxpZnkgYXMgc3VjaCkKICAtIEVtdWxhdG9yIGNoYW5nZXMKICAtIEtWTSBwcmVwYXJhdG9yeSBw
YXRjaGVzCiAgLSBCYXNpYyBpbnN0cm9zcGVjdGlvbiBmdW5jdGlvbmFsaXR5CgotLS0tLS0+OC0t
LS0tLS0tIGN1dCB0aGUgc2VyaWVzIGhlcmUKCiAgLSBPcHRpb25hbCBpbnRyb3NwZWN0aW9uIGZ1
bmN0aW9uYWxpdHkgKGlmIHRoZXJlIGlzIGFueSkKICAtIFNQUCBhbmQgaW50cm9zcGVjdGlvbiBp
bnRlZ3JhdGlvbgogIC0gUmVtb3RlIHBhZ2VzIGFuZCBpbnRyb3NwZWN0aW9uIGludGVncmF0aW9u
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
