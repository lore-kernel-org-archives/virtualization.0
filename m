From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 2/3] implementation of vdp
Date: Thu, 17 Jun 2010 15:57:10 +0200
Message-ID: <1276783031-10239-3-git-send-email-jens@linux.vnet.ibm.com>
References: <1276783031-10239-1-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1276783031-10239-1-git-send-email-jens@linux.vnet.ibm.com>
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

This patch contains an initial implemention of VDP as specified in IEEE 802.1Qbg.
VDP serves as the upper layer protocol (ULP) for TLVs communicated via the
ECP protocol.
For this it registers as a new module in lldpad. The VDP module supports a
station and a bridge role. As a station, new VSI (virtual station interface)
profiles can be registered to the VDP module using lldptool or libvirt (at a
later point in time). These profiles are then announced to an adjacent
bridge. Transmitted profiles are processed to the desired state by the VDP
station state machine.
As a bridge, the VDP module waits for new profiles received in TLVs by ECP.
The received profiles are processed to the desired state by a VDP bridge
state machine.

The patch still contains a lot of debug code to allow analysis of VDP
protocol behavior.

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 Makefile.am    |    8 +-
 ecp/ecp_rx.c   |    9 +-
 ecp/ecp_tx.c   |   36 ++-
 include/lldp.h |    1 +
 lldp_vdp.c     | 1140 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lldpad.c       |    2 +
 6 files changed, 1190 insertions(+), 6 deletions(-)
 create mode 100644 lldp_vdp.c

diff --git a/Makefile.am b/Makefile.am
index 693e57d..e2ecce4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -71,16 +71,16 @@ lldp_tlv.c include/lldp_tlv.h \
 lldp_basman.c include/lldp_basman.h	\
 lldp_med.c include/lldp_med.h \
 lldp_8023.c include/lldp_8023.h \
-lldp_evb.c include/lldp_evb.h
-
-
+lldp_evb.c include/lldp_evb.h \
+lldp_vdp.c include/lldp_vdp.h
 
 dcbtool_SOURCES = dcbtool.c clif.c dcbtool_cmds.c parse_cli.l \
 $(lldpad_include_HEADERS) $(noinst_HEADERS)
 
 lldptool_SOURCES = lldptool.c clif.c lldptool_cmds.c common.c os_unix.c \
 lldp_mand_clif.c lldp_basman_clif.c lldp_med_clif.c lldp_8023_clif.c \
-lldp_dcbx_clif.c lldp_evb_clif.c $(lldpad_include_HEADERS) $(noinst_HEADERS)
+lldp_dcbx_clif.c lldp_evb_clif.c $(lldpad_include_HEADERS) \
+$(noinst_HEADERS)
 
 nltest_SOURCES = nltest.c nltest.h
 
diff --git a/ecp/ecp_rx.c b/ecp/ecp_rx.c
index d8c050f..cc54377 100644
--- a/ecp/ecp_rx.c
+++ b/ecp/ecp_rx.c
@@ -420,7 +420,14 @@ void ecp_rx_ProcessFrame(struct port * port)
 		tlv_offset += sizeof(*tlv_head_ptr) + tlv_length;
 
 		if (tlv->type == TYPE_127) { /* private TLV */
-			/* TODO: give VSI TLV to VDP */
+			/* give VSI TLV to VDP */
+			if (!vdp_indicate(port, tlv, ecp_hdr->mode))
+				tlv_stored = true;
+			else {
+				/* TODO: put it in a list and try again later until
+				 * timer and retries have expired */
+				tlv_stored = false;
+			}
 		}
 
 		if ((tlv->type != TYPE_0) && !tlv_stored) {
diff --git a/ecp/ecp_tx.c b/ecp/ecp_tx.c
index d31edba..78a61ca 100644
--- a/ecp/ecp_tx.c
+++ b/ecp/ecp_tx.c
@@ -98,6 +98,13 @@ bool ecp_build_ECPDU(struct port *port, int mode)
 	struct vdp_data *vd;
 	struct vsi_profile *p;
 
+	vd = vdp_data(port->ifname);
+	if (!vd) {
+		printf("%s(%i): could not find vdp_data for %s !\n", __func__, __LINE__,
+		       port->ifname);
+		goto error;
+	}
+
 	if (port->ecp.tx.frameout) {
 		free(port->ecp.tx.frameout);
 		port->ecp.tx.frameout = NULL;
@@ -145,7 +152,34 @@ bool ecp_build_ECPDU(struct port *port, int mode)
 	datasize += sizeof(struct ecp_hdr);
 	fb_offset += sizeof(struct ecp_hdr);
 
-	/* TODO: create tlvs from profiles here */
+	/* create packed_tlvs for all profiles on this interface */
+	LIST_FOREACH(p, &vd->profile_head, profile) {
+		if(!p) {
+			printf("%s(%i): list vd->profile_head empty !\n", __func__, __LINE__);
+			continue;
+		}
+
+		if (p->localChange != mode) {
+			printf("%s(%i): not sending out profile !\n", __func__, __LINE__);
+			continue;
+		}
+
+		ptlv = vdp_gettlv(port, p);
+
+		if(!ptlv) {
+			printf("%s(%i): ptlv not created !\n", __func__, __LINE__);
+			continue;
+		}
+
+		if (ptlv) {
+			if ((ptlv->size+fb_offset) > ETH_MAX_DATA_LEN)
+				goto error;
+			memcpy(port->ecp.tx.frameout+fb_offset,
+			       ptlv->tlv, ptlv->size);
+			datasize += ptlv->size;
+			fb_offset += ptlv->size;
+		}
+	}
 
 	/* The End TLV marks the end of the LLDP PDU */
 	ptlv = pack_end_tlv();
diff --git a/include/lldp.h b/include/lldp.h
index 21347b0..7af4149 100644
--- a/include/lldp.h
+++ b/include/lldp.h
@@ -190,6 +190,7 @@ enum {
 
 /* IEEE 802.1Qbg subtype */
 #define LLDP_EVB_SUBTYPE		0
+#define LLDP_VDP_SUBTYPE		0
 
 /* forwarding mode */
 #define LLDP_EVB_CAPABILITY_FORWARD_STANDARD		(1 << 7)
diff --git a/lldp_vdp.c b/lldp_vdp.c
new file mode 100644
index 0000000..a511a43
--- /dev/null
+++ b/lldp_vdp.c
@@ -0,0 +1,1140 @@
+/*******************************************************************************
+
+  implementation of VDP according to IEEE 802.1Qbg
+  (c) Copyright IBM Corp. 2010
+
+  Author(s): Jens Osterkamp <jens@linux.vnet.ibm.com>
+
+  This program is free software; you can redistribute it and/or modify it
+  under the terms and conditions of the GNU General Public License,
+  version 2, as published by the Free Software Foundation.
+
+  This program is distributed in the hope it will be useful, but WITHOUT
+  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+  more details.
+
+  You should have received a copy of the GNU General Public License along with
+  this program; if not, write to the Free Software Foundation, Inc.,
+  51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+
+  The full GNU General Public License is included in this distribution in
+  the file called "COPYING".
+
+*******************************************************************************/
+
+#include <net/if.h>
+#include <sys/queue.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <sys/utsname.h>
+#include <linux/if_bridge.h>
+#include "lldp.h"
+#include "lldp_vdp.h"
+#include "ecp/ecp.h"
+#include "lldp_evb.h"
+#include "messages.h"
+#include "config.h"
+#include "common.h"
+#include "lldp_vdp_clif.h"
+#include "lldp_vdp_cmds.h"
+
+/* vdp_data - searches vdp_data in the list of modules for this port
+ * @ifname: interface name to search for
+ *
+ * returns vdp_data on success, NULL on error
+ *
+ * searches the list of user_data for the VDP module user_data.
+ */
+struct vdp_data *vdp_data(char *ifname)
+{
+	struct vdp_user_data *ud;
+	struct vdp_data *vd = NULL;
+
+	ud = find_module_user_data_by_if(ifname, &lldp_head, LLDP_MOD_VDP);
+	if (ud) {
+		LIST_FOREACH(vd, &ud->head, entry) {
+			if (!strncmp(ifname, vd->ifname, IFNAMSIZ))
+				return vd;
+		}
+	}
+	return NULL;
+}
+
+/* vdp_free_tlv - free tlv in vdp_data
+ * @vd: vdp_data
+ *
+ * no return value
+ *
+ * frees up tlv in vdp_data. used in vdp_free_data.
+ */
+static void vdp_free_tlv(struct vdp_data *vd)
+{
+	if (vd) {
+		FREE_UNPKD_TLV(vd, vdp);
+	}
+}
+
+/* vdp_free_data - frees up vdp data
+ * @ud: user data structure
+ *
+ * no return value
+ *
+ * removes vd_structure from the user_data list. frees up tlv in vdp_data.
+ * used in vdp_unregister.
+ */
+static void vdp_free_data(struct vdp_user_data *ud)
+{
+	struct vdp_data *vd;
+	if (ud) {
+		while (!LIST_EMPTY(&ud->head)) {
+			vd = LIST_FIRST(&ud->head);
+			LIST_REMOVE(vd, entry);
+			vdp_free_tlv(vd);
+			free(vd);
+		}
+	}
+}
+
+/* vdp_print_profile - print a vsi profile
+ * @profile: profile to print
+ *
+ * no return value
+ *
+ * prints the contents of a profile first to a string using the PRINT_PROFILE
+ * macro, and then to the screen. Used for debug purposes.
+ */
+static inline void vdp_print_profile(struct vsi_profile *profile)
+{
+	char *s, *t;
+
+	s = t = malloc(VDP_BUF_SIZE);
+
+	 if (!s) {
+		printf("%s(%i): unable to allocate string !\n", __func__, __LINE__);
+	 }
+
+	PRINT_PROFILE(t, profile);
+
+	printf("profile: %s\n", s);
+
+	free(s);
+}
+
+/* vdp_somethingChangedLocal - set flag if profile has changed
+ * @profile: profile to set the flag for
+ * @mode: mode to set the flag to
+ *
+ * no return value
+ *
+ * set the localChange flag with a mode to indicate a profile has changed.
+ * used next time when a ecpdu with profiles is sent out.
+ */
+void vdp_somethingChangedLocal(struct vsi_profile *profile, int mode)
+{
+	profile->localChange = mode;
+}
+
+/* vdp_ackTimer_expired - checks for expired ack timer
+ * @profile: profile to be checked
+ *
+ * returns true or false
+ *
+ * returns value of profile->ackTimerExpired, true if ack timer has expired,
+ * false otherwise.
+ */
+static bool vdp_ackTimer_expired(struct vsi_profile *profile)
+{
+	return profile->ackTimerExpired;
+}
+
+/* vdp_timeout_handler - handles the ack timer expiry
+ * @eloop_data: data structure of event loop
+ * @user_ctx: user context, profile here
+ *
+ * no return value
+ *
+ * called when the VDP ack timer has expired. sets a flag and calls the VDP
+ * state machine.
+ */
+void vdp_timeout_handler(void *eloop_data, void *user_ctx)
+{
+	struct vsi_profile *profile;
+
+	profile = (struct vsi_profile *) user_ctx;
+
+	profile->ackTimerExpired = true;
+
+	printf("%s(%i)-%s: timer expired\n", __func__, __LINE__,
+	       profile->port->ifname);
+
+	vdp_vsi_sm_station(profile);
+}
+
+/* vdp_stop_ackTimer - stop the VDP ack timer
+ * @profile: profile to process
+ *
+ * returns the number of removed handlers
+ *
+ * stops the VDP ack timer. used when a ack frame for the profile has been
+ * received.
+ */
+static int vdp_stop_ackTimer(struct vsi_profile *profile)
+{
+	printf("%s(%i)-%s: stopping timer\n", __func__, __LINE__,
+	       profile->port->ifname);
+
+	return eloop_cancel_timeout(vdp_timeout_handler, NULL, (void *) profile);
+}
+
+/* vdp_start_ackTimer - starts the VDP ack timer
+ * @profile: profile to process
+ *
+ * returns 0 on success, -1 on error
+ *
+ * starts the ack timer when a frame has been sent out.
+ */
+static int vdp_start_ackTimer(struct vsi_profile *profile)
+{
+	unsigned int secs, usecs;
+
+	profile->ackTimerExpired = false;
+
+	secs = VDP_TRANSMISSION_TIMER / VDP_TRANSMISSION_DIVIDER;
+	usecs = VDP_TRANSMISSION_TIMER % VDP_TRANSMISSION_DIVIDER;
+
+	printf("%s(%i)-%s: starting timer\n", __func__, __LINE__,
+	       profile->port->ifname);
+
+	return eloop_register_timeout(secs, usecs, vdp_timeout_handler, NULL, (void *) profile);
+}
+
+/* vdp_vsi_change_station_state - changes the VDP station sm state
+ * @profile: profile to process
+ * @newstate: new state for the sm
+ *
+ * no return value
+ *
+ * actually changes the state of the profile
+ */
+void vdp_vsi_change_station_state(struct vsi_profile *profile, u8 newstate)
+{
+	switch(newstate) {
+	case VSI_UNASSOCIATED:
+		break;
+	case VSI_ASSOC_PROCESSING:
+		assert((profile->state == VSI_PREASSOCIATED) ||
+		       (profile->state == VSI_UNASSOCIATED));
+		break;
+	case VSI_ASSOCIATED:
+		assert(profile->state == VSI_ASSOC_PROCESSING);
+		break;
+	case VSI_PREASSOC_PROCESSING:
+		assert(profile->state == VSI_UNASSOCIATED);
+		break;
+	case VSI_PREASSOCIATED:
+		assert(profile->state == VSI_PREASSOC_PROCESSING);
+		break;
+	case VSI_DEASSOC_PROCESSING:
+		assert((profile->state == VSI_PREASSOCIATED) ||
+		       (profile->state == VSI_ASSOCIATED));
+		break;
+	case VSI_EXIT:
+		assert((profile->state == VSI_ASSOC_PROCESSING) ||
+		       (profile->state == VSI_PREASSOC_PROCESSING) ||
+		       (profile->state == VSI_DEASSOC_PROCESSING) ||
+		       (profile->state == VSI_PREASSOCIATED) ||
+		       (profile->state == VSI_ASSOCIATED));
+		break;
+	default:
+		printf("ERROR: The VDP station State Machine is broken!\n");
+		break;
+	}
+
+	printf("%s(%i)-%s: state change %s -> %s\n", __func__, __LINE__,
+	       profile->port->ifname, vsi_states[profile->state], vsi_states[newstate]);
+
+	profile->state = newstate;
+}
+
+/* vdp_vsi_set_station_state - sets the vdp sm station state
+ * @profile: profile to process
+ *
+ * returns true or false
+ *
+ * switches the state machine to the next state depending on the input
+ * variables. returns true or false depending on wether the state machine
+ * can be run again with the new state or can stop at the current state.
+ */
+static bool vdp_vsi_set_station_state(struct vsi_profile *profile)
+{
+	switch(profile->state) {
+	case VSI_UNASSOCIATED:
+		if ((profile->mode == VDP_MODE_PREASSOCIATE) ||
+		    (profile->mode == VDP_MODE_PREASSOCIATE_WITH_RR)) {
+			vdp_vsi_change_station_state(profile, VSI_PREASSOC_PROCESSING);
+			return true;
+		} else if (profile->mode == VDP_MODE_ASSOCIATE) {
+			vdp_vsi_change_station_state(profile, VSI_ASSOC_PROCESSING);
+			return true;
+		}
+		return false;
+	case VSI_ASSOC_PROCESSING:
+		if (profile->ackReceived) {
+			vdp_vsi_change_station_state(profile, VSI_ASSOCIATED);
+			return true;
+		} else if (!profile->ackReceived && vdp_ackTimer_expired(profile)) {
+			vdp_vsi_change_station_state(profile, VSI_EXIT);
+			return true;
+		}
+		return false;
+	case VSI_ASSOCIATED:
+		if (profile->mode == VDP_MODE_PREASSOCIATE) {
+			vdp_vsi_change_station_state(profile, VSI_PREASSOC_PROCESSING);
+			return true;
+		} else if (profile->mode == VDP_MODE_DEASSOCIATE) {
+			vdp_vsi_change_station_state(profile, VSI_DEASSOC_PROCESSING);
+			return true;
+		}
+		return false;
+	case VSI_PREASSOC_PROCESSING:
+		if (profile->ackReceived) {
+			vdp_vsi_change_station_state(profile, VSI_PREASSOCIATED);
+			return true;
+		} else if (vdp_ackTimer_expired(profile)) {
+			vdp_vsi_change_station_state(profile, VSI_EXIT);
+			return true;
+		}
+	case VSI_PREASSOCIATED:
+		if (profile->mode == VDP_MODE_DEASSOCIATE) {
+			vdp_vsi_change_station_state(profile, VSI_DEASSOC_PROCESSING);
+			return true;
+		}
+		if (profile->mode == VDP_MODE_ASSOCIATE) {
+			vdp_vsi_change_station_state(profile, VSI_ASSOC_PROCESSING);
+			return true;
+		}
+		return false;
+	case VSI_DEASSOC_PROCESSING:
+		if ((profile->ackReceived) || vdp_ackTimer_expired(profile)) {
+			vdp_vsi_change_station_state(profile, VSI_EXIT);
+			return true;
+		}
+		return false;
+	case VSI_EXIT:
+		return false;
+	default:
+		printf("ERROR: The VSI RX State Machine is broken!\n");
+		log_message(MSG_ERR_RX_SM_INVALID, "");
+		return false;
+	}
+}
+
+/* vdp_vsi_sm_station - state machine for vdp station role
+ * @profile: profile for which the state is processed
+ *
+ * no return value
+ *
+ * runs the state machine for the station role of VDP.
+ */
+void vdp_vsi_sm_station(struct vsi_profile *profile)
+{
+	vdp_vsi_set_station_state(profile);
+	do {
+		printf("%s(%i)-%s: station - %s\n", __func__, __LINE__,
+		       profile->port->ifname, vsi_states[profile->state]);
+
+		switch(profile->state) {
+		case VSI_UNASSOCIATED:
+			break;
+		case VSI_ASSOC_PROCESSING:
+			vdp_somethingChangedLocal(profile, VDP_PROFILE_REQ);
+			ecp_somethingChangedLocal(profile->port, VDP_PROFILE_REQ);
+			ecp_tx_run_sm(profile->port);
+			vdp_start_ackTimer(profile);
+			break;
+		case VSI_ASSOCIATED:
+			 vdp_stop_ackTimer(profile);
+			 /* TODO:
+			  * vsiError = ProcRxandSetCfg(remoteTLV, localtlv, vsistate);
+			 *       if (!vsiError) vsistate=ASSOCIATED */
+			break;
+		case VSI_PREASSOC_PROCESSING:
+			/* send out profile */
+			vdp_somethingChangedLocal(profile, VDP_PROFILE_REQ);
+			ecp_somethingChangedLocal(profile->port, VDP_PROFILE_REQ);
+			ecp_tx_run_sm(profile->port);
+			vdp_start_ackTimer(profile);
+			break;
+		case VSI_PREASSOCIATED:
+			profile->ackReceived = false;
+			vdp_somethingChangedLocal(profile, VDP_PROFILE_NOCHANGE);
+			vdp_stop_ackTimer(profile);
+			/* TODO	 vsiError = ProcRxandSetCfg(remoteTLV, localtlv, vsistate);
+			 *       if (!vsiError) vsistate=PREASSOCIATED */
+			break;
+		case VSI_DEASSOC_PROCESSING:
+			vdp_somethingChangedLocal(profile, VDP_PROFILE_REQ);
+			vdp_start_ackTimer(profile);
+			break;
+		case VSI_EXIT:
+			/* TODO: something went wrong, remove this profile */
+			break;
+		default:
+			printf("ERROR: The VSI RX station State Machine is broken!\n");
+			log_message(MSG_ERR_TX_SM_INVALID, "");
+		}
+	} while (vdp_vsi_set_station_state(profile) == true);
+
+}
+
+/* vdp_vsi_change_bridge_state - changes the VDP bridge sm state
+ * @profile: profile to process
+ * @newstate: new state for the sm
+ *
+ * no return value
+ *
+ * actually changes the state of the profile
+ */
+static void vdp_vsi_change_bridge_state(struct vsi_profile *profile, u8 newstate)
+{
+	switch(newstate) {
+	case VSI_UNASSOCIATED:
+		break;
+	case VSI_ASSOC_PROCESSING:
+		assert((profile->state == VSI_UNASSOCIATED) ||
+		      (profile->state == VSI_PREASSOCIATED) ||
+		      (profile->state == VSI_ASSOCIATED));
+		break;
+	case VSI_ASSOCIATED:
+		assert(profile->state == VSI_ASSOC_PROCESSING);
+		break;
+	case VSI_PREASSOC_PROCESSING:
+		assert((profile->state == VSI_UNASSOCIATED) ||
+		      (profile->state == VSI_PREASSOCIATED) ||
+		      (profile->state == VSI_ASSOCIATED));
+		break;
+	case VSI_PREASSOCIATED:
+		assert(profile->state == VSI_PREASSOC_PROCESSING);
+		break;
+	case VSI_DEASSOC_PROCESSING:
+		assert((profile->state == VSI_UNASSOCIATED) ||
+		      (profile->state == VSI_PREASSOCIATED) ||
+		      (profile->state == VSI_ASSOCIATED));
+		break;
+	case VSI_EXIT:
+		assert((profile->state == VSI_DEASSOC_PROCESSING) ||
+		      (profile->state == VSI_PREASSOC_PROCESSING) ||
+		      (profile->state == VSI_ASSOC_PROCESSING));
+		break;
+	default:
+		printf("ERROR: The VDP bridge State Machine is broken!\n");
+		break;
+	}
+	profile->state = newstate;
+}
+
+/* vdp_vsi_set_bridge_state - sets the vdp sm bridge state
+ * @profile: profile to process
+ *
+ * returns true or false
+ *
+ * switches the state machine to the next state depending on the input
+ * variables. returns true or false depending on wether the state machine
+ * can be run again with the new state or can stop at the current state.
+ */
+static bool vdp_vsi_set_bridge_state(struct vsi_profile *profile)
+{
+	switch(profile->state) {
+	case VSI_UNASSOCIATED:
+		if ((profile->mode == VDP_MODE_DEASSOCIATE)) /* || (INACTIVE)) */ {
+			vdp_vsi_change_bridge_state(profile, VSI_DEASSOC_PROCESSING);
+			return true;
+		} else if (profile->mode == VDP_MODE_ASSOCIATE) {
+			vdp_vsi_change_bridge_state(profile, VSI_ASSOC_PROCESSING);
+			return true;
+		} else if (profile->mode == VDP_MODE_PREASSOCIATE) {
+			vdp_vsi_change_bridge_state(profile, VSI_PREASSOC_PROCESSING);
+			return true;
+		}
+		return false;
+	case VSI_ASSOC_PROCESSING:
+		/* TODO: handle error case
+		if (!vsiError) ||
+		   (vsiError && vsiState == Assoc) {
+		   */
+		if (profile->mode == VDP_MODE_ASSOCIATE) {
+			vdp_vsi_change_bridge_state(profile, VSI_ASSOCIATED);
+			return true;
+		}
+		return false;
+	case VSI_ASSOCIATED:
+		if (profile->mode == VDP_MODE_ASSOCIATE) /* || ( INACTIVE )*/ {
+			vdp_vsi_change_bridge_state(profile, VSI_DEASSOC_PROCESSING);
+			return true;
+		} else if (profile->mode == VDP_MODE_PREASSOCIATE) {
+			vdp_vsi_change_bridge_state(profile, VSI_PREASSOC_PROCESSING);
+			return true;
+		}  else if (profile->mode == VDP_MODE_ASSOCIATE) {
+			vdp_vsi_change_bridge_state(profile, VSI_ASSOC_PROCESSING);
+			return true;
+		}
+		return false;
+	case VSI_PREASSOC_PROCESSING:
+		 if (profile->response != VDP_RESPONSE_SUCCESS) {
+			vdp_vsi_change_bridge_state(profile, VSI_EXIT);
+			return true;
+		 }
+		vdp_vsi_change_bridge_state(profile, VSI_PREASSOCIATED);
+		return false;
+	case VSI_PREASSOCIATED:
+		if (profile->mode == VDP_MODE_ASSOCIATE) {
+			vdp_vsi_change_bridge_state(profile, VSI_ASSOC_PROCESSING);
+			return true;
+		} else if (profile->mode == VDP_MODE_DEASSOCIATE ) {
+			vdp_vsi_change_bridge_state(profile, VSI_DEASSOC_PROCESSING);
+			return true;
+		}  else if (profile->mode == VDP_MODE_PREASSOCIATE ) {
+			vdp_vsi_change_bridge_state(profile, VSI_PREASSOC_PROCESSING);
+			return true;
+		}
+		return false;
+	case VSI_DEASSOC_PROCESSING:
+		vdp_vsi_change_bridge_state(profile, VSI_EXIT);
+		return false;
+	case VSI_EXIT:
+		return false;
+	default:
+		printf("ERROR: The VSI RX State Machine (bridge) is broken!\n");
+		log_message(MSG_ERR_RX_SM_INVALID, "");
+		return false;
+	}
+}
+
+/* vdp_vsi_sm_bridge - state machine for vdp bridge role
+ * @profile: profile for which the state is processed
+ *
+ * no return value
+ *
+ * runs the state machine for the bridge role of VDP.
+ */
+static void vdp_vsi_sm_bridge(struct vsi_profile *profile)
+{
+	vdp_vsi_set_bridge_state(profile);
+	do {
+		printf("%s(%i)-%s: bridge - %s\n", __func__, __LINE__,
+		       profile->port->ifname, vsi_states[profile->state]);
+		switch(profile->state) {
+		case VSI_UNASSOCIATED:
+			break;
+		case VSI_ASSOC_PROCESSING:
+			/* TODO: vsiError = ProcRxandSetCfg(remoteTLV, localtlv, vsistate);
+			 *       if (vsiError)
+			 *		txTLV(Assoc NACK)
+			 *       else
+			 *		txTLV(Assoc ACK) */
+			break;
+		case VSI_ASSOCIATED:
+			break;
+		case VSI_PREASSOC_PROCESSING:
+			/* TODO: vsiError = ProcRxandSetCfg(remoteTLV, localtlv, vsistate);
+			 *       if (vsiError)
+			 *		txTLV(PreAssoc NACK)
+			 *       else
+			 *		txTLV(PreAssoc ACK) */
+			/* for now, we always succeed */
+			profile->response = VDP_RESPONSE_SUCCESS;
+			printf("%s(%i)-%s: framein %p, sizein %i\n", __func__, __LINE__,
+			       profile->port->ifname, profile->port->ecp.rx.framein,
+			       profile->port->ecp.rx.sizein);
+			ecp_rx_send_ack_frame(profile->port);
+			break;
+		case VSI_PREASSOCIATED:
+			printf("%s(%i)-%s: \n", __func__, __LINE__, profile->port->ifname);
+			break;
+		case VSI_DEASSOC_PROCESSING:
+			/* TODO: txTLV(DeAssoc ACK) */
+			break;
+		case VSI_EXIT:
+			/* TODO: something went wrong, remove this profile */
+			break;
+		default:
+			printf("ERROR: The VSI RX bridge State Machine is broken!\n");
+			log_message(MSG_ERR_TX_SM_INVALID, "");
+		}
+	} while (vdp_vsi_set_bridge_state(profile) == true);
+
+}
+
+/*
+ * vdp_print_vsi_tlv - print the raw contents of a VSI TLV
+ * @tlv: the unpacked tlv which gets printed
+ *
+ * No return value
+ *
+ * used for protocol debug purposes
+ */
+static void vdp_print_vsi_tlv(struct unpacked_tlv *tlv)
+{
+	int i;
+
+	printf("### %s:type %i, length %i, info:\n", __func__, tlv->type, tlv->length);
+
+	for (i=0; i < tlv->length; i++) {
+		printf("%02x ", tlv->info[i]);
+		if (!((i+1) % 16))
+			printf("\n");
+	}
+
+	printf("\n");
+}
+
+/*
+ * vdp_validate_tlv - validates vsi tlvs
+ * @vdp: decoded vsi tlv
+ *
+ * Returns 0 on success, 1 on error
+ *
+ * checks the contents of an already decoded vsi tlv for inconsistencies
+ */
+static int vdp_validate_tlv(struct tlv_info_vdp *vdp)
+{
+	if (ntoh24(vdp->oui) != OUI_IEEE_8021Qbg) {
+		printf("vdp->oui %06x \n", vdp->oui);
+		goto out_err;
+	}
+
+	if (vdp->sub != LLDP_VDP_SUBTYPE) {
+		printf("vdp->sub %02x \n", vdp->sub);
+		goto out_err;
+	}
+
+	if ((vdp->mode < VDP_MODE_PREASSOCIATE) ||
+		(vdp->mode > VDP_MODE_DEASSOCIATE)) {
+		printf("Unknown mode %02x in vsi tlv !\n", vdp->mode);
+		goto out_err;
+	}
+
+	if ((vdp->response < VDP_RESPONSE_SUCCESS) ||
+		(vdp->response > VDP_RESPONSE_OUT_OF_SYNC)) {
+		printf("Unknown response %02x \n", vdp->response);
+		goto out_err;
+	}
+
+	if (vdp->format != VDP_MACVLAN_FORMAT_1) {
+		printf("Unknown format %02x in vsi tlv !\n", vdp->format);
+		goto out_err;
+	}
+
+	if (vdp->entries != 1) {
+		printf("Multiple entries %02x in vsi tlv !\n", vdp->entries);
+		goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	return 1;
+}
+
+/*
+ * vdp_indicate - receive VSI TLVs from ECP
+ * @port: the port on which the tlv was received
+ * @tlv: the unpacked tlv to receive
+ * @ecp_mode: the mode under which the tlv was received (ACK or REQ)
+ *
+ * Returns 0 on success
+ *
+ * receives a vsi tlv and creates a profile. Take appropriate action
+ * depending on the role of the (receive) port
+ */
+int vdp_indicate(struct port *port, struct unpacked_tlv *tlv, int ecp_mode)
+{
+	char *s, *t;
+	struct vdp_data *vd;
+	struct tlv_info_vdp *vdp;
+	struct vsi_profile *p, *profile;
+
+	vd = vdp_data(port->ifname);
+	if (!vd) {
+		fprintf(stderr, "### %s:%s does not exist !\n", __func__,
+			port->ifname);
+		goto out_err;
+	}
+
+	vdp = malloc(sizeof(struct tlv_info_vdp));
+
+	if (!vdp) {
+		printf("%s(%i): unable to allocate vdp !\n", __func__, __LINE__);
+		goto out_err;
+	}
+
+	memset(vdp, 0, sizeof(struct tlv_info_vdp));
+	memcpy(vdp, tlv->info, tlv->length);
+
+	if (vdp_validate_tlv(vdp)) {
+		printf("%s(%i): Invalid TLV received !\n", __func__, __LINE__);
+		goto out_err;
+	}
+
+	profile = malloc(sizeof(struct vsi_profile));
+
+	 if (!profile) {
+		printf("%s(%i): unable to allocate profile !\n", __func__, __LINE__);
+		goto out_vdp;
+	 }
+
+	memset(profile, 0, sizeof(struct vsi_profile));
+
+	profile->mode = vdp->mode;
+	profile->response = vdp->response;
+
+	profile->mgrid = vdp->mgrid;
+	memcpy(&profile->id, &vdp->id, 3);
+	profile->version = vdp->version;
+	memcpy(&profile->instance, &vdp->instance, 16);
+	memcpy(&profile->mac, &vdp->mac_vlan.mac, MAC_ADDR_LEN);
+	profile->vlan = vdp->mac_vlan.vlan;
+
+	profile->port = port;
+	printf("%s(%i):\n", __func__, __LINE__);
+
+	if (vd->role == VDP_ROLE_STATION) {
+		/* do we have the profile already ? */
+		LIST_FOREACH(p, &vd->profile_head, profile) {
+			if (vdp_profile_equal(p, profile)) {
+				printf("%s(%i): station: profile found, localChange %i ackReceived %i!\n",
+				       __func__, __LINE__, p->localChange, p->ackReceived);
+
+				if (ecp_mode == ECP_ACK)
+					p->ackReceived = true;
+
+				vdp_vsi_sm_station(p);
+			} else {
+				printf("%s(%i): station: profile not found !\n", __func__, __LINE__);
+				/* ignore profile */
+			}
+		}
+	}
+
+	if (vd->role == VDP_ROLE_BRIDGE) {
+		/* do we have the profile already ? */
+		LIST_FOREACH(p, &vd->profile_head, profile) {
+			if (vdp_profile_equal(p, profile)) {
+				break;
+			}
+		}
+
+		if (p) {
+			printf("%s(%i): bridge: profile found !\n", __func__, __LINE__);
+		} else {
+			printf("%s(%i): bridge: profile not found !\n", __func__, __LINE__);
+			/* put it in the list  */
+			profile->state = VSI_UNASSOCIATED;
+			LIST_INSERT_HEAD(&vd->profile_head, profile, profile );
+		}
+
+		vdp_vsi_sm_bridge(profile);
+	}
+
+	return 0;
+
+out_vdp:
+	free(vdp);
+out_err:
+	printf("%s(%i): error !\n", __func__, __LINE__);
+	return 1;
+
+}
+
+/*
+ * vdp_bld_vsi_tlv - build the VDP VSI TLV
+ * @vd: vdp_data structure for this port
+ * @profile: profile the vsi tlv is created from
+ *
+ * Returns 0 on success, ENOMEM otherwise
+ *
+ * creates a vdp structure from an existing profile
+ */
+static int vdp_bld_vsi_tlv(struct vdp_data *vd, struct vsi_profile *profile)
+{
+	int rc = 0;
+	int i;
+	struct unpacked_tlv *tlv = NULL;
+	struct tlv_info_vdp vdp;
+
+	FREE_UNPKD_TLV(vd, vdp);
+
+	memset(&vdp, 0, sizeof(vdp));
+
+	hton24(vdp.oui, OUI_IEEE_8021Qbg);
+	vdp.sub = LLDP_VDP_SUBTYPE;
+	vdp.mode = profile->mode;
+	vdp.response = 0;
+	vdp.mgrid = profile->mgrid;
+	memcpy(&vdp.id,&profile->id, 3);
+	vdp.version = profile->version;
+	memcpy(&vdp.instance,&profile->instance, 16);
+	vdp.format = VDP_MACVLAN_FORMAT_1;
+	vdp.entries = 1;
+	memcpy(&vdp.mac_vlan.mac,&profile->mac, MAC_ADDR_LEN);
+	vdp.mac_vlan.vlan = profile->vlan;
+
+	tlv = create_tlv();
+	if (!tlv)
+		goto out_err;
+
+	tlv->type = ORG_SPECIFIC_TLV;
+	tlv->length = sizeof(vdp);
+	tlv->info = (u8 *)malloc(tlv->length);
+	if(!tlv->info) {
+		free(tlv);
+		tlv = NULL;
+		rc = ENOMEM;
+		goto out_err;
+	}
+	memcpy(tlv->info, &vdp, tlv->length);
+
+	vd->vdp = tlv;
+
+out_err:
+	return rc;
+}
+
+/* vdp_bld_tlv - builds a tlv from a profile
+ * @vd: vdp_data structure for this port
+ * @profile: profile the vsi tlv is created from
+ *
+ * returns 0 on success, != 0 on error
+ *
+ * wrapper function around vdp_bld_vsi_tlv. adds some checks and calls
+ * vdp_bld_vsi_tlv.
+*/
+
+static int vdp_bld_tlv(struct vdp_data *vd, struct vsi_profile *profile)
+{
+	int rc = 0;
+
+	if (!port_find_by_name(vd->ifname)) {
+		rc = EEXIST;
+		goto out_err;
+	}
+
+	if (!init_cfg()) {
+		rc = ENOENT;
+		goto out_err;
+	}
+
+	if (vdp_bld_vsi_tlv(vd, profile)) {
+		fprintf(stderr, "### %s:%s:vdp_bld_cfg_tlv() failed\n",
+				__func__, vd->ifname);
+		rc = EINVAL;
+		goto out_err_destroy;
+	}
+
+out_err_destroy:
+	destroy_cfg();
+
+out_err:
+	return rc;
+}
+
+/* vdp_gettlv - get the tlv for a profile
+ * @port: the port on which the tlv was received
+ * @profile: profile the vsi tlv is created from
+ *
+ * returns 0 on success
+ *
+ * this is the interface function called from ecp_build_ECPDU. It returns the
+ * packed tlv for a profile.
+ */
+struct packed_tlv *vdp_gettlv(struct port *port, struct vsi_profile *profile)
+{
+	int size;
+	struct vdp_data *vd;
+	struct packed_tlv *ptlv = NULL;
+
+	vd = vdp_data(port->ifname);
+	if (!vd) {
+		printf("%s(%i): Could not find vdp_data for %s !\n", __func__, __LINE__,
+		       port->ifname);
+		goto out_err;
+	}
+
+	/* frees the unpacked_tlv in vdp_data
+	 * also done in vdp_bld_vsi_tlv */
+	vdp_free_tlv(vd);
+
+	if (vdp_bld_tlv(vd, profile)) {
+		fprintf(stderr, "### %s:%s vdp_bld_tlv failed\n",
+			__func__, port->ifname);
+		goto out_err;
+	}
+
+	size = TLVSIZE(vd->vdp);
+
+	if (!size) {
+		printf("%s(%i): size %i of unpacked_tlv not correct !\n", __func__, __LINE__,
+		       size);
+		goto out_err;
+	}
+
+	ptlv = create_ptlv();
+	if (!ptlv)
+		goto out_err;
+
+	ptlv->tlv = malloc(size);
+	if (!ptlv->tlv)
+		goto out_free;
+
+	ptlv->size = 0;
+	PACK_TLV_AFTER(vd->vdp, ptlv, size, out_free);
+
+	return ptlv;
+
+out_free:
+	ptlv = free_pkd_tlv(ptlv);
+out_err:
+	fprintf(stderr,"### %s:%s: failed\n", __func__, port->ifname);
+	return NULL;
+}
+
+/* vdp_profile_equal - checks for equality of 2 profiles
+ * @p1: profile 1
+ * @p2: profile 2
+ *
+ * returns 1 on success, 0 on error
+ *
+ * compares mgrid, id, version, instance, mac and vlan of 2 profiles to find
+ * out if they are equal.
+ */
+int vdp_profile_equal(struct vsi_profile *p1, struct vsi_profile *p2)
+{
+	if (p1->mgrid != p2->mgrid)
+		return 0;
+
+	if (memcmp(p1->id, p2->id, 3))
+		return 0;
+
+	if (p1->version != p2->version)
+		return 0;
+
+	if (memcmp(p1->instance, p2->instance, 16))
+		return 0;
+
+	if (memcmp(p1->mac, p2->mac, MAC_ADDR_LEN))
+		return 0;
+
+	if (p1->vlan != p2->vlan)
+		return 0;
+
+	return 1;
+}
+
+/* vdp_add_profile - adds a profile to a per port list
+ * @profile: profile to add
+ *
+ * returns the profile that has been found or added
+ *
+ * main interface function which adds a profile to a list kept on a per-port
+ * basis. Checks if the profile is already in the list, adds it if necessary.
+ */
+struct vsi_profile *vdp_add_profile(struct vsi_profile *profile)
+{
+	struct port *port;
+	struct vsi_profile *p;
+	struct vdp_data *vd;
+
+	vd = vdp_data(profile->port->ifname);
+	if (!vd) {
+		printf("%s(%i): Could not find vdp_data for %i !\n", __func__, __LINE__,
+		       profile->port->ifname);
+		return NULL;
+	}
+
+	vdp_print_profile(profile);
+
+	/* loop over all existing profiles and check wether
+	 * one for this combination already exists. If yes, check,
+	 * if the MAC/VLAN pair already exists. If not, add it.
+	 * Note: currently only one MAC/VLAN pair supported ! */
+	LIST_FOREACH(p, &vd->profile_head, profile) {
+		if (p) {
+			vdp_print_profile(p);
+			if (vdp_profile_equal(p, profile)) {
+				if (p->mode == profile->mode) {
+					printf("%s(%i): profile already exists, ignoring !\n",
+					       __func__, __LINE__);
+					return NULL;
+				} else {
+					printf("%s(%i): taking new mode !\n", __func__,
+					       __LINE__);
+					p->mode = profile->mode;
+					return p;
+				}
+			}
+		}
+	}
+
+	LIST_INSERT_HEAD(&vd->profile_head, profile, profile );
+
+	return profile;
+}
+
+/* vdp_ifdown - tear down vdp structures for a interface
+ * @ifname: name of the interface
+ *
+ * no return value
+ *
+ * interface function to lldpad. tears down vdp specific structures if
+ * interface "ifname" goes down.
+ */
+void vdp_ifdown(char *ifname)
+{
+	struct vdp_data *vd;
+	struct vsi_tlv *vtlv;
+	struct vsi_profile *p;
+
+	vd = vdp_data(ifname);
+	if (!vd)
+		goto out_err;
+
+	LIST_REMOVE(vd, entry);
+
+	LIST_FOREACH(p, &vd->profile_head, profile) {
+		free(p);
+		LIST_REMOVE(p, profile);
+	}
+	vdp_free_tlv(vd);
+	free(vd);
+	fprintf(stderr, "### %s:port %s removed\n", __func__, ifname);
+	return;
+out_err:
+	fprintf(stderr, "### %s:port %s adding failed\n", __func__, ifname);
+
+	return;
+}
+
+/* vdp_ifup - build up vdp structures for a interface
+ * @ifname: name of the interface
+ *
+ * no return value
+ *
+ * interface function to lldpad. builds up vdp specific structures if
+ * interface "ifname" goes down.
+ */
+void vdp_ifup(char *ifname)
+{
+	struct vdp_data *vd;
+	struct vdp_user_data *ud;
+	char arg_path[VDP_BUF_SIZE];
+
+	vd = vdp_data(ifname);
+	if (vd) {
+		fprintf(stderr, "### %s:%s exists\n", __func__, ifname);
+		goto out_err;
+	}
+
+	/* not found, alloc/init per-port module data */
+	vd = (struct vdp_data *) calloc(1, sizeof(struct vdp_data));
+	if (!vd) {
+		fprintf(stderr, "### %s:%s malloc %ld failed\n",
+			 __func__, ifname, sizeof(*vd));
+		goto out_err;
+	}
+	strncpy(vd->ifname, ifname, IFNAMSIZ);
+
+	if (!init_cfg())
+		goto out_err;
+
+	if (get_config_setting(ifname, ARG_VDP_ROLE,
+			(void *)&vd->role, CONFIG_TYPE_INT)) {
+		vd->role = VDP_ROLE_STATION;
+	}
+
+	if (vd->role == VDP_ROLE_BRIDGE)
+		printf("### %s: configured for bridge mode (%i)!\n", ifname, vd->role);
+	else
+		printf("### %s: configured for station mode (%i)!\n", ifname, vd->role);
+
+	LIST_INIT(&vd->profile_head);
+
+	ud = find_module_user_data_by_if(ifname, &lldp_head, LLDP_MOD_VDP);
+	LIST_INSERT_HEAD(&ud->head, vd, entry);
+
+	ecp_init(ifname);
+
+	fprintf(stderr, "### %s:port %s added\n", __func__, ifname);
+	return;
+
+out_err:
+	fprintf(stderr, "### %s:port %s adding failed\n", __func__, ifname);
+	return;
+}
+
+static const struct lldp_mod_ops vdp_ops =  {
+	.lldp_mod_register	= vdp_register,
+	.lldp_mod_unregister	= vdp_unregister,
+	.lldp_mod_ifup		= vdp_ifup,
+	.lldp_mod_ifdown	= vdp_ifdown,
+	.get_arg_handler	= vdp_get_arg_handlers,
+};
+
+/* vdp_register - register vdp module to lldpad
+ * @none
+ *
+ * returns lldp_module struct on success, NULL on error
+ *
+ * allocates a module structure with vdp module information and returns it
+ * to lldpad.
+ */
+struct lldp_module *vdp_register(void)
+{
+	struct lldp_module *mod;
+	struct vdp_user_data *ud;
+
+	mod = malloc(sizeof(*mod));
+	if (!mod) {
+		fprintf(stderr, "failed to malloc module data\n");
+		log_message(MSG_ERR_SERVICE_START_FAILURE,
+			"%s", "failed to malloc module data");
+		goto out_err;
+	}
+	ud = malloc(sizeof(struct vdp_user_data));
+	if (!ud) {
+		free(mod);
+		fprintf(stderr, "failed to malloc module user data\n");
+		log_message(MSG_ERR_SERVICE_START_FAILURE,
+			"%s", "failed to malloc module user data");
+		goto out_err;
+	}
+	LIST_INIT(&ud->head);
+	mod->id = LLDP_MOD_VDP;
+	mod->ops = &vdp_ops;
+	mod->data = ud;
+	fprintf(stderr, "### %s:done\n", __func__);
+	return mod;
+
+out_err:
+	fprintf(stderr, "### %s:failed\n", __func__);
+	return NULL;
+}
+
+/* vdp_unregister - unregister vdp module from lldpad
+ * @none
+ *
+ * no return value
+ *
+ * frees vdp module structure.
+ */
+void vdp_unregister(struct lldp_module *mod)
+{
+	if (mod->data) {
+		vdp_free_data((struct vdp_user_data *) mod->data);
+		free(mod->data);
+	}
+	free(mod);
+	fprintf(stderr, "### %s:done\n", __func__);
+}
+
+
diff --git a/lldpad.c b/lldpad.c
index 711a995..7a8b75b 100644
--- a/lldpad.c
+++ b/lldpad.c
@@ -50,6 +50,7 @@
 #include "lldp_med.h"
 #include "lldp_8023.h"
 #include "lldp_evb.h"
+#include "lldp_vdp.h"
 #include "config.h"
 #include "lldpad_shm.h"
 #include "clif.h"
@@ -65,6 +66,7 @@ struct lldp_module *(*register_tlv_table[])(void) = {
 	med_register,
 	ieee8023_register,
 	evb_register,
+	vdp_register,
 	NULL,
 };
 
-- 
1.7.1
