From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Date: Tue, 21 Jan 2020 00:47:15 -0500
Message-ID: <20200121004047-mutt-send-email-mst@kernel.org>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200117070324-mutt-send-email-mst@kernel.org>
 <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
 <CAJPjb1+fG9L3=iKbV4Vn13VwaeDZZdcfBPvarogF_Nzhk+FnKg@mail.gmail.com>
 <AM0PR0502MB379553984D0D55FDE25426F6C3330@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <d69918ca-8af4-44b2-9652-633530d4c113@redhat.com>
 <20200120174933.GB3891@mellanox.com>
 <2a324cec-2863-58f4-c58a-2414ee32c930@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2a324cec-2863-58f4-c58a-2414ee32c930@redhat.com>
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
Cc: "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mhabets@solarflare.com" <mhabets@solarflare.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Rob Miller <rob.miller@broadcom.com>, "lulu@redhat.com" <lulu@redhat.com>, "hanand@xilinx.com" <hanand@xilinx.com>, "hch@infradead.org" <hch@infradead.org>, "eperezma@redhat.com" <eperezma@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Shahaf Shuler <shahafs@mellanox.com>, Parav Pandit <parav@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, "Wang,
 Xiao W" <xiao.w.wang@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, Netdev <netdev@vger.kernel.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>, linux-kernel@vger.kernel.or
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlLCBKYW4gMjEsIDIwMjAgYXQgMTI6MDA6NTdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzEvMjEg5LiK5Y2IMTo0OSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+
ID4gT24gTW9uLCBKYW4gMjAsIDIwMjAgYXQgMDQ6NDM6NTNQTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPiA+ID4gVGhpcyBpcyBzaW1pbGFyIHRvIHRoZSBkZXNpZ24gb2YgcGxhdGZvcm0gSU9N
TVUgcGFydCBvZiB2aG9zdC12ZHBhLiBXZQo+ID4gPiBkZWNpZGUgdG8gc2VuZCBkaWZmcyB0byBw
bGF0Zm9ybSBJT01NVSB0aGVyZS4gSWYgaXQncyBvayB0byBkbyB0aGF0IGluCj4gPiA+IGRyaXZl
ciwgd2UgY2FuIHJlcGxhY2Ugc2V0X21hcCB3aXRoIGluY3JlbWVudGFsIEFQSSBsaWtlIG1hcCgp
L3VubWFwKCkuCj4gPiA+IAo+ID4gPiBUaGVuIGRyaXZlciBuZWVkIHRvIG1haW50YWluIHJidHJl
ZSBpdHNlbGYuCj4gPiBJIHRoaW5rIHdlIHJlYWxseSBuZWVkIHRvIHNlZSB0d28gbW9kZXMsIG9u
ZSB3aGVyZSB0aGVyZSBpcyBhIGZpeGVkCj4gPiB0cmFuc2xhdGlvbiB3aXRob3V0IGR5bmFtaWMg
dklPTU1VIGRyaXZlbiBjaGFuZ2VzIGFuZCBvbmUgdGhhdAo+ID4gc3VwcG9ydHMgdklPTU1VLgo+
IAo+IAo+IEkgdGhpbmsgaW4gdGhpcyBjYXNlLCB5b3UgbWVhbnQgdGhlIG1ldGhvZCBwcm9wb3Nl
ZCBieSBTaGFoYWYgdGhhdCBzZW5kcwo+IGRpZmZzIG9mICJmaXhlZCB0cmFuc2xhdGlvbiIgdG8g
ZGV2aWNlPwo+IAo+IEl0IHdvdWxkIGJlIGtpbmQgb2YgdHJpY2t5IHRvIGRlYWwgd2l0aCB0aGUg
Zm9sbG93aW5nIGNhc2UgZm9yIGV4YW1wbGU6Cj4gCj4gb2xkIG1hcCBbNEcsIDE2RykgbmV3IG1h
cCBbNEcsIDhHKQo+IAo+IElmIHdlIGRvCj4gCj4gMSkgZmx1c2ggWzRHLCAxNkcpCj4gMikgYWRk
IFs0RywgOEcpCj4gCj4gVGhlcmUgY291bGQgYmUgYSB3aW5kb3cgYmV0d2VlbiAxKSBhbmQgMiku
Cj4gCj4gSXQgcmVxdWlyZXMgdGhlIElPTU1VIHRoYXQgY2FuIGRvCj4gCj4gMSkgcmVtb3ZlIFs4
RywgMTZHKQo+IDIpIGZsdXNoIFs4RywgMTZHKQo+IDMpIGNoYW5nZSBbNEcsIDhHKQo+IAo+IC4u
Li4KCkJhc2ljYWxseSB3aGF0IEkgaGFkIGluIG1pbmQgaXMgc29tZXRoaW5nIGxpa2UgcWVtdSBt
ZW1vcnkgYXBpCgowLiBiZWdpbgoxLiByZW1vdmUgWzhHLCAxNkcpCjIuIGFkZCBbNEcsIDhHKQoz
LiBjb21taXQKCkFueXdheSwgSSdtIGZpbmUgd2l0aCBhIG9uZS1zaG90IEFQSSBmb3Igbm93LCB3
ZSBjYW4KaW1wcm92ZSBpdCBsYXRlci4KCj4gPiAKPiA+IFRoZXJlIGFyZSBkaWZmZXJlbnQgb3B0
aW1pemF0aW9uIGdvYWxzIGluIHRoZSBkcml2ZXJzIGZvciB0aGVzZSB0d28KPiA+IGNvbmZpZ3Vy
YXRpb25zLgo+ID4gCj4gPiA+ID4gSWYgdGhlIGZpcnN0IG9uZSwgdGhlbiBJIHRoaW5rIG1lbW9y
eSBob3RwbHVnIGlzIGEgaGVhdnkgZmxvdwo+ID4gPiA+IHJlZ2FyZGxlc3MuIERvIHlvdSB0aGlu
ayB0aGUgZXh0cmEgY3ljbGVzIGZvciB0aGUgdHJlZSB0cmF2ZXJzZQo+ID4gPiA+IHdpbGwgYmUg
dmlzaWJsZSBpbiBhbnkgd2F5Pwo+ID4gPiBJIHRoaW5rIGlmIHRoZSBkcml2ZXIgY2FuIHBhdXNl
IHRoZSBETUEgZHVyaW5nIHRoZSB0aW1lIGZvciBzZXR0aW5nIHVwIG5ldwo+ID4gPiBtYXBwaW5n
LCBpdCBzaG91bGQgYmUgZmluZS4KPiA+IFRoaXMgaXMgdmVyeSB0cmlja3kgZm9yIGFueSBkcml2
ZXIgaWYgdGhlIG1hcHBpbmcgY2hhbmdlIGhpdHMgdGhlCj4gPiB2aXJ0aW8gcmluZ3MuIDooCj4g
PiAKPiA+IEV2ZW4gYSBJT01NVSB1c2luZyBkcml2ZXIgaXMgZ29pbmcgdG8gaGF2ZSBwcm9ibGVt
cyB3aXRoIHRoYXQuLgo+ID4gCj4gPiBKYXNvbgo+IAo+IAo+IE9yIEkgd29uZGVyIHdoZXRoZXIg
QVRTL1BSSSBjYW4gaGVscCBoZXJlLiBFLmcgZHVyaW5nIEkvTyBwYWdlIGZhdWx0LAo+IGRyaXZl
ci9kZXZpY2UgY2FuIHdhaXQgZm9yIHRoZSBuZXcgbWFwcGluZyB0byBiZSBzZXQgYW5kIHRoZW4g
cmVwbGF5IHRoZQo+IERNQS4KPiAKPiBUaGFua3MKPiAKCgotLSAKTVNUCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
