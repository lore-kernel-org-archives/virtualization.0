From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH V2] vhost: don't use kmap() to log dirty pages
Date: Fri, 10 May 2019 12:48:12 +0800
Message-ID: <fa6444aa-9c46-22f0-204a-c7592dc5bd51@redhat.com>
References: <1557406680-4087-1-git-send-email-jasowang@redhat.com>
	<20190509090433-mutt-send-email-mst@kernel.org>
	<d6d69a36-9a3a-2a21-924e-97fdcc6e6733@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <d6d69a36-9a3a-2a21-924e-97fdcc6e6733@redhat.com>
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

Ck9uIDIwMTkvNS8xMCDkuIrljYgxMDo1OSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Cj4+PiDCoCDC
oMKgwqDCoMKgIHIgPSBnZXRfdXNlcl9wYWdlc19mYXN0KGxvZywgMSwgMSwgJnBhZ2UpOwo+PiBP
SyBzbyB0aGUgdHJpY2sgaXMgdGhhdCBwYWdlIGlzIHBpbm5lZCBzbyB5b3UgZG9uJ3QgZXhwZWN0
Cj4+IGFyY2hfZnV0ZXhfYXRvbWljX29wX2ludXNlciBiZWxvdyB0byBmYWlsLsKgIGdldF91c2Vy
X3BhZ2VzX2Zhc3QKPj4gZ3VhcmFudGVlcyBwYWdlIGlzIG5vdCBnb2luZyBhd2F5IGJ1dCBkb2Vz
IGl0IGd1YXJhbnRlZSBQVEUgd29uJ3QgYmUKPj4gaW52YWlkYXRlZCBvciB3cml0ZSBwcm90ZWN0
ZWQ/Cj4KPgo+IEdvb2QgcG9pbnQsIHRoZW4gSSB0aGluayB3ZSBwcm9iYWJseSBuZWVkIHRvIGRv
IG1hbnVhbCBmaXh1cCB0aHJvdWdoIAo+IGZpeHVwX3VzZXJfZmF1bHQoKSBpZiBhcmNoX2Z1dGV4
X2F0b21pY19vcF9pbl91c2VyKCkgZmFpbC4gCgoKVGhpcyBsb29rcyBsaWtlIGEgb3ZlcmtpbGws
IHdlIGRvbid0IG5lZWQgdG8gYXRvbWljIGVudmlyb25tZW50IGhlcmUgCmFjdHVhbGx5LiBJbnN0
ZWFkLCBqdXN0IGtlZXAgcGFnZWZhdWx0IGVuYWJsZWQgc2hvdWxkIHdvcmsuIFNvIGp1c3QgCmlu
dHJvZHVjZSBhcmNoX2Z1dGV4X2F0b21pY19vcF9pbnVzZXJfaW5hdG9taWMoKSB2YXJpYW50IHdp
dGggcGFnZWZhdWx0IApkaXNhYmxlZCB0aGVyZSBqdXN0IGZvciBmdXRleCBzaG91bGQgYmUgc3Vm
ZmljaWVudC4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
