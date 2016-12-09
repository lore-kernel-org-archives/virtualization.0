From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] linux/types.h: enable endian checks for all sparse builds
Date: Fri, 9 Dec 2016 22:45:55 +0200
Message-ID: <20161209224511-mutt-send-email-mst__19651.4749587097$1481316372$gmane$org@kernel.org>
References: <1481164052-28036-1-git-send-email-mst@redhat.com>
	<BLUPR02MB168374E98A6C86E43DF0BCFE81840@BLUPR02MB1683.namprd02.prod.outlook.com>
	<20161208075152-mutt-send-email-mst@kernel.org>
	<BLUPR02MB168304F8FBA50C916A6A4E6081840@BLUPR02MB1683.namprd02.prod.outlook.com>
	<20161208163658-mutt-send-email-mst@kernel.org>
	<6199215E-2AA4-4705-9552-5D61FE03F866@cavium.com>
	<BLUPR02MB168371E06EFA9AB34AA2C58181870@BLUPR02MB1683.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <BLUPR02MB168371E06EFA9AB34AA2C58181870@BLUPR02MB1683.namprd02.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "v9fs-developer@lists.sourceforge.net" <v9fs-developer@lists.sourceforge.net>, Asias He <asias@redhat.com>, "Madhani,
	Himanshu" <Himanshu.Madhani@cavium.com>, Arnd Bergmann <arnd@arndb.de>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, Jens Axboe <axboe@fb.com>, Mi
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCBEZWMgMDksIDIwMTYgYXQgMDM6MTg6MDJQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hl
IHdyb3RlOgo+IE9uIDEyLzA4LzE2IDIyOjQwLCBNYWRoYW5pLCBIaW1hbnNodSB3cm90ZToKPiA+
IFdl4oCZbGwgdGFrZSBhIGxvb2sgYW5kIHNlbmQgcGF0Y2hlcyB0byByZXNvbHZlIHRoZXNlIHdh
cm5pbmdzLgo+IAo+IFRoYW5rcyEKPiAKPiBCYXJ0Lgo+IAoKU291bmRzIGdvb2QuIEkgcG9zdGVk
IHdoYXQgSSBoYXZlIHNvIGZhciBzbyB0aGF0IHlvdSBjYW4Kc3RhcnQgZnJvbSB0aGF0LgoKLS0g
Ck1TVApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
