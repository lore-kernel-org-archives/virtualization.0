From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH V2] vhost: don't use kmap() to log dirty pages
Date: Mon, 13 May 2019 13:22:37 +0800
Message-ID: <e713f08b-b460-0094-fd28-f838c9efdff1@redhat.com>
References: <1557406680-4087-1-git-send-email-jasowang@redhat.com>
	<20190509090433-mutt-send-email-mst@kernel.org>
	<d6d69a36-9a3a-2a21-924e-97fdcc6e6733@redhat.com>
	<fa6444aa-9c46-22f0-204a-c7592dc5bd51@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <fa6444aa-9c46-22f0-204a-c7592dc5bd51@redhat.com>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvNS8xMCDkuIvljYgxMjo0OCwgSmFzb24gV2FuZyB3cm90ZToKPgo+IE9uIDIwMTkv
NS8xMCDkuIrljYgxMDo1OSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pgo+Pj4+IMKgIMKgwqDCoMKg
wqAgciA9IGdldF91c2VyX3BhZ2VzX2Zhc3QobG9nLCAxLCAxLCAmcGFnZSk7Cj4+PiBPSyBzbyB0
aGUgdHJpY2sgaXMgdGhhdCBwYWdlIGlzIHBpbm5lZCBzbyB5b3UgZG9uJ3QgZXhwZWN0Cj4+PiBh
cmNoX2Z1dGV4X2F0b21pY19vcF9pbnVzZXIgYmVsb3cgdG8gZmFpbC4gZ2V0X3VzZXJfcGFnZXNf
ZmFzdAo+Pj4gZ3VhcmFudGVlcyBwYWdlIGlzIG5vdCBnb2luZyBhd2F5IGJ1dCBkb2VzIGl0IGd1
YXJhbnRlZSBQVEUgd29uJ3QgYmUKPj4+IGludmFpZGF0ZWQgb3Igd3JpdGUgcHJvdGVjdGVkPwo+
Pgo+Pgo+PiBHb29kIHBvaW50LCB0aGVuIEkgdGhpbmsgd2UgcHJvYmFibHkgbmVlZCB0byBkbyBt
YW51YWwgZml4dXAgdGhyb3VnaCAKPj4gZml4dXBfdXNlcl9mYXVsdCgpIGlmIGFyY2hfZnV0ZXhf
YXRvbWljX29wX2luX3VzZXIoKSBmYWlsLiAKPgo+Cj4gVGhpcyBsb29rcyBsaWtlIGEgb3Zlcmtp
bGwsIHdlIGRvbid0IG5lZWQgdG8gYXRvbWljIGVudmlyb25tZW50IGhlcmUgCj4gYWN0dWFsbHku
IEluc3RlYWQsIGp1c3Qga2VlcCBwYWdlZmF1bHQgZW5hYmxlZCBzaG91bGQgd29yay4gU28ganVz
dCAKPiBpbnRyb2R1Y2UgYXJjaF9mdXRleF9hdG9taWNfb3BfaW51c2VyX2luYXRvbWljKCkgdmFy
aWFudCB3aXRoIAo+IHBhZ2VmYXVsdCBkaXNhYmxlZCB0aGVyZSBqdXN0IGZvciBmdXRleCBzaG91
bGQgYmUgc3VmZmljaWVudC4KPgo+IFRoYW5rcwoKCk9rLCBpbnN0ZWFkIG9mIHVzaW5nIHRyaWNr
cywgSSB0aGluayB3ZSBjYW4gZ3JhY2VmdWxseSBmYWxsYmFjayB0byBhIApnZXRfdXNlcigpL3B1
dF91c2VyKCkgcGFpciBwcm90ZWN0ZWQgYnkgYSBtdXRleC4KCkxldCBtZSBwb3N0IGEgbm9uLXJm
YyB2ZXJzaW9uIGZvciB0aGlzLgoKVGhhbmtzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
