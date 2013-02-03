From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_console: Don't access uninitialized data.
Date: Mon, 04 Feb 2013 10:09:05 +1030
Message-ID: <87vca9klwm.fsf@rustcorp.com.au>
References: <1358425292-4449-1-git-send-email-sjur.brandeland@stericsson.com>
	<20130125090801.GA30483@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130125090801.GA30483@amit.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, sjur.brandeland@stericsson.com
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

QW1pdCBTaGFoIDxhbWl0LnNoYWhAcmVkaGF0LmNvbT4gd3JpdGVzOgo+IE9uIChUaHUpIDE3IEph
biAyMDEzIFsxMzoyMTozMl0sIHNqdXIuYnJhbmRlbGFuZEBzdGVyaWNzc29uLmNvbSB3cm90ZToK
Pj4gRnJvbTogU2p1ciBCcsOmbmRlbGFuZCA8c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29t
Pgo+PiAKPj4gRG9uJ3QgYWNjZXNzIHVuaW5pdGlhbGl6ZWQgd29yay1xdWV1ZSB3aGVuIHJlbW92
aW5nIGRldmljZS4KPj4gVGhlIHdvcmsgcXVldWUgaXMgaW5pdGlhbGl6ZWQgb25seSBpZiB0aGUg
ZGV2aWNlIG11bHRpLXF1ZXVlLgo+PiBTbyBkb24ndCBjYWxsIGNhbmNlbF93b3JrIHVubGVzcyB0
aGlzIGlzIGEgbXVsdGktcXVldWUgZGV2aWNlLgo+PiAKPj4gVGhpcyBmaXhlcyB0aGUgZm9sbG93
aW5nIHBhbmljOgo+Cj4gW3NuaXBdCj4KPj4gU2lnbmVkLW9mZi1ieTogU2p1ciBCcsOmbmRlbGFu
ZCA8c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tPgo+Cj4gQWNrZWQtYnk6IEFtaXQgU2hh
aCA8YW1pdC5zaGFoQHJlZGhhdC5jb20+Cj4KPj4gVGhpcyBmaXggaXMgaW50ZW5kZWQgb2YgdjMu
OC4KPgo+IFNob3VsZCBhbHNvIGJlIENDJ2VkIHRvIHN0YWJsZUAKClNvcnJ5LCBJIHdhcyBhdCBs
aW51eC5jb25mLmF1IGFsbCBsYXN0IHdlZWsuCgpJJ3ZlIGFscmVhZHkgc2VudCBpdCB0byBMaW51
cy4gIFNqdXIgc2FpZDogIlRoaXMgZml4IGlzIGludGVuZGVkIG9mCnYzLjguIi4gIElmIGl0IG5l
ZWRzIHRvIGJlIGluIC1zdGFibGUsIHBsZWFzZSB0ZWxsIG1lIGFuZCBJJ2xsIGZ3ZCBpdAptYW51
YWxseS4KClRoYW5rcywKUnVzdHkuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
