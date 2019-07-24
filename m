From: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 07/12] vhost-scsi: convert put_page() to put_user_page*()
Date: Tue, 23 Jul 2019 21:34:56 -0700
Message-ID: <de40950e-0801-b830-4c48-56e84de0c82b__16925.9849631757$1563995432$gmane$org@nvidia.com>
References: <20190724042518.14363-1-jhubbard@nvidia.com>
	<20190724042518.14363-8-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190724042518.14363-8-jhubbard@nvidia.com>
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
To: john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Boaz Harrosh <boaz@plexistor.com>, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Dave Chinner <david@fromorbit.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, linux-cifs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Johannes Thumshirn <jthumshirn@suse.de>, v9fs-developer@lists.sourceforge.net, Eric Van Hensbergen <ericvh@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>, ceph-devel@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, Jens Axboe <axboe@kernel.dk>
List-Id: virtualization@lists.linuxfoundation.org

T24gNy8yMy8xOSA5OjI1IFBNLCBqb2huLmh1YmJhcmRAZ21haWwuY29tIHdyb3RlOgo+IEZyb206
IErDqXLDtG1lIEdsaXNzZSA8amdsaXNzZUByZWRoYXQuY29tPgo+IAo+IEZvciBwYWdlcyB0aGF0
IHdlcmUgcmV0YWluZWQgdmlhIGdldF91c2VyX3BhZ2VzKigpLCByZWxlYXNlIHRob3NlIHBhZ2Vz
Cj4gdmlhIHRoZSBuZXcgcHV0X3VzZXJfcGFnZSooKSByb3V0aW5lcywgaW5zdGVhZCBvZiB2aWEg
cHV0X3BhZ2UoKS4KPiAKPiBUaGlzIGlzIHBhcnQgYSB0cmVlLXdpZGUgY29udmVyc2lvbiwgYXMg
ZGVzY3JpYmVkIGluIGNvbW1pdCBmYzFkOGU3Y2NhMmQKPiAoIm1tOiBpbnRyb2R1Y2UgcHV0X3Vz
ZXJfcGFnZSooKSwgcGxhY2Vob2xkZXIgdmVyc2lvbnMiKS4KPiAKPiBDaGFuZ2VzIGZyb20gSsOp
csO0bWUncyBvcmlnaW5hbCBwYXRjaDoKPiAKPiAqIENoYW5nZWQgYSBXQVJOX09OIHRvIGEgQlVH
X09OLgo+IAoKQ2xlYXJseSwgdGhlIGFib3ZlIGNvbW1pdCBsb2cgaGFzIGl0IGJhY2t3YXJkcyAo
dGhpcyBpcyBxdWl0ZSBteSBuaWdodApmb3IgdHlwb3MpLiAgUGxlYXNlIHJlYWQgdGhhdCBhcyAi
Y2hhbmdlZCBhIEJVR19PTiB0byBhIFdBUk5fT04iLgoKSSdsbCBjb3JyZWN0IHRoZSBjb21taXQg
ZGVzY3JpcHRpb24gaW4gbmV4dCBpdGVyYXRpb24gb2YgdGhpcyBwYXRjaHNldC4KCi4uLgoKPiAr
CS8qCj4gKwkgKiBIZXJlIGluIGFsbCBjYXNlcyB3ZSBzaG91bGQgaGF2ZSBhbiBJT1ZFQyB3aGlj
aCB1c2UgR1VQLiBJZiB0aGF0IGlzCj4gKwkgKiBub3QgdGhlIGNhc2UgdGhlbiB3ZSB3aWxsIHdy
b25nbHkgY2FsbCBwdXRfdXNlcl9wYWdlKCkgYW5kIHRoZSBwYWdlCj4gKwkgKiByZWZjb3VudCB3
aWxsIGdvIHdyb25nICh0aGlzIGlzIGluIHZob3N0X3Njc2lfcmVsZWFzZV9jbWQoKSkKPiArCSAq
Lwo+ICsJV0FSTl9PTighaW92X2l0ZXJfZ2V0X3BhZ2VzX3VzZV9ndXAoaXRlcikpOwo+ICsKLi4u
Cgp0aGFua3MsCi0tIApKb2huIEh1YmJhcmQKTlZJRElBCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
