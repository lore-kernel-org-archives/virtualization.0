From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [RFC/PATCH 15/15] guest: virtio device support, and kvm hypercalls
Date: Sat, 22 Mar 2008 08:36:39 +0100
Message-ID: <47E4B707.4060204__2537.59462289072$1206171549$gmane$org@de.ibm.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<200803211124.49829.rusty@rustcorp.com.au>
	<200803210915.48029.borntraeger@de.ibm.com>
	<200803221030.49457.rusty@rustcorp.com.au>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803221030.49457.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: aliguori@us.ibm.com, Christian Ehrhardt <EHRHARDT@de.ibm.com>, arnd@arndb.de, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, borntrae@linux.vnet.ibm.com, rvdheij@gmail.com, Olaf Schnapper <os@de.ibm.com>, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

UnVzdHkgUnVzc2VsbCB3cm90ZToKPiBPbiBGcmlkYXkgMjEgTWFyY2ggMjAwOCAxOToxNTo0NyBD
aHJpc3RpYW4gQm9ybnRyYWVnZXIgd3JvdGU6Cj4+IEFtIEZyZWl0YWcsIDIxLiBNw6RyeiAyMDA4
IHNjaHJpZWIgUnVzdHkgUnVzc2VsbDoKPj4+IEhtbSwgcGFuaWMgb24gZGV2aWNlX3JlZ2lzdGVy
IGZhaWwsIGJ1dCAtRU5PTUVNIG9uIGFkZF9zaGFyZWRfbWVtb3J5Cj4+PiBmYWlsPyBNeSB0aGVv
cnkgd2FzIHRoYXQgc2luY2UgdGhpcyBpcyBib290IHRpbWUsIHBhbmljKCkgaXMgdGhlIHJpZ2h0
Cj4+PiB0aGluZy4KPj4gR29vZCBzcG90LCBidXQgSSBhZ3JlZSB3aXRoIENhcnN0ZW4uIERyaXZl
cnMgc2hvdWxkIG5vdCBwYW5pYy4gSSBoYXZlCj4+IG1vZHVsZSBsb2FkL3VubG9hZCBjYXBhYmls
aXR5IG9uIG15IGxvbmcgdGVybSB0b2RvIGxpc3QsIGJ1dCBJIGNhbiBjaGFuZ2UKPj4gdGhlIHBh
bmljIG5vdy4KPiAKPiBZZXAsIHRoYXQgbWFrZXMgc2Vuc2UuICBGb3IgbGd1ZXN0LCB3ZSBwYW5p
YzogaXQncyBhbHdheXMgYXQgYm9vdCB0aW1lIHNvIGlmIAo+IGl0IGZhaWxzIHdlIHNob3VsZCBk
aWUgZWFybHkgdG8gbWFrZSBpdCBlYXNpZXIgdG8gZGlhZ25vc2UgKGFuZCB0aGF0IG1ha2VzIAo+
IHN1cmUgaXQgaGFwcGVucyBiZWZvcmUgd2UgbG9zZSBvdXIgZWFybHkgY29uc29sZSkuCkRpYW5n
bm9zdGljIGlzIGVhc3kgaGVyZSBhdCBhbnkgdGltZSBkdXJpbmcgdGhlIGJvb3QgcHJvY2Vzczog
d2UndmUgCmdvdCBvdXIgc3RvcmUgc3RhdHVzIGlvY3RsIHRoYXQgdXNlcnNwYWNlIGNhbGxzIGFm
dGVyIGd1ZXN0IGV4ZWN1dGlvbiAKaGFzIGVuZGVkLiBJdCBjYXVzZXMgYWxsIGNwdXMgdG8gc3Rv
cmUgdGhlaXIgcmVnaXN0ZXIgY29udGVudCBhbmQgc3VjaCAKaW50byB0aGUgY3B1J3MgbG93Y29y
ZSBhcmVhLiBUaGVuIGl0IHdyaXRlcyBvdXQgb3VyIG1lbW9yeSB0byBhIGR1bXAgCmltYWdlLCB3
aGljaCBsa2NkdXRpbHMgYW5kL29yIGNyYXNoIGNhbiByZWFkLgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
