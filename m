From: Liran Alon <liran.alon@oracle.com>
Subject: Re: [summary] virtio network device failover writeup
Date: Thu, 21 Mar 2019 18:31:35 +0200
Message-ID: <BC327EF2-22C7-402B-9078-93891A4774D6__48964.1577981942$1555717619$gmane$org@oracle.com>
References: <36772E22-7A8F-4C42-A731-398E3204B418@oracle.com>
	<20190320180641-mutt-send-email-mst@kernel.org>
	<B3FB267A-2DC0-4A4C-8193-7F420BC9791B@oracle.com>
	<20190321044920-mutt-send-email-mst@kernel.org>
	<CD40EA09-242D-41E1-8BD2-4FF4BB4D1986@oracle.com>
	<20190321082532-mutt-send-email-mst@kernel.org>
	<BB2B938F-D2F0-47F8-B651-70EC8A19BC6B@oracle.com>
	<20190321085159-mutt-send-email-mst@kernel.org>
	<2939FB15-720A-4C9E-92B7-2DBA139DDE0F@oracle.com>
	<20190321084517.773a65fa@shemminger-XPS-13-9360>
	<20190321114557-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190321114557-mutt-send-email-mst@kernel.org>
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

Cgo+IE9uIDIxIE1hciAyMDE5LCBhdCAxNzo1MCwgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4gCj4gT24gVGh1LCBNYXIgMjEsIDIwMTkgYXQgMDg6NDU6MTdBTSAt
MDcwMCwgU3RlcGhlbiBIZW1taW5nZXIgd3JvdGU6Cj4+IE9uIFRodSwgMjEgTWFyIDIwMTkgMTU6
MDQ6MzcgKzAyMDAKPj4gTGlyYW4gQWxvbiA8bGlyYW4uYWxvbkBvcmFjbGUuY29tPiB3cm90ZToK
Pj4gCj4+Pj4gCj4+Pj4gT0suIE5vdyB3aGF0IGhhcHBlbnMgaWYgbWFzdGVyIGlzIG1vdmVkIHRv
IGFub3RoZXIgbmFtZXNwYWNlPyBEbyB3ZSBuZWVkCj4+Pj4gdG8gbW92ZSB0aGUgc2xhdmVzIHRv
bz8gIAo+Pj4gCj4+PiBOby4gV2h5IHdvdWxkIHdlIG1vdmUgdGhlIHNsYXZlcz8gVGhlIHdob2xl
IHBvaW50IGlzIHRvIG1ha2UgbW9zdCBjdXN0b21lciBpZ25vcmUgdGhlIG5ldC1mYWlsb3ZlciBz
bGF2ZXMgYW5kIHJlbWFpbiB0aGVtIOKAnGhpZGRlbuKAnSBpbiB0aGVpciBkZWRpY2F0ZWQgbmV0
bnMuCj4+PiBXZSB3b27igJl0IHByZXZlbnQgY3VzdG9tZXIgZnJvbSBleHBsaWNpdGx5IG1vdmlu
ZyB0aGUgbmV0LWZhaWxvdmVyIHNsYXZlcyBvdXQgb2YgdGhpcyBuZXRucywgYnV0IHdlIHdpbGwg
bm90IG1vdmUgdGhlbSBvdXQgb2YgdGhlcmUgYXV0b21hdGljYWxseS4KPj4gCj4+IAo+PiBUaGUg
Mi1kZXZpY2UgbmV0dnNjIGFscmVhZHkgaGFuZGxlcyBjYXNlIHdoZXJlIG1hc3RlciBjaGFuZ2Vz
IG5hbWVzcGFjZS4KPiAKPiBJcyBpdCBieSBtb3Zpbmcgc2xhdmUgd2l0aCBpdD8KClNlZSBjMGE0
MWI4ODdjZTYgKCJodl9uZXR2c2M6IG1vdmUgVkYgdG8gc2FtZSBuYW1lc3BhY2UgYXMgbmV0dnNj
IGRldmljZeKAnSkuCkl0IHNlZW1zIHRoYXQgd2hlbiBOZXRWU0MgbWFzdGVyIG5ldGRldiBjaGFu
Z2VzIG5ldG5zLCB0aGUgVkYgaXMgbW92ZWQgdG8gdGhlIHNhbWUgbmV0bnMgYnkgdGhlIE5ldFZT
QyBkcml2ZXIuCktpbmRhIHRoZSBvcHBvc2l0ZSB0aGFuIHdoYXQgd2UgYXJlIHN1Z2dlc3Rpbmcg
aGVyZSB0byBtYWtlIHN1cmUgdGhhdCB0aGUgbmV0LWZhaWxvdmVyIG1hc3RlciBuZXRkZXYgaXMg
b24gYSBzZXBhcmF0ZQpuZXRucyB0aGFuIGl04oCZcyBzbGF2ZXMuLi4KCi1MaXJhbgoKPiAKPiAt
LSAKPiBNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
