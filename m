From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 7/9] use connect instead of bind
Date: Mon,  8 Nov 2010 17:11:58 +0100
Message-ID: <1289232720-27443-8-git-send-email-jens@linux.vnet.ibm.com>
References: <1289232720-27443-1-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1289232720-27443-1-git-send-email-jens@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: e1000-eedc@lists.sourceforge.net, virtualization@lists.linux-foundation.org, evb@yahoogroups.com
Cc: chrisw@redhat.com, Gerhard Stenzel <gstenzel@linux.vnet.ibm.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

modifies the setup of the netlink socket in drv_cfg.c to use pid 0 instead
of the processes pid.
Also replaces bind with connect to allow the reception of netlink messages
from libvirt.
Preparation patch for communication between libvirt and lldpad.

Signed-off-by: Gerhard Stenzel <gstenzel@linux.vnet.ibm.com>
---
 drv_cfg.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drv_cfg.c b/drv_cfg.c
index 6c02555..23c11f3 100644
--- a/drv_cfg.c
+++ b/drv_cfg.c
@@ -71,9 +71,9 @@ static int init_socket(void)
 
 	memset((void *)&snl, 0, sizeof(struct sockaddr_nl));
 	snl.nl_family = AF_NETLINK;
-	snl.nl_pid = getpid();
+	snl.nl_pid = 0;
 
-	if (bind(sd, (struct sockaddr *)&snl, sizeof(struct sockaddr_nl)) < 0) {
+	if (connect(sd, (struct sockaddr *)&snl, sizeof(struct sockaddr_nl)) < 0) {
 		close(sd);
 		return -EIO;
 	}
@@ -195,6 +195,7 @@ static struct nlmsghdr *get_msg(unsigned int seq)
 			nlh = NULL;
 			break;
 		}
+		fprintf(stderr, "%s:%s: nlmsg_type: %d\n", __FILE__, __FUNCTION__, nlh->nlmsg_type);
 		if ((nlh->nlmsg_type == RTM_GETDCB ||
 			nlh->nlmsg_type == RTM_SETDCB) &&
 			nlh->nlmsg_seq == seq) {
-- 
1.7.1
