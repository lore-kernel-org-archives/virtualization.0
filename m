From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [summary] virtio network device failover writeup
Date: Thu, 21 Mar 2019 13:12:23 -0400
Message-ID: <20190321131006-mutt-send-email-mst@kernel.org>
References: <B3FB267A-2DC0-4A4C-8193-7F420BC9791B@oracle.com>
	<20190321044920-mutt-send-email-mst@kernel.org>
	<CD40EA09-242D-41E1-8BD2-4FF4BB4D1986@oracle.com>
	<20190321082532-mutt-send-email-mst@kernel.org>
	<BB2B938F-D2F0-47F8-B651-70EC8A19BC6B@oracle.com>
	<20190321085159-mutt-send-email-mst@kernel.org>
	<2939FB15-720A-4C9E-92B7-2DBA139DDE0F@oracle.com>
	<20190321084517.773a65fa@shemminger-XPS-13-9360>
	<20190321114557-mutt-send-email-mst@kernel.org>
	<BC327EF2-22C7-402B-9078-93891A4774D6@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <BC327EF2-22C7-402B-9078-93891A4774D6@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liran Alon <liran.alon@oracle.com>
Cc: vuhuong@mellanox.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, Si-Wei Liu <si-wei.liu@oracle.com>, boris.ostrovsky@oracle.com, David Miller <davem@davemloft.net>, ogerlitz@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCBNYXIgMjEsIDIwMTkgYXQgMDY6MzE6MzVQTSArMDIwMCwgTGlyYW4gQWxvbiB3cm90
ZToKPiAKPiAKPiA+IE9uIDIxIE1hciAyMDE5LCBhdCAxNzo1MCwgTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiAKPiA+IE9uIFRodSwgTWFyIDIxLCAyMDE5IGF0
IDA4OjQ1OjE3QU0gLTA3MDAsIFN0ZXBoZW4gSGVtbWluZ2VyIHdyb3RlOgo+ID4+IE9uIFRodSwg
MjEgTWFyIDIwMTkgMTU6MDQ6MzcgKzAyMDAKPiA+PiBMaXJhbiBBbG9uIDxsaXJhbi5hbG9uQG9y
YWNsZS5jb20+IHdyb3RlOgo+ID4+IAo+ID4+Pj4gCj4gPj4+PiBPSy4gTm93IHdoYXQgaGFwcGVu
cyBpZiBtYXN0ZXIgaXMgbW92ZWQgdG8gYW5vdGhlciBuYW1lc3BhY2U/IERvIHdlIG5lZWQKPiA+
Pj4+IHRvIG1vdmUgdGhlIHNsYXZlcyB0b28/ICAKPiA+Pj4gCj4gPj4+IE5vLiBXaHkgd291bGQg
d2UgbW92ZSB0aGUgc2xhdmVzPyBUaGUgd2hvbGUgcG9pbnQgaXMgdG8gbWFrZSBtb3N0IGN1c3Rv
bWVyIGlnbm9yZSB0aGUgbmV0LWZhaWxvdmVyIHNsYXZlcyBhbmQgcmVtYWluIHRoZW0g4oCcaGlk
ZGVu4oCdIGluIHRoZWlyIGRlZGljYXRlZCBuZXRucy4KPiA+Pj4gV2Ugd29u4oCZdCBwcmV2ZW50
IGN1c3RvbWVyIGZyb20gZXhwbGljaXRseSBtb3ZpbmcgdGhlIG5ldC1mYWlsb3ZlciBzbGF2ZXMg
b3V0IG9mIHRoaXMgbmV0bnMsIGJ1dCB3ZSB3aWxsIG5vdCBtb3ZlIHRoZW0gb3V0IG9mIHRoZXJl
IGF1dG9tYXRpY2FsbHkuCj4gPj4gCj4gPj4gCj4gPj4gVGhlIDItZGV2aWNlIG5ldHZzYyBhbHJl
YWR5IGhhbmRsZXMgY2FzZSB3aGVyZSBtYXN0ZXIgY2hhbmdlcyBuYW1lc3BhY2UuCj4gPiAKPiA+
IElzIGl0IGJ5IG1vdmluZyBzbGF2ZSB3aXRoIGl0Pwo+IAo+IFNlZSBjMGE0MWI4ODdjZTYgKCJo
dl9uZXR2c2M6IG1vdmUgVkYgdG8gc2FtZSBuYW1lc3BhY2UgYXMgbmV0dnNjIGRldmljZeKAnSku
Cj4gSXQgc2VlbXMgdGhhdCB3aGVuIE5ldFZTQyBtYXN0ZXIgbmV0ZGV2IGNoYW5nZXMgbmV0bnMs
IHRoZSBWRiBpcyBtb3ZlZCB0byB0aGUgc2FtZSBuZXRucyBieSB0aGUgTmV0VlNDIGRyaXZlci4K
PiBLaW5kYSB0aGUgb3Bwb3NpdGUgdGhhbiB3aGF0IHdlIGFyZSBzdWdnZXN0aW5nIGhlcmUgdG8g
bWFrZSBzdXJlIHRoYXQgdGhlIG5ldC1mYWlsb3ZlciBtYXN0ZXIgbmV0ZGV2IGlzIG9uIGEgc2Vw
YXJhdGUKPiBuZXRucyB0aGFuIGl04oCZcyBzbGF2ZXMuLi4KPiAKPiAtTGlyYW4KPiAKPiA+IAo+
ID4gLS0gCj4gPiBNU1QKCk5vdCBleGFjdGx5IG9wcG9zaXRlIEknZCBzYXkuCgpJZiBmYWlsb3Zl
ciBpcyBpbiBob3N0IG5zLCBzbGF2ZXMgaW4gL3ByaW1hcnkgYW5kIC9zdGFuZGJ5LCB0aGVuIG1v
dmluZwpmYWlsb3ZlciB0byAvY29udGFpbmVyIHNob3VsZCBtb3ZlIHNsYXZlcyB0byAvY29udGFp
bmVyL3ByaW1hcnkgYW5kCi9jb250YWluZXIvc3RhbmRieS4KCgotLSAKTVNUCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
