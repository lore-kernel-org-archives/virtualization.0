From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-mem: drop unnecessary initialization
Date: Mon, 8 Jun 2020 13:59:40 +0800
Message-ID: <5d00d5e0-0430-dabd-9486-ca363453928f@redhat.com>
References: <20200608054517.708167-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200608054517.708167-1-mst@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, virtualization@lists.linux-foundation.org, kernel test robot <lkp@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMjAvNi84IOS4i+WNiDE6NDUsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiByYyBp
cyBpbml0aWFsaXplZCB0byAtRU5JVkFMIGJ1dCB0aGF0J3MgbmV2ZXIgdXNlZC4gRHJvcCBpdC4K
Pgo+IEZpeGVzOiA1ZjFmNzliYmM5ZTIgKCJ2aXJ0aW8tbWVtOiBQYXJhdmlydHVhbGl6ZWQgbWVt
b3J5IGhvdHBsdWciKQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVs
LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29t
Pgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX21lbS5jIHwgMiArLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX21lbS5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX21lbS5j
Cj4gaW5kZXggZjY1OGZlOTE0OWJlLi4yZjM1NzE0MmVhNWUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX21lbS5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX21lbS5j
Cj4gQEAgLTE3NjgsNyArMTc2OCw3IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19tZW1fZGVsZXRlX3Jl
c291cmNlKHN0cnVjdCB2aXJ0aW9fbWVtICp2bSkKPiAgIHN0YXRpYyBpbnQgdmlydGlvX21lbV9w
cm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgIHsKPiAgIAlzdHJ1Y3QgdmlydGlv
X21lbSAqdm07Cj4gLQlpbnQgcmMgPSAtRUlOVkFMOwo+ICsJaW50IHJjOwo+ICAgCj4gICAJQlVJ
TERfQlVHX09OKHNpemVvZihzdHJ1Y3QgdmlydGlvX21lbV9yZXEpICE9IDI0KTsKPiAgIAlCVUlM
RF9CVUdfT04oc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbWVtX3Jlc3ApICE9IDEwKTsKCgpBY2tlZC1i
eTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
