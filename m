From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/6] virtio: wrap find_vqs
Date: Fri, 31 Mar 2017 12:04:55 +0800
Message-ID: <c388e4fd-2956-8894-31ec-31fe8b01e49f__41485.2547496141$1490933142$gmane$org@redhat.com>
References: <1490820507-8005-1-git-send-email-mst@redhat.com>
	<1490820507-8005-2-git-send-email-mst@redhat.com>
	<72f533a2-482d-1956-b0fe-254e273e1818@redhat.com>
	<20170330173146-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170330173146-mutt-send-email-mst@kernel.org>
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
Cc: Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, kvm@vger.kernel.org, David Airlie <airlied@linux.ie>, linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-scsi@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, "Martin K. Petersen" <martin.petersen@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE35bm0MDPmnIgzMOaXpSAyMjozMiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IE9uIFRodSwgTWFyIDMwLCAyMDE3IGF0IDAyOjAwOjA4UE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+Cj4+IE9uIDIwMTflubQwM+aciDMw5pelIDA0OjQ4LCBNaWNoYWVsIFMuIFRzaXJraW4g
d3JvdGU6Cj4+PiBXZSBhcmUgZ29pbmcgdG8gYWRkIG1vcmUgcGFyYW1ldGVycyB0byBmaW5kX3Zx
cywgbGV0J3Mgd3JhcCB0aGUgY2FsbCBzbwo+Pj4gd2UgZG9uJ3QgbmVlZCB0byB0d2VhayBhbGwg
ZHJpdmVycyBldmVyeSB0aW1lLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNp
cmtpbjxtc3RAcmVkaGF0LmNvbT4KPj4+IC0tLQo+PiBBIHF1aWNrIGdsYW5jZSBhbmQgaXQgbG9v
a3Mgb2ssIGJ1dCB3aGF0IHRoZSBiZW5lZml0IG9mIHRoaXMgc2VyaWVzLCBpcyBpdAo+PiByZXF1
aXJlZCBieSBvdGhlciBjaGFuZ2VzPwo+Pgo+PiBUaGFua3MKPiBZZXMgLSB0byBhdm9pZCB0b3Vj
aGluZyBhbGwgZGV2aWNlcyB3aGVuIGRvaW5nIHRoZSByZXN0IG9mCj4gdGhlIHBhdGNoc2V0LgoK
TWF5YmUgSSdtIG5vdCBjbGVhci4gSSBtZWFuIHRoZSBiZW5lZml0IG9mIHRoaXMgc2VyaWVzIG5v
dCB0aGlzIHNpbmdsZSAKcGF0Y2guIEkgZ3Vlc3MgaXQgbWF5IGJlIHVzZWQgYnkgeW91IHByb3Bv
c2FsIHRoYXQgYXZvaWQgcmVzZXQgd2hlbiBzZXQgClhEUD8gSWYgeWVzLCBkbyB3ZSByZWFsbHkg
d2FudCB0byBkcm9wIHNvbWUgcGFja2V0cyBhZnRlciBYRFAgaXMgc2V0PwoKVGhhbmtzCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
