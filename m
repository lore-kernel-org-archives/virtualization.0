From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 10/10] implement VDP keepalive
Date: Mon, 22 Nov 2010 16:50:57 +0100
Message-ID: <1290441057-16729-11-git-send-email-jens@linux.vnet.ibm.com>
References: <1290441057-16729-1-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1290441057-16729-1-git-send-email-jens@linux.vnet.ibm.com>
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

Once a VSI is associated with the adjacent switch, it needs to be renewed in
the switch from time to time. This patch implements the renewal of the VSI.
As a time base it uses the RTE (ReTransmission Exponent) exchanged in the
EVB TLV.

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 ecp/ecp.h          |    2 +-
 ecp/ecp_tx.c       |    8 ++-
 include/lldp_evb.h |    4 +-
 include/lldp_vdp.h |    3 +-
 lldp_evb.c         |    7 +++
 lldp_vdp.c         |  109 +++++++++++++++++++++++++++++++++++++++++++++-------
 6 files changed, 112 insertions(+), 21 deletions(-)

diff --git a/ecp/ecp.h b/ecp/ecp.h
index cc9ca2b..89c1154 100644
--- a/ecp/ecp.h
+++ b/ecp/ecp.h
@@ -34,7 +34,7 @@
 #define ECP_MAX_RETRIES			3
 #define ECP_SEQUENCE_NR_START		0x0
 
-#define ECP_TRANSMISSION_TIMER		EVB_RTM(RTE)*EVB_RTG
+#define ECP_TRANSMISSION_TIMER(rte)	EVB_RTM(rte)*EVB_RTG
 #define ECP_TRANSMISSION_DIVIDER	10000
 
 typedef enum {
diff --git a/ecp/ecp_tx.c b/ecp/ecp_tx.c
index 1db9ac3..6518a79 100644
--- a/ecp/ecp_tx.c
+++ b/ecp/ecp_tx.c
@@ -316,12 +316,14 @@ int ecp_tx_stop_ackTimer(struct vdp_data *vd)
  */
 static void ecp_tx_start_ackTimer(struct vdp_data *vd)
 {
-	unsigned int secs, usecs;
+	unsigned int secs, usecs, rte;
 
 	vd->ecp.ackTimerExpired = false;
 
-	secs = ECP_TRANSMISSION_TIMER / ECP_TRANSMISSION_DIVIDER;
-	usecs = ECP_TRANSMISSION_TIMER % ECP_TRANSMISSION_DIVIDER;
+	rte = evb_get_rte(vd->ifname);
+
+	secs = ECP_TRANSMISSION_TIMER(rte) / ECP_TRANSMISSION_DIVIDER;
+	usecs = ECP_TRANSMISSION_TIMER(rte) % ECP_TRANSMISSION_DIVIDER;
 
 	LLDPAD_DBG("%s(%i)-%s: starting timer\n", __func__, __LINE__,
 	       vd->ifname);
diff --git a/include/lldp_evb.h b/include/lldp_evb.h
index d028c21..549f2b2 100644
--- a/include/lldp_evb.h
+++ b/include/lldp_evb.h
@@ -37,11 +37,11 @@ typedef enum {
 	EVB_CONFIRMATION
 } evb_state;
 
-#define	RTE		13
+#define	EVB_RTE		13
 /* retransmission granularity (RTG) in microseconds */
 #define EVB_RTG		10
 /* retransmission multiplier (RTM) */
-#define EVB_RTM(rte)	(2<<(RTE-1))
+#define EVB_RTM(rte)	(2<<(rte-1))
 
 struct tlv_info_evb {
 	u8 oui[3];
diff --git a/include/lldp_vdp.h b/include/lldp_vdp.h
index 8866d51..5cd2b2e 100644
--- a/include/lldp_vdp.h
+++ b/include/lldp_vdp.h
@@ -71,7 +71,7 @@ enum {
 
 #define VDP_MACVLAN_FORMAT_1	1
 
-#define VDP_TRANSMISSION_TIMER		3*EVB_RTM(RTE)*EVB_RTG
+#define VDP_TRANSMISSION_TIMER(rte)	3*EVB_RTM(rte)*EVB_RTG
 #define VDP_TRANSMISSION_DIVIDER	10000
 
 #define VDP_ROLE_STATION		0
@@ -128,6 +128,7 @@ struct vsi_profile {
 	struct port *port;
 	int ackTimerExpired;
 	int ackReceived;
+	int keepaliveTimerExpired;
 	int state;
 	bool localChange;
 	LIST_ENTRY(vsi_profile) profile;
diff --git a/lldp_evb.c b/lldp_evb.c
index 50ee17d..051559c 100644
--- a/lldp_evb.c
+++ b/lldp_evb.c
@@ -91,6 +91,13 @@ static void evb_dump_tlv(struct unpacked_tlv *tlv)
 	free(t);
 }
 
+unsigned int evb_get_rte(char *ifname)
+{
+	struct evb_data *ed = evb_data(ifname);
+
+	return (unsigned int) ed->tie->rte;
+}
+
 /*
  * evb_bld_cfg_tlv - build the EVB TLV
  * @ed: the evb data struct
diff --git a/lldp_vdp.c b/lldp_vdp.c
index cb23d90..bc17ee4 100644
--- a/lldp_vdp.c
+++ b/lldp_vdp.c
@@ -141,6 +141,82 @@ void vdp_somethingChangedLocal(struct vsi_profile *profile, bool mode)
 	profile->localChange = mode;
 }
 
+/* vdp_keepaliveTimer_expired - checks for expired ack timer
+ * @profile: profile to be checked
+ *
+ * returns true or false
+ *
+ * returns value of profile->ackTimerExpired, true if ack timer has expired,
+ * false otherwise.
+ */
+static bool vdp_keepaliveTimer_expired(struct vsi_profile *profile)
+{
+	return profile->keepaliveTimerExpired;
+}
+
+/* vdp_acktimeout_handler - handles the ack timer expiry
+ * @eloop_data: data structure of event loop
+ * @user_ctx: user context, profile here
+ *
+ * no return value
+ *
+ * called when the VDP ack timer has expired. sets a flag and calls the VDP
+ * state machine.
+ */
+void vdp_keepalivetimeout_handler(void *eloop_data, void *user_ctx)
+{
+	struct vsi_profile *profile;
+
+	profile = (struct vsi_profile *) user_ctx;
+
+	profile->keepaliveTimerExpired = true;
+
+	LLDPAD_DBG("%s(%i)-%s: keepalive timer expired\n", __func__, __LINE__,
+	       profile->port->ifname);
+
+	vdp_vsi_sm_station(profile);
+}
+
+/* vdp_stop_keepaliveTimer - stop the VDP keepalive timer
+ * @profile: profile to process
+ *
+ * returns the number of removed handlers
+ *
+ * stops the VDP keepalive timer. Used when the profile changes state e.g. a deassoc
+ * has been requested.
+ */
+static int vdp_stop_keepaliveTimer(struct vsi_profile *profile)
+{
+	LLDPAD_DBG("%s(%i)-%s: stopping keepalive timer\n", __func__, __LINE__,
+	       profile->port->ifname);
+
+	return eloop_cancel_timeout(vdp_keepalivetimeout_handler, NULL, (void *) profile);
+}
+
+/* vdp_start_keepaliveTimer - starts the VDP keepalive timer
+ * @profile: profile to process
+ *
+ * returns 0 on success, -1 on error
+ *
+ * starts the keepalive timer after a ack frame has received.
+ */
+static int vdp_start_keepaliveTimer(struct vsi_profile *profile)
+{
+	unsigned int secs, usecs, rte;
+
+	profile->keepaliveTimerExpired = false;
+
+	rte = evb_get_rte(profile->port->ifname);
+
+	secs = VDP_TRANSMISSION_TIMER(rte) / VDP_TRANSMISSION_DIVIDER;
+	usecs = VDP_TRANSMISSION_TIMER(rte) % VDP_TRANSMISSION_DIVIDER;
+
+	LLDPAD_DBG("%s(%i)-%s: starting keepalive timer (%i secs, %i usecs) \n", __func__, __LINE__,
+	       profile->port->ifname, secs, usecs);
+
+	return eloop_register_timeout(secs, usecs, vdp_keepalivetimeout_handler, NULL, (void *) profile);
+}
+
 /* vdp_ackTimer_expired - checks for expired ack timer
  * @profile: profile to be checked
  *
@@ -154,7 +230,7 @@ static bool vdp_ackTimer_expired(struct vsi_profile *profile)
 	return profile->ackTimerExpired;
 }
 
-/* vdp_timeout_handler - handles the ack timer expiry
+/* vdp_acktimeout_handler - handles the ack timer expiry
  * @eloop_data: data structure of event loop
  * @user_ctx: user context, profile here
  *
@@ -163,7 +239,7 @@ static bool vdp_ackTimer_expired(struct vsi_profile *profile)
  * called when the VDP ack timer has expired. sets a flag and calls the VDP
  * state machine.
  */
-void vdp_timeout_handler(void *eloop_data, void *user_ctx)
+void vdp_acktimeout_handler(void *eloop_data, void *user_ctx)
 {
 	struct vsi_profile *profile;
 
@@ -171,7 +247,7 @@ void vdp_timeout_handler(void *eloop_data, void *user_ctx)
 
 	profile->ackTimerExpired = true;
 
-	LLDPAD_DBG("%s(%i)-%s: timer expired\n", __func__, __LINE__,
+	LLDPAD_DBG("%s(%i)-%s: ack timer expired\n", __func__, __LINE__,
 	       profile->port->ifname);
 
 	vdp_vsi_sm_station(profile);
@@ -187,10 +263,10 @@ void vdp_timeout_handler(void *eloop_data, void *user_ctx)
  */
 static int vdp_stop_ackTimer(struct vsi_profile *profile)
 {
-	LLDPAD_DBG("%s(%i)-%s: stopping timer\n", __func__, __LINE__,
+	LLDPAD_DBG("%s(%i)-%s: stopping ack timer\n", __func__, __LINE__,
 	       profile->port->ifname);
 
-	return eloop_cancel_timeout(vdp_timeout_handler, NULL, (void *) profile);
+	return eloop_cancel_timeout(vdp_acktimeout_handler, NULL, (void *) profile);
 }
 
 /* vdp_start_ackTimer - starts the VDP ack timer
@@ -202,17 +278,19 @@ static int vdp_stop_ackTimer(struct vsi_profile *profile)
  */
 static int vdp_start_ackTimer(struct vsi_profile *profile)
 {
-	unsigned int secs, usecs;
+	unsigned int secs, usecs, rte;
 
 	profile->ackTimerExpired = false;
 
-	secs = VDP_TRANSMISSION_TIMER / VDP_TRANSMISSION_DIVIDER;
-	usecs = VDP_TRANSMISSION_TIMER % VDP_TRANSMISSION_DIVIDER;
+	rte = evb_get_rte(profile->port->ifname);
 
-	LLDPAD_DBG("%s(%i)-%s: starting timer\n", __func__, __LINE__,
-	       profile->port->ifname);
+	secs = VDP_TRANSMISSION_TIMER(rte) / VDP_TRANSMISSION_DIVIDER;
+	usecs = VDP_TRANSMISSION_TIMER(rte) % VDP_TRANSMISSION_DIVIDER;
 
-	return eloop_register_timeout(secs, usecs, vdp_timeout_handler, NULL, (void *) profile);
+	LLDPAD_DBG("%s(%i)-%s: starting ack timer (%i secs, %i usecs)\n", __func__, __LINE__,
+	       profile->port->ifname, secs, usecs);
+
+	return eloop_register_timeout(secs, usecs, vdp_acktimeout_handler, NULL, (void *) profile);
 }
 
 /* vdp_vsi_change_station_state - changes the VDP station sm state
@@ -233,13 +311,15 @@ void vdp_vsi_change_station_state(struct vsi_profile *profile, u8 newstate)
 		       (profile->state == VSI_UNASSOCIATED));
 		break;
 	case VSI_ASSOCIATED:
-		assert(profile->state == VSI_ASSOC_PROCESSING);
+		assert((profile->state == VSI_ASSOC_PROCESSING) ||
+			(profile->state == VSI_ASSOCIATED));
 		break;
 	case VSI_PREASSOC_PROCESSING:
 		assert(profile->state == VSI_UNASSOCIATED);
 		break;
 	case VSI_PREASSOCIATED:
-		assert(profile->state == VSI_PREASSOC_PROCESSING);
+		assert((profile->state == VSI_PREASSOC_PROCESSING) ||
+		       (profile->state == VSI_PREASSOCIATED));
 		break;
 	case VSI_DEASSOC_PROCESSING:
 		assert((profile->state == VSI_PREASSOCIATED) ||
@@ -371,8 +451,8 @@ void vdp_vsi_sm_station(struct vsi_profile *profile)
 				vdp_somethingChangedLocal(profile, true);
 				ecp_somethingChangedLocal(vd);
 				ecp_tx_run_sm(vd);
-				vdp_start_keepaliveTimer(profile);
 			}
+			vdp_start_keepaliveTimer(profile);
 			 /* TODO:
 			  * vsiError = ProcRxandSetCfg(remoteTLV, localtlv, vsistate);
 			 *       if (!vsiError) vsistate=ASSOCIATED */
@@ -1080,6 +1160,7 @@ void vdp_ifdown(char *ifname)
 
 	LIST_FOREACH(p, &vd->profile_head, profile) {
 		vdp_stop_ackTimer(p);
+		vdp_stop_keepaliveTimer(p);
 		LIST_REMOVE(p, profile);
 		free(p);
 	}
-- 
1.7.2.3
