From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v8] virtio_blk: add discard and write zeroes support
Date: Fri, 26 Oct 2018 01:28:54 +0200
Message-ID: <486afcff-a8bd-a05b-e331-e395d4d14853@redhat.com>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
	<20181012210628.226361-1-dverkamp@chromium.org>
	<20181015092740.GA3964@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181015092740.GA3964@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>, Daniel Verkamp <dverkamp@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMTUvMTAvMjAxOCAxMToyNywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gVGhlcmUgaXMg
c29tZSBpc3N1ZXMgaW4gdGhpcyBzcGVjLiAgRm9yIG9uZSB1c2luZyB0aGUgbXVsdGlwbGUgcmFu
Z2VzCj4gYWxzbyBmb3Igd3JpdGUgemVyb2VzIGlzIHJhdGhlciBpbmVmZmljaWVudC4gIFdyaXRl
IHplcm9lcyByZWFsbHkgc2hvdWxkCj4gdXNlIHRoZSBzYW1lIGZvcm1hdCBhcyByZWFkIGFuZCB3
cml0ZS4KCldoYXQgbWFrZXMgaXQgaW5lZmZpY2llbnQ/Cgo+IFNlY29uZCB0aGUgdW5tYXAgZmxh
ZyBpc24ndCBwcm9wZXJseSBzcGVjaWZpZWQgYXQgYWxsLCBhcyBub3RoaW5nCj4gc2F5cyB0aGUg
ZGV2aWNlIG1heSBub3QgdW5tYXAgd2l0aG91dCB0aGUgdW5tYXAgZmxhZy4gIFBsZWFzZSB0YWtl
Cj4gYSBsb29rIGF0IHRoZSBTQ1NJIG9yIE5WTWUg0ZVwZWMgZm9yIHNvbWUgZ3VpZGFuY2UuCgpU
aGFua3MsIEknbGwgc3VibWl0IGEgcGF0Y2ggZm9yIHRoaXMuCgpQYW9sbwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
