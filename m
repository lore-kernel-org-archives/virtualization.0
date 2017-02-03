From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/9] virtio_pci: use shared interrupts for virtqueues
Date: Fri, 3 Feb 2017 15:54:54 +0800
Message-ID: <da34883b-1069-2cfc-aaa3-6aaf3ee0ebf2__34432.1897639476$1486108506$gmane$org@redhat.com>
References: <1485504997-17584-1-git-send-email-hch@lst.de>
	<1485504997-17584-3-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1485504997-17584-3-git-send-email-hch@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>, mst@redhat.com
Cc: axboe@kernel.dk, pbonzini@redhat.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE35bm0MDHmnIgyN+aXpSAxNjoxNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4g
KwkJc25wcmludGYodnBfZGV2LT5tc2l4X25hbWVzW2kgKyAxXSwKPiArCQkJIHNpemVvZigqdnBf
ZGV2LT5tc2l4X25hbWVzKSwgIiVzLSVzIiwKPiAgIAkJCSBkZXZfbmFtZSgmdnBfZGV2LT52ZGV2
LmRldiksIG5hbWVzW2ldKTsKPiAgIAkJZXJyID0gcmVxdWVzdF9pcnEocGNpX2lycV92ZWN0b3Io
dnBfZGV2LT5wY2lfZGV2LCBtc2l4X3ZlYyksCj4gLQkJCQkgIHZyaW5nX2ludGVycnVwdCwgMCwK
PiAtCQkJCSAgdnBfZGV2LT5tc2l4X25hbWVzW21zaXhfdmVjXSwKPiAtCQkJCSAgdnFzW2ldKTsK
PiArCQkJCSAgdnJpbmdfaW50ZXJydXB0LCBJUlFGX1NIQVJFRCwKPiArCQkJCSAgdnBfZGV2LT5t
c2l4X25hbWVzW2kgKyAxXSwgdnFzW2ldKTsKCkRvIHdlIG5lZWQgdG8gY2hlY2sgcGVyX3ZxX3Zl
Y3RvcnMgYmVmb3JlIGRlcmVmZXJlbmNpbmcgbXNpeF9uYW1lc1tpICsgMV0gPwoKVGhhbmtzCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
