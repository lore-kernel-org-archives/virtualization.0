From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [RFCv3 0/5] enable migration of driver pages
Date: Thu, 9 Jul 2015 16:33:01 +0300
Message-ID: <20150709133301.GG5176__39448.8149592236$1436483885$gmane$org@intel.com>
References: <1436243785-24105-1-git-send-email-gioh.kim@lge.com>
	<20150707153701.bfcde75108d1fb8aaedc8134@linux-foundation.org>
	<559C68B3.3010105@lge.com>
	<20150707170746.1b91ba0d07382cbc9ba3db92@linux-foundation.org>
	<559C6CA6.1050809@lge.com>
	<CAPM=9txmUJ58=CAxDhf12Y3Y8wz7CGBy-Bd4pQ8YAAKDsCxU8w@mail.gmail.com>
	<559DB86D.40000@lge.com>
	<20150709130848.GD21858@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150709130848.GD21858@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gioh Kim <gioh.kim@lge.com>, Dave Airlie <airlied@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Andrew Morton <akpm@linux-foundation.org>, jlayton@poochiereds.net, bfields@fieldses.org, vbabka@suse.cz, iamjoonsoo.kim@lge.com, Al Viro <viro@zeniv.linux.org.uk>, "Michael S. Tsirkin" <mst@redhat.com>, koct9i@gmail.com, minchan@kernel.org, aquini@redhat.com, linux-fsdevel@vger.kernel.org, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, open@kvack.org, list@kvack.org, ABI/API <linux-api@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, gunho.lee@lge.com, Gioh Kim <gurugio@hanmail.net>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCBKdWwgMDksIDIwMTUgYXQgMDM6MDg6NDhQTSArMDIwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBPbiBUaHUsIEp1bCAwOSwgMjAxNSBhdCAwODo1NToyNUFNICswOTAwLCBHaW9oIEtp
bSB3cm90ZToKPiA+IAo+ID4gCj4gPiAyMDE1LTA3LTA5IOyYpOyghCA3OjQ37JeQIERhdmUgQWly
bGllIOydtCjqsIApIOyTtCDquIA6Cj4gPiA+Pj4KPiA+ID4+Pgo+ID4gPj4+Q2FuIHRoZSB2YXJp
b3VzIGluLWtlcm5lbCBHUFUgZHJpdmVycyBiZW5lZml0IGZyb20gdGhpcz8gIElmIHNvLCB3aXJp
bmcKPiA+ID4+PnVwIG9uZSBvciBtb3JlIG9mIHRob3NlIHdvdWxkIGJlIGhlbHBmdWw/Cj4gPiA+
Pgo+ID4gPj4KPiA+ID4+SSdtIHN1cmUgdGhhdCBvdGhlciBpbi1rZXJuZWwgR1BVIGRyaXZlcnMg
Y2FuIGhhdmUgYmVuZWZpdC4KPiA+ID4+SXQgbXVzdCBiZSBoZWxwZnVsLgo+ID4gPj4KPiA+ID4+
SWYgSSB3YXMgZmFtaWxpYXIgd2l0aCBvdGhlciBpbi1rZXJuZWwgR1BVIGRyaXZlcnMgY29kZSwg
SSB0cmllZCB0byBwYXRjaAo+ID4gPj50aGVtLgo+ID4gPj5JdCdzIHRvbyBiYWQuCj4gPiA+Cj4g
PiA+SSdsbCBicmluZyBkcmktZGV2ZWwgaW50byB0aGUgbG9vcCBoZXJlLgo+ID4gPgo+ID4gPkFS
TSBHUFUgZGV2ZWxvcGVycyBwbGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhpcyBzdHVmZiwgTGF1cmVu
dCwgUm9iLAo+ID4gPkVyaWMgSSBzdXBwb3NlLgo+ID4gCj4gPiBJIHNlbnQgYSBwYXRjaCwgaHR0
cHM6Ly9sa21sLm9yZy9sa21sLzIwMTUvMy8yNC8xMTgyLCBhbmQgbXkgb3BpbmlvbiBhYm91dCBj
b21wYWN0aW9uCj4gPiB0byBBUk0gR1BVIGRldmVsb3BlcnMgdmlhIEtvcmVhIEFSTSBicmFuY2gu
Cj4gPiBJIGdvdCBhIHJlcGx5IHRoYXQgdGhleSBoYWQgbm8gdGltZSB0byByZXZpZXcgaXQuCj4g
PiAKPiA+IEkgaG9wZSB0aGV5J3JlIGludGVyZXN0ZWQgdG8gdGhpcyBwYXRjaC4KPiAKPiBpOTE1
IGdwdXMgd291bGQgc3VwcG9ydCA2NGtiIGFuZCAybWIgcGFnZXMsIGJ1dCB3ZSBuZXZlciBpbXBs
ZW1lbnRlZCB0aGlzLgo+IEkgZG9uJ3QgdGhpbmsgdGhpcyB3b3VsZCBmaXQgZm9yIGdlbSBiYXNl
ZCBkcml2ZXJzIHNpbmNlIG91ciBiYWNraW5nCj4gc3RvcmFnZSBpcyBzaG1lbWZzLiBTbyBpZiB3
ZSB3YW50IHRvIGltcGxlbWVudCBwYWdlIG1pZ3JhdGlvbiAod2hpY2ggd2UnZAo+IHByb2JhYmx5
IHdhbnQgdG8gbWFrZSBsYXJnZSBwYWdlcyB3b3JrIHdlbGwpIHdlJ2QgbmVlZCB0byBwaW1wIHNo
bWVtIHRvIGEpCj4gaGFuZCBsYXJnZSBwYWdlcyB0byB1cyBiKSBmb3J3YXJkIHRoZSBtaWdyYXRl
IGNhbGxzLiBQcm9iYWJseSB0aGF0IG1lYW5zCj4gd2UgbmVlZCB0byBidWlsZCBvdXIgb3duIGdl
bWZzIHJldXNpbmcgc2htZW1mcyBjb2RlLgoKQUZBSUsgdGhlcmUgYXJlIGVmZm9ydHMgb25nb2lu
ZyB0byBtYWtlIGxhcmdlIHBhZ2VzIHdvcmsgd2l0aCBzaG1lbS4KCktpcmlsbCwgSUlSQyB5b3Ug
bWVudGlvbmVkIHRoYXQgeW91J3JlIHdlcmUgbG9va2luZyBpbnRvIHRoaXMgYSB3aGlsZQpiYWNr
PwoKLS0gClZpbGxlIFN5cmrDpGzDpApJbnRlbCBPVEMKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
