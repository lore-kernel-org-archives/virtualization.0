From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/9] virtio_pci: use shared interrupts for virtqueues
Date: Fri, 3 Feb 2017 17:56:30 +0800
Message-ID: <c0f97bcc-9675-c725-6d13-9b1181aafced__12609.8967776217$1486115799$gmane$org@redhat.com>
References: <1485504997-17584-1-git-send-email-hch@lst.de>
	<1485504997-17584-3-git-send-email-hch@lst.de>
	<da34883b-1069-2cfc-aaa3-6aaf3ee0ebf2@redhat.com>
	<20170203082606.GB26800@lst.de>
	<12332f9d-2cf8-d761-032e-a5a89863fd09@redhat.com>
	<20170203095219.GA28483@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170203095219.GA28483@lst.de>
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

CgpPbiAyMDE35bm0MDLmnIgwM+aXpSAxNzo1MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4g
T24gRnJpLCBGZWIgMDMsIDIwMTcgYXQgMDU6NDc6NDFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPj4+IE5vLCB3ZSBuZWVkIHRvIGFsbG9jYXRlIHRoZSBhcnJheSBsYXJnZXIgaW4gdGhhdCBj
YXNlIGFzIHdhbnQgcHJvcGVyCj4+PiBuYW1lcyBmb3IgdGhlIGludGVycnVwdHMuCj4+IENvbnNp
ZGVyIHRoZSBjYXNlIG9mICFwZXJfdnFfdmVjdG9ycywgdGhlIHNpemUgb2YgbXNpeF9uYW1lcyBp
cyAyLCBidXQKPj4gc25wcmludGYgY2FuIGRvIG91dCBvZiBib3VuZCBhY2Nlc3NpbmcgaGVyZS4g
KFdlIG5hbWUgdGhlIG1zaXggc2hhcmVkIGJ5Cj4+IHZpcnRxdWV1ZXMgd2l0aCBzb21ldGhpbmcg
bGlrZSAiJXMtdmlydHF1ZXVlcyIgYmVmb3JlIHRoZSBwYXRjaCkuCj4gWWVzLCB0aGF0J3Mgd2hh
dCBJIG1lYW50IGFib3ZlIC0gd2UgbmVlZCB0byBhbGxvY2F0ZSBhIGxhcmdlIGFycmF5Cj4gc3Rh
cnRpbmcgd2l0aCB0aGlzIHBhdGNoLiAgSSdsbCBmaXggaXQgdXAgZm9yIHRoZSBuZXh0IHZlcnNp
b24uCgpJIHNlZS4KClRoYW5rcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
