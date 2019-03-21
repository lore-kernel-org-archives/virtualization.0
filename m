From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [summary] virtio network device failover writeup
Date: Thu, 21 Mar 2019 08:45:17 -0700
Message-ID: <20190321084517.773a65fa__27241.242797912$1553183138$gmane$org@shemminger-XPS-13-9360>
References: <20190320061632-mutt-send-email-mst@kernel.org>
	<E0606AE7-7DE2-47C7-B64A-8161FD814277@oracle.com>
	<20190320100747-mutt-send-email-mst@kernel.org>
	<36772E22-7A8F-4C42-A731-398E3204B418@oracle.com>
	<20190320180641-mutt-send-email-mst@kernel.org>
	<B3FB267A-2DC0-4A4C-8193-7F420BC9791B@oracle.com>
	<20190321044920-mutt-send-email-mst@kernel.org>
	<CD40EA09-242D-41E1-8BD2-4FF4BB4D1986@oracle.com>
	<20190321082532-mutt-send-email-mst@kernel.org>
	<BB2B938F-D2F0-47F8-B651-70EC8A19BC6B@oracle.com>
	<20190321085159-mutt-send-email-mst@kernel.org>
	<2939FB15-720A-4C9E-92B7-2DBA139DDE0F@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2939FB15-720A-4C9E-92B7-2DBA139DDE0F@oracle.com>
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
Cc: vuhuong@mellanox.com, Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, Si-Wei Liu <si-wei.liu@oracle.com>, boris.ostrovsky@oracle.com, David Miller <davem@davemloft.net>, ogerlitz@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCAyMSBNYXIgMjAxOSAxNTowNDozNyArMDIwMApMaXJhbiBBbG9uIDxsaXJhbi5hbG9u
QG9yYWNsZS5jb20+IHdyb3RlOgoKPiA+IAo+ID4gT0suIE5vdyB3aGF0IGhhcHBlbnMgaWYgbWFz
dGVyIGlzIG1vdmVkIHRvIGFub3RoZXIgbmFtZXNwYWNlPyBEbyB3ZSBuZWVkCj4gPiB0byBtb3Zl
IHRoZSBzbGF2ZXMgdG9vPyAgCj4gCj4gTm8uIFdoeSB3b3VsZCB3ZSBtb3ZlIHRoZSBzbGF2ZXM/
IFRoZSB3aG9sZSBwb2ludCBpcyB0byBtYWtlIG1vc3QgY3VzdG9tZXIgaWdub3JlIHRoZSBuZXQt
ZmFpbG92ZXIgc2xhdmVzIGFuZCByZW1haW4gdGhlbSDigJxoaWRkZW7igJ0gaW4gdGhlaXIgZGVk
aWNhdGVkIG5ldG5zLgo+IFdlIHdvbuKAmXQgcHJldmVudCBjdXN0b21lciBmcm9tIGV4cGxpY2l0
bHkgbW92aW5nIHRoZSBuZXQtZmFpbG92ZXIgc2xhdmVzIG91dCBvZiB0aGlzIG5ldG5zLCBidXQg
d2Ugd2lsbCBub3QgbW92ZSB0aGVtIG91dCBvZiB0aGVyZSBhdXRvbWF0aWNhbGx5LgoKClRoZSAy
LWRldmljZSBuZXR2c2MgYWxyZWFkeSBoYW5kbGVzIGNhc2Ugd2hlcmUgbWFzdGVyIGNoYW5nZXMg
bmFtZXNwYWNlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
