From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/9] virtio_pci: use shared interrupts for virtqueues
Date: Fri, 3 Feb 2017 17:47:41 +0800
Message-ID: <12332f9d-2cf8-d761-032e-a5a89863fd09@redhat.com>
References: <1485504997-17584-1-git-send-email-hch@lst.de>
	<1485504997-17584-3-git-send-email-hch@lst.de>
	<da34883b-1069-2cfc-aaa3-6aaf3ee0ebf2@redhat.com>
	<20170203082606.GB26800@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170203082606.GB26800@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE35bm0MDLmnIgwM+aXpSAxNjoyNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4g
T24gRnJpLCBGZWIgMDMsIDIwMTcgYXQgMDM6NTQ6NTRQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPj4gT24gMjAxN+W5tDAx5pyIMjfml6UgMTY6MTYsIENocmlzdG9waCBIZWxsd2lnIHdyb3Rl
Ogo+Pj4gKwkJc25wcmludGYodnBfZGV2LT5tc2l4X25hbWVzW2kgKyAxXSwKPj4+ICsJCQkgc2l6
ZW9mKCp2cF9kZXYtPm1zaXhfbmFtZXMpLCAiJXMtJXMiLAo+Pj4gICAgCQkJIGRldl9uYW1lKCZ2
cF9kZXYtPnZkZXYuZGV2KSwgbmFtZXNbaV0pOwo+Pj4gICAgCQllcnIgPSByZXF1ZXN0X2lycShw
Y2lfaXJxX3ZlY3Rvcih2cF9kZXYtPnBjaV9kZXYsIG1zaXhfdmVjKSwKPj4+IC0JCQkJICB2cmlu
Z19pbnRlcnJ1cHQsIDAsCj4+PiAtCQkJCSAgdnBfZGV2LT5tc2l4X25hbWVzW21zaXhfdmVjXSwK
Pj4+IC0JCQkJICB2cXNbaV0pOwo+Pj4gKwkJCQkgIHZyaW5nX2ludGVycnVwdCwgSVJRRl9TSEFS
RUQsCj4+PiArCQkJCSAgdnBfZGV2LT5tc2l4X25hbWVzW2kgKyAxXSwgdnFzW2ldKTsKPj4gRG8g
d2UgbmVlZCB0byBjaGVjayBwZXJfdnFfdmVjdG9ycyBiZWZvcmUgZGVyZWZlcmVuY2luZyBtc2l4
X25hbWVzW2kgKyAxXSA/Cj4gTm8sIHdlIG5lZWQgdG8gYWxsb2NhdGUgdGhlIGFycmF5IGxhcmdl
ciBpbiB0aGF0IGNhc2UgYXMgd2FudCBwcm9wZXIKPiBuYW1lcyBmb3IgdGhlIGludGVycnVwdHMu
CgpDb25zaWRlciB0aGUgY2FzZSBvZiAhcGVyX3ZxX3ZlY3RvcnMsIHRoZSBzaXplIG9mIG1zaXhf
bmFtZXMgaXMgMiwgYnV0IApzbnByaW50ZiBjYW4gZG8gb3V0IG9mIGJvdW5kIGFjY2Vzc2luZyBo
ZXJlLiAoV2UgbmFtZSB0aGUgbXNpeCBzaGFyZWQgYnkgCnZpcnRxdWV1ZXMgd2l0aCBzb21ldGhp
bmcgbGlrZSAiJXMtdmlydHF1ZXVlcyIgYmVmb3JlIHRoZSBwYXRjaCkuCgpUaGFua3MKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
