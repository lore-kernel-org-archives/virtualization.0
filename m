From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 5/6] vdpa: introduce virtio pci driver
Date: Mon, 8 Jun 2020 09:29:01 -0400
Message-ID: <20200608092530-mutt-send-email-mst@kernel.org>
References: <20200607095012-mutt-send-email-mst@kernel.org>
 <9b1abd2b-232c-aa0f-d8bb-03e65fd47de2@redhat.com>
 <20200608021438-mutt-send-email-mst@kernel.org>
 <a1b1b7fb-b097-17b7-2e3a-0da07d2e48ae@redhat.com>
 <20200608052041-mutt-send-email-mst@kernel.org>
 <9d2571b6-0b95-53b3-6989-b4d801eeb623@redhat.com>
 <20200608054453-mutt-send-email-mst@kernel.org>
 <bc27064c-2309-acf3-ccd8-6182bfa2a4cd@redhat.com>
 <20200608055331-mutt-send-email-mst@kernel.org>
 <61117e6a-2568-d0f4-8713-d831af32814d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <61117e6a-2568-d0f4-8713-d831af32814d@redhat.com>
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

T24gTW9uLCBKdW4gMDgsIDIwMjAgYXQgMDY6MDc6MzZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzYvOCDkuIvljYg1OjU0LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiBPbiBNb24sIEp1biAwOCwgMjAyMCBhdCAwNTo0Njo1MlBNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiBPbiAyMDIwLzYvOCDkuIvljYg1OjQ1LCBNaWNoYWVsIFMuIFRzaXJraW4g
d3JvdGU6Cj4gPiA+ID4gT24gTW9uLCBKdW4gMDgsIDIwMjAgYXQgMDU6NDM6NThQTSArMDgwMCwg
SmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiBMb29raW5nIGF0Cj4gPiA+ID4gPiA+ID4g
cGNpX21hdGNoX29uZV9kZXZpY2UoKSBpdCBjaGVja3MgYm90aCBzdWJ2ZW5kb3IgYW5kIHN1YmRl
dmljZSB0aGVyZS4KPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+
ID4gQnV0IElJVUMgdGhlcmUgaXMgbm8gZ3VhcmFudGVlIHRoYXQgZHJpdmVyIHdpdGggYSBzcGVj
aWZpYyBzdWJ2ZW5kb3IKPiA+ID4gPiA+ID4gbWF0Y2hlcyBpbiBwcmVzZW5jZSBvZiBhIGdlbmVy
aWMgb25lLgo+ID4gPiA+ID4gPiBTbyBlaXRoZXIgSUZDIG9yIHZpcnRpbyBwY2kgY2FuIHdpbiwg
d2hpY2hldmVyIGJpbmRzIGZpcnN0Lgo+ID4gPiA+ID4gSSdtIG5vdCBzdXJlIEkgZ2V0IHRoZXJl
LiBCdXQgSSB0cnkgbWFudWFsbHkgYmluZCBJRkNWRiB0byBxZW11J3MKPiA+ID4gPiA+IHZpcnRp
by1uZXQtcGNpLCBhbmQgaXQgZmFpbHMuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFRoYW5rcwo+ID4g
PiA+IFJpZ2h0IGJ1dCB0aGUgcmV2ZXJzZSBjYW4gaGFwcGVuOiB2aXJ0aW8tbmV0IGNhbiBiaW5k
IHRvIElGQ1ZGIGZpcnN0Lgo+ID4gPiAKPiA+ID4gVGhhdCdzIGtpbmQgb2YgZXhwZWN0ZWQuIFRo
ZSBQRiBpcyBleHBlY3RlZCB0byBiZSBib3VuZCB0byB2aXJ0aW8tcGNpIHRvCj4gPiA+IGNyZWF0
ZSBWRiB2aWEgc3lzZnMuCj4gPiA+IAo+ID4gPiBUaGFua3MKPiA+ID4gCj4gPiA+IAo+ID4gPiAK
PiA+IE9uY2UgVkZzIGFyZSBjcmVhdGVkLCBkb24ndCB3ZSB3YW50IElGQ1ZGIHRvIGJpbmQgcmF0
aGVyIHRoYW4KPiA+IHZpcnRpby1wY2k/Cj4gCj4gCj4gWWVzLCBidXQgZm9yIFBGIHdlIG5lZWQg
dmlydGlvLXBjaS4KPiAKPiBUaGFua3MKPiAKCihBYil1c2luZyB0aGUgZHJpdmVyX2RhdGEgZmll
bGQgZm9yIHRoaXMgaXMgYW4gb3B0aW9uLgpXaGF0IGRvIHlvdSB0aGluaz8KCi0tIApNU1QKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
