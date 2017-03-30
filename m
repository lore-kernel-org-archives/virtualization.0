From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/6] virtio: wrap find_vqs
Date: Thu, 30 Mar 2017 17:32:19 +0300
Message-ID: <20170330173146-mutt-send-email-mst__19771.3622976609$1490884360$gmane$org@kernel.org>
References: <1490820507-8005-1-git-send-email-mst@redhat.com>
	<1490820507-8005-2-git-send-email-mst@redhat.com>
	<72f533a2-482d-1956-b0fe-254e273e1818@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <72f533a2-482d-1956-b0fe-254e273e1818@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, kvm@vger.kernel.org, David Airlie <airlied@linux.ie>, linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-scsi@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, "Martin K. Petersen" <martin.petersen@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCBNYXIgMzAsIDIwMTcgYXQgMDI6MDA6MDhQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiAKPiBPbiAyMDE35bm0MDPmnIgzMOaXpSAwNDo0OCwgTWljaGFlbCBTLiBUc2lya2lu
IHdyb3RlOgo+ID4gV2UgYXJlIGdvaW5nIHRvIGFkZCBtb3JlIHBhcmFtZXRlcnMgdG8gZmluZF92
cXMsIGxldCdzIHdyYXAgdGhlIGNhbGwgc28KPiA+IHdlIGRvbid0IG5lZWQgdG8gdHdlYWsgYWxs
IGRyaXZlcnMgZXZlcnkgdGltZS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBTLiBU
c2lya2luPG1zdEByZWRoYXQuY29tPgo+ID4gLS0tCj4gCj4gQSBxdWljayBnbGFuY2UgYW5kIGl0
IGxvb2tzIG9rLCBidXQgd2hhdCB0aGUgYmVuZWZpdCBvZiB0aGlzIHNlcmllcywgaXMgaXQKPiBy
ZXF1aXJlZCBieSBvdGhlciBjaGFuZ2VzPwo+IAo+IFRoYW5rcwoKWWVzIC0gdG8gYXZvaWQgdG91
Y2hpbmcgYWxsIGRldmljZXMgd2hlbiBkb2luZyB0aGUgcmVzdCBvZgp0aGUgcGF0Y2hzZXQuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
