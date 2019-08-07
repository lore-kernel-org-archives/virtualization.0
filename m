From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 00/12] block/bio, fs: convert put_page() to
	put_user_page*()
Date: Tue, 6 Aug 2019 23:34:48 -0700
Message-ID: <20190807063448.GA6002__24103.351908137$1565159762$gmane$org@infradead.org>
References: <20190724042518.14363-1-jhubbard@nvidia.com>
	<20190724061750.GA19397@infradead.org>
	<c35aa2bf-c830-9e57-78ca-9ce6fb6cb53b@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <c35aa2bf-c830-9e57-78ca-9ce6fb6cb53b@nvidia.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: John Hubbard <jhubbard@nvidia.com>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, linux-cifs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, v9fs-developer@lists.sourceforge.net, Eric Van Hensbergen <ericvh@gmail.com>, john.hubbard@gmail.com, linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, samba-technical@lists.samba.org, LKML <linux-kernel@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Anna
List-Id: virtualization@lists.linuxfoundation.org

T24gTW9uLCBBdWcgMDUsIDIwMTkgYXQgMDM6NTQ6MzVQTSAtMDcwMCwgSm9obiBIdWJiYXJkIHdy
b3RlOgo+IE9uIDcvMjMvMTkgMTE6MTcgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+ID4g
T24gVHVlLCBKdWwgMjMsIDIwMTkgYXQgMDk6MjU6MDZQTSAtMDcwMCwgam9obi5odWJiYXJkQGdt
YWlsLmNvbSB3cm90ZToKPiA+PiAqIFN0b3JlLCBpbiB0aGUgaW92X2l0ZXIsIGEgImNhbWUgZnJv
bSBndXAgKGdldF91c2VyX3BhZ2VzKSIgcGFyYW1ldGVyLgo+ID4+ICAgVGhlbiwgdXNlIHRoZSBu
ZXcgaW92X2l0ZXJfZ2V0X3BhZ2VzX3VzZV9ndXAoKSB0byByZXRyaWV2ZSBpdCB3aGVuCj4gPj4g
ICBpdCBpcyB0aW1lIHRvIHJlbGVhc2UgdGhlIHBhZ2VzLiBUaGF0IGFsbG93cyBjaG9vc2luZyBi
ZXR3ZWVuIHB1dF9wYWdlKCkKPiA+PiAgIGFuZCBwdXRfdXNlcl9wYWdlKigpLgo+ID4+Cj4gPj4g
KiBQYXNzIGluIG9uZSBtb3JlIHBpZWNlIG9mIGluZm9ybWF0aW9uIHRvIGJpb19yZWxlYXNlX3Bh
Z2VzOiBhICJmcm9tX2d1cCIKPiA+PiAgIHBhcmFtZXRlci4gU2ltaWxhciB1c2UgYXMgYWJvdmUu
Cj4gPj4KPiA+PiAqIENoYW5nZSB0aGUgYmxvY2sgbGF5ZXIsIGFuZCBzZXZlcmFsIGZpbGUgc3lz
dGVtcywgdG8gdXNlCj4gPj4gICBwdXRfdXNlcl9wYWdlKigpLgo+ID4gCj4gPiBJIHRoaW5rIHdl
IGNhbiBkbyB0aGlzIGluIGEgc2ltcGxlIGFuZCBiZXR0ZXIgd2F5LiAgV2UgaGF2ZSA1IElURVJf
Kgo+ID4gdHlwZXMuICBPZiB0aG9zZSBJVEVSX0RJU0NBUkQgYXMgdGhlIG5hbWUgc3VnZ2VzdHMg
bmV2ZXIgdXNlcyBwYWdlcywgc28KPiA+IHdlIGNhbiBza2lwIGhhbmRsaW5nIGl0LiAgSVRFUl9Q
SVBFIGlzIHJlamVjdGVkINGWbiB0aGUgZGlyZWN0IEkvTyBwYXRoLAo+ID4gd2hpY2ggbGVhdmVz
IHVzIHdpdGggdGhyZWUuCj4gPiAKPiAKPiBIaSBDaHJpc3RvcGgsCj4gCj4gQXJlIHlvdSB3b3Jr
aW5nIG9uIGFueXRoaW5nIGxpa2UgdGhpcz8KCkkgd2FzIGhvcGluZyBJIGNvdWxkIHN0ZWVyIHlv
dSB0b3dhcmRzIGl0LiAgQnV0IGlmIHlvdSBkb24ndCB3YW50IHRvIGRvCml0IHlvdXJzZWxmIEkn
bGwgYWRkIGl0IHRvIG15IGV2ZXIgZ3Jvd2luZyB0b2RvIGxpc3QuCgo+IE9yIG9uIHRoZSBwdXRf
dXNlcl9idmVjKCkgaWRlYT8KCkkgaGF2ZSBhIHByb3RvdHlwZSBmcm9tIHR3byBtb250aCBhZ286
CgpodHRwOi8vZ2l0LmluZnJhZGVhZC5vcmcvdXNlcnMvaGNoL21pc2MuZ2l0L3Nob3J0bG9nL3Jl
ZnMvaGVhZHMvZ3VwLWJ2ZWMKCmJ1dCB0aGF0IG9ubHkgc3Vydml2ZWQgdGhlIG1vc3QgYmFzaWMg
dGVzdGluZywgc28gaXQnbGwgbmVlZCBtb3JlIHdvcmssCndoaWNoIEknbSBub3Qgc3VyZSB3aGVu
IEknbGwgZmluZCB0aW1lIGZvci4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
