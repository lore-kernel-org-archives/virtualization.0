From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 00/12] block/bio, fs: convert put_page() to
	put_user_page*()
Date: Tue, 23 Jul 2019 23:17:50 -0700
Message-ID: <20190724061750.GA19397__20932.3873090156$1563949096$gmane$org@infradead.org>
References: <20190724042518.14363-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190724042518.14363-1-jhubbard@nvidia.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: john.hubbard@gmail.com
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, linux-cifs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, v9fs-developer@lists.sourceforge.net, Eric Van Hensbergen <ericvh@gmail.com>, John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, samba-technical@lists.samba.org, LKML <linux-kernel@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Anna Schumaker <anna.schumaker@n>
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlLCBKdWwgMjMsIDIwMTkgYXQgMDk6MjU6MDZQTSAtMDcwMCwgam9obi5odWJiYXJkQGdt
YWlsLmNvbSB3cm90ZToKPiAqIFN0b3JlLCBpbiB0aGUgaW92X2l0ZXIsIGEgImNhbWUgZnJvbSBn
dXAgKGdldF91c2VyX3BhZ2VzKSIgcGFyYW1ldGVyLgo+ICAgVGhlbiwgdXNlIHRoZSBuZXcgaW92
X2l0ZXJfZ2V0X3BhZ2VzX3VzZV9ndXAoKSB0byByZXRyaWV2ZSBpdCB3aGVuCj4gICBpdCBpcyB0
aW1lIHRvIHJlbGVhc2UgdGhlIHBhZ2VzLiBUaGF0IGFsbG93cyBjaG9vc2luZyBiZXR3ZWVuIHB1
dF9wYWdlKCkKPiAgIGFuZCBwdXRfdXNlcl9wYWdlKigpLgo+IAo+ICogUGFzcyBpbiBvbmUgbW9y
ZSBwaWVjZSBvZiBpbmZvcm1hdGlvbiB0byBiaW9fcmVsZWFzZV9wYWdlczogYSAiZnJvbV9ndXAi
Cj4gICBwYXJhbWV0ZXIuIFNpbWlsYXIgdXNlIGFzIGFib3ZlLgo+IAo+ICogQ2hhbmdlIHRoZSBi
bG9jayBsYXllciwgYW5kIHNldmVyYWwgZmlsZSBzeXN0ZW1zLCB0byB1c2UKPiAgIHB1dF91c2Vy
X3BhZ2UqKCkuCgpJIHRoaW5rIHdlIGNhbiBkbyB0aGlzIGluIGEgc2ltcGxlIGFuZCBiZXR0ZXIg
d2F5LiAgV2UgaGF2ZSA1IElURVJfKgp0eXBlcy4gIE9mIHRob3NlIElURVJfRElTQ0FSRCBhcyB0
aGUgbmFtZSBzdWdnZXN0cyBuZXZlciB1c2VzIHBhZ2VzLCBzbwp3ZSBjYW4gc2tpcCBoYW5kbGlu
ZyBpdC4gIElURVJfUElQRSBpcyByZWplY3RlZCDRlm4gdGhlIGRpcmVjdCBJL08gcGF0aCwKd2hp
Y2ggbGVhdmVzIHVzIHdpdGggdGhyZWUuCgpPdXQgb2YgdGhvc2UgSVRFUl9CVkVDIG5lZWRzIGEg
dXNlciBwYWdlIHJlZmVyZW5jZSwgc28gd2Ugd2FudCB0byBjYWxsCnB1dF91c2VyX3BhZ2UqIG9u
IGl0LiAgSVRFUl9CVkVDIGFsd2F5cyBhbHJlYWR5IGhhcyBwYWdlIHJlZmVyZW5jZSwKd2hpY2gg
bWVhbnMgaW4gdGhlIGJsb2NrIGRpcmVjdCBJL08gcGF0aCBwYXRoIHdlIGFscmVhZCBkb24ndCB0
YWtlCmEgcGFnZSByZWZlcmVuY2UuICBXZSBzaG91bGQgZXh0ZW50IHRoYXQgaGFuZGxpbmcgdG8g
YWxsIG90aGVyIGNhbGxzCm9mIGlvdl9pdGVyX2dldF9wYWdlcyAvIGlvdl9pdGVyX2dldF9wYWdl
c19hbGxvYy4gIEkgdGhpbmsgd2Ugc2hvdWxkCmp1c3QgcmVqZWN0IElURVJfS1ZFQyBmb3IgZGly
ZWN0IEkvTyBhcyB3ZWxsIGFzIHdlIGhhdmUgbm8gdXNlcnMgYW5kCml0IGlzIHJhdGhlciBwb2lu
dGxlc3MuICBBbHRlcm5hdGl2ZWx5IGlmIHdlIHNlZSBhIHVzZSBmb3IgaXQgdGhlCmNhbGxlcnMg
c2hvdWxkIGFsd2F5cyBoYXZlIGEgbGlmZSBwYWdlIHJlZmVyZW5jZSBhbnl3YXkgKG9yIG1pZ2h0
CmJlIG9uIGttYWxsb2MgbWVtb3J5KSwgc28gd2UgcmVhbGx5IHNob3VsZCBub3QgdGFrZSBhIHJl
ZmVyZW5jZSBlaXRoZXIuCgpJbiBvdGhlciB3b3JkczogIHRoZSBvbmx5IHRpbWUgd2Ugc2hvdWxk
IGV2ZXIgaGF2ZSB0byBwdXQgYSBwYWdlIGluCnRoaXMgcGF0Y2ggaXMgd2hlbiB0aGV5IGFyZSB1
c2VyIHBhZ2VzLiAgV2UnbGwgbmVlZCB0byBjbGVhbiB1cAp2YXJpb3VzIGJpdHMgb2YgY29kZSBm
b3IgdGhhdCwgYnV0IHRoYXQgY2FuIGJlIGRvbmUgZ3JhZHVhbGx5IGJlZm9yZQpldmVuIGdldHRp
bmcgdG8gdGhlIGFjdHVhbCBwdXRfdXNlcl9wYWdlcyBjb252ZXJzaW9uLgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
