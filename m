From: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v2] x86/paravirt: Drop {read,write}_cr8() hooks
Date: Tue, 16 Jul 2019 00:30:09 +0100
Message-ID: <4a7592c8-0ee8-f394-c445-4032daf74493__15619.8775208154$1563233426$gmane$org@citrix.com>
References: <20190715151641.29210-1-andrew.cooper3@citrix.com>
	<602B4D96-E2A9-45BE-8247-4E3481ED5402@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <602B4D96-E2A9-45BE-8247-4E3481ED5402@vmware.com>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nadav Amit <namit@vmware.com>
Cc: Juergen Gross <jgross@suse.com>, Feng Tang <feng.tang@intel.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMTUvMDcvMjAxOSAxOToxNywgTmFkYXYgQW1pdCB3cm90ZToKPj4gT24gSnVsIDE1LCAyMDE5
LCBhdCA4OjE2IEFNLCBBbmRyZXcgQ29vcGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPiB3
cm90ZToKPj4KPj4gVGhlcmUgaXMgYSBsb3Qgb2YgaW5mcmFzdHJ1Y3R1cmUgZm9yIGZ1bmN0aW9u
YWxpdHkgd2hpY2ggaXMgdXNlZAo+PiBleGNsdXNpdmVseSBpbiBfX3tzYXZlLHJlc3RvcmV9X3By
b2Nlc3Nvcl9zdGF0ZSgpIG9uIHRoZSBzdXNwZW5kL3Jlc3VtZQo+PiBwYXRoLgo+Pgo+PiBjcjgg
aXMgYW4gYWxpYXMgb2YgQVBJQ19UQVNLUFJJLCBhbmQgQVBJQ19UQVNLUFJJIGlzIHNhdmVkL3Jl
c3RvcmVkIGJ5Cj4+IGxhcGljX3tzdXNwZW5kLHJlc3VtZX0oKS4gIFNhdmluZyBhbmQgcmVzdG9y
aW5nIGNyOCBpbmRlcGVuZGVudGx5IG9mIHRoZQo+PiByZXN0IG9mIHRoZSBMb2NhbCBBUElDIHN0
YXRlIGlzbid0IGEgY2xldmVyIHRoaW5nIHRvIGJlIGRvaW5nLgo+Pgo+PiBEZWxldGUgdGhlIHN1
c3BlbmQvcmVzdW1lIGNyOCBoYW5kbGluZywgd2hpY2ggc2hyaW5rcyB0aGUgc2l6ZSBvZiBzdHJ1
Y3QKPj4gc2F2ZWRfY29udGV4dCwgYW5kIGFsbG93cyBmb3IgdGhlIHJlbW92YWwgb2YgYm90aCBQ
Vk9QUy4KPiBJIHRoaW5rIHJlbW92aW5nIHRoZSBpbnRlcmZhY2UgZm9yIENSOCB3cml0ZXMgaXMg
YWxzbyBnb29kIHRvIGF2b2lkCj4gcG90ZW50aWFsIGNvcnJlY3RuZXNzIGlzc3VlcywgYXMgdGhl
IFNETSBzYXlzICgxMC44LjYuMSAiSW50ZXJhY3Rpb24gb2YgVGFzawo+IFByaW9yaXRpZXMgYmV0
d2VlbiBDUjggYW5kIEFQSUPigJ0pOgo+Cj4gIk9wZXJhdGluZyBzb2Z0d2FyZSBzaG91bGQgaW1w
bGVtZW50IGVpdGhlciBkaXJlY3QgQVBJQyBUUFIgdXBkYXRlcyBvciBDUjgKPiBzdHlsZSBUUFIg
dXBkYXRlcyBidXQgbm90IG1peCB0aGVtLiBTb2Z0d2FyZSBjYW4gdXNlIGEgc2VyaWFsaXppbmcK
PiBpbnN0cnVjdGlvbiAoZm9yIGV4YW1wbGUsIENQVUlEKSB0byBzZXJpYWxpemUgdXBkYXRlcyBi
ZXR3ZWVuIE1PViBDUjggYW5kCj4gc3RvcmVzIHRvIHRoZSBBUElDLuKAnQo+Cj4gQW5kIG5hdGl2
ZV93cml0ZV9jcjgoKSBkaWQgbm90IGV2ZW4gaXNzdWUgYSBzZXJpYWxpemluZyBpbnN0cnVjdGlv
bi4KPgoKR2l2ZW4gaXRzIGxvY2F0aW9uLCB0aGUgb25lIHdyaXRlX2NyOCgpIGlzIGJvdW5kZWQg
YnkgdHdvIHNlcmlhbGlzaW5nCm9wZXJhdGlvbnMsIHNvIGlzIHNhZmUgaW4gcHJhY3RpY2UuCgpI
b3dldmVyLCBJIGFncmVlIHdpdGggdGhlIHN0YXRlbWVudCBpbiB0aGUgbWFudWFsLsKgIEkgY291
bGQgc3VibWl0IGEgdjMKd2l0aCBhbiB1cGRhdGVkIGNvbW1pdCBtZXNzYWdlLCBvciBsZXQgaXQg
YmUgZml4ZWQgb24gY29tbWl0LsKgIFdoaWNoZXZlcgppcyBlYXNpZXN0LgoKfkFuZHJldwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
