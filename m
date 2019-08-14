From: Adalbert =?iso-8859-2?b?TGF643I=?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH v6 14/92] kvm: introspection: handle introspection
	commands before returning to guest
Date: Wed, 14 Aug 2019 12:39:31 +0300
Message-ID: <46222.6762714394$1565775558@news.gmane.org>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-15-alazar@bitdefender.com>
	<645d86f5-67f6-f5d3-3fbb-5ee9898a7ef8@redhat.com>
	<5d52c10e.1c69fb81.26904.fd34SMTPIN_ADDED_BROKEN@mx.google.com>
	<97cdf9cb-286c-2387-6cb5-003b30f74c7e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <97cdf9cb-286c-2387-6cb5-003b30f74c7e@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C Zhang <yu.c.zhang@intel.com>, Radim =?iso-8859-2?b?S3LobeH4?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel =?iso-8859-1?q?Laur=E9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Mircea =?iso-8859-1?q?C=EErjaliu?= <mcirjaliu@bitdefender.com>, Mihai =?UTF-8?b?RG9uyJt1?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlLCAxMyBBdWcgMjAxOSAxNjo0NToxMSArMDIwMCwgUGFvbG8gQm9uemluaSA8cGJvbnpp
bmlAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gMTMvMDgvMTkgMTU6NTQsIEFkYWxiZXJ0IExhesSD
ciB3cm90ZToKPiA+ICAgICBMZWF2aW5nIGt2bV92Y3B1X2Jsb2NrKCkgaW4gb3JkZXIgdG8gaGFu
ZGxlIGEgcmVxdWVzdCBzdWNoIGFzICdwYXVzZScsCj4gPiAgICAgd291bGQgY2F1c2UgdGhlIHZD
UFUgdG8gZW50ZXIgdGhlIGd1ZXN0IHdoZW4gcmVzdW1lZC4gTW9zdCBvZiB0aGUKPiA+ICAgICB0
aW1lIHRoaXMgZG9lcyBub3QgYXBwZWFyIHRvIGJlIGFuIGlzc3VlLCBidXQgZHVyaW5nIGVhcmx5
IGJvb3QgaXQKPiA+ICAgICBjYW4gaGFwcGVuIGZvciBhIG5vbi1ib290IHZDUFUgdG8gc3RhcnQg
ZXhlY3V0aW5nIGNvZGUgZnJvbSBhcmVhcyB0aGF0Cj4gPiAgICAgZmlyc3QgbmVlZGVkIHRvIGJl
IHNldCB1cCBieSB2Q1BVICMwLgo+ID4gICAgIAo+ID4gICAgIEluIGEgcGFydGljdWxhciBjYXNl
LCB2Q1BVICMxIGV4ZWN1dGVkIGNvZGUgd2hpY2ggcmVzaWRlZCBpbiBhbiBhcmVhCj4gPiAgICAg
bm90IGNvdmVyZWQgYnkgYSBtZW1zbG90LCB3aGljaCBjYXVzZWQgYW4gRVBUIHZpb2xhdGlvbiB0
aGF0IGdvdAo+ID4gICAgIHR1cm5lZCBpbiBtbXVfc2V0X3NwdGUoKSBpbnRvIGEgTU1JTyByZXF1
ZXN0IHRoYXQgcmVxdWlyZWQgZW11bGF0aW9uLgo+ID4gICAgIFVuZm9ydHVuYXRlbGx5LCB0aGUg
ZW11bGF0b3IgdHJpcHBlZCwgZXhpdGVkIHRvIHVzZXJzcGFjZSBhbmQgdGhlIFZNCj4gPiAgICAg
d2FzIGFib3J0ZWQuCj4gCj4gT2theSwgdGhpcyBtYWtlcyBzZW5zZS4gIE1heWJlIHlvdSB3YW50
IHRvIGhhbmRsZSBLVk1fUkVRX0lOVFJPU1BFQ1RJT04KPiBpbiB2Y3B1X3J1biByYXRoZXIgdGhh
biB2Y3B1X2VudGVyX2d1ZXN0Pwo+IAo+IFBhb2xvCgpSaWdodCEgV2UndmUgbWlzc2VkIHRoYXQu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
