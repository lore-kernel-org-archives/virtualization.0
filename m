From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/9] virtio: allow drivers to request IRQ affinity when
	creating VQs
Date: Fri, 3 Feb 2017 16:01:04 +0800
Message-ID: <315fa499-2b2c-e883-4097-a8c2c415dfd4__23600.9180116982$1486108878$gmane$org@redhat.com>
References: <1485504997-17584-1-git-send-email-hch@lst.de>
	<1485504997-17584-6-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1485504997-17584-6-git-send-email-hch@lst.de>
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
QWRkIGEgc3RydWN0IGlycV9hZmZpbml0eSBwb2ludGVyIHRvIHRoZSBmaW5kX3ZxcyBtZXRob2Rz
LCB3aGljaCBpZiBzZXQKPiBpcyB1c2VkIHRvIHRlbGwgdGhlIFBDSSBsYXllciB0byBjcmVhdGUg
dGhlIE1TSS1YIHZlY3RvcnMgZm9yIG91ciBJL08KPiB2aXJ0cXVldWVzIHdpdGggdGhlIHByb3Bl
ciBhZmZpbml0eSBmcm9tIHRoZSBzdGFydC4gIENvbXBhcmVkIHRvIGFmdGVyCj4gdGhlIGZhY3Qg
YWZmaW5pdHkgaGludHMgdGhpcyBnaXZlcyB1cyBhbiBpbnN0YW50bHkgd29ya2luZyBzZXR1cCBh
bmQKPiBhbGxvd3MgdG8gYWxsb2NhdGUgdGhlIGlycSBkZXNjcml0b3JzIG5vZGUtbG9jYWwgYW5k
IGF2b2lkIGludGVyY29ubmVjdAo+IHRyYWZmaWMuICBMYXN0IGJ1dCBub3QgbGVhc3QgdGhpcyB3
aWxsIGFsbG93IGJsay1tcSBxdWV1ZXMgYXJlIGNyZWF0ZWQKPiBiYXNlZCBvbiB0aGUgaW50ZXJy
dXB0IGFmZmluaXR5IGZvciBzdG9yYWdlIGRyaXZlcnMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RvcGggSGVsbHdpZzxoY2hAbHN0LmRlPgo+IC0tLQoKUmV2aWV3ZWQtYnk6IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
