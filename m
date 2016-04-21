From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v4 6/6] hwmon: use smp_call_on_cpu() for dell-smm i8k
Date: Thu, 21 Apr 2016 15:12:52 +0200
Message-ID: <5718D1D4.3040309@suse.com>
References: <1459833007-11618-1-git-send-email-jgross@suse.com>
	<1459833007-11618-7-git-send-email-jgross@suse.com>
	<20160405145414.GB27359@roeck-us.net> <201604052131.52765@pali>
	<20160421105724.GK29406@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160421105724.GK29406@pali>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Cc: x86@kernel.org, jeremy@goop.org, jdelvare@suse.com, peterz@infradead.org, akataria@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, hpa@zytor.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

T24gMjEvMDQvMTYgMTI6NTcsIFBhbGkgUm9ow6FyIHdyb3RlOgo+IE9uIFR1ZXNkYXkgMDUgQXBy
aWwgMjAxNiAyMTozMTo1MiBQYWxpIFJvaMOhciB3cm90ZToKPj4gT24gVHVlc2RheSAwNSBBcHJp
bCAyMDE2IDE2OjU0OjE0IEd1ZW50ZXIgUm9lY2sgd3JvdGU6Cj4+PiBPbiBUdWUsIEFwciAwNSwg
MjAxNiBhdCAwNzoxMDowN0FNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOgo+Pj4+IFVzZSB0
aGUgc21wX2NhbGxfb25fY3B1KCkgZnVuY3Rpb24gdG8gY2FsbCBzeXN0ZW0gbWFuYWdlbWVudAo+
Pj4+IG1vZGUgb24gY3B1IDAuCj4+Pj4gTWFrZSBjYWxsIHNlY3VyZSBieSBhZGRpbmcgZ2V0X29u
bGluZV9jcHVzKCkgdG8gYXZvaWQgZS5nLiBzdXNwZW5kCj4+Pj4gcmVzdW1lIGN5Y2xlcyBpbiBi
ZXR3ZWVuLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuY29tPgo+Pj4+IC0tLQo+Pj4+IFY0OiBhZGQgY2FsbCB0byBnZXRfb25saW5lX2NwdXMoKQo+
Pj4KPj4+IFBhbGksIGFueSBjaGFuY2UgdG8gdGVzdCB0aGlzID8KPj4KPj4gSSBjYW4gdGVzdCBp
dCwgYnV0IGp1c3Qgb24gbWFjaGluZSB3aGVyZSAocHJvYmFibHkpIHNtbSBjYWxscyBjYW4gYmUg
Cj4+IHNlbmQgZnJvbSBhbnkgY3B1Li4uIE5lZWQgc29tZSB0aW1lIGZvciB0ZXN0aW5nIGFuZCBJ
IGJlbGlldmUgSSBjYW4gZG8gCj4+IHRoYXQgYXQgdGhlIGVuZCBvZiB0aGUgd2Vlay4KPiAKPiBT
b3JyeSBJIGhhZCBhYnNvbHV0ZWx5IG5vIG1vcmUgZnJlZSB0aW1lIGxhc3Qgd2Vla2VuZCA6LSgg
QW5kIHNhbWUKPiBwcmVkaWN0aW9uIGlzIGZvciB0aGlzIHdlZWtlbmQgYW5kIGFsc28gbmV4dCBv
bmUuLi4KClBhbGksIEkndmUgZ290IGEgRGVsbCBsYXB0b3AgKExhdGl0dWRlIEU2NDQwKSBoZXJl
LiBXb3VsZCB0aGlzIGRldmljZSBiZQpva2F5IGZvciBhIHRlc3Q/IFdoYXQgd291bGQgeW91IGRv
IGZvciB0ZXN0aW5nPyBJbiBjYXNlIHlvdSBjYW4gZ2l2ZSBtZQpzb21lIGhpbnRzIGhvdyB0byBk
byBhIHNlbnNpYmxlIHRlc3QgSSdkIGRvIGl0LgoKSSd2ZSB2ZXJpZmllZCBieSBhZGRpbmcgYSBw
cmludGsoKSB0byBzbXBfY2FsbF9vbl9jcHUoKSB0aGF0IGF0IGxlYXN0Cm9uZSBvZiB0aGUgbW9k
aWZpZWQgZHJpdmVycyBoYXMgYmVlbiB1c2VkIGR1cmluZyBzeXN0ZW0gYm9vdC4KCgpKdWVyZ2Vu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
