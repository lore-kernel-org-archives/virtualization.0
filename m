From: Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH] vhost-net: comment use of invalid fd when setting vhost
	backend
Date: Tue, 22 Dec 2009 10:18:28 -0800
Message-ID: <20091222181828.GA2095__20744.0726728693$1261505971$gmane$org@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This looks like an error case, but it's just a special case to shutdown
the backend.  Clarify with a comment.

Signed-off-by: Chris Wright <chrisw@redhat.com>
---
 drivers/vhost/net.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 22d5fef..cc92086 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -465,6 +465,7 @@ static struct socket *get_tun_socket(int fd)
 static struct socket *get_socket(int fd)
 {
 	struct socket *sock;
+	/* special case to disable backend */
 	if (fd == -1)
 		return NULL;
 	sock = get_raw_socket(fd);
