From: Matthew Wilcox <willy@infradead.org>
Subject: Re: DANGER WILL ROBINSON, DANGER
Date: Tue, 13 Aug 2019 04:24:08 -0700
Message-ID: <20190813112408.GC5307@bombadil.infradead.org>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-72-alazar@bitdefender.com>
	<20190809162444.GP5482@bombadil.infradead.org>
	<ae0d274c-96b1-3ac9-67f2-f31fd7bbdcee@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <ae0d274c-96b1-3ac9-67f2-f31fd7bbdcee@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C <yu.c.zhang@intel.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel =?iso-8859-1?Q?Laur=E9n?= <samuel.lauren@iki.fi>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, virtualization@lists.linux-foundation.org, Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zhang@kvack.org, Mircea =?iso-8859-1?Q?C=EErjaliu?= <mcirjaliu@bitdefender.com>, Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlLCBBdWcgMTMsIDIwMTkgYXQgMTE6Mjk6MDdBTSArMDIwMCwgUGFvbG8gQm9uemluaSB3
cm90ZToKPiBPbiAwOS8wOC8xOSAxODoyNCwgTWF0dGhldyBXaWxjb3ggd3JvdGU6Cj4gPiBPbiBG
cmksIEF1ZyAwOSwgMjAxOSBhdCAwNzowMDoyNlBNICswMzAwLCBBZGFsYmVydCBMYXrEg3Igd3Jv
dGU6Cj4gPj4gKysrIGIvaW5jbHVkZS9saW51eC9wYWdlLWZsYWdzLmgKPiA+PiBAQCAtNDE3LDgg
KzQxNywxMCBAQCBQQUdFRkxBRyhJZGxlLCBpZGxlLCBQRl9BTlkpCj4gPj4gICAqLwo+ID4+ICAj
ZGVmaW5lIFBBR0VfTUFQUElOR19BTk9OCTB4MQo+ID4+ICAjZGVmaW5lIFBBR0VfTUFQUElOR19N
T1ZBQkxFCTB4Mgo+ID4+ICsjZGVmaW5lIFBBR0VfTUFQUElOR19SRU1PVEUJMHg0Cj4gPiBVaC4g
IEhvdyBkbyB5b3Uga25vdyBwYWdlLT5tYXBwaW5nIHdvdWxkIG90aGVyd2lzZSBoYXZlIGJpdCAy
IGNsZWFyPwo+ID4gV2hvJ3MgZ3VhcmFudGVlaW5nIHRoYXQ/Cj4gPiAKPiA+IFRoaXMgaXMgYW4g
YXdmdWxseSBiaWcgcGF0Y2ggdG8gdGhlIG1lbW9yeSBtYW5hZ2VtZW50IGNvZGUsIGJ1cmllZCBp
bgo+ID4gdGhlIG1pZGRsZSBvZiBhIGdpZ2FudGljIHNlcmllcyB3aGljaCBhbG1vc3QgZ3VhcmFu
dGVlcyBub2JvZHkgd291bGQKPiA+IGxvb2sgYXQgaXQuICBJIGNhbGwgc2hlbmFuaWdhbnMuCj4g
Cj4gQXJlIHlvdSBjYWxsaW5nIHNoZW5hbmlnYW5zIG9uIHRoZSBwYXRjaCBzdWJtaXR0ZXIgKHdo
aWNoIGlzIGdyYXR1aXRvdXMpCj4gb3Igb24gdGhlIEtWTSBtYWludGFpbmVycy9yZXZpZXdlcnM/
CgpPbiB0aGUgcGF0Y2ggc3VibWl0dGVyLCBvZiBjb3Vyc2UuICBIb3cgY2FuIEkgcG9zc2libHkg
YmUgY3JpdGljaXNpbmcgeW91CmZvciBzb21ldGhpbmcgeW91IGRpZG4ndCBkbz8KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
