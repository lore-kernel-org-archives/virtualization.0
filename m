From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/9] virtio_pci: use shared interrupts for virtqueues
Date: Fri, 3 Feb 2017 09:26:06 +0100
Message-ID: <20170203082606.GB26800@lst.de>
References: <1485504997-17584-1-git-send-email-hch@lst.de>
	<1485504997-17584-3-git-send-email-hch@lst.de>
	<da34883b-1069-2cfc-aaa3-6aaf3ee0ebf2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <da34883b-1069-2cfc-aaa3-6aaf3ee0ebf2@redhat.com>
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
Cc: axboe@kernel.dk, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, pbonzini@redhat.com, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCBGZWIgMDMsIDIwMTcgYXQgMDM6NTQ6NTRQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiAyMDE35bm0MDHmnIgyN+aXpSAxNjoxNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6
Cj4+ICsJCXNucHJpbnRmKHZwX2Rldi0+bXNpeF9uYW1lc1tpICsgMV0sCj4+ICsJCQkgc2l6ZW9m
KCp2cF9kZXYtPm1zaXhfbmFtZXMpLCAiJXMtJXMiLAo+PiAgIAkJCSBkZXZfbmFtZSgmdnBfZGV2
LT52ZGV2LmRldiksIG5hbWVzW2ldKTsKPj4gICAJCWVyciA9IHJlcXVlc3RfaXJxKHBjaV9pcnFf
dmVjdG9yKHZwX2Rldi0+cGNpX2RldiwgbXNpeF92ZWMpLAo+PiAtCQkJCSAgdnJpbmdfaW50ZXJy
dXB0LCAwLAo+PiAtCQkJCSAgdnBfZGV2LT5tc2l4X25hbWVzW21zaXhfdmVjXSwKPj4gLQkJCQkg
IHZxc1tpXSk7Cj4+ICsJCQkJICB2cmluZ19pbnRlcnJ1cHQsIElSUUZfU0hBUkVELAo+PiArCQkJ
CSAgdnBfZGV2LT5tc2l4X25hbWVzW2kgKyAxXSwgdnFzW2ldKTsKPgo+IERvIHdlIG5lZWQgdG8g
Y2hlY2sgcGVyX3ZxX3ZlY3RvcnMgYmVmb3JlIGRlcmVmZXJlbmNpbmcgbXNpeF9uYW1lc1tpICsg
MV0gPwoKTm8sIHdlIG5lZWQgdG8gYWxsb2NhdGUgdGhlIGFycmF5IGxhcmdlciBpbiB0aGF0IGNh
c2UgYXMgd2FudCBwcm9wZXIKbmFtZXMgZm9yIHRoZSBpbnRlcnJ1cHRzLgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
