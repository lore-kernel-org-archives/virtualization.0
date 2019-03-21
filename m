From: Liran Alon <liran.alon@oracle.com>
Subject: Re: [summary] virtio network device failover writeup
Date: Thu, 21 Mar 2019 19:15:19 +0200
Message-ID: <65C9DA4E-D959-4F9D-AD5B-1831387E652E__43468.0021878862$1555717633$gmane$org@oracle.com>
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
	<20190321131006-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190321131006-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: vuhuong@mellanox.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, Si-Wei Liu <si-wei.liu@oracle.com>, boris.ostrovsky@oracle.com, David Miller <davem@davemloft.net>, ogerlitz@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

Cgo+IE9uIDIxIE1hciAyMDE5LCBhdCAxOToxMiwgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4gCj4gT24gVGh1LCBNYXIgMjEsIDIwMTkgYXQgMDY6MzE6MzVQTSAr
MDIwMCwgTGlyYW4gQWxvbiB3cm90ZToKPj4gCj4+IAo+Pj4gT24gMjEgTWFyIDIwMTksIGF0IDE3
OjUwLCBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPj4+IAo+Pj4g
T24gVGh1LCBNYXIgMjEsIDIwMTkgYXQgMDg6NDU6MTdBTSAtMDcwMCwgU3RlcGhlbiBIZW1taW5n
ZXIgd3JvdGU6Cj4+Pj4gT24gVGh1LCAyMSBNYXIgMjAxOSAxNTowNDozNyArMDIwMAo+Pj4+IExp
cmFuIEFsb24gPGxpcmFuLmFsb25Ab3JhY2xlLmNvbT4gd3JvdGU6Cj4+Pj4gCj4+Pj4+PiAKPj4+
Pj4+IE9LLiBOb3cgd2hhdCBoYXBwZW5zIGlmIG1hc3RlciBpcyBtb3ZlZCB0byBhbm90aGVyIG5h
bWVzcGFjZT8gRG8gd2UgbmVlZAo+Pj4+Pj4gdG8gbW92ZSB0aGUgc2xhdmVzIHRvbz8gIAo+Pj4+
PiAKPj4+Pj4gTm8uIFdoeSB3b3VsZCB3ZSBtb3ZlIHRoZSBzbGF2ZXM/IFRoZSB3aG9sZSBwb2lu
dCBpcyB0byBtYWtlIG1vc3QgY3VzdG9tZXIgaWdub3JlIHRoZSBuZXQtZmFpbG92ZXIgc2xhdmVz
IGFuZCByZW1haW4gdGhlbSDigJxoaWRkZW7igJ0gaW4gdGhlaXIgZGVkaWNhdGVkIG5ldG5zLgo+
Pj4+PiBXZSB3b27igJl0IHByZXZlbnQgY3VzdG9tZXIgZnJvbSBleHBsaWNpdGx5IG1vdmluZyB0
aGUgbmV0LWZhaWxvdmVyIHNsYXZlcyBvdXQgb2YgdGhpcyBuZXRucywgYnV0IHdlIHdpbGwgbm90
IG1vdmUgdGhlbSBvdXQgb2YgdGhlcmUgYXV0b21hdGljYWxseS4KPj4+PiAKPj4+PiAKPj4+PiBU
aGUgMi1kZXZpY2UgbmV0dnNjIGFscmVhZHkgaGFuZGxlcyBjYXNlIHdoZXJlIG1hc3RlciBjaGFu
Z2VzIG5hbWVzcGFjZS4KPj4+IAo+Pj4gSXMgaXQgYnkgbW92aW5nIHNsYXZlIHdpdGggaXQ/Cj4+
IAo+PiBTZWUgYzBhNDFiODg3Y2U2ICgiaHZfbmV0dnNjOiBtb3ZlIFZGIHRvIHNhbWUgbmFtZXNw
YWNlIGFzIG5ldHZzYyBkZXZpY2XigJ0pLgo+PiBJdCBzZWVtcyB0aGF0IHdoZW4gTmV0VlNDIG1h
c3RlciBuZXRkZXYgY2hhbmdlcyBuZXRucywgdGhlIFZGIGlzIG1vdmVkIHRvIHRoZSBzYW1lIG5l
dG5zIGJ5IHRoZSBOZXRWU0MgZHJpdmVyLgo+PiBLaW5kYSB0aGUgb3Bwb3NpdGUgdGhhbiB3aGF0
IHdlIGFyZSBzdWdnZXN0aW5nIGhlcmUgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIG5ldC1mYWlsb3Zl
ciBtYXN0ZXIgbmV0ZGV2IGlzIG9uIGEgc2VwYXJhdGUKPj4gbmV0bnMgdGhhbiBpdOKAmXMgc2xh
dmVzLi4uCj4+IAo+PiAtTGlyYW4KPj4gCj4+PiAKPj4+IC0tIAo+Pj4gTVNUCj4gCj4gTm90IGV4
YWN0bHkgb3Bwb3NpdGUgSSdkIHNheS4KPiAKPiBJZiBmYWlsb3ZlciBpcyBpbiBob3N0IG5zLCBz
bGF2ZXMgaW4gL3ByaW1hcnkgYW5kIC9zdGFuZGJ5LCB0aGVuIG1vdmluZwo+IGZhaWxvdmVyIHRv
IC9jb250YWluZXIgc2hvdWxkIG1vdmUgc2xhdmVzIHRvIC9jb250YWluZXIvcHJpbWFyeSBhbmQK
PiAvY29udGFpbmVyL3N0YW5kYnkuCgpZZXMgSSBhZ3JlZS4KSSBtZWFudCB0aGF0IHRoZXkgdHJp
ZWQgdG8ga2VlcCB0aGUgVkYgb24gdGhlIHNhbWUgbmV0bnMgYXMgdGhlIE5ldFZTQy4KQnV0IG9m
IGNvdXJzZSB3aGF0IHlvdSBqdXN0IGRlc2NyaWJlZCBpcyBleGFjdGx5IHRoZSBmdW5jdGlvbmFs
aXR5IEkgd291bGQgaGF2ZSB3YW50ZWQgaW4gb3VyIG5ldC1mYWlsb3ZlciBtZWNoYW5pc20uCgot
TGlyYW4KCj4gCj4gCj4gLS0gCj4gTVNUCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
