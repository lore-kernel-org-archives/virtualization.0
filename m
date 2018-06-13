From: Jason Wang <jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: Introduce VIRTIO_NET_F_STANDBY feature
	bit to virtio_net
Date: Wed, 13 Jun 2018 10:41:01 +0800
Message-ID: <6c7666e6-dc00-d9ed-8814-68e8b3998eef@redhat.com>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
	<20180605152344-mutt-send-email-mst@kernel.org>
	<a45625c9-d2cd-f8f7-ce31-37c558e70b88@redhat.com>
	<20180612144743-mutt-send-email-mst@kernel.org>
	<7aa6dbe7-bac2-96f6-d96c-f51e5173c556@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7aa6dbe7-bac2-96f6-d96c-f51e5173c556@intel.com>
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
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDbmnIgxM+aXpSAwODoyMCwgU2FtdWRyYWxhLCBTcmlkaGFyIHdyb3RlOgo+
IE9uIDYvMTIvMjAxOCA0OjU0IEFNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+IE9uIFdl
ZCwgSnVuIDA2LCAyMDE4IGF0IDEwOjI5OjAzQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
Pgo+Pj4gT24gMjAxOOW5tDA25pyIMDXml6UgMjA6MzMsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPj4+PiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgc3VmZmljaWVudC4KPj4+Pgo+Pj4+IElmIGJv
dGggcHJpbWFyeSBhbmQgc3RhbmRieSBkZXZpY2VzIGFyZSBwcmVzZW50LCBhIGxlZ2FjeSBndWVz
dCAKPj4+PiB3aXRob3V0Cj4+Pj4gc3VwcG9ydCBmb3IgdGhlIGZlYXR1cmUgbWlnaHQgc2VlIHR3
byBkZXZpY2VzIHdpdGggc2FtZSBtYWMgYW5kIGdldAo+Pj4+IGNvbmZ1c2VkLgo+Pj4+Cj4+Pj4g
SSB0aGluayB0aGF0IHdlIHNob3VsZCBvbmx5IG1ha2UgcHJpbWFyeSB2aXNpYmxlIGFmdGVyIGd1
ZXN0IGFja2VkIHRoZQo+Pj4+IGJhY2t1cCBmZWF0dXJlIGJpdC4KPj4+IEkgdGhpbmsgd2Ugd2Fu
dCBleGFjdGx5IHRoZSByZXZlcnNlPyBFLmcgZmFpbCB0aGUgbmVnb3RpYXRpb24gd2hlbiAKPj4+
IGd1ZXN0Cj4+PiBkb2VzIG5vdCBhY2sgYmFja3VwIGZlYXR1cmUuCj4+Pgo+Pj4gT3RoZXJ3aXNl
IGxlZ2FjeSBndWVzdCB3b24ndCBldmVuIGhhdmUgdGhlIGNoYW5jZSB0byBzZWUgcHJpbWFyeSAK
Pj4+IGRldmljZSBpbgo+Pj4gdGhlIGd1ZXN0Lgo+PiBUaGF0J3MgYnkgZGVzaWduLgo+Pgo+Pj4+
IEFuZCBvbiByZXNldCBvciB3aGVuIGJhY2t1cCBpcyBjbGVhcmVkIGluIHNvbWUgb3RoZXIgd2F5
LCB1bnBsdWcgdGhlCj4+Pj4gcHJpbWFyeS4KPj4+IFdoYXQgaWYgZ3Vlc3QgZG9lcyBub3Qgc3Vw
cG9ydCBob3RwbHVnPwo+PiBJdCBzaG91bGRuJ3QgYWNrIHRoZSBiYWNrdXAgZmVhdHVyZSB0aGVu
IGFuZCBpdCdzIGEgZ29vZCBwb2ludC4KPj4gV2Ugc2hvdWxkIGJvdGggZG9jdW1lbnQgdGhpcyBh
bmQgY2hlY2sga2VybmVsIGNvbmZpZyBoYXMKPj4gaG90cGx1ZyBzdXBwb3J0LiBTcmlkaGFyIGNv
dWxkIHlvdSB0YWtlIGEgbG9vayBwbHM/Cj4KPiBSaWdodCBub3cgd2Ugc2VsZWN0IE5FVF9GQUlM
T1ZFUiB3aGVuIHZpcnRpby1uZXQgaXMgZW5hYmxlZCwgU2hvdWxkIHdlIAo+IHNlbGVjdAo+IFBD
SV9IT1RQTFVHIHdoZW4gTkVUX0ZBSUxPVkVSIGlzIGVuYWJsZWQ/IAoKTWF5YmUgSSB3YXMgd3Jv
bmcgYnV0IGl0IGxvb2tzIHRvIG1lIFBDSV9IT1RQTFVHIGlzIG5vIHN1ZmZpY2llbnQgc2luY2Ug
Cml0IGRlcGVuZHMgb24gb3RoZXIgdG8gd29yayBlLmcgSE9UUExVR19QQ0lfQUNQSS4KClRoYW5r
cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
