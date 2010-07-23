From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 10/17] allow to set both supported forwarding modes
Date: Fri, 23 Jul 2010 12:34:26 +0200
Message-ID: <1279881273-10261-11-git-send-email-jens@linux.vnet.ibm.com>
References: <1279881273-10261-1-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1279881273-10261-1-git-send-email-jens@linux.vnet.ibm.com>
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

In the previous version of lldptool, only one setting of either bridge or
reflective relay mode was allowed whereas both modes together should be
settable.
This patch corrects it.

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 lldp_evb_cmds.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/lldp_evb_cmds.c b/lldp_evb_cmds.c
index d0a9051..aa2dc7c 100644
--- a/lldp_evb_cmds.c
+++ b/lldp_evb_cmds.c
@@ -194,6 +194,7 @@ static int get_arg_fmode(struct cmd *cmd, char *arg, char *argvalue,
 static int set_arg_fmode(struct cmd *cmd, char *arg, char *argvalue,
 			       char *obuf)
 {
+	u8 smode;
 	char arg_path[EVB_BUF_SIZE];
 	struct evb_data *ed;
 
@@ -214,12 +215,21 @@ static int set_arg_fmode(struct cmd *cmd, char *arg, char *argvalue,
 	if (!ed)
 		return cmd_invalid;
 
-	if (!strcasecmp(argvalue, VAL_EVB_FMODE_BRIDGE))
-		ed->tie->smode = LLDP_EVB_CAPABILITY_FORWARD_STANDARD;
-	else if (!strcasecmp(argvalue, VAL_EVB_FMODE_REFLECTIVE_RELAY))
-		ed->tie->smode = LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY;
-	else
+	smode = 0;
+
+	if (strcasestr(argvalue, VAL_EVB_FMODE_BRIDGE)) {
+		smode |= LLDP_EVB_CAPABILITY_FORWARD_STANDARD;
+	}
+
+	if (strcasestr(argvalue, VAL_EVB_FMODE_REFLECTIVE_RELAY)) {
+		smode |= LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY;
+	}
+
+	if (smode == 0) {
 		return cmd_invalid;
+	} else {
+		ed->tie->smode = smode;
+	}
 
 	evb_changed(cmd->ifname);
 
-- 
1.7.1
