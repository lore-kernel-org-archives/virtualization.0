From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 05/17] remove VDPL and proper config save and restore
Date: Fri, 23 Jul 2010 12:34:21 +0200
Message-ID: <1279881273-10261-6-git-send-email-jens@linux.vnet.ibm.com>
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

This patch contains multiple changes to the EVB protocol implementation:

 - it completely removes the use of VDPL, which is no longer in the spec
 - it introduces a mechanism for saving and restoring the EVB setting:
	If lldpad is loaded, and no EVB settings can be loaded from the
	configuration file, reasonable default settings are taken.
	If EVB settings can be loaded from the config file, these are taken.
	If changes are made to the EVB settings, e.g. new values are
	received by an adjacent switch or new values are set on the command
	line using lldptool, these settings are saved into the
	configuration.
 - it contains some janitorial changes for renaming the variable for
   evb_data to ed rather than bd for more consistent variable naming. It
   also renames the typo "relaxed relay" to the right "reflective relay".
 - split out printing of tlv into a separate function evb_print_tlvinfo

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 include/lldp.h          |    7 +-
 include/lldp_evb_clif.h |    5 +-
 lldp_evb.c              |  223 +++++++++++++++++++++++------------------------
 lldp_evb_clif.c         |   10 +--
 lldp_evb_cmds.c         |   54 +++++++-----
 5 files changed, 148 insertions(+), 151 deletions(-)

diff --git a/include/lldp.h b/include/lldp.h
index 21347b0..e00ba7a 100644
--- a/include/lldp.h
+++ b/include/lldp.h
@@ -193,12 +193,11 @@ enum {
 
 /* forwarding mode */
 #define LLDP_EVB_CAPABILITY_FORWARD_STANDARD		(1 << 7)
-#define LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY	(1 << 6)
+#define LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY	(1 << 6)
 
 /* EVB supported protocols */
-#define LLDP_EVB_CAPABILITY_PROTOCOL_RTE		(1 << 3)
-#define LLDP_EVB_CAPABILITY_PROTOCOL_ECP		(1 << 2)
-#define LLDP_EVB_CAPABILITY_PROTOCOL_VDPL		(1 << 1)
+#define LLDP_EVB_CAPABILITY_PROTOCOL_RTE		(1 << 2)
+#define LLDP_EVB_CAPABILITY_PROTOCOL_ECP		(1 << 1)
 #define LLDP_EVB_CAPABILITY_PROTOCOL_VDP		(1 << 0)
 
 /* EVB specific values */
diff --git a/include/lldp_evb_clif.h b/include/lldp_evb_clif.h
index 5306eca..43083f3 100644
--- a/include/lldp_evb_clif.h
+++ b/include/lldp_evb_clif.h
@@ -34,14 +34,13 @@ int evb_print_tlv(u32, u16, u8 *);
 
 #define ARG_EVB_FORWARDING_MODE	"fmode"
 
-#define VAL_EVB_FMODE_BRIDGE        "bridge"
-#define VAL_EVB_FMODE_RELAXEDRELAY	"relaxedrelay"
+#define VAL_EVB_FMODE_BRIDGE		"bridge"
+#define VAL_EVB_FMODE_REFLECTIVE_RELAY	"reflectiverelay"
 
 #define ARG_EVB_CAPABILITIES	"capabilities"
 
 #define VAL_EVB_CAPA_RTE		"rte"
 #define VAL_EVB_CAPA_ECP		"ecp"
-#define VAL_EVB_CAPA_VDPL		"vdpl"
 #define VAL_EVB_CAPA_VDP		"vdp"
 
 #define ARG_EVB_VSIS		"vsis"
diff --git a/lldp_evb.c b/lldp_evb.c
index db5a11c..c9a99bc 100644
--- a/lldp_evb.c
+++ b/lldp_evb.c
@@ -42,64 +42,57 @@ extern struct lldp_head lldp_head;
 struct evb_data *evb_data(char *ifname)
 {
 	struct evb_user_data *ud;
-	struct evb_data *bd = NULL;
+	struct evb_data *ed = NULL;
 
 	ud = find_module_user_data_by_if(ifname, &lldp_head, LLDP_MOD_EVB);
 	if (ud) {
-		LIST_FOREACH(bd, &ud->head, entry) {
-			if (!strncmp(ifname, bd->ifname, IFNAMSIZ))
-				return bd;
+		LIST_FOREACH(ed, &ud->head, entry) {
+			if (!strncmp(ifname, ed->ifname, IFNAMSIZ))
+				return ed;
 		}
 	}
 	return NULL;
 }
 
+static void evb_print_tlvinfo(struct tlv_info_evb *tie)
+{
+	printf("%s(%i): supported forwarding mode: %02x\n", __FILE__, __LINE__,  tie->smode);
+	printf("%s(%i): configured forwarding mode: %02x\n", __FILE__, __LINE__,  tie->cmode);
+	printf("%s(%i): supported capabilities: %02x\n", __FILE__, __LINE__,  tie->scap);
+	printf("%s(%i): configured capabilities: %02x\n", __FILE__, __LINE__,  tie->ccap);
+	printf("%s(%i): supported no. of vsis: %04i\n", __FILE__, __LINE__,  tie->svsi);
+	printf("%s(%i): configured no. of vsis: %04i\n", __FILE__, __LINE__,  tie->cvsi);
+	printf("%s(%i): rte: %02i\n\n", __FILE__, __LINE__,  tie->rte);
+}
+
 /*
  * evb_bld_cfg_tlv - build the EVB TLV
- * @bd: the evb data struct
+ * @ed: the evb data struct
  *
  * Returns 0 on success
  */
-static int evb_bld_cfg_tlv(struct evb_data *bd)
+static int evb_bld_cfg_tlv(struct evb_data *ed)
 {
 	int rc = 0;
 	int i;
 	struct unpacked_tlv *tlv = NULL;
-	struct tlv_info_evb evb;
 
-	/* free bd->evb if it exists */
-	FREE_UNPKD_TLV(bd, evb);
+	/* free ed->evb if it exists */
+	FREE_UNPKD_TLV(ed, evb);
 
-	if (!is_tlv_txenabled(bd->ifname, TLVID_8021Qbg(LLDP_EVB_SUBTYPE))) {
+	if (!is_tlv_txenabled(ed->ifname, TLVID_8021Qbg(LLDP_EVB_SUBTYPE))) {
 		fprintf(stderr, "### %s:%s:EVB Config disabled\n",
-			__func__, bd->ifname);
+			__func__, ed->ifname);
 		rc = EINVAL;
 		goto out_err;
 	}
 
-	/* load from config */
-	memset(&evb, 0, sizeof(evb));
-	if (get_config_tlvinfo_bin(bd->ifname, TLVID_8021Qbg(LLDP_EVB_SUBTYPE),
-			       (void *)&evb, sizeof(evb))) {
-		hton24(evb.oui, LLDP_MOD_EVB);
-		fprintf(stderr, "### %s:%s:Build EVB Config from scratch\n",
-			__func__, bd->ifname);
-		evb.sub = LLDP_EVB_SUBTYPE;
-		evb.smode = bd->tie->smode;
-		evb.scap = bd->tie->scap;
-		evb.cmode = bd->tie->cmode;
-		evb.ccap = bd->tie->ccap;
-		evb.svsi = bd->tie->svsi;
-		evb.cvsi = bd->tie->cvsi;
-		evb.rte = bd->tie->rte;
-	}
-
 	tlv = create_tlv();
 	if (!tlv)
 		goto out_err;
 
 	tlv->type = ORG_SPECIFIC_TLV;
-	tlv->length = sizeof(evb);
+	tlv->length = sizeof(struct tlv_info_evb);
 	tlv->info = (u8 *)malloc(tlv->length);
 	if(!tlv->info) {
 		free(tlv);
@@ -107,7 +100,7 @@ static int evb_bld_cfg_tlv(struct evb_data *bd)
 		rc = ENOMEM;
 		goto out_err;
 	}
-	memcpy(tlv->info, &evb, tlv->length);
+	memcpy(tlv->info, ed->tie, tlv->length);
 
 	printf("### %s:type %i, length %i, info ", __func__, tlv->type, tlv->length);
 
@@ -117,15 +110,15 @@ static int evb_bld_cfg_tlv(struct evb_data *bd)
 
 	printf("\n");
 
-	bd->evb = tlv;
+	ed->evb = tlv;
 out_err:
 	return rc;
 }
 
-static void evb_free_tlv(struct evb_data *bd)
+static void evb_free_tlv(struct evb_data *ed)
 {
-	if (bd) {
-		FREE_UNPKD_TLV(bd, evb);
+	if (ed) {
+		FREE_UNPKD_TLV(ed, evb);
 	}
 }
 
@@ -133,30 +126,36 @@ static void evb_free_tlv(struct evb_data *bd)
  *
  * fill up tlv_info_evb structure with reasonable info
  */
-static int evb_init_cfg_tlv(struct evb_data *bd)
+static int evb_init_cfg_tlv(struct evb_data *ed)
 {
-	bd->tie = (struct tlv_info_evb *) calloc(1, sizeof(struct tlv_info_evb));
-	if (!bd->tie)
+	ed->tie = (struct tlv_info_evb *) calloc(1, sizeof(struct tlv_info_evb));
+	if (!ed->tie)
 		return ENOMEM;
 
-	/* TODO: these should be set reasonable default, and must be able to change via config */
-	/* if possible, we request RR */
-	bd->tie->smode = LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY;
-	/* capabilities we support */
-	bd->tie->scap = LLDP_EVB_CAPABILITY_PROTOCOL_RTE | LLDP_EVB_CAPABILITY_PROTOCOL_ECP
-		| LLDP_EVB_CAPABILITY_PROTOCOL_VDP | LLDP_EVB_CAPABILITY_PROTOCOL_VDPL;
-	/* FIXME: for test: support something different than bridge */
-	bd->tie->svsi = LLDP_EVB_DEFAULT_SVSI;
-	bd->tie->rte = LLDP_EVB_DEFAULT_RTE;
+	if (get_config_tlvinfo_bin(ed->ifname, TLVID_8021Qbg(LLDP_EVB_SUBTYPE),
+			       (void *)ed->tie, sizeof(struct tlv_info_evb))) {
+		printf("%s:%s: loading EVB config failed, using default.\n",
+			__func__, ed->ifname);
+		hton24(ed->tie->oui, LLDP_MOD_EVB);
+		ed->tie->smode = LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY | LLDP_EVB_CAPABILITY_FORWARD_STANDARD;
+		ed->tie->cmode = 0x0;
+		ed->tie->scap = LLDP_EVB_CAPABILITY_PROTOCOL_RTE | LLDP_EVB_CAPABILITY_PROTOCOL_ECP
+			| LLDP_EVB_CAPABILITY_PROTOCOL_VDP;
+		ed->tie->ccap = 0x0;
+		ed->tie->svsi = LLDP_EVB_DEFAULT_SVSI;
+		ed->tie->rte = LLDP_EVB_DEFAULT_RTE;
+	} else {
+		printf("%s(%i): loaded EVB config from file.\n", __FILE__, __LINE__);
+	}
 
 	return 0;
 }
 
-static int evb_bld_tlv(struct evb_data *bd)
+static int evb_bld_tlv(struct evb_data *ed)
 {
 	int rc = 0;
 
-	if (!port_find_by_name(bd->ifname)) {
+	if (!port_find_by_name(ed->ifname)) {
 		rc = EEXIST;
 		goto out_err;
 	}
@@ -166,9 +165,9 @@ static int evb_bld_tlv(struct evb_data *bd)
 		goto out_err;
 	}
 
-	if (evb_bld_cfg_tlv(bd)) {
+	if (evb_bld_cfg_tlv(ed)) {
 		fprintf(stderr, "### %s:%s:evb_bld_cfg_tlv() failed\n",
-				__func__, bd->ifname);
+				__func__, ed->ifname);
 		rc = EINVAL;
 		goto out_err_destroy;
 	}
@@ -182,13 +181,13 @@ out_err:
 
 static void evb_free_data(struct evb_user_data *ud)
 {
-	struct evb_data *bd;
+	struct evb_data *ed;
 	if (ud) {
 		while (!LIST_EMPTY(&ud->head)) {
-			bd = LIST_FIRST(&ud->head);
-			LIST_REMOVE(bd, entry);
-			evb_free_tlv(bd);
-			free(bd);
+			ed = LIST_FIRST(&ud->head);
+			LIST_REMOVE(ed, entry);
+			evb_free_tlv(ed);
+			free(ed);
 		}
 	}
 }
@@ -196,22 +195,22 @@ static void evb_free_data(struct evb_user_data *ud)
 struct packed_tlv *evb_gettlv(struct port *port)
 {
 	int size;
-	struct evb_data *bd;
+	struct evb_data *ed;
 	struct packed_tlv *ptlv = NULL;
 
-	bd = evb_data(port->ifname);
-	if (!bd)
+	ed = evb_data(port->ifname);
+	if (!ed)
 		goto out_err;
 
-	evb_free_tlv(bd);
+	evb_free_tlv(ed);
 
-	if (evb_bld_tlv(bd)) {
+	if (evb_bld_tlv(ed)) {
 		fprintf(stderr, "### %s:%s evb_bld_tlv failed\n",
 			__func__, port->ifname);
 		goto out_err;
 	}
 
-	size = TLVSIZE(bd->evb);
+	size = TLVSIZE(ed->evb);
 
 	if (!size)
 		goto out_err;
@@ -225,7 +224,7 @@ struct packed_tlv *evb_gettlv(struct port *port)
 		goto out_free;
 
 	ptlv->size = 0;
-	PACK_TLV_AFTER(bd->evb, ptlv, size, out_free);
+	PACK_TLV_AFTER(ed->evb, ptlv, size, out_free);
 	return ptlv;
 out_free:
 	/* FIXME: free function returns pointer ? */
@@ -243,13 +242,7 @@ out_err:
 int evb_check_and_fill(struct evb_data *ed, struct tlv_info_evb *tie)
 {
 	if ((tie->smode & (LLDP_EVB_CAPABILITY_FORWARD_STANDARD |
-			  LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY)) == 0)
-		return TLV_ERR;
-
-	if ((tie->scap & (LLDP_EVB_CAPABILITY_PROTOCOL_RTE |
-			  LLDP_EVB_CAPABILITY_PROTOCOL_ECP |
-			  LLDP_EVB_CAPABILITY_PROTOCOL_VDP |
-			  LLDP_EVB_CAPABILITY_PROTOCOL_VDPL)) == 0)
+			  LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY)) == 0)
 		return TLV_ERR;
 
 	if ((tie->svsi < 0) || (tie->svsi > LLDP_EVB_DEFAULT_MAX_VSI))
@@ -258,10 +251,9 @@ int evb_check_and_fill(struct evb_data *ed, struct tlv_info_evb *tie)
 	if ((tie->cvsi < 0) || (tie->cvsi > LLDP_EVB_DEFAULT_MAX_VSI))
 		return TLV_ERR;
 
-	/* If both sides support RR, set it */
-	if ((tie->smode & LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY) &&
-	    (ed->tie->smode & LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY)) {
-		ed->tie->cmode = LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY;
+	if ((tie->smode & LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY) &&
+	    (ed->tie->smode & LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY)) {
+		ed->tie->cmode = LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY;
 	} else {
 		ed->tie->cmode = LLDP_EVB_CAPABILITY_FORWARD_STANDARD;
 	}
@@ -276,11 +268,6 @@ int evb_check_and_fill(struct evb_data *ed, struct tlv_info_evb *tie)
 	    (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_ECP))
 		ed->tie->ccap |= LLDP_EVB_CAPABILITY_PROTOCOL_ECP;
 
-	/* If both sides support VDPL, set it */
-	if ((tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDPL) &&
-	    (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDPL))
-		ed->tie->ccap |= LLDP_EVB_CAPABILITY_PROTOCOL_VDPL;
-
 	/* If both sides support VDP, set it */
 	if ((tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDP) &&
 	    (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDP))
@@ -296,6 +283,13 @@ int evb_check_and_fill(struct evb_data *ed, struct tlv_info_evb *tie)
 		(tie->rte > 0))
 		ed->tie->rte = MIN(ed->tie->svsi,tie->rte);
 
+	if (set_config_tlvinfo_bin(ed->ifname, TLVID_8021Qbg(LLDP_EVB_SUBTYPE),
+			       (void *)ed->tie, sizeof(struct tlv_info_evb))) {
+		printf("%s(%i): error saving tlv_info_evb !\n", __FILE__, __LINE__);
+	} else {
+		printf("%s(%i): saved tlv_info_evb to config !\n", __FILE__, __LINE__);
+	}
+
 	return TLV_OK;
 }
 
@@ -336,7 +330,7 @@ static void evb_statemachine(struct evb_data *ed, struct tlv_info_evb *tie)
 		 *		- switch to EVB_CONFIGURE
 		 */
 		printf("%s: state -> EVB_OFFER_CAPABILITIES\n", __func__);
-		if (!evb_check_and_fill(ed, tie)) {
+		if (evb_check_and_fill(ed, tie) != TLV_OK) {
 			fprintf(stderr, "Invalid contents of EVB Cfg TLV !\n");
 			return;
 		}
@@ -379,15 +373,18 @@ static int evb_rchange(struct port *port, struct unpacked_tlv *tlv)
 	struct tlv_info_evb *tie = (struct tlv_info_evb *) tlv->info;
 	u8 oui_subtype[OUI_SUB_SIZE] = LLDP_OUI_SUBTYPE;
 
-	ed = evb_data(port->ifname);
+	if (!init_cfg()) {
+		return SUBTYPE_INVALID;
+	}
 
-	/* TODO: disable rx if tx has been disabled by administrator ?
+	/* disable rx if tx has been disabled by administrator
 	if (!is_tlv_txenabled(ed->ifname, TLVID_8021(LLDP_EVB_SUBTYPE))) {
 		fprintf(stderr, "### %s:%s:EVB Config disabled\n",
 			__func__, ed->ifname);
 		return TLV_OK;
-	}
-	*/
+	} */
+
+	ed = evb_data(port->ifname);
 
 	if (!ed)
 		return SUBTYPE_INVALID;
@@ -411,22 +408,15 @@ static int evb_rchange(struct port *port, struct unpacked_tlv *tlv)
 			return SUBTYPE_INVALID;
 		}
 
-		/* decode values */
-		fprintf(stderr, "### %s:now ready to decode values !\n", __func__);
+		evb_print_tlvinfo(tie);
 
 		offset = OUI_SUB_SIZE;
 
-		/* received valid values, save them */
-		fprintf(stderr,"### supported forwarding mode: %02x\n", tie->smode);
-		fprintf(stderr,"### configured forwarding mode: %02x\n", tie->cmode);
-		fprintf(stderr,"### supported capabilities: %02x\n", tie->scap);
-		fprintf(stderr,"### configured capabilities: %02x\n", tie->ccap);
-		fprintf(stderr,"### supported no. of vsis: %04i\n", tie->svsi);
-		fprintf(stderr,"### configured no. of vsis: %04i\n", tie->cvsi);
-		fprintf(stderr,"### rte: %02i\n", tie->rte);
-
 		/* change state */
 		evb_statemachine(ed, tie);
+
+		/* check which values have been taken over */
+		evb_print_tlvinfo(ed->tie);
 	}
 
 	return TLV_OK;
@@ -434,15 +424,18 @@ static int evb_rchange(struct port *port, struct unpacked_tlv *tlv)
 
 void evb_ifdown(char *ifname)
 {
-	struct evb_data *bd;
+	struct evb_data *ed;
+
+	printf("%s called !\n", __func__);
 
-	bd = evb_data(ifname);
-	if (!bd)
+	ed = evb_data(ifname);
+	if (!ed)
 		goto out_err;
 
-	LIST_REMOVE(bd, entry);
-	evb_free_tlv(bd);
-	free(bd);
+	free(ed->tie);
+	LIST_REMOVE(ed, entry);
+	evb_free_tlv(ed);
+	free(ed);
 	fprintf(stderr, "### %s:port %s removed\n", __func__, ifname);
 	return;
 out_err:
@@ -453,40 +446,44 @@ out_err:
 
 void evb_ifup(char *ifname)
 {
-	struct evb_data *bd;
+	struct evb_data *ed;
 	struct evb_user_data *ud;
 
-	bd = evb_data(ifname);
-	if (bd) {
+	ed = evb_data(ifname);
+	if (ed) {
 		fprintf(stderr, "### %s:%s exists\n", __func__, ifname);
 		goto out_err;
 	}
 
 	/* not found, alloc/init per-port tlv data */
-	bd = (struct evb_data *) calloc(1, sizeof(struct evb_data));
-	if (!bd) {
+	ed = (struct evb_data *) calloc(1, sizeof(struct evb_data));
+	if (!ed) {
 		fprintf(stderr, "### %s:%s malloc %ld failed\n",
-			 __func__, ifname, sizeof(*bd));
+			 __func__, ifname, sizeof(*ed));
+		goto out_err;
+	}
+	strncpy(ed->ifname, ifname, IFNAMSIZ);
+
+	if (!init_cfg()) {
 		goto out_err;
 	}
-	strncpy(bd->ifname, ifname, IFNAMSIZ);
 
-	if (evb_init_cfg_tlv(bd)) {
+	if (evb_init_cfg_tlv(ed)) {
 		fprintf(stderr, "### %s:%s evb_init_cfg_tlv failed\n", __func__, ifname);
-		free(bd);
+		free(ed);
 		goto out_err;
 	}
 
-	bd->state = EVB_OFFER_CAPABILITIES;
+	ed->state = EVB_OFFER_CAPABILITIES;
 
-	if (evb_bld_tlv(bd)) {
+	if (evb_bld_tlv(ed)) {
 		fprintf(stderr, "### %s:%s evb_bld_tlv failed\n", __func__, ifname);
-		free(bd);
+		free(ed);
 		goto out_err;
 	}
 
 	ud = find_module_user_data_by_if(ifname, &lldp_head, LLDP_MOD_EVB);
-	LIST_INSERT_HEAD(&ud->head, bd, entry);
+	LIST_INSERT_HEAD(&ud->head, ed, entry);
 	fprintf(stderr, "### %s:port %s added\n", __func__, ifname);
 	return;
 
diff --git a/lldp_evb_clif.c b/lldp_evb_clif.c
index d450f4b..383b717 100644
--- a/lldp_evb_clif.c
+++ b/lldp_evb_clif.c
@@ -110,7 +110,7 @@ void evb_print_cfg_tlv(u16 len, char *info)
 	if (!hexstr2bin(info, &smode, sizeof(smode))) {
 		printf("supported forwarding mode: (0x%02hhx)", smode);
 
-		if (smode & LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY)
+		if (smode & LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY)
 			printf(" reflective relay");
 
 		if (smode & LLDP_EVB_CAPABILITY_FORWARD_STANDARD)
@@ -130,9 +130,6 @@ void evb_print_cfg_tlv(u16 len, char *info)
 		if ( scap & LLDP_EVB_CAPABILITY_PROTOCOL_ECP)
 		     printf(" ECP");
 
-		if ( scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDPL)
-		     printf(" VDPL");
-
 		if ( scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDP)
 		     printf(" VDP");
 
@@ -144,7 +141,7 @@ void evb_print_cfg_tlv(u16 len, char *info)
 	if (!hexstr2bin(info+4, &cmode, sizeof(cmode))) {
 		printf("\tconfigured forwarding mode: (0x%02hhx)", cmode);
 
-		if (cmode & LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY)
+		if (cmode & LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY)
 			printf(" reflective relay");
 
 		if (cmode & LLDP_EVB_CAPABILITY_FORWARD_STANDARD)
@@ -164,9 +161,6 @@ void evb_print_cfg_tlv(u16 len, char *info)
 		if ( ccap & LLDP_EVB_CAPABILITY_PROTOCOL_ECP)
 		     printf(" ECP");
 
-		if ( ccap & LLDP_EVB_CAPABILITY_PROTOCOL_VDPL)
-		     printf(" VDPL");
-
 		if ( ccap & LLDP_EVB_CAPABILITY_PROTOCOL_VDP)
 		     printf(" VDP");
 
diff --git a/lldp_evb_cmds.c b/lldp_evb_cmds.c
index 7cef1bb..d0a9051 100644
--- a/lldp_evb_cmds.c
+++ b/lldp_evb_cmds.c
@@ -66,6 +66,27 @@ static struct arg_handlers arg_handlers[] = {
 	{ NULL }
 };
 
+static void evb_changed(char *ifname)
+{
+	struct evb_data *ed;
+
+	ed = evb_data(ifname);
+
+	if (!ed)
+		goto trigger_send;
+
+	if (set_config_tlvinfo_bin(ifname, TLVID_8021Qbg(LLDP_EVB_SUBTYPE),
+			       (void *)ed->tie, sizeof(struct tlv_info_evb))) {
+		printf("%s(%i): error saving tlv_info_evb !\n", __FILE__, __LINE__);
+	} else {
+		printf("%s(%i): saved tlv_info_evb to config !\n", __FILE__, __LINE__);
+	}
+
+trigger_send:
+	somethingChangedLocal(ifname);
+
+}
+
 static int get_arg_tlvtxenable(struct cmd *cmd, char *arg, char *argvalue,
 			       char *obuf)
 {
@@ -132,7 +153,7 @@ static int set_arg_tlvtxenable(struct cmd *cmd, char *arg, char *argvalue,
 	if (set_cfg(cmd->ifname, arg_path, (void *)&value, CONFIG_TYPE_BOOL))
 		return cmd_failed;
 
-	somethingChangedLocal(cmd->ifname);
+	evb_changed(cmd->ifname);
 
 	return cmd_success;
 }
@@ -160,10 +181,10 @@ static int get_arg_fmode(struct cmd *cmd, char *arg, char *argvalue,
 	ed = evb_data((char *) &cmd->ifname);
 	if (!ed)
 		return cmd_invalid;
-	if (ed->tie->smode & LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY)
+	if (ed->tie->smode & LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY)
 		s = VAL_EVB_FMODE_BRIDGE;
 	else
-		s = VAL_EVB_FMODE_RELAXEDRELAY;
+		s = VAL_EVB_FMODE_REFLECTIVE_RELAY;
 
 	sprintf(obuf, "%02x%s%04x%s", strlen(arg), arg, strlen(s), s);
 
@@ -195,12 +216,12 @@ static int set_arg_fmode(struct cmd *cmd, char *arg, char *argvalue,
 
 	if (!strcasecmp(argvalue, VAL_EVB_FMODE_BRIDGE))
 		ed->tie->smode = LLDP_EVB_CAPABILITY_FORWARD_STANDARD;
-	else if (!strcasecmp(argvalue, VAL_EVB_FMODE_RELAXEDRELAY))
-		ed->tie->smode = LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY;
+	else if (!strcasecmp(argvalue, VAL_EVB_FMODE_REFLECTIVE_RELAY))
+		ed->tie->smode = LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY;
 	else
 		return cmd_invalid;
 
-	somethingChangedLocal(cmd->ifname);
+	evb_changed(cmd->ifname);
 
 	return cmd_success;
 }
@@ -259,14 +280,6 @@ static int get_arg_capabilities(struct cmd *cmd, char *arg, char *argvalue,
 		s += c;
 	}
 
-	if (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDPL) {
-		c = sprintf(s, VAL_EVB_CAPA_VDPL " ");
-		if (c <= 0)
-			return cmd_invalid;
-		s += c;
-	}
-
-
 	sprintf(obuf, "%02x%s%04x%s", strlen(arg), arg, strlen(t), t);
 
 	return cmd_success;
@@ -307,14 +320,9 @@ static int set_arg_capabilities(struct cmd *cmd, char *arg, char *argvalue,
 			scap |= LLDP_EVB_CAPABILITY_PROTOCOL_VDP;
 		}
 
-	if (strcasestr(argvalue, VAL_EVB_CAPA_VDPL)) {
-			scap |= LLDP_EVB_CAPABILITY_PROTOCOL_VDPL;
-		}
+	ed->tie->scap = scap;
 
-	if (scap != ed->tie->scap) {
-		ed->tie->scap = scap;
-		somethingChangedLocal(cmd->ifname);
-	}
+	evb_changed(cmd->ifname);
 
 	return cmd_success;
 }
@@ -380,7 +388,7 @@ static int set_arg_rte(struct cmd *cmd, char *arg, char *argvalue,
 
 	ed->tie->rte = value;
 
-	somethingChangedLocal(cmd->ifname);
+	evb_changed(cmd->ifname);
 
 	return cmd_success;
 }
@@ -447,7 +455,7 @@ static int set_arg_vsis(struct cmd *cmd, char *arg, char *argvalue,
 
 	ed->tie->svsi = value;
 
-	somethingChangedLocal(cmd->ifname);
+	evb_changed(cmd->ifname);
 
 	return cmd_success;
 }
-- 
1.7.1
