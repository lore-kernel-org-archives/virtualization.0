From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 5/6] vdpa: introduce virtio pci driver
Date: Sun, 7 Jun 2020 09:51:52 -0400
Message-ID: <20200607095012-mutt-send-email-mst@kernel.org>
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-6-jasowang@redhat.com>
 <20200602010332-mutt-send-email-mst@kernel.org>
 <5dbb0386-beeb-5bf4-d12e-fb5427486bb8@redhat.com>
 <6b1d1ef3-d65e-08c2-5b65-32969bb5ecbc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <6b1d1ef3-d65e-08c2-5b65-32969bb5ecbc@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Jason Wang <jasowang@redhat.com>
Cc: shahafs@mellanox.com, lulu@redhat.com, kvm@vger.kernel.org, saugatm@xilinx.com, netdev@vger.kernel.org, mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org, gdawar@xilinx.com, virtualization@lists.linux-foundation.org, eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn, eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCBKdW4gMDUsIDIwMjAgYXQgMDQ6NTQ6MTdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzYvMiDkuIvljYgzOjA4LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiAK
PiA+ID4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIHZwX3ZkcGFfaWRfdGFi
bGVbXSA9IHsKPiA+ID4gPiArwqDCoMKgIHsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX1JFREhB
VF9RVU1SQU5FVCwgUENJX0FOWV9JRCkgfSwKPiA+ID4gPiArwqDCoMKgIHsgMCB9Cj4gPiA+ID4g
K307Cj4gPiA+IFRoaXMgbG9va3MgbGlrZSBpdCdsbCBjcmVhdGUgYSBtZXNzIHdpdGggZWl0aGVy
IHZpcnRpbyBwY2kKPiA+ID4gb3IgdmRwYSBiZWluZyBsb2FkZWQgYXQgcmFuZG9tLiBNYXliZSBq
dXN0IGRvbid0IHNwZWNpZnkKPiA+ID4gYW55IElEcyBmb3Igbm93LiBEb3duIHRoZSByb2FkIHdl
IGNvdWxkIGdldCBhCj4gPiA+IGRpc3RpbmN0IHZlbmRvciBJRCBvciBhIHJhbmdlIG9mIGRldmlj
ZSBJRHMgZm9yIHRoaXMuCj4gPiAKPiA+IAo+ID4gUmlnaHQsIHdpbGwgZG8uCj4gPiAKPiA+IFRo
YW5rcwo+IAo+IAo+IFJldGhpbmsgYWJvdXQgdGhpcy4gSWYgd2UgZG9uJ3Qgc3BlY2lmeSBhbnkg
SUQsIHRoZSBiaW5kaW5nIHdvbid0IHdvcmsuCgpXZSBjYW4gYmluZCBtYW51YWxseS4gSXQncyBu
b3QgcmVhbGx5IGZvciBwcm9kdWN0aW9uIGFueXdheSwgc28Kbm90IGEgYmlnIGRlYWwgaW1oby4K
Cj4gSG93IGFib3V0IHVzaW5nIGEgZGVkaWNhdGVkIHN1YnN5c3RlbSB2ZW5kb3IgaWQgZm9yIHRo
aXM/Cj4gCj4gVGhhbmtzCgpJZiB2aXJ0aW8gdmVuZG9yIGlkIGlzIHVzZWQgdGhlbiBzdGFuZGFy
ZCBkcml2ZXIgaXMgZXhwZWN0ZWQKdG8gYmluZCwgcmlnaHQ/IE1heWJlIHVzZSBhIGRlZGljYXRl
ZCB2ZW5kb3IgaWQ/CgotLSAKTVNUCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
