From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 3/9] BUGFIX: check for existence of ifup
Date: Fri, 22 Oct 2010 13:26:54 +0200
Message-ID: <1287746820-6036-4-git-send-email-jens@linux.vnet.ibm.com>
References: <1287746820-6036-1-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1287746820-6036-1-git-send-email-jens@linux.vnet.ibm.com>
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
Cc: chrisw@redhat.com, Jens Osterkamp <jens@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

added an additional check for existence of the ifup operation.
If it does not exist, just skip it.

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 config.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 5cfac83..26afe3b 100644
--- a/config.c
+++ b/config.c
@@ -370,8 +370,10 @@ void init_ports(void)
 		} else if (check_link_status(p->if_name)) {
 			add_adapter(p->if_name);
 
-			LIST_FOREACH(np, &lldp_head, lldp)
-				np->ops->lldp_mod_ifup(p->if_name);
+			LIST_FOREACH(np, &lldp_head, lldp) {
+				if (np->ops->lldp_mod_ifup)
+					np->ops->lldp_mod_ifup(p->if_name);
+			}
 			set_lldp_port_enable_state(p->if_name, 1);
 		}
 		p++;
-- 
1.7.1
