From: john.hubbard@gmail.com
Subject: [PATCH 12/12] fs/ceph: fix a build warning: returning a value from
	void function
Date: Tue, 23 Jul 2019 21:25:18 -0700
Message-ID: <20190724042518.14363-13-jhubbard__11989.227896423$1563995101$gmane$org@nvidia.com>
References: <20190724042518.14363-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, linux-cifs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, v9fs-developer@lists.sourceforge.net, Eric Van Hensbergen <ericvh@gmail.com>, John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, samba-technical@lists.samba.org, LKML <linux-kernel@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, linux-fsdevel@vger.kernel.org, Anna Schumaker <anna.schumaker@netapp.com>
List-Id: virtualization@lists.linuxfoundation.org

From: John Hubbard <jhubbard@nvidia.com>

Trivial build warning fix: don't return a value from a function
whose type is "void".

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 fs/ceph/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 2eb88ed22993..fa14c8e8761d 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -294,7 +294,7 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 
 void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 {
-	return 0;
+	return;
 }
 
 void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
-- 
2.22.0
