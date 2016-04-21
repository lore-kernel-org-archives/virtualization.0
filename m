From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v4 6/6] hwmon: use smp_call_on_cpu() for dell-smm i8k
Date: Thu, 21 Apr 2016 12:57:24 +0200
Message-ID: <20160421105724.GK29406@pali>
References: <1459833007-11618-1-git-send-email-jgross@suse.com>
	<1459833007-11618-7-git-send-email-jgross@suse.com>
	<20160405145414.GB27359@roeck-us.net> <201604052131.52765@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201604052131.52765@pali>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Juergen Gross <jgross@suse.com>, x86@kernel.org, jeremy@goop.org, jdelvare@suse.com, peterz@infradead.org, akataria@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, hpa@zytor.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlc2RheSAwNSBBcHJpbCAyMDE2IDIxOjMxOjUyIFBhbGkgUm9ow6FyIHdyb3RlOgo+IE9u
IFR1ZXNkYXkgMDUgQXByaWwgMjAxNiAxNjo1NDoxNCBHdWVudGVyIFJvZWNrIHdyb3RlOgo+ID4g
T24gVHVlLCBBcHIgMDUsIDIwMTYgYXQgMDc6MTA6MDdBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3
cm90ZToKPiA+ID4gVXNlIHRoZSBzbXBfY2FsbF9vbl9jcHUoKSBmdW5jdGlvbiB0byBjYWxsIHN5
c3RlbSBtYW5hZ2VtZW50Cj4gPiA+IG1vZGUgb24gY3B1IDAuCj4gPiA+IE1ha2UgY2FsbCBzZWN1
cmUgYnkgYWRkaW5nIGdldF9vbmxpbmVfY3B1cygpIHRvIGF2b2lkIGUuZy4gc3VzcGVuZAo+ID4g
PiByZXN1bWUgY3ljbGVzIGluIGJldHdlZW4uCj4gPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBK
dWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+Cj4gPiA+IC0tLQo+ID4gPiBWNDogYWRkIGNh
bGwgdG8gZ2V0X29ubGluZV9jcHVzKCkKPiA+IAo+ID4gUGFsaSwgYW55IGNoYW5jZSB0byB0ZXN0
IHRoaXMgPwo+IAo+IEkgY2FuIHRlc3QgaXQsIGJ1dCBqdXN0IG9uIG1hY2hpbmUgd2hlcmUgKHBy
b2JhYmx5KSBzbW0gY2FsbHMgY2FuIGJlIAo+IHNlbmQgZnJvbSBhbnkgY3B1Li4uIE5lZWQgc29t
ZSB0aW1lIGZvciB0ZXN0aW5nIGFuZCBJIGJlbGlldmUgSSBjYW4gZG8gCj4gdGhhdCBhdCB0aGUg
ZW5kIG9mIHRoZSB3ZWVrLgoKU29ycnkgSSBoYWQgYWJzb2x1dGVseSBubyBtb3JlIGZyZWUgdGlt
ZSBsYXN0IHdlZWtlbmQgOi0oIEFuZCBzYW1lCnByZWRpY3Rpb24gaXMgZm9yIHRoaXMgd2Vla2Vu
ZCBhbmQgYWxzbyBuZXh0IG9uZS4uLgoKLS0gClBhbGkgUm9ow6FyCnBhbGkucm9oYXJAZ21haWwu
Y29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
