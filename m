From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [summary] virtio network device failover writeup
Date: Thu, 21 Mar 2019 11:50:48 -0400
Message-ID: <20190321114557-mutt-send-email-mst__5957.73627735383$1553183471$gmane$org@kernel.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190321084517.773a65fa@shemminger-XPS-13-9360>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: vuhuong@mellanox.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, Liran Alon <liran.alon@oracle.com>, Netdev <netdev@vger.kernel.org>, Si-Wei Liu <si-wei.liu@oracle.com>, boris.ostrovsky@oracle.com, David Miller <davem@davemloft.net>, ogerlitz@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCBNYXIgMjEsIDIwMTkgYXQgMDg6NDU6MTdBTSAtMDcwMCwgU3RlcGhlbiBIZW1taW5n
ZXIgd3JvdGU6Cj4gT24gVGh1LCAyMSBNYXIgMjAxOSAxNTowNDozNyArMDIwMAo+IExpcmFuIEFs
b24gPGxpcmFuLmFsb25Ab3JhY2xlLmNvbT4gd3JvdGU6Cj4gCj4gPiA+IAo+ID4gPiBPSy4gTm93
IHdoYXQgaGFwcGVucyBpZiBtYXN0ZXIgaXMgbW92ZWQgdG8gYW5vdGhlciBuYW1lc3BhY2U/IERv
IHdlIG5lZWQKPiA+ID4gdG8gbW92ZSB0aGUgc2xhdmVzIHRvbz8gIAo+ID4gCj4gPiBOby4gV2h5
IHdvdWxkIHdlIG1vdmUgdGhlIHNsYXZlcz8gVGhlIHdob2xlIHBvaW50IGlzIHRvIG1ha2UgbW9z
dCBjdXN0b21lciBpZ25vcmUgdGhlIG5ldC1mYWlsb3ZlciBzbGF2ZXMgYW5kIHJlbWFpbiB0aGVt
IOKAnGhpZGRlbuKAnSBpbiB0aGVpciBkZWRpY2F0ZWQgbmV0bnMuCj4gPiBXZSB3b27igJl0IHBy
ZXZlbnQgY3VzdG9tZXIgZnJvbSBleHBsaWNpdGx5IG1vdmluZyB0aGUgbmV0LWZhaWxvdmVyIHNs
YXZlcyBvdXQgb2YgdGhpcyBuZXRucywgYnV0IHdlIHdpbGwgbm90IG1vdmUgdGhlbSBvdXQgb2Yg
dGhlcmUgYXV0b21hdGljYWxseS4KPiAKPiAKPiBUaGUgMi1kZXZpY2UgbmV0dnNjIGFscmVhZHkg
aGFuZGxlcyBjYXNlIHdoZXJlIG1hc3RlciBjaGFuZ2VzIG5hbWVzcGFjZS4KCklzIGl0IGJ5IG1v
dmluZyBzbGF2ZSB3aXRoIGl0PwoKLS0gCk1TVApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
