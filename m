From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Date: Tue, 21 Jan 2020 12:00:57 +0800
Message-ID: <2a324cec-2863-58f4-c58a-2414ee32c930@redhat.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200117070324-mutt-send-email-mst@kernel.org>
 <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
 <CAJPjb1+fG9L3=iKbV4Vn13VwaeDZZdcfBPvarogF_Nzhk+FnKg@mail.gmail.com>
 <AM0PR0502MB379553984D0D55FDE25426F6C3330@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <d69918ca-8af4-44b2-9652-633530d4c113@redhat.com>
 <20200120174933.GB3891@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200120174933.GB3891@mellanox.com>
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
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "mhabets@solarflare.com" <mhabets@solarflare.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Rob Miller <rob.miller@broadcom.com>, "lulu@redhat.com" <lulu@redhat.com>, "hanand@xilinx.com" <hanand@xilinx.com>, "hch@infradead.org" <hch@infradead.org>, "eperezma@redhat.com" <eperezma@redhat.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, Shahaf Shuler <shahafs@mellanox.com>, Parav Pandit <parav@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.>
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMjAvMS8yMSDkuIrljYgxOjQ5LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gT24gTW9u
LCBKYW4gMjAsIDIwMjAgYXQgMDQ6NDM6NTNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4g
VGhpcyBpcyBzaW1pbGFyIHRvIHRoZSBkZXNpZ24gb2YgcGxhdGZvcm0gSU9NTVUgcGFydCBvZiB2
aG9zdC12ZHBhLiBXZQo+PiBkZWNpZGUgdG8gc2VuZCBkaWZmcyB0byBwbGF0Zm9ybSBJT01NVSB0
aGVyZS4gSWYgaXQncyBvayB0byBkbyB0aGF0IGluCj4+IGRyaXZlciwgd2UgY2FuIHJlcGxhY2Ug
c2V0X21hcCB3aXRoIGluY3JlbWVudGFsIEFQSSBsaWtlIG1hcCgpL3VubWFwKCkuCj4+Cj4+IFRo
ZW4gZHJpdmVyIG5lZWQgdG8gbWFpbnRhaW4gcmJ0cmVlIGl0c2VsZi4KPiBJIHRoaW5rIHdlIHJl
YWxseSBuZWVkIHRvIHNlZSB0d28gbW9kZXMsIG9uZSB3aGVyZSB0aGVyZSBpcyBhIGZpeGVkCj4g
dHJhbnNsYXRpb24gd2l0aG91dCBkeW5hbWljIHZJT01NVSBkcml2ZW4gY2hhbmdlcyBhbmQgb25l
IHRoYXQKPiBzdXBwb3J0cyB2SU9NTVUuCgoKSSB0aGluayBpbiB0aGlzIGNhc2UsIHlvdSBtZWFu
dCB0aGUgbWV0aG9kIHByb3Bvc2VkIGJ5IFNoYWhhZiB0aGF0IHNlbmRzIApkaWZmcyBvZiAiZml4
ZWQgdHJhbnNsYXRpb24iIHRvIGRldmljZT8KCkl0IHdvdWxkIGJlIGtpbmQgb2YgdHJpY2t5IHRv
IGRlYWwgd2l0aCB0aGUgZm9sbG93aW5nIGNhc2UgZm9yIGV4YW1wbGU6CgpvbGQgbWFwIFs0Rywg
MTZHKSBuZXcgbWFwIFs0RywgOEcpCgpJZiB3ZSBkbwoKMSkgZmx1c2ggWzRHLCAxNkcpCjIpIGFk
ZCBbNEcsIDhHKQoKVGhlcmUgY291bGQgYmUgYSB3aW5kb3cgYmV0d2VlbiAxKSBhbmQgMikuCgpJ
dCByZXF1aXJlcyB0aGUgSU9NTVUgdGhhdCBjYW4gZG8KCjEpIHJlbW92ZSBbOEcsIDE2RykKMikg
Zmx1c2ggWzhHLCAxNkcpCjMpIGNoYW5nZSBbNEcsIDhHKQoKLi4uLgoKPgo+IFRoZXJlIGFyZSBk
aWZmZXJlbnQgb3B0aW1pemF0aW9uIGdvYWxzIGluIHRoZSBkcml2ZXJzIGZvciB0aGVzZSB0d28K
PiBjb25maWd1cmF0aW9ucy4KPgo+Pj4gSWYgdGhlIGZpcnN0IG9uZSwgdGhlbiBJIHRoaW5rIG1l
bW9yeSBob3RwbHVnIGlzIGEgaGVhdnkgZmxvdwo+Pj4gcmVnYXJkbGVzcy4gRG8geW91IHRoaW5r
IHRoZSBleHRyYSBjeWNsZXMgZm9yIHRoZSB0cmVlIHRyYXZlcnNlCj4+PiB3aWxsIGJlIHZpc2li
bGUgaW4gYW55IHdheT8KPj4gSSB0aGluayBpZiB0aGUgZHJpdmVyIGNhbiBwYXVzZSB0aGUgRE1B
IGR1cmluZyB0aGUgdGltZSBmb3Igc2V0dGluZyB1cCBuZXcKPj4gbWFwcGluZywgaXQgc2hvdWxk
IGJlIGZpbmUuCj4gVGhpcyBpcyB2ZXJ5IHRyaWNreSBmb3IgYW55IGRyaXZlciBpZiB0aGUgbWFw
cGluZyBjaGFuZ2UgaGl0cyB0aGUKPiB2aXJ0aW8gcmluZ3MuIDooCj4KPiBFdmVuIGEgSU9NTVUg
dXNpbmcgZHJpdmVyIGlzIGdvaW5nIHRvIGhhdmUgcHJvYmxlbXMgd2l0aCB0aGF0Li4KPgo+IEph
c29uCgoKT3IgSSB3b25kZXIgd2hldGhlciBBVFMvUFJJIGNhbiBoZWxwIGhlcmUuIEUuZyBkdXJp
bmcgSS9PIHBhZ2UgZmF1bHQsIApkcml2ZXIvZGV2aWNlIGNhbiB3YWl0IGZvciB0aGUgbmV3IG1h
cHBpbmcgdG8gYmUgc2V0IGFuZCB0aGVuIHJlcGxheSB0aGUgCkRNQS4KClRoYW5rcwoKPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
