From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/6] vhost: allow device that does not depend on vhost
 worker
Date: Tue, 2 Jun 2020 15:04:08 +0800
Message-ID: <21e1bfbf-4b0c-5a73-6fdd-a58c43c733ea@redhat.com>
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-2-jasowang@redhat.com>
 <20200602005904-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200602005904-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: shahafs@mellanox.com, lulu@redhat.com, kvm@vger.kernel.org, saugatm@xilinx.com, netdev@vger.kernel.org, mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org, gdawar@xilinx.com, virtualization@lists.linux-foundation.org, eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn, eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMjAvNi8yIOS4i+WNiDE6MDEsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBG
cmksIE1heSAyOSwgMjAyMCBhdCAwNDowMjo1OFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92aG9zdC5jIGIvZHJpdmVycy92aG9zdC92aG9z
dC5jCj4+IGluZGV4IGQ0NTBlMTZjNWMyNS4uNzAxMDVlMDQ1NzY4IDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL3Zob3N0L3Zob3N0LmMKPj4gKysrIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4+IEBA
IC0xNjYsMTEgKzE2NiwxNiBAQCBzdGF0aWMgaW50IHZob3N0X3BvbGxfd2FrZXVwKHdhaXRfcXVl
dWVfZW50cnlfdCAqd2FpdCwgdW5zaWduZWQgbW9kZSwgaW50IHN5bmMsCj4+ICAgCQkJICAgICB2
b2lkICprZXkpCj4+ICAgewo+PiAgIAlzdHJ1Y3Qgdmhvc3RfcG9sbCAqcG9sbCA9IGNvbnRhaW5l
cl9vZih3YWl0LCBzdHJ1Y3Qgdmhvc3RfcG9sbCwgd2FpdCk7Cj4+ICsJc3RydWN0IHZob3N0X3dv
cmsgKndvcmsgPSAmcG9sbC0+d29yazsKPj4gICAKPj4gICAJaWYgKCEoa2V5X3RvX3BvbGwoa2V5
KSAmIHBvbGwtPm1hc2spKQo+PiAgIAkJcmV0dXJuIDA7Cj4+ICAgCj4+IC0Jdmhvc3RfcG9sbF9x
dWV1ZShwb2xsKTsKPj4gKwlpZiAoIXBvbGwtPmRldi0+dXNlX3dvcmtlcikKPj4gKwkJd29yay0+
Zm4od29yayk7Cj4+ICsJZWxzZQo+PiArCQl2aG9zdF9wb2xsX3F1ZXVlKHBvbGwpOwo+PiArCj4+
ICAgCXJldHVybiAwOwo+PiAgIH0KPj4KPiBTbyBhIHdha2V1cCBmdW5jdGlvbiB3YWtlcyB1cCBl
dmVudGZkIGRpcmVjdGx5Lgo+Cj4gV2hhdCBpZiB1c2VyIHN1cHBsaWVzIGUuZy4gdGhlIHNhbWUg
ZXZlbnRmZCBhcyBpb2V2ZW50ZmQ/Cj4KPiBXb24ndCB0aGlzIGNhdXNlIGluZmluaXRlIGxvb3Bz
PwoKCkknbSBub3Qgc3VyZSBJIGdldCB0aGlzLgoKVGhpcyBiYXNpY2FsbHkgY2FsbHMgaGFuZGxl
X3ZxIGRpcmVjdGx5IHdoZW4gZXZlbnRmZCBpcyB3b2tlbiB1cC4gVGhlIAppbmZpbml0ZSBsb29w
cyBjYW4gb25seSBoYXBwZW4gd2hlbiBoYW5kbGVfdnEoKSB0cmllcyB0byB3cml0ZSB0byAKaW9l
dmVudGZkIGl0c2xlZiB3aGljaCBzaG91bGQgYmUgYSBidWcgb2YgdGhlIGRldmljZS4KClRoYW5r
cwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
