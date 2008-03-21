From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC/PATCH 15/15] guest: virtio device support, and kvm hypercalls
Date: Sat, 22 Mar 2008 10:30:48 +1100
Message-ID: <200803221030.49457.rusty__19174.1805444055$1206142472$gmane$org@rustcorp.com.au>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<200803211124.49829.rusty@rustcorp.com.au>
	<200803210915.48029.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803210915.48029.borntraeger@de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Carsten Otte <cotte@de.ibm.com>, aliguori@us.ibm.com, EHRHARDT@de.ibm.com, arnd@arndb.de, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang, Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpZGF5IDIxIE1hcmNoIDIwMDggMTk6MTU6NDcgQ2hyaXN0aWFuIEJvcm50cmFlZ2VyIHdy
b3RlOgo+IEFtIEZyZWl0YWcsIDIxLiBNw6RyeiAyMDA4IHNjaHJpZWIgUnVzdHkgUnVzc2VsbDoK
PiA+IEhtbSwgcGFuaWMgb24gZGV2aWNlX3JlZ2lzdGVyIGZhaWwsIGJ1dCAtRU5PTUVNIG9uIGFk
ZF9zaGFyZWRfbWVtb3J5Cj4gPiBmYWlsPyBNeSB0aGVvcnkgd2FzIHRoYXQgc2luY2UgdGhpcyBp
cyBib290IHRpbWUsIHBhbmljKCkgaXMgdGhlIHJpZ2h0Cj4gPiB0aGluZy4KPgo+IEdvb2Qgc3Bv
dCwgYnV0IEkgYWdyZWUgd2l0aCBDYXJzdGVuLiBEcml2ZXJzIHNob3VsZCBub3QgcGFuaWMuIEkg
aGF2ZQo+IG1vZHVsZSBsb2FkL3VubG9hZCBjYXBhYmlsaXR5IG9uIG15IGxvbmcgdGVybSB0b2Rv
IGxpc3QsIGJ1dCBJIGNhbiBjaGFuZ2UKPiB0aGUgcGFuaWMgbm93LgoKWWVwLCB0aGF0IG1ha2Vz
IHNlbnNlLiAgRm9yIGxndWVzdCwgd2UgcGFuaWM6IGl0J3MgYWx3YXlzIGF0IGJvb3QgdGltZSBz
byBpZiAKaXQgZmFpbHMgd2Ugc2hvdWxkIGRpZSBlYXJseSB0byBtYWtlIGl0IGVhc2llciB0byBk
aWFnbm9zZSAoYW5kIHRoYXQgbWFrZXMgCnN1cmUgaXQgaGFwcGVucyBiZWZvcmUgd2UgbG9zZSBv
dXIgZWFybHkgY29uc29sZSkuCgpDaGVlcnMsClJ1c3R5LgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
