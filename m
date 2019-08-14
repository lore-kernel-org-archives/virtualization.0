From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 01/92] kvm: introduce KVMI (VM introspection
	subsystem)
Date: Wed, 14 Aug 2019 12:37:50 +0200
Message-ID: <e00a35b2-74ca-41b8-77a0-2cd37f55a8b6@redhat.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-2-alazar@bitdefender.com>
	<20190812202030.GB1437@linux.intel.com>
	<5d52a5ae.1c69fb81.5c260.1573SMTPIN_ADDED_BROKEN@mx.google.com>
	<5fa6bd89-9d02-22cd-24a8-479abaa4f788@redhat.com>
	<20190813150128.GB13991@linux.intel.com>
	<5d53d8d1.1c69fb81.7d32.0bedSMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d53d8d1.1c69fb81.7d32.0bedSMTPIN_ADDED_BROKEN@mx.google.com>
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
To: =?UTF-8?Q?Adalbert_Laz=c4=83r?= <alazar@bitdefender.com>, Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C <yu.c.zhang@intel.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Samuel_Laur=c3=a9n?= <samuel.lauren@iki.fi>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Zhang@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Mircea_C=c3=aerjaliu?= <mcirjaliu@bitdefender.com>, =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMTQvMDgvMTkgMTE6NDgsIEFkYWxiZXJ0IExhesSDciB3cm90ZToKPj4gV2h5IGRvZXMgY2xv
c2luZyB0aGUgc29ja2V0IHJlcXVpcmUgZGVzdHJveWluZyB0aGUga3ZtaSBvYmplY3Q/ICBFLmcu
IGNhbgo+PiBpdCBiZSBtYXJrZWQgYXMgZGVmdW5jdCBvciB3aGF0ZXZlciBhbmQgb25seSBmdWxs
eSByZW1vdmVkIG9uIGEgc3luY2hyb25vdXMKPj4gdW5ob29rIGZyb20gdXNlcnNwYWNlPyAgUmUt
aG9va2luZyBjb3VsZCBlaXRoZXIgcmVxdWlyZSBzYWlkIHVuaG9vaywgb3IKPj4gbWF5YmUgcmV1
c2UgdGhlIGV4aXN0aW5nIGt2bWkgb2JqZWN0IHdpdGggYSBuZXcgc29ja2V0Lgo+IFdpbGwgaXQg
YmUgYmV0dGVyIHRvIGhhdmUgdGhlIGZvbGxvd2luZyBpb2N0bHM/Cj4gCj4gICAtIGhvb2sgKGFs
bG9jIGt2bWkgYW5kIGt2bWlfdmNwdSBzdHJ1Y3RzKQo+ICAgLSBub3RpZnlfaW1taW5lbnRfdW5o
b29rIChzZW5kIHRoZSBLVk1JX0VWRU5UX1VOSE9PSyBldmVudCkKPiAgIC0gdW5ob29rIChmcmVl
IGt2bWkgYW5kIGt2bWlfdmNwdSBzdHJ1Y3RzKQoKWWVhaCwgdGhhdCBpcyBuaWNlIGFsc28gYmVj
YXVzZSBpdCBsZWF2ZXMgdGhlIHRpbWVvdXQgcG9saWN5IHRvCnVzZXJzcGFjZS4gIChCVFcsIHBs
ZWFzZSBjaGFuZ2UgcmVmZXJlbmNlcyB0byBRRU1VIHRvICJ1c2Vyc3BhY2UiKS4KClBhb2xvCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
