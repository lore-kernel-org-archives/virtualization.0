From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next v2 15/15] vhost/vsock: refuse CID assigned to the
	guest->host transport
Date: Thu, 14 Nov 2019 10:57:50 +0100
Message-ID: <20191114095750.59106-16-sgarzare__30630.2509315842$1573725719$gmane$org@redhat.com>
References: <20191114095750.59106-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191114095750.59106-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, Haiyang Zhang <haiyangz@microsoft.com>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

In a nested VM environment, we have to refuse to assign to a nested
guest the same CID assigned to our guest->host transport.
In this way, the user can use the local CID for loopback.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index fdda9ec625ad..dde392b91bb3 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -718,6 +718,12 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 	if (guest_cid > U32_MAX)
 		return -EINVAL;
 
+	/* Refuse if CID is assigned to the guest->host transport (i.e. nested
+	 * VM), to make the loopback work.
+	 */
+	if (vsock_find_cid(guest_cid))
+		return -EADDRINUSE;
+
 	/* Refuse if CID is already in use */
 	mutex_lock(&vhost_vsock_mutex);
 	other = vhost_vsock_get(guest_cid);
-- 
2.21.0
