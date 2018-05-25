From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v5 0/5] virtio: support packed ring
Date: Fri, 25 May 2018 10:31:26 +0800
Message-ID: <b19e0888-61dc-c067-0b05-fde3b5eb0902__3683.05172673917$1527215391$gmane$org@redhat.com>
References: <20180522081648.14768-1-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180522081648.14768-1-tiwei.bie@intel.com>
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
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDXmnIgyMuaXpSAxNjoxNiwgVGl3ZWkgQmllIHdyb3RlOgo+IEhlbGxvIGV2
ZXJ5b25lLAo+Cj4gVGhpcyBSRkMgaW1wbGVtZW50cyBwYWNrZWQgcmluZyBzdXBwb3J0IGluIHZp
cnRpbyBkcml2ZXIuCj4KPiBTb21lIHNpbXBsZSBmdW5jdGlvbmFsIHRlc3RzIGhhdmUgYmVlbiBk
b25lIHdpdGggSmFzb24ncwo+IHBhY2tlZCByaW5nIGltcGxlbWVudGF0aW9uIGluIHZob3N0IChS
RkMgdjQpOgo+Cj4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgvNS8xNi81MDEKPgo+IEJvdGgg
b2YgcGluZyBhbmQgbmV0cGVyZiB3b3JrZWQgYXMgZXhwZWN0ZWQgdy8gRVZFTlRfSURYCj4gZGlz
YWJsZWQuIFBpbmcgd29ya2VkIGFzIGV4cGVjdGVkIHcvIEVWRU5UX0lEWCBlbmFibGVkLAo+IGJ1
dCBuZXRwZXJmIGRpZG4ndCAoQSBoYWNrIGhhcyBiZWVuIGFkZGVkIGluIHRoZSBkcml2ZXIKPiB0
byBtYWtlIG5ldHBlcmYgdGVzdCBwYXNzIGluIHRoaXMgY2FzZS4gVGhlIGhhY2sgY2FuIGJlCj4g
Zm91bmQgYnkgYGdyZXAgLXJ3IFhYWGAgaW4gdGhlIGNvZGUpLgoKTG9va3MgbGlrZSB0aGlzIGlz
IGJlY2F1c2UgYSBidWcgaW4gdmhvc3Qgd2hpY2ggd3JvbmdseSB0cmFjayAKc2lnbmFsbGVkX3Vz
ZWQgYW5kIG1heSBtaXNzIGFuIGludGVycnVwdC4gQWZ0ZXIgZml4aW5nIHRoYXQsIGJvdGggc2lk
ZSAKd29ya3MgbGlrZSBhIGNoYXJtLgoKSSdtIHRlc3RpbmcgdklPTU1VIGFuZCB6ZXJvY29weSwg
YW5kIHdpbGwgcG9zdCBhIG5ldyB2ZXJzaW9uIHNob3J0bHkuIAooSG9wZSBpdCB3b3VsZCBiZSB0
aGUgbGFzdCBSRkMgdmVyc2lvbikuCgpUaGFua3MKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
