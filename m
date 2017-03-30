From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/6] virtio: wrap find_vqs
Date: Thu, 30 Mar 2017 14:00:08 +0800
Message-ID: <72f533a2-482d-1956-b0fe-254e273e1818__3255.09079634703$1490853645$gmane$org@redhat.com>
References: <1490820507-8005-1-git-send-email-mst@redhat.com>
	<1490820507-8005-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1490820507-8005-2-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, kvm@vger.kernel.org, David Airlie <airlied@linux.ie>, linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-scsi@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, "Martin K. Petersen" <martin.petersen@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-crypto@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE35bm0MDPmnIgzMOaXpSAwNDo0OCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IFdlIGFyZSBnb2luZyB0byBhZGQgbW9yZSBwYXJhbWV0ZXJzIHRvIGZpbmRfdnFzLCBsZXQncyB3
cmFwIHRoZSBjYWxsIHNvCj4gd2UgZG9uJ3QgbmVlZCB0byB0d2VhayBhbGwgZHJpdmVycyBldmVy
eSB0aW1lLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBTLiBUc2lya2luPG1zdEByZWRoYXQu
Y29tPgo+IC0tLQoKQSBxdWljayBnbGFuY2UgYW5kIGl0IGxvb2tzIG9rLCBidXQgd2hhdCB0aGUg
YmVuZWZpdCBvZiB0aGlzIHNlcmllcywgaXMgCml0IHJlcXVpcmVkIGJ5IG90aGVyIGNoYW5nZXM/
CgpUaGFua3MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
