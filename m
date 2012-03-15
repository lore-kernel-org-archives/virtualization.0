From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 0001/001] xen: multi page ring support
	for block devices
Date: Thu, 15 Mar 2012 08:09:23 +0000
Message-ID: <4F61B1C302000078000788D2@nat28.tlf.novell.com>
References: <1330701099-18281-1-git-send-email-santoshprasadnayak@gmail.com>
	<7914B38A4445B34AA16EB9F1352942F1010A1FA12364@SJCPMAILBOX01.citrite.net>
	<4F55DA3E0200007800076916@nat28.tlf.novell.com>
	<96ED0F5B-AE7D-4C8E-A8E1-D386B2DED212@scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <96ED0F5B-AE7D-4C8E-A8E1-D386B2DED212@scsiguy.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: "jeremy@goop.org" <jeremy@goop.org>, Ian Campbell <Ian.Campbell@citrix.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "waldi@debian.org" <waldi@debian.org>, "joe.jin@oracle.com" <joe.jin@oracle.com>, "weiyi.huang@gmail.com" <weiyi.huang@gmail.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Paul Durrant <Paul.Durrant@citrix.com>, David Vrabel <david.vrabel@citrix.com>, Santosh Jodh <Santosh.Jodh@citrix.com>, "dgdegra@tycho.nsa.gov" <dgdegra@tycho.nsa.gov>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>, "lersek@redhat.com" <lersek@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Pj4+IE9uIDE0LjAzLjEyIGF0IDE4OjE3LCAiSnVzdGluIFQuIEdpYmJzIiA8Z2liYnNAc2NzaWd1
eS5jb20+IHdyb3RlOgo+IE9uIE1hciA2LCAyMDEyLCBhdCAxOjM0IEFNLCBKYW4gQmV1bGljaCB3
cm90ZToKPiAKPj4+Pj4gT24gMDUuMDMuMTIgYXQgMjI6NDksIFNhbnRvc2ggSm9kaCA8U2FudG9z
aC5Kb2RoQGNpdHJpeC5jb20+IHdyb3RlOgo+IAo+IOKApgo+IAo+Pj4gKyAgICAgICB9Cj4+PiAr
Cj4+PiAgICAgICAgLyogQ3JlYXRlIHNoYXJlZCByaW5nLCBhbGxvYyBldmVudCBjaGFubmVsLiAq
Lwo+Pj4gICAgICAgIGVyciA9IHNldHVwX2Jsa3JpbmcoZGV2LCBpbmZvKTsKPj4+ICAgICAgICBp
ZiAoZXJyKQo+Pj4gQEAgLTg4OSwxMiArOTE2LDM1IEBAIGFnYWluOgo+Pj4gICAgICAgICAgICAg
ICAgZ290byBkZXN0cm95X2Jsa3Jpbmc7Cj4+PiAgICAgICAgfQo+Pj4gCj4+PiAtICAgICAgIGVy
ciA9IHhlbmJ1c19wcmludGYoeGJ0LCBkZXYtPm5vZGVuYW1lLAo+Pj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJyaW5nLXJlZiIsICIldSIsIGluZm8tPnJpbmdfcmVmKTsKPj4+IC0gICAg
ICAgaWYgKGVycikgewo+Pj4gLSAgICAgICAgICAgICAgIG1lc3NhZ2UgPSAid3JpdGluZyByaW5n
LXJlZiI7Cj4+PiAtICAgICAgICAgICAgICAgZ290byBhYm9ydF90cmFuc2FjdGlvbjsKPj4+ICsg
ICAgICAgaWYgKGxlZ2FjeV9iYWNrZW5kKSB7Cj4+IAo+PiBXaHkgbm90IHVzZSB0aGUgc2ltcGxl
ciBpbnRlcmZhY2UgYWx3YXlzIHdoZW4gaW5mby0+cmluZ19vcmRlciA9PSAwPwo+IAo+IEJlY2F1
c2UsIGFzIEkganVzdCBmb3VuZCBvdXQgdG9kYXkgdmlhIGEgRnJlZUJTRCBidWcgcmVwb3J0LCB0
aGF0J3MKPiBub3QgaG93IFhlblNlcnZlciB3b3Jrcy4gIElmIHRoZSBmcm9udC1lbmQgcHVibGlz
aGVzICJyaW5nLXBhZ2Utb3JkZXIiLAo+IHRoZSBiYWNrZW5kIGFzc3VtZXMgdGhlICJyaW5nLXJl
Zk5OIiBYZW5TdG9yZSBub2RlcyBhcmUgaW4gZWZmZWN0LAo+IGV2ZW4gaWYgdGhlIG9yZGVyIGlz
IDAuCgpJIHdhcyBjZXJ0YWlubHkgaW1wbHlpbmcgdG8gbm90IHdyaXRlIHRoZSByaW5nLXBhZ2Ut
b3JkZXIgYW5kCm51bS1yaW5nLXBhZ2VzIG5vZGVzIGluIHRoYXQgY2FzZS4KCj4gSSdtIHdvcmtp
bmcgb24gYSBkb2N1bWVudGF0aW9uIHVwZGF0ZSBmb3IgYmxraWYuaCBub3cuCj4gCj4gPHNpZ2g+
Cj4gCj4gLS0KPiBKdXN0aW4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
