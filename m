From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v8] virtio_blk: add discard and write zeroes support
Date: Mon, 15 Oct 2018 02:27:40 -0700
Message-ID: <20181015092740.GA3964@infradead.org>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
	<20181012210628.226361-1-dverkamp@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181012210628.226361-1-dverkamp@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCBPY3QgMTIsIDIwMTggYXQgMDI6MDY6MjhQTSAtMDcwMCwgRGFuaWVsIFZlcmthbXAg
d3JvdGU6Cj4gRnJvbTogQ2hhbmdwZW5nIExpdSA8Y2hhbmdwZW5nLmxpdUBpbnRlbC5jb20+Cj4g
Cj4gSW4gY29tbWl0IDg4Yzg1NTM4LCAidmlydGlvLWJsazogYWRkIGRpc2NhcmQgYW5kIHdyaXRl
IHplcm9lcyBmZWF0dXJlcwo+IHRvIHNwZWNpZmljYXRpb24iIChodHRwczovL2dpdGh1Yi5jb20v
b2FzaXMtdGNzL3ZpcnRpby1zcGVjKSwgdGhlIHZpcnRpbwoKVGhlcmUgaXMgc29tZSBpc3N1ZXMg
aW4gdGhpcyBzcGVjLiAgRm9yIG9uZSB1c2luZyB0aGUgbXVsdGlwbGUgcmFuZ2VzCmFsc28gZm9y
IHdyaXRlIHplcm9lcyBpcyByYXRoZXIgaW5lZmZpY2llbnQuICBXcml0ZSB6ZXJvZXMgcmVhbGx5
IHNob3VsZAp1c2UgdGhlIHNhbWUgZm9ybWF0IGFzIHJlYWQgYW5kIHdyaXRlLgoKU2Vjb25kIHRo
ZSB1bm1hcCBmbGFnIGlzbid0IHByb3Blcmx5IHNwZWNpZmllZCBhdCBhbGwsIGFzIG5vdGhpbmcK
c2F5cyB0aGUgZGV2aWNlIG1heSBub3QgdW5tYXAgd2l0aG91dCB0aGUgdW5tYXAgZmxhZy4gIFBs
ZWFzZSB0YWtlCmEgbG9vayBhdCB0aGUgU0NTSSBvciBOVk1lINGVcGVjIGZvciBzb21lIGd1aWRh
bmNlLgoKPiArc3RhdGljIGlubGluZSBpbnQgdmlydGJsa19zZXR1cF9kaXNjYXJkX3dyaXRlX3pl
cm9lcyhzdHJ1Y3QgcmVxdWVzdCAqcmVxLAo+ICsJCQkJCQlib29sIHVubWFwKQoKV2h5IGlzIHRo
aXMgYW4gaW5saW5lIGZ1bmN0aW9uPwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
