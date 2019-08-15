From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V5 0/9] Fixes for vhost metadata acceleration
Date: Thu, 15 Aug 2019 11:28:05 +0800
Message-ID: <bba46127-ea43-f9f3-eece-0910243782c5@redhat.com>
References: <20190809054851.20118-1-jasowang@redhat.com>
	<20190810134948-mutt-send-email-mst@kernel.org>
	<360a3b91-1ac5-84c0-d34b-a4243fa748c4@redhat.com>
	<20190812054429-mutt-send-email-mst@kernel.org>
	<20190812130252.GE24457@ziepe.ca>
	<9a9641fe-b48f-f32a-eecc-af9c2f4fbe0e@redhat.com>
	<20190813115707.GC29508@ziepe.ca>
	<20190813164105.GD22640@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190813164105.GD22640@infradead.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvOC8xNCDkuIrljYgxMjo0MSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24g
VHVlLCBBdWcgMTMsIDIwMTkgYXQgMDg6NTc6MDdBTSAtMDMwMCwgSmFzb24gR3VudGhvcnBlIHdy
b3RlOgo+PiBPbiBUdWUsIEF1ZyAxMywgMjAxOSBhdCAwNDozMTowN1BNICswODAwLCBKYXNvbiBX
YW5nIHdyb3RlOgo+Pgo+Pj4gV2hhdCBraW5kIG9mIGlzc3VlcyBkbyB5b3Ugc2VlPyBTcGlubG9j
ayBpcyB0byBzeW5jaHJvbml6ZSBHVVAgd2l0aCBNTVUKPj4+IG5vdGlmaWVyIGluIHRoaXMgc2Vy
aWVzLgo+PiBBIEdVUCB0aGF0IGNhbid0IHNsZWVwIGNhbid0IHBhZ2VmYXVsdCB3aGljaCBtYWtl
cyBpdCBhIHJlYWxseSB3ZWlyZAo+PiBwYXR0ZXJuCj4gZ2V0X3VzZXJfcGFnZXMvZ2V0X3VzZXJf
cGFnZXNfZmFzdCBtdXN0IG5vdCBiZSBjYWxsZWQgdW5kZXIgYSBzcGlubG9jay4KPiBXZSBoYXZl
IHRoZSBzb21ld2hhdCBtaXNuYW1lZCBfX2dldF91c2VyX3BhZ2VfZmFzdCB0aGF0IGp1c3QgZG9l
cyBhCj4gbG9va3VwIGZvciBleGlzdGluZyBwYWdlcyBhbmQgbmV2ZXIgZmF1bHRzIGZvciBhIGZl
dyBwbGFjZXMgdGhhdCBuZWVkCj4gdG8gZG8gdGhhdCBsb29rdXAgZnJvbSBjb250ZXh0cyB3aGVy
ZSB3ZSBjYW4ndCBzbGVlcC4KCgpZZXMsIEkgZG8gdXNlIF9fZ2V0X3VzZXJfcGFnZXNfZmFzdCgp
IGluIHRoZSBjb2RlLgoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
