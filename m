From: Nadav Amit via Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2] x86/paravirt: Drop {read,write}_cr8() hooks
Date: Mon, 15 Jul 2019 18:17:59 +0000
Message-ID: <602B4D96-E2A9-45BE-8247-4E3481ED5402__8118.54929649911$1563214693$gmane$org@vmware.com>
References: <20190715151641.29210-1-andrew.cooper3@citrix.com>
Reply-To: Nadav Amit <namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190715151641.29210-1-andrew.cooper3@citrix.com>
Content-Language: en-US
Content-ID: <FD49B339CA227D44BB5DFB367BC85236@namprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, Feng Tang <feng.tang@intel.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

PiBPbiBKdWwgMTUsIDIwMTksIGF0IDg6MTYgQU0sIEFuZHJldyBDb29wZXIgPGFuZHJldy5jb29w
ZXIzQGNpdHJpeC5jb20+IHdyb3RlOg0KPiANCj4gVGhlcmUgaXMgYSBsb3Qgb2YgaW5mcmFzdHJ1
Y3R1cmUgZm9yIGZ1bmN0aW9uYWxpdHkgd2hpY2ggaXMgdXNlZA0KPiBleGNsdXNpdmVseSBpbiBf
X3tzYXZlLHJlc3RvcmV9X3Byb2Nlc3Nvcl9zdGF0ZSgpIG9uIHRoZSBzdXNwZW5kL3Jlc3VtZQ0K
PiBwYXRoLg0KPiANCj4gY3I4IGlzIGFuIGFsaWFzIG9mIEFQSUNfVEFTS1BSSSwgYW5kIEFQSUNf
VEFTS1BSSSBpcyBzYXZlZC9yZXN0b3JlZCBieQ0KPiBsYXBpY197c3VzcGVuZCxyZXN1bWV9KCku
ICBTYXZpbmcgYW5kIHJlc3RvcmluZyBjcjggaW5kZXBlbmRlbnRseSBvZiB0aGUNCj4gcmVzdCBv
ZiB0aGUgTG9jYWwgQVBJQyBzdGF0ZSBpc24ndCBhIGNsZXZlciB0aGluZyB0byBiZSBkb2luZy4N
Cj4gDQo+IERlbGV0ZSB0aGUgc3VzcGVuZC9yZXN1bWUgY3I4IGhhbmRsaW5nLCB3aGljaCBzaHJp
bmtzIHRoZSBzaXplIG9mIHN0cnVjdA0KPiBzYXZlZF9jb250ZXh0LCBhbmQgYWxsb3dzIGZvciB0
aGUgcmVtb3ZhbCBvZiBib3RoIFBWT1BTLg0KDQpJIHRoaW5rIHJlbW92aW5nIHRoZSBpbnRlcmZh
Y2UgZm9yIENSOCB3cml0ZXMgaXMgYWxzbyBnb29kIHRvIGF2b2lkDQpwb3RlbnRpYWwgY29ycmVj
dG5lc3MgaXNzdWVzLCBhcyB0aGUgU0RNIHNheXMgKDEwLjguNi4xICJJbnRlcmFjdGlvbiBvZiBU
YXNrDQpQcmlvcml0aWVzIGJldHdlZW4gQ1I4IGFuZCBBUElD4oCdKToNCg0KIk9wZXJhdGluZyBz
b2Z0d2FyZSBzaG91bGQgaW1wbGVtZW50IGVpdGhlciBkaXJlY3QgQVBJQyBUUFIgdXBkYXRlcyBv
ciBDUjgNCnN0eWxlIFRQUiB1cGRhdGVzIGJ1dCBub3QgbWl4IHRoZW0uIFNvZnR3YXJlIGNhbiB1
c2UgYSBzZXJpYWxpemluZw0KaW5zdHJ1Y3Rpb24gKGZvciBleGFtcGxlLCBDUFVJRCkgdG8gc2Vy
aWFsaXplIHVwZGF0ZXMgYmV0d2VlbiBNT1YgQ1I4IGFuZA0Kc3RvcmVzIHRvIHRoZSBBUElDLuKA
nQ0KDQpBbmQgbmF0aXZlX3dyaXRlX2NyOCgpIGRpZCBub3QgZXZlbiBpc3N1ZSBhIHNlcmlhbGl6
aW5nIGluc3RydWN0aW9uLg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
