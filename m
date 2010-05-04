From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 3/3] support for getting and setting EVB TLV parameters
Date: Tue,  4 May 2010 13:47:49 +0200
Message-ID: <1272973669-6694-4-git-send-email-jens@linux.vnet.ibm.com>
References: <1272973669-6694-1-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1272973669-6694-1-git-send-email-jens@linux.vnet.ibm.com>
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

This patch adds for querying and setting parameters used in
the exchange of EVB TLV messages.
The parameters that can be set are:

	- forwarding mode
	- host protocol capabilities (RTE, ECP, VDP and VDPL)
	- no. of supported VSIs
	- retransmission timer exponent (RTE)

To implement this, struct tlv_info_evb had to move to include/lldp_evb.h.
Besides that, the patch contains some minor bugfixes.

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 include/lldp_evb.h      |   20 +++
 include/lldp_evb_clif.h |   18 +++
 lldp_evb.c              |   21 +---
 lldp_evb_cmds.c         |  335 ++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 372 insertions(+), 22 deletions(-)

diff --git a/include/lldp_evb.h b/include/lldp_evb.h
index 3559dde..de39fd3 100644
--- a/include/lldp_evb.h
+++ b/include/lldp_evb.h
@@ -37,6 +37,25 @@ typedef enum {
 	EVB_CONFIRMATION
 } evb_state;
 
+struct tlv_info_evb {
+	u8 oui[3];
+	u8 sub;
+	/* supported forwarding mode */
+	u8 smode;
+	/* supported capabilities */
+	u8 scap;
+	/* currently configured forwarding mode */
+	u8 cmode;
+	/* currently configured capabilities */
+	u8 ccap;
+	/* supported no. of vsi */
+	u16 svsi;
+	/* currently configured no. of vsi */
+	u16 cvsi;
+	/* retransmission exponent */
+	u8 rte;
+} __attribute__ ((__packed__));
+
 struct evb_data {
 	char ifname[IFNAMSIZ];
 	struct unpacked_tlv *evb;
@@ -54,5 +73,6 @@ void evb_unregister(struct lldp_module *mod);
 struct packed_tlv *evb_gettlv(struct port *port);
 void evb_ifdown(char *);
 void evb_ifup(char *);
+struct evb_data *evb_data(char *ifname);
 
 #endif /* _LLDP_EVB_H */
diff --git a/include/lldp_evb_clif.h b/include/lldp_evb_clif.h
index 56011d1..5306eca 100644
--- a/include/lldp_evb_clif.h
+++ b/include/lldp_evb_clif.h
@@ -30,4 +30,22 @@ struct lldp_module *evb_cli_register(void);
 void evb_cli_unregister(struct lldp_module *);
 int evb_print_tlv(u32, u16, u8 *);
 
+#define EVB_BUF_SIZE		256
+
+#define ARG_EVB_FORWARDING_MODE	"fmode"
+
+#define VAL_EVB_FMODE_BRIDGE        "bridge"
+#define VAL_EVB_FMODE_RELAXEDRELAY	"relaxedrelay"
+
+#define ARG_EVB_CAPABILITIES	"capabilities"
+
+#define VAL_EVB_CAPA_RTE		"rte"
+#define VAL_EVB_CAPA_ECP		"ecp"
+#define VAL_EVB_CAPA_VDPL		"vdpl"
+#define VAL_EVB_CAPA_VDP		"vdp"
+
+#define ARG_EVB_VSIS		"vsis"
+
+#define ARG_EVB_RTE			"rte"
+
 #endif
diff --git a/lldp_evb.c b/lldp_evb.c
index 304a9f4..db5a11c 100644
--- a/lldp_evb.c
+++ b/lldp_evb.c
@@ -39,26 +39,7 @@
 
 extern struct lldp_head lldp_head;
 
-struct tlv_info_evb {
-	u8 oui[3];
-	u8 sub;
-	/* supported forwarding mode */
-	u8 smode;
-	/* supported capabilities */
-	u8 scap;
-	/* currently configured forwarding mode */
-	u8 cmode;
-	/* currently configured capabilities */
-	u8 ccap;
-	/* supported no. of vsi */
-	u16 svsi;
-	/* currently configured no. of vsi */
-	u16 cvsi;
-	/* retransmission exponent */
-	u8 rte;
-} __attribute__ ((__packed__));
-
-static struct evb_data *evb_data(const char *ifname)
+struct evb_data *evb_data(char *ifname)
 {
 	struct evb_user_data *ud;
 	struct evb_data *bd = NULL;
diff --git a/lldp_evb_cmds.c b/lldp_evb_cmds.c
index b6f6ad5..7cef1bb 100644
--- a/lldp_evb_cmds.c
+++ b/lldp_evb_cmds.c
@@ -45,7 +45,23 @@
 static int get_arg_tlvtxenable(struct cmd *, char *, char *, char *);
 static int set_arg_tlvtxenable(struct cmd *, char *, char *, char *);
 
+static int get_arg_fmode(struct cmd *, char *, char *, char *);
+static int set_arg_fmode(struct cmd *, char *, char *, char *);
+
+static int get_arg_rte(struct cmd *, char *, char *, char *);
+static int set_arg_rte(struct cmd *, char *, char *, char *);
+
+static int get_arg_vsis(struct cmd *, char *, char *, char *);
+static int set_arg_vsis(struct cmd *, char *, char *, char *);
+
+static int get_arg_capabilities(struct cmd *, char *, char *, char *);
+static int set_arg_capabilities(struct cmd *, char *, char *, char *);
+
 static struct arg_handlers arg_handlers[] = {
+	{ ARG_EVB_FORWARDING_MODE, get_arg_fmode, set_arg_fmode },
+	{ ARG_EVB_CAPABILITIES, get_arg_capabilities, set_arg_capabilities },
+	{ ARG_EVB_VSIS, get_arg_vsis, set_arg_vsis },
+	{ ARG_EVB_RTE, get_arg_rte, set_arg_rte },
 	{ ARG_TLVTXENABLE, get_arg_tlvtxenable, set_arg_tlvtxenable },
 	{ NULL }
 };
@@ -55,7 +71,7 @@ static int get_arg_tlvtxenable(struct cmd *cmd, char *arg, char *argvalue,
 {
 	int value;
 	char *s;
-	char arg_path[256];
+	char arg_path[EVB_BUF_SIZE];
 
 	if (cmd->cmd != cmd_gettlv)
 		return cmd_invalid;
@@ -89,7 +105,7 @@ static int set_arg_tlvtxenable(struct cmd *cmd, char *arg, char *argvalue,
 			       char *obuf)
 {
 	int value;
-	char arg_path[256];
+	char arg_path[EVB_BUF_SIZE];
 
 	if (cmd->cmd != cmd_settlv)
 		return cmd_invalid;
@@ -121,6 +137,321 @@ static int set_arg_tlvtxenable(struct cmd *cmd, char *arg, char *argvalue,
 	return cmd_success;
 }
 
+static int get_arg_fmode(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	u8 smode;
+	char *s;
+	char arg_path[EVB_BUF_SIZE];
+	struct evb_data *ed;
+
+	if (cmd->cmd != cmd_gettlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	ed = evb_data((char *) &cmd->ifname);
+	if (!ed)
+		return cmd_invalid;
+	if (ed->tie->smode & LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY)
+		s = VAL_EVB_FMODE_BRIDGE;
+	else
+		s = VAL_EVB_FMODE_RELAXEDRELAY;
+
+	sprintf(obuf, "%02x%s%04x%s", strlen(arg), arg, strlen(s), s);
+
+	return cmd_success;
+}
+
+static int set_arg_fmode(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	char arg_path[EVB_BUF_SIZE];
+	struct evb_data *ed;
+
+	if (cmd->cmd != cmd_settlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	ed = evb_data((char *) &cmd->ifname);
+
+	if (!ed)
+		return cmd_invalid;
+
+	if (!strcasecmp(argvalue, VAL_EVB_FMODE_BRIDGE))
+		ed->tie->smode = LLDP_EVB_CAPABILITY_FORWARD_STANDARD;
+	else if (!strcasecmp(argvalue, VAL_EVB_FMODE_RELAXEDRELAY))
+		ed->tie->smode = LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY;
+	else
+		return cmd_invalid;
+
+	somethingChangedLocal(cmd->ifname);
+
+	return cmd_success;
+}
+
+static int get_arg_capabilities(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	int c;
+	char *s, *t;
+	char arg_path[EVB_BUF_SIZE];
+	struct evb_data *ed;
+
+	printf("%s(%i): arg %s, argvalue %s !\n", __func__, __LINE__, arg, argvalue);
+
+	s = t = malloc(EVB_BUF_SIZE);
+
+	if (!s)
+		return cmd_invalid;
+
+	memset(s, 0, EVB_BUF_SIZE);
+
+	if (cmd->cmd != cmd_gettlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	ed = evb_data((char *) &cmd->ifname);
+	if (!ed)
+		return cmd_invalid;
+
+	if (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_RTE) {
+		c = sprintf(s, VAL_EVB_CAPA_RTE " ");
+		if (c <= 0)
+			return cmd_invalid;
+		s += c;
+	}
+
+	if (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_ECP) {
+		c = sprintf(s, VAL_EVB_CAPA_ECP " ");
+		if (c <= 0)
+			return cmd_invalid;
+		s += c;
+	}
+
+	if (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDP) {
+		c = sprintf(s, VAL_EVB_CAPA_VDP " ");
+		if (c <= 0)
+			return cmd_invalid;
+		s += c;
+	}
+
+	if (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDPL) {
+		c = sprintf(s, VAL_EVB_CAPA_VDPL " ");
+		if (c <= 0)
+			return cmd_invalid;
+		s += c;
+	}
+
+
+	sprintf(obuf, "%02x%s%04x%s", strlen(arg), arg, strlen(t), t);
+
+	return cmd_success;
+}
+
+static int set_arg_capabilities(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	u8 scap;
+	struct evb_data *ed;
+
+	if (cmd->cmd != cmd_settlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	ed = evb_data((char *) &cmd->ifname);
+
+	if (!ed)
+		return cmd_invalid;
+
+	if (strcasestr(argvalue, VAL_EVB_CAPA_RTE)) {
+			scap |= LLDP_EVB_CAPABILITY_PROTOCOL_RTE;
+		}
+
+	if (strcasestr(argvalue, VAL_EVB_CAPA_ECP)) {
+			scap |= LLDP_EVB_CAPABILITY_PROTOCOL_ECP;
+		}
+
+	if (strcasestr(argvalue, VAL_EVB_CAPA_VDP)) {
+			scap |= LLDP_EVB_CAPABILITY_PROTOCOL_VDP;
+		}
+
+	if (strcasestr(argvalue, VAL_EVB_CAPA_VDPL)) {
+			scap |= LLDP_EVB_CAPABILITY_PROTOCOL_VDPL;
+		}
+
+	if (scap != ed->tie->scap) {
+		ed->tie->scap = scap;
+		somethingChangedLocal(cmd->ifname);
+	}
+
+	return cmd_success;
+}
+
+static int get_arg_rte(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	char s[EVB_BUF_SIZE];
+	struct evb_data *ed;
+
+	if (cmd->cmd != cmd_gettlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	ed = evb_data((char *) &cmd->ifname);
+	if (!ed)
+		return cmd_invalid;
+
+	if (sprintf(s, "%i", ed->tie->rte) <= 0)
+		return cmd_invalid;
+
+	sprintf(obuf, "%02x%s%04x%s", strlen(arg), arg, strlen(s), s);
+
+	return cmd_success;
+}
+
+static int set_arg_rte(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	int value;
+	char arg_path[EVB_BUF_SIZE];
+	struct evb_data *ed;
+
+	if (cmd->cmd != cmd_settlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	ed = evb_data((char *) &cmd->ifname);
+
+	if (!ed)
+		return cmd_invalid;
+
+	value = atoi(argvalue);
+
+	if ((value < 0))
+		return cmd_invalid;
+
+	ed->tie->rte = value;
+
+	somethingChangedLocal(cmd->ifname);
+
+	return cmd_success;
+}
+
+
+static int get_arg_vsis(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	char s[EVB_BUF_SIZE];
+	struct evb_data *ed;
+
+	if (cmd->cmd != cmd_gettlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	ed = evb_data((char *) &cmd->ifname);
+	if (!ed)
+		return cmd_invalid;
+
+	if (sprintf(s, "%04i", ed->tie->svsi) <= 0)
+		return cmd_invalid;
+
+	sprintf(obuf, "%02x%s%04x%s", strlen(arg), arg, strlen(s), s);
+
+	return cmd_success;
+}
+
+static int set_arg_vsis(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	int value;
+	char arg_path[EVB_BUF_SIZE];
+	struct evb_data *ed;
+
+	if (cmd->cmd != cmd_settlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	ed = evb_data((char *) &cmd->ifname);
+
+	if (!ed)
+		return cmd_invalid;
+
+	value = atoi(argvalue);
+
+	if ((value < 0) || (value > LLDP_EVB_DEFAULT_MAX_VSI))
+		return cmd_invalid;
+
+	ed->tie->svsi = value;
+
+	somethingChangedLocal(cmd->ifname);
+
+	return cmd_success;
+}
+
 struct arg_handlers *evb_get_arg_handlers()
 {
 	return &arg_handlers[0];
-- 
1.7.0.1
