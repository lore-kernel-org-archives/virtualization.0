From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: Stats for XDP actions
Date: Thu, 20 Jun 2019 16:42:41 -0400
Message-ID: <87sgs46la6.fsf__15577.3686057486$1561063378$gmane$org@toke.dk>
References: <1548934830-2389-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20190131101516-mutt-send-email-mst@kernel.org>
	<20190131.094523.2248120325911339180.davem@davemloft.net>
	<20190131211555.3b15c81f@carbon>
	<b8c97120-851f-450f-dc71-59350236329e@gmail.com>
	<20190204125307.08492005@redhat.com>
	<bdcfedd6-465d-4485-e268-25c4ce6b9fcf@gmail.com>
	<87tvevpf0y.fsf@toke.dk>
	<44ae964a-d3dd-6b7f-4bcc-21e07525bf41@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <44ae964a-d3dd-6b7f-4bcc-21e07525bf41@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Ahern <dsahern@gmail.com>, Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, hawk@kernel.org, mst@redhat.com, netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux-foundation.org, Saeed Mahameed <saeedm@mellanox.com>, makita.toshiaki@lab.ntt.co.jp, Daniel Borkmann <borkmann@iogearbox.net>, David Miller <davem@davemloft.net>, Tariq Toukan <tariqt@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org

RGF2aWQgQWhlcm4gPGRzYWhlcm5AZ21haWwuY29tPiB3cml0ZXM6Cgo+IE9uIDQvMTgvMTkgODoy
NCBBTSwgVG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIHdyb3RlOgo+Pj4+Cj4+Pgo+Pj4gVW5kZXJz
dG9vZC4gSG9wZWZ1bGx5IGluIE1hcmNoIEkgd2lsbCBnZXQgc29tZSB0aW1lIHRvIGNvbWUgYmFj
ayB0byB0aGlzCj4+PiBhbmQgcHJvcG9zZSBhbiBpZGVhIG9uIHdoYXQgSSB3b3VsZCBsaWtlIHRv
IHNlZSAtIG5hbWVseSwgdGhlIGFkbWluIGhhcwo+Pj4gYSBjb25maWcgb3B0aW9uIGF0IGxvYWQg
dGltZSB0byBlbmFibGUgZHJpdmVyIGNvdW50ZXJzIHZlcnN1cyBjdXN0b20gbWFwCj4+PiBjb3Vu
dGVycy4gKG1lYW5pbmcgdGhlIG9wZXJhdG9yIG9mIHRoZSBub2RlIGNob29zZXMgc3RhbmRhcmQg
c3RhdHMgb3Zlcgo+Pj4gc3RyaWN0IHBlcmZvcm1hbmNlLikgQnV0IG9mIGNvdXJzZSB0aGF0IG1l
YW5zIHRoZSBkcml2ZXJzIGhhdmUgdGhlIGNvZGUKPj4+IHRvIGNvbGxlY3QgdGhvc2Ugc3RhdHMu
Cj4+IAo+PiBIaSBEYXZpZAo+PiAKPj4gSSBkb24ndCByZWNhbGwgc2VlaW5nIGFueSBmb2xsb3ct
dXAgb24gdGhpcy4gRGlkIHlvdSBoYXZlIGEgY2hhbmNlIHRvCj4+IGZvcm11bGF0ZSB5b3VyIGlk
ZWFzPyA6KQo+PiAKPgo+IE5vdCB5ZXQuIEFsbW9zdCBkb25lIHdpdGggdGhlIG5leHRob3AgY2hh
bmdlcy4gT25jZSB0aGF0IGlzIG91dCBvZiB0aGUKPiB3YXkgSSBjYW4gY29tZSBiYWNrIHRvIHRo
aXMuCgpQaW5nPyA6KQoKLVRva2UKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
