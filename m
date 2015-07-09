From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RFCv3 0/5] enable migration of driver pages
Date: Thu, 9 Jul 2015 17:02:48 +0300
Message-ID: <20150709140248.GA27109__25189.7705057219$1436483903$gmane$org@node.dhcp.inet.fi>
References: <1436243785-24105-1-git-send-email-gioh.kim@lge.com>
	<20150707153701.bfcde75108d1fb8aaedc8134@linux-foundation.org>
	<559C68B3.3010105@lge.com>
	<20150707170746.1b91ba0d07382cbc9ba3db92@linux-foundation.org>
	<559C6CA6.1050809@lge.com>
	<CAPM=9txmUJ58=CAxDhf12Y3Y8wz7CGBy-Bd4pQ8YAAKDsCxU8w@mail.gmail.com>
	<559DB86D.40000@lge.com>
	<20150709130848.GD21858@phenom.ffwll.local>
	<20150709133301.GG5176@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150709133301.GG5176@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: aquini@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, bfields@fieldses.org, Linux Memory Management List <linux-mm@kvack.org>, jlayton@poochiereds.net, Dave Airlie <airlied@gmail.com>, Hugh Dickins <hughd@google.com>, vbabka@suse.cz, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Gioh Kim <gioh.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, koct9i@gmail.com, open@kvack.org, gunho.lee@lge.com, LKML <linux-kernel@vger.kernel.org>, minchan@kernel.org, Gioh Kim <gurugio@hanmail.net>, ABI/API <linux-api@vger.kernel.org>, list@kvack.org, iamjoonsoo.kim@lge.com, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCBKdWwgMDksIDIwMTUgYXQgMDQ6MzM6MDFQTSArMDMwMCwgVmlsbGUgU3lyasOkbMOk
IHdyb3RlOgo+IE9uIFRodSwgSnVsIDA5LCAyMDE1IGF0IDAzOjA4OjQ4UE0gKzAyMDAsIERhbmll
bCBWZXR0ZXIgd3JvdGU6Cj4gPiBPbiBUaHUsIEp1bCAwOSwgMjAxNSBhdCAwODo1NToyNUFNICsw
OTAwLCBHaW9oIEtpbSB3cm90ZToKPiA+ID4gCj4gPiA+IAo+ID4gPiAyMDE1LTA3LTA5IOyYpOyg
hCA3OjQ37JeQIERhdmUgQWlybGllIOydtCjqsIApIOyTtCDquIA6Cj4gPiA+ID4+Pgo+ID4gPiA+
Pj4KPiA+ID4gPj4+Q2FuIHRoZSB2YXJpb3VzIGluLWtlcm5lbCBHUFUgZHJpdmVycyBiZW5lZml0
IGZyb20gdGhpcz8gIElmIHNvLCB3aXJpbmcKPiA+ID4gPj4+dXAgb25lIG9yIG1vcmUgb2YgdGhv
c2Ugd291bGQgYmUgaGVscGZ1bD8KPiA+ID4gPj4KPiA+ID4gPj4KPiA+ID4gPj5JJ20gc3VyZSB0
aGF0IG90aGVyIGluLWtlcm5lbCBHUFUgZHJpdmVycyBjYW4gaGF2ZSBiZW5lZml0Lgo+ID4gPiA+
Pkl0IG11c3QgYmUgaGVscGZ1bC4KPiA+ID4gPj4KPiA+ID4gPj5JZiBJIHdhcyBmYW1pbGlhciB3
aXRoIG90aGVyIGluLWtlcm5lbCBHUFUgZHJpdmVycyBjb2RlLCBJIHRyaWVkIHRvIHBhdGNoCj4g
PiA+ID4+dGhlbS4KPiA+ID4gPj5JdCdzIHRvbyBiYWQuCj4gPiA+ID4KPiA+ID4gPkknbGwgYnJp
bmcgZHJpLWRldmVsIGludG8gdGhlIGxvb3AgaGVyZS4KPiA+ID4gPgo+ID4gPiA+QVJNIEdQVSBk
ZXZlbG9wZXJzIHBsZWFzZSB0YWtlIGEgbG9vayBhdCB0aGlzIHN0dWZmLCBMYXVyZW50LCBSb2Is
Cj4gPiA+ID5FcmljIEkgc3VwcG9zZS4KPiA+ID4gCj4gPiA+IEkgc2VudCBhIHBhdGNoLCBodHRw
czovL2xrbWwub3JnL2xrbWwvMjAxNS8zLzI0LzExODIsIGFuZCBteSBvcGluaW9uIGFib3V0IGNv
bXBhY3Rpb24KPiA+ID4gdG8gQVJNIEdQVSBkZXZlbG9wZXJzIHZpYSBLb3JlYSBBUk0gYnJhbmNo
Lgo+ID4gPiBJIGdvdCBhIHJlcGx5IHRoYXQgdGhleSBoYWQgbm8gdGltZSB0byByZXZpZXcgaXQu
Cj4gPiA+IAo+ID4gPiBJIGhvcGUgdGhleSdyZSBpbnRlcmVzdGVkIHRvIHRoaXMgcGF0Y2guCj4g
PiAKPiA+IGk5MTUgZ3B1cyB3b3VsZCBzdXBwb3J0IDY0a2IgYW5kIDJtYiBwYWdlcywgYnV0IHdl
IG5ldmVyIGltcGxlbWVudGVkIHRoaXMuCj4gPiBJIGRvbid0IHRoaW5rIHRoaXMgd291bGQgZml0
IGZvciBnZW0gYmFzZWQgZHJpdmVycyBzaW5jZSBvdXIgYmFja2luZwo+ID4gc3RvcmFnZSBpcyBz
aG1lbWZzLiBTbyBpZiB3ZSB3YW50IHRvIGltcGxlbWVudCBwYWdlIG1pZ3JhdGlvbiAod2hpY2gg
d2UnZAo+ID4gcHJvYmFibHkgd2FudCB0byBtYWtlIGxhcmdlIHBhZ2VzIHdvcmsgd2VsbCkgd2Un
ZCBuZWVkIHRvIHBpbXAgc2htZW0gdG8gYSkKPiA+IGhhbmQgbGFyZ2UgcGFnZXMgdG8gdXMgYikg
Zm9yd2FyZCB0aGUgbWlncmF0ZSBjYWxscy4gUHJvYmFibHkgdGhhdCBtZWFucwo+ID4gd2UgbmVl
ZCB0byBidWlsZCBvdXIgb3duIGdlbWZzIHJldXNpbmcgc2htZW1mcyBjb2RlLgo+IAo+IEFGQUlL
IHRoZXJlIGFyZSBlZmZvcnRzIG9uZ29pbmcgdG8gbWFrZSBsYXJnZSBwYWdlcyB3b3JrIHdpdGgg
c2htZW0uCj4gCj4gS2lyaWxsLCBJSVJDIHlvdSBtZW50aW9uZWQgdGhhdCB5b3UncmUgd2VyZSBs
b29raW5nIGludG8gdGhpcyBhIHdoaWxlCj4gYmFjaz8KCkkgd29yayBpbiB0aGlzIGRpcmVjdGlv
biwgYnV0IGRvbid0IGhhdmUgYW55dGhpbmcgdG8gc2hvdyBhdCB0aGUgbW9tZW50LgoKSHVnaCBo
YXMgcHVibGlzaGVkIGhpcyBpbXBsZW1lbnRhdGlvbiBvZiBodWdlIHRtcGZzIGJhY2sgaW4gRmVi
cnVhcnk6CgpodHRwOi8vbGttbC5rZXJuZWwub3JnL2cvYWxwaW5lLkxTVS4yLjExLjE1MDIyMDE5
NDEzNDAuMTQ0MTRAZWdnbHkuYW52aWxzCgotLSAKIEtpcmlsbCBBLiBTaHV0ZW1vdgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
