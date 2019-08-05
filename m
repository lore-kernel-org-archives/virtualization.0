From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 7/9] vhost: do not use RCU to synchronize MMU notifier
	with worker
Date: Mon, 5 Aug 2019 12:36:40 +0800
Message-ID: <e8ecb811-6653-cff4-bc11-81f4ccb0dbbf__21986.0782077134$1564979823$gmane$org@redhat.com>
References: <20190731084655.7024-1-jasowang@redhat.com>
	<20190731084655.7024-8-jasowang@redhat.com>
	<20190731123935.GC3946@ziepe.ca>
	<7555c949-ae6f-f105-6e1d-df21ddae9e4e@redhat.com>
	<20190731193057.GG3946@ziepe.ca>
	<a3bde826-6329-68e4-2826-8a9de4c5bd1e@redhat.com>
	<20190801141512.GB23899@ziepe.ca>
	<42ead87b-1749-4c73-cbe4-29dbeb945041@redhat.com>
	<20190802124613.GA11245@ziepe.ca>
	<20190802100414-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190802100414-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvOC8yIOS4i+WNiDEwOjI3LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
RnJpLCBBdWcgMDIsIDIwMTkgYXQgMDk6NDY6MTNBTSAtMDMwMCwgSmFzb24gR3VudGhvcnBlIHdy
b3RlOgo+PiBPbiBGcmksIEF1ZyAwMiwgMjAxOSBhdCAwNTo0MDowN1BNICswODAwLCBKYXNvbiBX
YW5nIHdyb3RlOgo+Pj4+IFRoaXMgbXVzdCBiZSBhIHByb3BlciBiYXJyaWVyLCBsaWtlIGEgc3Bp
bmxvY2ssIG11dGV4LCBvcgo+Pj4+IHN5bmNocm9uaXplX3JjdS4KPj4+Cj4+PiBJIHN0YXJ0IHdp
dGggc3luY2hyb25pemVfcmN1KCkgYnV0IGJvdGggeW91IGFuZCBNaWNoYWVsIHJhaXNlIHNvbWUK
Pj4+IGNvbmNlcm4uCj4+IEkndmUgYWxzbyBpZGx5IHdvbmRlcmVkIGlmIGNhbGxpbmcgc3luY2hy
b25pemVfcmN1KCkgdW5kZXIgdGhlIHZhcmlvdXMKPj4gbW0gbG9ja3MgaXMgYSBkZWFkbG9jayBz
aXR1YXRpb24uCj4+Cj4+PiBUaGVuIEkgdHJ5IHNwaW5sb2NrIGFuZCBtdXRleDoKPj4+Cj4+PiAx
KSBzcGlubG9jazogYWRkIGxvdHMgb2Ygb3ZlcmhlYWQgb24gZGF0YXBhdGgsIHRoaXMgbGVhZHMg
MCBwZXJmb3JtYW5jZQo+Pj4gaW1wcm92ZW1lbnQuCj4+IEkgdGhpbmsgdGhlIHRvcGljIGhlcmUg
aXMgY29ycmVjdG5lc3Mgbm90IHBlcmZvcm1hbmNlIGltcHJvdmVtZW50Cj4gVGhlIHRvcGljIGlz
IHdoZXRoZXIgd2Ugc2hvdWxkIHJldmVydAo+IGNvbW1pdCA3ZjQ2NjAzMmRjOSAoInZob3N0OiBh
Y2Nlc3MgdnEgbWV0YWRhdGEgdGhyb3VnaCBrZXJuZWwgdmlydHVhbCBhZGRyZXNzIikKPgo+IG9y
IGtlZXAgaXQgaW4uIFRoZSBvbmx5IHJlYXNvbiB0byBrZWVwIGl0IGlzIHBlcmZvcm1hbmNlLgoK
Ck1heWJlIGl0J3MgdGltZSB0byBpbnRyb2R1Y2UgdGhlIGNvbmZpZyBvcHRpb24/CgoKPgo+IE5v
dyBhcyBsb25nIGFzIGFsbCB0aGlzIGNvZGUgaXMgZGlzYWJsZWQgYW55d2F5LCB3ZSBjYW4gZXhw
ZXJpbWVudCBhCj4gYml0Lgo+Cj4gSSBwZXJzb25hbGx5IGZlZWwgd2Ugd291bGQgYmUgYmVzdCBz
ZXJ2ZWQgYnkgaGF2aW5nIHR3byBjb2RlIHBhdGhzOgo+Cj4gLSBBY2Nlc3MgdG8gVk0gbWVtb3J5
IGRpcmVjdGx5IG1hcHBlZCBpbnRvIGtlcm5lbAo+IC0gQWNjZXNzIHRvIHVzZXJzcGFjZQo+Cj4K
PiBIYXZpbmcgaXQgYWxsIGNsZWFubHkgc3BsaXQgd2lsbCBhbGxvdyBhIGJ1bmNoIG9mIG9wdGlt
aXphdGlvbnMsIGZvcgo+IGV4YW1wbGUgZm9yIHllYXJzIG5vdyB3ZSBwbGFubmVkIHRvIGJlIGFi
bGUgdG8gcHJvY2VzcyBhbiBpbmNvbWluZyBzaG9ydAo+IHBhY2tldCBkaXJlY3RseSBvbiBzb2Z0
aXJxIHBhdGgsIG9yIGFuIG91dGdvaW5nIG9uIGRpcmVjdGx5IHdpdGhpbgo+IGV2ZW50ZmQuCgoK
SXQncyBub3QgaGFyZCBjb25zaWRlciB3ZSd2ZSBhbHJlYWR5IGhhZCBvdXIgb3duIGFjY3Nzb3Jz
LiBCdXQgdGhlIApxdWVzdGlvbiBpcyAoYXMgYXNrZWQgaW4gYW5vdGhlciB0aHJlYWQpLCBkbyB5
b3Ugd2FudCBwZXJtYW5lbnQgR1VQIG9yIApzdGlsbCB1c2UgTU1VIG5vdGlmaWVycy4KClRoYW5r
cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
