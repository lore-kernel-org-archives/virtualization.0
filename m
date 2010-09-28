From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 4/9] implementation of IEEE 802.1Qbg in lldpad, part 2
Date: Tue, 28 Sep 2010 17:10:57 +0200
Message-ID: <1285686662-8561-5-git-send-email-jens@linux.vnet.ibm.com>
References: <1285686662-8561-1-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1285686662-8561-1-git-send-email-jens@linux.vnet.ibm.com>
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

This is the implementation of the edge control protocol (ECP) and VSI
discovery protocol (VDP) currently being specified in IEEE 802.1Qbg.

This implementation extends the infrastructure defined lldpad to send and
receive ECP frames with a new (yet to be defined) ethertype.
Received frames are validated and analyzed before the content is handed to the
upper layer protocol (ULP, VDP in this case) for further processing. Frames
to be transmitted are compiled from VSI (guest interface) profiles registered
on a interface.
Reception and transmission of ECP frames is controlled by RX and TX state
machines, timeouts are handled timeout functions.
The patch still contains a lot of debug code to allow low-level protocol
analysis.

VDP serves as the upper layer protocol (ULP) for TLVs communicated via the
ECP protocol.
For this it registers as a new module in lldpad. The VDP module supports a
station and a bridge role. As a station, new VSI (virtual station interface)
profiles can be registered to the VDP module using lldptool or libvirt.
These profiles are then announced to an adjacent switch. Transmitted profiles
are processed to the desired state by the VDP station state machine.
As a bridge, the VDP module waits for new profiles received in TLVs by ECP.
The received profiles are processed to the desired state by a VDP bridge
state machine.

VDP module parameters are stored in the "vdp" section under the appropriate
interface.

The patch still contains a lot of debug code to allow analysis of VDP
protocol behavior.

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 Makefile.am        |   10 +-
 ecp/ecp.c          |   79 ++++
 ecp/ecp.h          |  101 +++++
 ecp/ecp_rx.c       |  599 ++++++++++++++++++++++++++
 ecp/ecp_tx.c       |  494 ++++++++++++++++++++++
 include/lldp.h     |    1 +
 include/lldp_evb.h |    6 +
 include/lldp_vdp.h |  159 +++++++
 lldp/l2_packet.h   |    2 +
 lldp/ports.h       |   11 +-
 lldp_vdp.c         | 1185 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 lldpad.c           |    2 +
 12 files changed, 2642 insertions(+), 7 deletions(-)
 create mode 100644 ecp/ecp.c
 create mode 100644 ecp/ecp.h
 create mode 100644 ecp/ecp_rx.c
 create mode 100644 ecp/ecp_tx.c
 create mode 100644 include/lldp_vdp.h
 create mode 100644 lldp_vdp.c

diff --git a/Makefile.am b/Makefile.am
index d59a6fa..4b69389 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -56,6 +56,8 @@ $(lldpad_include_HEADERS) $(noinst_HEADERS) \
 lldp/ports.c lldp/agent.c lldp/l2_packet_linux.c lldp/tx.c \
 lldp/rx.c lldp/agent.h lldp/l2_packet.h lldp/mibdata.h lldp/ports.h \
 lldp/states.h \
+ecp/ecp.c ecp/ecp_tx.c \
+ecp/ecp_rx.c \
 include/lldp.h include/lldp_mod.h \
 lldp_dcbx.c include/lldp_dcbx.h tlv_dcbx.c include/tlv_dcbx.h \
 lldp_dcbx_cfg.c include/lldp_dcbx_cfg.h \
@@ -67,16 +69,16 @@ lldp_tlv.c include/lldp_tlv.h \
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
 
diff --git a/ecp/ecp.c b/ecp/ecp.c
new file mode 100644
index 0000000..20a8e66
--- /dev/null
+++ b/ecp/ecp.c
@@ -0,0 +1,79 @@
+/*******************************************************************************
+
+  implementation of ECP according to 802.1Qbg
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
+#include "lldp_evb.h"
+#include "lldp_vdp.h"
+#include "messages.h"
+#include "config.h"
+#include "common.h"
+#include "lldp/l2_packet.h"
+#include "ecp/ecp.h"
+
+/* ecp_init - initialize ecp module
+ * @ifname: interface for which the module is initialized
+ *
+ * returns 0 on success, -1 on error
+ *
+ * finds the port to the interface name, sets up the receive handle for
+ * incoming ecp frames and initializes the ecp rx and tx state machines.
+ * should usually be called when a successful exchange of EVB TLVs has been
+ * made and ECP and VDP protocols are supported by both sides.
+ */
+int ecp_init(char *ifname)
+{
+	struct vdp_data *vd;
+
+	printf("%s(%i): starting ECP for if %s !\n", __func__, __LINE__, ifname);
+
+	vd = vdp_data(ifname);
+
+	if (!vd) {
+		printf("%s(%i): unable to find vd %s ! \n", __func__, __LINE__, ifname);
+		goto fail;
+	}
+
+	vd->ecp.l2 = l2_packet_init(vd->ifname, NULL, ETH_P_ECP,
+		ecp_rx_ReceiveFrame, vd, 1);
+	if (!vd->ecp.l2) {
+		printf("ERROR: Failed to open register layer 2 access to "
+			"ETH_P_ECP\n");
+		goto fail;
+	}
+
+	ecp_tx_run_sm(vd);
+	ecp_rx_run_sm(vd);
+
+	return 0;
+
+fail:
+	return -1;
+}
diff --git a/ecp/ecp.h b/ecp/ecp.h
new file mode 100644
index 0000000..cc9ca2b
--- /dev/null
+++ b/ecp/ecp.h
@@ -0,0 +1,101 @@
+/*******************************************************************************
+
+  implementation of ECP according to 802.1Qbg
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
+#ifndef _ECP_H
+#define _ECP_H
+
+#include "lldp_mod.h"
+#include "include/lldp_vdp.h"
+
+#define ECP_SUBTYPE			0x0
+
+#define ECP_MAX_RETRIES			3
+#define ECP_SEQUENCE_NR_START		0x0
+
+#define ECP_TRANSMISSION_TIMER		EVB_RTM(RTE)*EVB_RTG
+#define ECP_TRANSMISSION_DIVIDER	10000
+
+typedef enum {
+	ECP_REQUEST = 0,
+	ECP_ACK
+} ecp_mode;
+
+struct ecp {
+	struct l2_packet_data *l2;
+	int sequence;
+	int retries;
+	int ackReceived;
+	int ackTimerExpired;
+	u16 lastSequence;
+	u16 seqECPDU;
+	struct portrx rx;
+	struct porttx tx;
+	struct portstats stats;
+};
+
+struct ecp_hdr {
+	u8 oui[3];
+	u8 pad1;
+	u16 subtype;
+	u8 mode;
+	u16 seqnr;
+} __attribute__ ((__packed__));
+
+enum {
+	ECP_TX_INIT_TRANSMIT,
+	ECP_TX_TRANSMIT_ECPDU,
+	ECP_TX_WAIT_FOR_ACK,
+	ECP_TX_REQUEST_PDU
+};
+
+static const char *ecp_tx_states[] = {
+	"ECP_TX_IDLE",
+	"ECP_TX_INIT_TRANSMIT",
+	"ECP_TX_TRANSMIT_ECPDU",
+	"ECP_TX_WAIT_FOR_ACK",
+	"ECP_TX_REQUEST_PDU"
+};
+
+enum {
+	ECP_RX_IDLE,
+	ECP_RX_INIT_RECEIVE,
+	ECP_RX_RECEIVE_WAIT,
+	ECP_RX_RECEIVE_ECPDU,
+	ECP_RX_SEND_ACK,
+	ECP_RX_RESEND_ACK,
+};
+
+static const char *ecp_rx_states[] = {
+	"ECP_RX_IDLE",
+	"ECP_RX_INIT_RECEIVE",
+	"ECP_RX_RECEIVE_WAIT",
+	"ECP_RX_RECEIVE_ECPDU",
+	"ECP_RX_SEND_ACK",
+	"ECP_RX_RESEND_ACK",
+};
+
+void ecp_rx_ReceiveFrame(void *, unsigned int, const u8 *, size_t );
+
+#endif /* _ECP_H */
diff --git a/ecp/ecp_rx.c b/ecp/ecp_rx.c
new file mode 100644
index 0000000..3a5dff7
--- /dev/null
+++ b/ecp/ecp_rx.c
@@ -0,0 +1,599 @@
+/*******************************************************************************
+
+  implementation of ECP according to 802.1Qbg
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
+#include "dcb_osdep.h"
+#include "lldp/ports.h"
+#include "lldp/l2_packet.h"
+#include "messages.h"
+#include "lldp.h"
+#include "lldpad.h"
+#include "lldp_mod.h"
+#include "clif_msgs.h"
+#include "lldp_mand.h"
+#include "lldp_vdp.h"
+
+/* ecp_rx_Initialize - initializes the ecp rx state machine
+ * @vd: vd for the state machine
+ *
+ * no return value
+ *
+ * initialize some variables, get rid of old frame if necessary
+ */
+void ecp_rx_Initialize(struct vdp_data *vd)
+{
+	vd->ecp.rx.rcvFrame = false;
+	vd->ecp.rx.badFrame = false;
+
+	vd->ecp.ackReceived = 0;
+
+	if (vd->ecp.rx.framein) {
+		free(vd->ecp.rx.framein);
+		vd->ecp.rx.framein = NULL;
+	}
+	vd->ecp.rx.sizein = 0;
+
+	return;
+}
+
+/* ecp_rx_freeFrame - free up received frame
+ * @vd: vd for the state machine
+ *
+ * no return value
+ *
+ * frees up an old received frame, set pointer to NULL and size to 0.
+ */
+void ecp_rx_freeFrame(struct vdp_data *vd)
+{
+	free(vd->ecp.rx.framein);
+	vd->ecp.rx.framein = NULL;
+	vd->ecp.rx.sizein = 0;
+}
+
+/* ecp_print_framein - print raw received frame
+ * @vd: vd for the state machine
+ *
+ * no return value
+ *
+ * prints out a raw version of a received frame. useful for low-level protocol
+ * debugging.
+ */
+void ecp_print_framein(struct vdp_data *vd)
+{
+	int i;
+
+	for (i=0; i < vd->ecp.rx.sizein; i++) {
+		printf("%02x ", vd->ecp.rx.framein[i]);
+		if (!((i+1) % 16))
+			printf("\n");
+	}
+
+	printf("\n");
+}
+
+/* ecp_rx_SendAckFrame - send ack frame
+ * @vd: port used by ecp
+ *
+ * currently always returns 0
+ *
+ * copies current received frame over to frame out, fills in address of this
+ * port and set mode field to ACK. used by ecp_rx_send_ack_frame.
+ */
+int ecp_rx_SendAckFrame(struct vdp_data *vd)
+{
+	u16 tlv_offset = 0;
+	struct ecp_hdr *ecp_hdr;
+	struct l2_ethhdr *hdr;
+	u8 own_addr[ETH_ALEN];
+
+	printf("%s(%i)-%s: acking frame \n", __func__, __LINE__, vd->ifname);
+
+	assert(vd->ecp.rx.framein && vd->ecp.rx.sizein);
+
+	/* copy over to frameout */
+	vd->ecp.tx.frameout = (u8 *)malloc(ETH_FRAME_LEN);
+	memcpy(vd->ecp.tx.frameout, vd->ecp.rx.framein, vd->ecp.rx.sizein);
+	vd->ecp.tx.sizeout = vd->ecp.rx.sizein;
+
+	/* use my own addr to send ACK */
+	hdr = (struct l2_ethhdr *)vd->ecp.tx.frameout;
+	l2_packet_get_own_src_addr(vd->ecp.l2,(u8 *)&own_addr);
+	memcpy(hdr->h_source, &own_addr, ETH_ALEN);
+
+	tlv_offset = sizeof(struct l2_ethhdr);
+	ecp_hdr = (struct ecp_hdr *)&vd->ecp.tx.frameout[tlv_offset];
+	ecp_hdr->mode = ECP_ACK;
+
+	return 0;
+}
+
+/* ecp_rx_send_ack_frame - send out ack frame for received frame
+ * @vd: vd for the state machine
+ *
+ * no return value
+ *
+ * creates an ack frame for a just received frame, prints the about to be
+ * sent frame and finally transmits it.
+ */
+void ecp_rx_send_ack_frame(struct vdp_data *vd)
+{
+	ecp_rx_SendAckFrame(vd);
+
+	ecp_print_frameout(vd);
+
+	ecp_txFrame(vd);
+
+	return;
+}
+
+/* ecp_rx_ReceiveFrame - receive ecp frame
+ * @ctx: rx callback context, struct vd * in this case
+ * @ifindex: index of interface
+ * @buf: buffer which contains the frame just received
+ * @len: size of buffer (frame)
+ *
+ * no return value
+ *
+ * creates a local copy of the buffer and checks the header. keeps some
+ * statistics about ecp frames. Checks if it is a request or an ack frame and branches
+ * to ecp rx or ecp tx state machine.
+ */
+void ecp_rx_ReceiveFrame(void *ctx, unsigned int ifindex, const u8 *buf, size_t len)
+{
+
+	struct vdp_data *vd = NULL;
+	struct port *port;
+	u8  frame_error = 0;
+	u16 tlv_offset;
+	struct l2_ethhdr *hdr;
+	struct l2_ethhdr example_hdr,*ex;
+	struct ecp_hdr *ecp_hdr;
+
+	if (ctx)
+		vd = (struct vdp_data *)ctx;
+
+	port = port_find_by_name(vd->ifname);
+
+	printf("%s(%i)-%s: received packet with size %i\n", __func__, __LINE__,
+	       vd->ifname, (int) len);
+
+	if (port->adminStatus == disabled || port->adminStatus == enabledTxOnly)
+		return;
+
+	if (vd->ecp.rx.framein &&
+	    vd->ecp.rx.sizein == len &&
+	    (memcmp(buf, vd->ecp.rx.framein, len) == 0)) {
+		vd->ecp.stats.statsFramesInTotal++;
+		return;
+	}
+
+	if (vd->ecp.rx.framein)
+		free(vd->ecp.rx.framein);
+
+	vd->ecp.rx.framein = (u8 *)malloc(len);
+	if (vd->ecp.rx.framein == NULL) {
+		printf("ERROR - could not allocate memory for rx'ed frame\n");
+		return;
+	}
+	memcpy(vd->ecp.rx.framein, buf, len);
+
+	vd->ecp.rx.sizein = (u16)len;
+	ex = &example_hdr;
+	memcpy(ex->h_dest, multi_cast_source, ETH_ALEN);
+	ex->h_proto = htons(ETH_P_ECP);
+	hdr = (struct l2_ethhdr *)vd->ecp.rx.framein;
+
+	if ((memcmp(hdr->h_dest,ex->h_dest, ETH_ALEN) != 0)) {
+		printf("ERROR multicast address error in incoming frame. "
+			"Dropping frame.\n");
+		frame_error++;
+		free(vd->ecp.rx.framein);
+		vd->ecp.rx.framein = NULL;
+		vd->ecp.rx.sizein = 0;
+		return;
+	}
+
+	if (hdr->h_proto != example_hdr.h_proto) {
+		printf("ERROR Ethertype not ECP ethertype but ethertype "
+			"'%x' in incoming frame.\n", htons(hdr->h_proto));
+		frame_error++;
+		free(vd->ecp.rx.framein);
+		vd->ecp.rx.framein = NULL;
+		vd->ecp.rx.sizein = 0;
+		return;
+	}
+
+	if (!frame_error) {
+		vd->ecp.stats.statsFramesInTotal++;
+		vd->ecp.rx.rcvFrame = 1;
+	}
+
+	tlv_offset = sizeof(struct l2_ethhdr);
+
+	ecp_hdr = (struct ecp_hdr *)&vd->ecp.rx.framein[tlv_offset];
+
+	vd->ecp.seqECPDU = ntohs(ecp_hdr->seqnr);
+
+	switch(ecp_hdr->mode) {
+	case ECP_REQUEST:
+		vd->ecp.ackReceived = false;
+		ecp_print_framein(vd);
+		ecp_rx_run_sm(vd);
+		break;
+	case ECP_ACK:
+		vd->ecp.ackReceived = true;
+		printf("%s(%i)-%s: received ack frame \n", __func__, __LINE__, vd->ifname);
+		ecp_print_framein(vd);
+		ecp_tx_run_sm(vd);
+		vd->ecp.ackReceived = false;
+		break;
+	default:
+		printf("ERROR: unknown mode %i!\n", ecp_hdr->mode);
+		return;
+	}
+
+	ecp_rx_freeFrame(vd);
+}
+
+/* ecp_rx_validateFrame - validates received frame
+ * @vd: vdp_data used by ecp
+ *
+ * no return value
+ *
+ * checks wether received frame has correct subtype and mode
+ */
+
+void ecp_rx_validateFrame(struct vdp_data *vd)
+{
+	u16 tlv_offset = 0;
+	struct ecp_hdr *ecp_hdr;
+
+	printf("%s(%i)-%s: validating frame \n", __func__, __LINE__, vd->ifname);
+
+	assert(vd->ecp.rx.framein && vd->ecp.rx.sizein);
+
+	tlv_offset = sizeof(struct l2_ethhdr);
+
+	ecp_hdr = (struct ecp_hdr *)&vd->ecp.rx.framein[tlv_offset];
+
+	printf("%s(%i)-%s: ecp packet with subtype %04x, mode %02x, sequence nr %04x\n",
+	       __func__, __LINE__, vd->ifname, ecp_hdr->subtype, ecp_hdr->mode, ntohs(ecp_hdr->seqnr));
+
+	if (ecp_hdr->subtype != ECP_SUBTYPE) {
+		printf("ERROR: unknown subtype !\n");
+		return;
+	}
+
+	if ((ecp_hdr->oui[0] != 0x0) || (ecp_hdr->oui[1] != 0x1b) ||
+		(ecp_hdr->oui[2] != 0x3f)) {
+		printf("ERROR: incorrect OUI 0x%02x%02x%02x !\n",
+		       ecp_hdr->oui[0], ecp_hdr->oui[1], ecp_hdr->oui[2]);
+		return;
+	}
+
+	switch(ecp_hdr->mode) {
+	case ECP_REQUEST:
+		break;
+	case ECP_ACK:
+		break;
+	default:
+		printf("ERROR: unknown mode %i!\n", ecp_hdr->mode);
+		return;
+	}
+
+	/* FIXME: also done in ecp_rx_ReceiveFrame,
+	 * are both necessary ? */
+	vd->ecp.seqECPDU = ntohs(ecp_hdr->seqnr);
+}
+
+/* ecp_rx_validate_frame - wrapper around ecp_rx_validateFrame
+ * @vd: currently used port
+ *
+ * no return value
+ *
+ * sets rcvFrame to false and validates frame. used in ECP_RX_RECEIVE_ECPDU
+ * state of ecp_rx_run_sm
+ */
+void ecp_rx_validate_frame(struct vdp_data *vd)
+{
+	vd->ecp.rx.rcvFrame = false;
+	ecp_rx_validateFrame(vd);
+	return;
+}
+
+/* ecp_rx_ProcessFrame - process received ecp frames
+ * @vd: currently used port
+ *
+ * no return value
+ *
+ * walks through the packed vsi tlvs in an ecp frame, extracts them
+ * and passes them to the VDP ULP with vdp_indicate.
+ */
+void ecp_rx_ProcessFrame(struct vdp_data *vd)
+{
+	u16 tlv_cnt = 0;
+	u8  tlv_type = 0;
+	u16 tlv_length = 0;
+	u16 tlv_offset = 0;
+	u16 *tlv_head_ptr = NULL;
+	u8  frame_error = 0;
+	bool tlv_stored     = false;
+	struct ecp_hdr *ecp_hdr;
+
+	printf("%s(%i)-%s: processing frame \n", __func__, __LINE__, vd->ifname);
+
+	assert(vd->ecp.rx.framein && vd->ecp.rx.sizein);
+
+	tlv_offset = sizeof(struct l2_ethhdr);
+
+	ecp_hdr = (struct ecp_hdr *)&vd->ecp.rx.framein[tlv_offset];
+
+	printf("%s(%i)-%s: ecp packet with subtype %04x, mode %02x, sequence nr %04x\n",
+	       __func__, __LINE__, vd->ifname, ecp_hdr->subtype, ecp_hdr->mode, ntohs(ecp_hdr->seqnr));
+
+	if (ecp_hdr->mode == ECP_ACK)
+		return;
+
+	/* processing of VSI_TLVs starts here */
+
+	tlv_offset += sizeof(struct ecp_hdr);
+
+	do {
+		tlv_cnt++;
+		if (tlv_offset > vd->ecp.rx.sizein) {
+			printf("%s(%i)-%s: ERROR: Frame overrun! tlv_offset %i, sizein %i cnt %i\n",
+			       __func__, __LINE__, vd->ifname, tlv_offset, vd->ecp.rx.sizein, tlv_cnt);
+			frame_error++;
+			goto out;
+		}
+
+		tlv_head_ptr = (u16 *)&vd->ecp.rx.framein[tlv_offset];
+		tlv_length = htons(*tlv_head_ptr) & 0x01FF;
+		tlv_type = (u8)(htons(*tlv_head_ptr) >> 9);
+
+		u16 tmp_offset = tlv_offset + tlv_length;
+		if (tmp_offset > vd->ecp.rx.sizein) {
+			printf("ERROR: Frame overflow error: offset=%d, "
+				"rx.size=%d \n", tmp_offset, vd->ecp.rx.sizein);
+			frame_error++;
+			goto out;
+		}
+
+		u8 *info = (u8 *)&vd->ecp.rx.framein[tlv_offset +
+					sizeof(*tlv_head_ptr)];
+
+		struct unpacked_tlv *tlv = create_tlv();
+
+		if (!tlv) {
+			printf("ERROR: Failed to malloc space for "
+				"incoming TLV. \n");
+			goto out;
+		}
+
+		if ((tlv_length == 0) && (tlv->type != TYPE_0)) {
+				printf("ERROR: tlv_length == 0\n");
+				free_unpkd_tlv(tlv);
+				goto out;
+		}
+
+		tlv->type = tlv_type;
+		tlv->length = tlv_length;
+		tlv->info = (u8 *)malloc(tlv_length);
+		if (tlv->info) {
+			memset(tlv->info,0, tlv_length);
+			memcpy(tlv->info, info, tlv_length);
+		} else {
+			printf("ERROR: Failed to malloc space for incoming "
+				"TLV info \n");
+			free_unpkd_tlv(tlv);
+			goto out;
+		}
+
+		/* Validate the TLV */
+		tlv_offset += sizeof(*tlv_head_ptr) + tlv_length;
+
+		if (tlv->type == TYPE_127) { /* private TLV */
+			/* give VSI TLV to VDP */
+			if (!vdp_indicate(vd, tlv, ecp_hdr->mode))
+				tlv_stored = true;
+			else {
+				/* TODO: put it in a list and try again later until
+				 * timer and retries have expired */
+				tlv_stored = false;
+			}
+		}
+
+		if ((tlv->type != TYPE_0) && !tlv_stored) {
+			printf("\n%s: allocated TLV (%u) "
+				   " was not stored! (%p)\n", __func__, tlv->type,
+				   tlv);
+			tlv = free_unpkd_tlv(tlv);
+			vd->ecp.stats.statsTLVsUnrecognizedTotal++;
+		}
+
+		tlv = NULL;
+		tlv_stored = false;
+	} while(tlv_type != 0);
+
+out:
+	if (frame_error) {
+		vd->ecp.stats.statsFramesDiscardedTotal++;
+		vd->ecp.stats.statsFramesInErrorsTotal++;
+		vd->ecp.rx.badFrame = true;
+	}
+
+	return;
+}
+
+/* ecp_rx_change_state - changes the ecp rx sm state
+ * @vd: currently used port
+ * @newstate: new state for the sm
+ *
+ * no return value
+ *
+ * checks state transistion for consistency and finally changes the state of
+ * the profile.
+ */
+void ecp_rx_change_state(struct vdp_data *vd, u8 newstate)
+{
+	switch(newstate) {
+	case ECP_RX_IDLE:
+		break;
+	case ECP_RX_INIT_RECEIVE:
+		break;
+	case ECP_RX_RECEIVE_WAIT:
+		assert((vd->ecp.rx.state == ECP_RX_INIT_RECEIVE) ||
+		       (vd->ecp.rx.state == ECP_RX_IDLE) ||
+		       (vd->ecp.rx.state == ECP_RX_SEND_ACK) ||
+		       (vd->ecp.rx.state == ECP_RX_RESEND_ACK));
+		break;
+	case ECP_RX_RECEIVE_ECPDU:
+		assert(vd->ecp.rx.state == ECP_RX_RECEIVE_WAIT);
+		break;
+	case ECP_RX_SEND_ACK:
+		assert(vd->ecp.rx.state == ECP_RX_RECEIVE_ECPDU);
+		break;
+	case ECP_RX_RESEND_ACK:
+		assert(vd->ecp.rx.state == ECP_RX_RECEIVE_ECPDU);
+		break;
+	default:
+		printf("ERROR: The ECP_RX State Machine is broken!\n");
+		log_message(MSG_ERR_RX_SM_INVALID, "%s", vd->ifname);
+	}
+
+	printf("%s(%i)-%s: state change %s -> %s\n", __func__, __LINE__,
+	       vd->ifname, ecp_rx_states[vd->ecp.rx.state], ecp_rx_states[newstate]);
+
+	vd->ecp.rx.state = newstate;
+}
+
+/* ecp_set_rx_state - sets the ecp rx sm state
+ * @vd: currently used port
+ *
+ * returns true or false
+ *
+ * switches the state machine to the next state depending on the input
+ * variables. returns true or false depending on wether the state machine
+ * can be run again with the new state or can stop at the current state.
+ */
+bool ecp_set_rx_state(struct vdp_data *vd)
+{
+	struct port *port = port_find_by_name(vd->ifname);
+
+	if (port->portEnabled == false) {
+		ecp_rx_change_state(vd, ECP_RX_IDLE);
+	}
+
+	switch(vd->ecp.rx.state) {
+	case ECP_RX_IDLE:
+		if (port->portEnabled == true) {
+			ecp_rx_change_state(vd, ECP_RX_INIT_RECEIVE);
+			return true;
+		}
+		return false;
+	case ECP_RX_INIT_RECEIVE:
+		if ((port->adminStatus == enabledRxTx) ||
+			(port->adminStatus == enabledRxOnly)) {
+			ecp_rx_change_state(vd, ECP_RX_RECEIVE_WAIT);
+			return true;
+		}
+		return false;
+	case ECP_RX_RECEIVE_WAIT:
+		if ((port->adminStatus == disabled) ||
+			(port->adminStatus == enabledTxOnly)) {
+			ecp_rx_change_state(vd, ECP_RX_IDLE);
+			return true;
+		}
+		if (vd->ecp.rx.rcvFrame == true) {
+			ecp_rx_change_state(vd, ECP_RX_RECEIVE_ECPDU);
+			return true;
+		}
+		return false;
+	case ECP_RX_RECEIVE_ECPDU:
+		if (vd->ecp.seqECPDU == vd->ecp.lastSequence) {
+			printf("%s(%i):-(%s) seqECPDU %x, lastSequence %x\n", __func__, __LINE__,
+			       vd->ifname, vd->ecp.seqECPDU, vd->ecp.lastSequence);
+			ecp_rx_change_state(vd, ECP_RX_RESEND_ACK);
+			return true;
+		}
+		if (vd->ecp.seqECPDU != vd->ecp.lastSequence) {
+			ecp_rx_change_state(vd, ECP_RX_RESEND_ACK);
+			return true;
+		}
+		return false;
+	case ECP_RX_SEND_ACK:
+		ecp_rx_change_state(vd, ECP_RX_RECEIVE_WAIT);
+		return false;
+	case ECP_RX_RESEND_ACK:
+		ecp_rx_change_state(vd, ECP_RX_RECEIVE_WAIT);
+		return false;
+	default:
+		printf("ERROR: The ECP_RX State Machine is broken!\n");
+		log_message(MSG_ERR_RX_SM_INVALID, "%s", vd->ifname);
+		return false;
+	}
+}
+
+/* ecp_rx_run_sm - state machine for ecp rx
+ * @vd: currently used port
+ *
+ * no return value
+ *
+ * runs the state machine for ecp rx.
+ */
+void ecp_rx_run_sm(struct vdp_data *vd)
+{
+	ecp_set_rx_state(vd);
+	do {
+		printf("%s(%i)-%s: ecp_rx - %s\n", __func__, __LINE__,
+		       vd->ifname, ecp_rx_states[vd->ecp.tx.state]);
+
+		switch(vd->ecp.rx.state) {
+		case ECP_RX_IDLE:
+			break;
+		case ECP_RX_INIT_RECEIVE:
+			ecp_rx_Initialize(vd);
+			break;
+		case ECP_RX_RECEIVE_WAIT:
+			break;
+		case ECP_RX_RECEIVE_ECPDU:
+			ecp_rx_validate_frame(vd);
+			break;
+		case ECP_RX_SEND_ACK:
+			ecp_rx_ProcessFrame(vd);
+			break;
+		case ECP_RX_RESEND_ACK:
+			ecp_rx_ProcessFrame(vd);
+			if (!vd->ecp.ackReceived) {
+				ecp_rx_send_ack_frame(vd);
+				ecp_rx_freeFrame(vd);
+			}
+			break;
+		default:
+			printf("ERROR: The ECP_RX State Machine is broken!\n");
+			log_message(MSG_ERR_TX_SM_INVALID, "%s", vd->ifname);
+		}
+	} while (ecp_set_rx_state(vd) == true);
+
+}
diff --git a/ecp/ecp_tx.c b/ecp/ecp_tx.c
new file mode 100644
index 0000000..9ddf821
--- /dev/null
+++ b/ecp/ecp_tx.c
@@ -0,0 +1,494 @@
+/*******************************************************************************
+
+  implementation of ECP according to 802.1Qbg
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
+#include "dcb_osdep.h"
+#include "lldp/ports.h"
+#include "lldp/l2_packet.h"
+#include "eloop.h"
+#include "messages.h"
+#include "lldpad.h"
+#include "lldp_tlv.h"
+#include "lldp_mod.h"
+#include "lldp_mand.h"
+#include "lldp_evb.h"
+#include "include/lldp_vdp.h"
+
+void ecp_tx_run_sm(struct vdp_data *);
+
+/* ecp_somethingChangedLocal - set flag if port has changed
+ * @vd: port to set the flag for
+ * @mode: mode to set the flag to
+ *
+ * no return value
+ *
+ * set the localChange flag with a mode to indicate a port has changed.
+ * used  to signal an ecpdu needs to be sent out.
+ */
+
+void ecp_somethingChangedLocal(struct vdp_data *vd, int mode)
+{
+	if (!vd)
+		return;
+
+	vd->ecp.tx.localChange |= mode;
+
+	return;
+}
+
+/* ecp_print_frameout - print outbound frame
+ * @vd: currently used port
+ *
+ * no return value
+ *
+ * prints a raw dump of an outbound ecp frame. useful for low-level protocol
+ * debugging.
+ */
+void ecp_print_frameout(struct vdp_data *vd)
+{
+	int i;
+
+	for (i=0; i < vd->ecp.tx.sizeout; i++) {
+		printf("%02x ", vd->ecp.tx.frameout[i]);
+		if (!((i+1) % 16))
+			printf("\n");
+	}
+
+	printf("\n");
+}
+
+/* ecp_build_ECPDU - create an ecp protocol data unit
+ * @vd: currently used port
+ * @mode: mode to create pdu with (REQ or ACK)
+ *
+ * returns true on success, false on failure
+ *
+ * creates the frame header with the ports mac address, the ecp header with REQ
+ * or ACK mode, plus a list of packed TLVs created from the profiles on this
+ * port.
+ */
+bool ecp_build_ECPDU(struct vdp_data *vd, int mode)
+{
+	struct l2_ethhdr eth;
+	struct ecp_hdr ecp_hdr;
+	u8  own_addr[ETH_ALEN];
+	u32 fb_offset = 0;
+	u32 datasize = 0;
+	struct packed_tlv *ptlv =  NULL;
+	struct vsi_profile *p;
+
+	if (vd->ecp.tx.frameout) {
+		free(vd->ecp.tx.frameout);
+		vd->ecp.tx.frameout = NULL;
+	}
+
+	/* TODO: different multicast address for sending ECP over S-channel (multi_cast_source_s)
+	 * S-channels to implement later */
+	memcpy(eth.h_dest, multi_cast_source, ETH_ALEN);
+	l2_packet_get_own_src_addr(vd->ecp.l2,(u8 *)&own_addr);
+	memcpy(eth.h_source, &own_addr, ETH_ALEN);
+	eth.h_proto = htons(ETH_P_ECP);
+	vd->ecp.tx.frameout = (u8 *)malloc(ETH_FRAME_LEN);
+	if (vd->ecp.tx.frameout == NULL) {
+		printf("InfoECPDU: Failed to malloc frame buffer \n");
+		return false;
+	}
+	memset(vd->ecp.tx.frameout,0,ETH_FRAME_LEN);
+	memcpy(vd->ecp.tx.frameout, (void *)&eth, sizeof(struct l2_ethhdr));
+	fb_offset += sizeof(struct l2_ethhdr);
+
+	ecp_hdr.oui[0] = 0x0;
+	ecp_hdr.oui[1] = 0x1b;
+	ecp_hdr.oui[2] = 0x3f;
+
+	ecp_hdr.pad1 = 0x0;
+
+	ecp_hdr.subtype = ECP_SUBTYPE;
+	switch(mode) {
+	case VDP_PROFILE_REQ:
+		ecp_hdr.mode = ECP_REQUEST;
+		break;
+	case VDP_PROFILE_ACK:
+		ecp_hdr.mode = ECP_ACK;
+		break;
+	default:
+		printf("%s(%i): unknown mode for %s !\n", __func__, __LINE__,
+		       vd->ifname);
+	}
+
+	vd->ecp.lastSequence++;
+	ecp_hdr.seqnr = htons(vd->ecp.lastSequence);
+
+	if ((sizeof(struct ecp_hdr)+fb_offset) > ETH_MAX_DATA_LEN)
+				goto error;
+	memcpy(vd->ecp.tx.frameout+fb_offset, (void *)&ecp_hdr, sizeof(struct ecp_hdr));
+	datasize += sizeof(struct ecp_hdr);
+	fb_offset += sizeof(struct ecp_hdr);
+
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
+		ptlv = vdp_gettlv(vd, p);
+
+		if(!ptlv) {
+			printf("%s(%i): ptlv not created !\n", __func__, __LINE__);
+			continue;
+		}
+
+		if (ptlv) {
+			if ((ptlv->size+fb_offset) > ETH_MAX_DATA_LEN)
+				goto error;
+			memcpy(vd->ecp.tx.frameout+fb_offset,
+			       ptlv->tlv, ptlv->size);
+			datasize += ptlv->size;
+			fb_offset += ptlv->size;
+		}
+	}
+
+	/* The End TLV marks the end of the LLDP PDU */
+	ptlv = pack_end_tlv();
+	if (!ptlv || ((ptlv->size + fb_offset) > ETH_MAX_DATA_LEN))
+		goto error;
+	memcpy(vd->ecp.tx.frameout + fb_offset, ptlv->tlv, ptlv->size);
+	datasize += ptlv->size;
+	fb_offset += ptlv->size;
+	ptlv =  free_pkd_tlv(ptlv);
+
+	if (datasize > ETH_MAX_DATA_LEN)
+		goto error;
+
+	if (datasize < ETH_MIN_DATA_LEN)
+		vd->ecp.tx.sizeout = ETH_MIN_PKT_LEN;
+	else
+		vd->ecp.tx.sizeout = fb_offset;
+
+	return true;
+
+error:
+	ptlv = free_pkd_tlv(ptlv);
+	if (vd->ecp.tx.frameout)
+		free(vd->ecp.tx.frameout);
+	vd->ecp.tx.frameout = NULL;
+	printf("InfoECPDU: packed TLV too large for tx frame\n");
+	return false;
+}
+
+/* ecp_tx_Initialize - initializes the ecp tx state machine
+ * @vd: currently used port
+ *
+ * no return value
+ *
+ * initializes some variables for the ecp tx state machine.
+ */
+void ecp_tx_Initialize(struct vdp_data *vd)
+{
+	if (vd->ecp.tx.frameout) {
+		free(vd->ecp.tx.frameout);
+		vd->ecp.tx.frameout = NULL;
+	}
+	vd->ecp.tx.localChange = VDP_PROFILE_REQ;
+	vd->ecp.lastSequence = ECP_SEQUENCE_NR_START;
+	vd->ecp.stats.statsFramesOutTotal = 0;
+	vd->ecp.ackTimerExpired = false;
+	vd->ecp.retries = 0;
+
+	struct port *port = port_find_by_name(vd->ifname);
+	l2_packet_get_port_state(vd->ecp.l2, (u8 *)&(port->portEnabled));
+
+	return;
+}
+
+/* ecp_txFrame - transmit ecp frame
+ * @vd: currently used port
+ *
+ * returns the number of characters sent on success, -1 on failure
+ *
+ * sends out the frame stored in the frameout structure using l2_packet_send.
+ */
+u8 ecp_txFrame(struct vdp_data *vd)
+{
+	int status = 0;
+
+	status = l2_packet_send(vd->ecp.l2, (u8 *)&multi_cast_source,
+		htons(ETH_P_ECP),vd->ecp.tx.frameout,vd->ecp.tx.sizeout);
+	vd->ecp.stats.statsFramesOutTotal++;
+
+	return status;
+}
+
+/* ecp_tx_create_frame - create ecp frame
+ * @vd: currently used port
+ *
+ * no return value
+ *
+ *
+ */
+void ecp_tx_create_frame(struct vdp_data *vd)
+{
+	/* send REQs */
+	if (vd->ecp.tx.localChange & VDP_PROFILE_REQ) {
+		printf("%s(%i)-%s: sending REQs\n", __func__, __LINE__, vd->ifname);
+		ecp_build_ECPDU(vd, VDP_PROFILE_REQ);
+		ecp_print_frameout(vd);
+		ecp_txFrame(vd);
+	}
+
+	/* send ACKs */
+	if (vd->ecp.tx.localChange & VDP_PROFILE_ACK) {
+		printf("%s(%i)-%s: sending ACKs\n", __func__, __LINE__, vd->ifname);
+		ecp_build_ECPDU(vd, VDP_PROFILE_ACK);
+		ecp_print_frameout(vd);
+		ecp_txFrame(vd);
+	}
+
+	vd->ecp.tx.localChange = 0;
+	return;
+}
+
+/* ecp_timeout_handler - handles the ack timer expiry
+ * @eloop_data: data structure of event loop
+ * @user_ctx: user context, port here
+ *
+ * no return value
+ *
+ * called when the ECP ack timer has expired. sets a flag and calls the ECP
+ * state machine.
+ */
+static void ecp_tx_timeout_handler(void *eloop_data, void *user_ctx)
+{
+	struct vdp_data *vd;
+
+	vd = (struct vdp_data *) user_ctx;
+
+	vd->ecp.ackTimerExpired = true;
+
+	printf("%s(%i)-%s: timer expired\n", __func__, __LINE__,
+	       vd->ifname);
+
+	ecp_tx_run_sm(vd);
+}
+
+/* ecp_tx_stop_ackTimer - stop the ECP ack timer
+ * @vd: currently used port
+ *
+ * returns the number of removed handlers
+ *
+ * stops the ECP ack timer. used when a ack frame for the port has been
+ * received.
+ */
+static int ecp_tx_stop_ackTimer(struct vdp_data *vd)
+{
+	printf("%s(%i)-%s: stopping timer\n", __func__, __LINE__,
+	       vd->ifname);
+
+	return eloop_cancel_timeout(ecp_tx_timeout_handler, NULL, (void *) vd);
+}
+
+/* ecp_tx_start_ackTimer - starts the ECP ack timer
+ * @profile: profile to process
+ *
+ * returns 0 on success, -1 on error
+ *
+ * starts the ack timer when a frame has been sent out.
+ */
+static void ecp_tx_start_ackTimer(struct vdp_data *vd)
+{
+	unsigned int secs, usecs;
+
+	vd->ecp.ackTimerExpired = false;
+
+	secs = ECP_TRANSMISSION_TIMER / ECP_TRANSMISSION_DIVIDER;
+	usecs = ECP_TRANSMISSION_TIMER % ECP_TRANSMISSION_DIVIDER;
+
+	printf("%s(%i)-%s: starting timer\n", __func__, __LINE__,
+	       vd->ifname);
+
+	eloop_register_timeout(secs, usecs, ecp_tx_timeout_handler, NULL, (void *) vd);
+}
+
+/* ecp_tx_change_state - changes the ecp tx sm state
+ * @vd: currently used port
+ * @newstate: new state for the sm
+ *
+ * no return value
+ *
+ * checks state transistion for consistency and finally changes the state of
+ * the profile.
+ */
+static void ecp_tx_change_state(struct vdp_data *vd, u8 newstate)
+{
+	switch(newstate) {
+	case ECP_TX_INIT_TRANSMIT:
+		break;
+	case ECP_TX_TRANSMIT_ECPDU:
+		assert((vd->ecp.tx.state == ECP_TX_INIT_TRANSMIT) ||
+		       (vd->ecp.tx.state == ECP_TX_WAIT_FOR_ACK) ||
+		       (vd->ecp.tx.state == ECP_TX_REQUEST_PDU));
+		break;
+	case ECP_TX_WAIT_FOR_ACK:
+		assert(vd->ecp.tx.state == ECP_TX_TRANSMIT_ECPDU);
+		break;
+	case ECP_TX_REQUEST_PDU:
+		assert(vd->ecp.tx.state == ECP_TX_WAIT_FOR_ACK);
+		break;
+	default:
+		printf("ERROR: The ECP_TX State Machine is broken!\n");
+		log_message(MSG_ERR_TX_SM_INVALID, "%s", vd->ifname);
+	}
+
+	printf("%s(%i)-%s: state change %s -> %s\n", __func__, __LINE__,
+	       vd->ifname, ecp_tx_states[vd->ecp.tx.state], ecp_tx_states[newstate]);
+
+	vd->ecp.tx.state = newstate;
+	return;
+}
+
+/* ecp_set_tx_state - sets the ecp tx sm state
+ * @vd: currently used port
+ *
+ * returns true or false
+ *
+ * switches the state machine to the next state depending on the input
+ * variables. returns true or false depending on wether the state machine
+ * can be run again with the new state or can stop at the current state.
+ */
+static bool ecp_set_tx_state(struct vdp_data *vd)
+{
+	struct port *port = port_find_by_name(vd->ifname);
+
+	if (!port) {
+		printf("%s(%i): port not found !\n", __func__, __LINE__);
+		return 0;
+	}
+
+	if ((port->portEnabled == false) && (port->prevPortEnabled == true)) {
+		printf("set_tx_state: port was disabled\n");
+		ecp_tx_change_state(vd, ECP_TX_INIT_TRANSMIT);
+	}
+	port->prevPortEnabled = port->portEnabled;
+
+	switch (vd->ecp.tx.state) {
+	case ECP_TX_INIT_TRANSMIT:
+		if (port->portEnabled && ((port->adminStatus == enabledRxTx) ||
+			(port->adminStatus == enabledTxOnly)) && vd->ecp.tx.localChange) {
+			ecp_tx_change_state(vd, ECP_TX_TRANSMIT_ECPDU);
+			return true;
+		}
+		return false;
+	case ECP_TX_TRANSMIT_ECPDU:
+		if ((port->adminStatus == disabled) ||
+			(port->adminStatus == enabledRxOnly)) {
+			ecp_tx_change_state(vd, ECP_TX_INIT_TRANSMIT);
+			return true;
+		}
+		ecp_tx_change_state(vd, ECP_TX_WAIT_FOR_ACK);
+		return true;
+	case ECP_TX_WAIT_FOR_ACK:
+		if (vd->ecp.ackTimerExpired) {
+			vd->ecp.retries++;
+			if (vd->ecp.retries < ECP_MAX_RETRIES) {
+				ecp_somethingChangedLocal(vd, VDP_PROFILE_REQ);
+				ecp_tx_change_state(vd, ECP_TX_TRANSMIT_ECPDU);
+				return true;
+			}
+			if (vd->ecp.retries == ECP_MAX_RETRIES) {
+				printf("%s(%i)-%s: 1 \n", __func__, __LINE__,
+				       vd->ifname);
+				ecp_tx_change_state(vd, ECP_TX_REQUEST_PDU);
+				return true;
+			}
+		}
+		if (vd->ecp.ackReceived && vd->ecp.seqECPDU == vd->ecp.lastSequence) {
+			vd->ecp.ackReceived = false;
+			ecp_tx_change_state(vd, ECP_TX_REQUEST_PDU);
+			return true;
+		}
+		return false;
+	case ECP_TX_REQUEST_PDU:
+		if (vd->ecp.tx.localChange & VDP_PROFILE_REQ) {
+			ecp_tx_change_state(vd, ECP_TX_TRANSMIT_ECPDU);
+			return true;
+		}
+		return false;
+	default:
+		printf("ERROR: The TX State Machine is broken!\n");
+		log_message(MSG_ERR_TX_SM_INVALID, "%s", vd->ifname);
+		return false;
+	}
+}
+
+/* ecp_tx_run_sm - state machine for ecp tx
+ * @vd: currently used vdp_data
+ *
+ * no return value
+ *
+ * runs the state machine for ecp tx.
+ */
+void ecp_tx_run_sm(struct vdp_data *vd)
+{
+	do {
+		printf("%s(%i)-%s: ecp_tx - %s\n", __func__, __LINE__,
+		       vd->ifname, ecp_tx_states[vd->ecp.tx.state]);
+
+		switch(vd->ecp.tx.state) {
+		case ECP_TX_INIT_TRANSMIT:
+			ecp_tx_Initialize(vd);
+			break;
+		case ECP_TX_TRANSMIT_ECPDU:
+			ecp_tx_create_frame(vd);
+			ecp_tx_start_ackTimer(vd);
+			break;
+		case ECP_TX_WAIT_FOR_ACK:
+			if (vd->ecp.ackReceived) {
+				printf("%s(%i)-%s: ECP_TX_WAIT_FOR_ACK ackReceived\n", __func__, __LINE__,
+				       vd->ifname);
+				printf("%s(%i)-%s: 2: seqECPDU %x lastSequence %x \n", __func__, __LINE__,
+				       vd->ifname, vd->ecp.seqECPDU, vd->ecp.lastSequence);
+				vd->ecp.tx.localChange = 0;
+				ecp_tx_stop_ackTimer(vd);
+			}
+			break;
+		case ECP_TX_REQUEST_PDU:
+			vd->ecp.retries = 0;
+			printf("%s(%i)-%s: ECP_TX_REQUEST_PDU lastSequence %x\n", __func__, __LINE__,
+			       vd->ifname, vd->ecp.lastSequence);
+			break;
+		default:
+			printf("%s(%i): ERROR The TX State Machine is broken!\n", __func__,
+			       __LINE__);
+			log_message(MSG_ERR_TX_SM_INVALID, "%s", vd->ifname);
+		}
+	} while (ecp_set_tx_state(vd) == true);
+
+	return;
+}
diff --git a/include/lldp.h b/include/lldp.h
index e00ba7a..fd515cd 100644
--- a/include/lldp.h
+++ b/include/lldp.h
@@ -190,6 +190,7 @@ enum {
 
 /* IEEE 802.1Qbg subtype */
 #define LLDP_EVB_SUBTYPE		0
+#define LLDP_VDP_SUBTYPE		0x2
 
 /* forwarding mode */
 #define LLDP_EVB_CAPABILITY_FORWARD_STANDARD		(1 << 7)
diff --git a/include/lldp_evb.h b/include/lldp_evb.h
index 667f9ad..d028c21 100644
--- a/include/lldp_evb.h
+++ b/include/lldp_evb.h
@@ -37,6 +37,12 @@ typedef enum {
 	EVB_CONFIRMATION
 } evb_state;
 
+#define	RTE		13
+/* retransmission granularity (RTG) in microseconds */
+#define EVB_RTG		10
+/* retransmission multiplier (RTM) */
+#define EVB_RTM(rte)	(2<<(RTE-1))
+
 struct tlv_info_evb {
 	u8 oui[3];
 	u8 sub;
diff --git a/include/lldp_vdp.h b/include/lldp_vdp.h
new file mode 100644
index 0000000..b97d8c0
--- /dev/null
+++ b/include/lldp_vdp.h
@@ -0,0 +1,159 @@
+/*******************************************************************************
+
+  implementation of according to IEEE 802.1Qbg
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
+#ifndef _LLDP_VDP_H
+#define _LLDP_VDP_H
+
+#include "lldp_mod.h"
+#include "ecp/ecp.h"
+
+#define LLDP_MOD_VDP		OUI_IEEE_8021Qbg+1
+
+#define VDP_MODE_PREASSOCIATE		0x0
+#define VDP_MODE_PREASSOCIATE_WITH_RR	0x1
+#define VDP_MODE_ASSOCIATE		0x2
+#define VDP_MODE_DEASSOCIATE		0x3
+
+#define VDP_RESPONSE_SUCCESS		0x0
+#define VDP_RESPONSE_INVALID_FORMAT	0x1
+#define VDP_RESPONSE_INSUFF_RESOURCES	0x2
+#define VDP_RESPONSE_UNUSED_VTID	0x3
+#define VDP_RESPONSE_VTID_VIOLATION	0x4
+#define VDP_RESPONSE_VTID_VER_VIOLATION	0x5
+#define VDP_RESPONSE_OUT_OF_SYNC	0x6
+
+enum {
+	VDP_PROFILE_NOCHANGE = 0,
+	VDP_PROFILE_REQ,
+	VDP_PROFILE_ACK,
+	VDP_PROFILE_NACK,
+};
+
+#define VDP_MACVLAN_FORMAT_1	1
+
+#define VDP_TRANSMISSION_TIMER		3*EVB_RTM(RTE)*EVB_RTG
+#define VDP_TRANSMISSION_DIVIDER	10000
+
+#define VDP_ROLE_STATION		0
+#define VDP_ROLE_BRIDGE			1
+
+enum {
+	VSI_UNASSOCIATED = 0,
+	VSI_ASSOC_PROCESSING,
+	VSI_ASSOCIATED,
+	VSI_PREASSOC_PROCESSING,
+	VSI_PREASSOCIATED,
+	VSI_DEASSOC_PROCESSING,
+	VSI_EXIT,
+};
+
+static char *vsi_states[] = {
+	"VSI_UNASSOCIATED",
+	"VSI_ASSOC_PROCESSING",
+	"VSI_ASSOCIATED",
+	"VSI_PREASSOC_PROCESSING",
+	"VSI_PREASSOCIATED",
+	"VSI_DEASSOC_PROCESSING",
+	"VSI_EXIT"
+};
+
+struct mac_vlan {
+	u8 mac[6];
+	u16 vlan;
+} __attribute__ ((__packed__));
+
+struct tlv_info_vdp {
+	u8 oui[3];
+	u8 sub;
+	u8 mode;
+	u8 response;
+	u8 mgrid;
+	u8 id[3];
+	u8 version;
+	u8 instance[16];
+	u8 format;
+	u16 entries;
+	struct mac_vlan mac_vlan;
+} __attribute__ ((__packed__));
+
+struct vsi_profile {
+	int mode;
+	int response;
+	u8 mgrid;
+	int id;
+	u8 version;
+	u8 instance[16];
+	u8 mac[6]; /* TODO: currently only one MAC/VLAN pair supported, more later */
+	u16 vlan;
+	struct port *port;
+	int ackTimerExpired;
+	int ackReceived;
+	int state;
+	int localChange;
+	LIST_ENTRY(vsi_profile) profile;
+};
+
+struct vdp_data {
+	char ifname[IFNAMSIZ];
+	struct ecp ecp;
+	struct unpacked_tlv *vdp;
+	int role;
+	LIST_HEAD(profile_head, vsi_profile) profile_head;
+	LIST_ENTRY(vdp_data) entry;
+};
+
+struct vdp_user_data {
+	LIST_HEAD(vdp_head, vdp_data) head;
+};
+
+struct lldp_module *vdp_register(void);
+void vdp_unregister(struct lldp_module *mod);
+struct vdp_data *vdp_data(char *ifname);
+struct packed_tlv *vdp_gettlv(struct vdp_data *vd, struct vsi_profile *profile);
+void vdp_vsi_sm_station(struct vsi_profile *profile);
+struct vsi_profile *vdp_add_profile(struct vsi_profile *profile);
+
+#define MAC_ADDR_STRLEN		18
+#define INSTANCE_STRLEN		32
+
+#define PRINT_PROFILE(s, p)	\
+{ int c; \
+  c = sprintf(s, "\nmode: %i\n", p->mode); s += c; \
+  c = sprintf(s, "response: %i\n", p->response); s += c; \
+  c = sprintf(s, "state: %i\n", p->state); s += c; \
+  c = sprintf(s, "mgrid: %i\n", p->mgrid); s += c; \
+  c = sprintf(s, "id: %x\n", p->id); \
+  s += c; \
+  c = sprintf(s, "version: %i\n", p->version); s += c; \
+  char instance[INSTANCE_STRLEN+2]; \
+  instance2str(p->instance, instance, sizeof(instance)); \
+  c = sprintf(s, "instance: %s\n", &instance[0]); s += c; \
+  char macbuf[MAC_ADDR_STRLEN+1]; \
+  mac2str(p->mac, macbuf, MAC_ADDR_STRLEN); \
+  c = sprintf(s, "mac: %s\n", macbuf); s += c; \
+  c = sprintf(s, "vlan: %i\n\n", p->vlan); s += c; \
+}
+
+#endif /* _LLDP_VDP_H */
diff --git a/lldp/l2_packet.h b/lldp/l2_packet.h
index 16f3683..0962429 100644
--- a/lldp/l2_packet.h
+++ b/lldp/l2_packet.h
@@ -36,6 +36,8 @@
 
 #define ETH_P_LLDP 0x88cc
 
+/* TODO: use extended ethertype until final ethertype is available */
+#define ETH_P_ECP 0x88b7
 
 #define ETH_FRAME_LEN   1514
 
diff --git a/lldp/ports.h b/lldp/ports.h
index 0138efe..44dc5f1 100644
--- a/lldp/ports.h
+++ b/lldp/ports.h
@@ -142,15 +142,20 @@ struct port {
 	u8 portEnabled;
 	u8 prevPortEnabled;
 	u8 adminStatus;
-	u8 rxChanges;
-	u16   lldpdu;
+
+	/* protocol specific */
 	struct l2_packet_data *l2;
 	struct portrx rx;
 	struct porttx tx;
-	struct porttlvs tlvs;
 	struct portstats stats;
 	struct porttimers timers;
+	u8 rxChanges;
+	u16   lldpdu;
 	struct msap msap;
+
+	/* not sure */
+	struct porttlvs tlvs;
+
 	struct port *next;
 };
 
diff --git a/lldp_vdp.c b/lldp_vdp.c
new file mode 100644
index 0000000..c2b21bb
--- /dev/null
+++ b/lldp_vdp.c
@@ -0,0 +1,1185 @@
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
+#include "eloop.h"
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
+	struct vdp_data *vd = vdp_data(profile->port->ifname);
+
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
+			ecp_somethingChangedLocal(vd, VDP_PROFILE_REQ);
+			ecp_tx_run_sm(vd);
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
+			ecp_somethingChangedLocal(vd, VDP_PROFILE_REQ);
+			ecp_tx_run_sm(vd);
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
+			ecp_somethingChangedLocal(vd, VDP_PROFILE_REQ);
+			ecp_tx_run_sm(vd);
+			vdp_start_ackTimer(profile);
+			break;
+		case VSI_EXIT:
+			/* TODO: send DEASSOC here ? */
+			vdp_stop_ackTimer(profile);
+			vdp_remove_profile(profile);
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
+	struct vdp_data *vd = vdp_data(profile->port->ifname);
+
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
+			 *		txTLV(Assoc ACK)
+			 */
+			break;
+		case VSI_ASSOCIATED:
+			break;
+		case VSI_PREASSOC_PROCESSING:
+			/* TODO: vsiError = ProcRxandSetCfg(remoteTLV, localtlv, vsistate);
+			 *       if (vsiError)
+			 *		txTLV(PreAssoc NACK)
+			 *       else
+			 *		txTLV(PreAssoc ACK)
+			 */
+			/* for now, we always succeed */
+			profile->response = VDP_RESPONSE_SUCCESS;
+			printf("%s(%i)-%s: framein %p, sizein %i\n", __func__, __LINE__,
+			       profile->port->ifname, vd->ecp.rx.framein,
+			       vd->ecp.rx.sizein);
+			ecp_rx_send_ack_frame(profile->port);
+			break;
+		case VSI_PREASSOCIATED:
+			printf("%s(%i)-%s: \n", __func__, __LINE__, profile->port->ifname);
+			break;
+		case VSI_DEASSOC_PROCESSING:
+			/* TODO: txTLV(DeAssoc ACK) */
+			break;
+		case VSI_EXIT:
+			vdp_remove_profile(profile);
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
+		printf("vdp->oui %06x \n", ntoh24(vdp->oui));
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
+	if (ntohs(vdp->entries) != 1) {
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
+int vdp_indicate(struct vdp_data *vd, struct unpacked_tlv *tlv, int ecp_mode)
+{
+	struct tlv_info_vdp *vdp;
+	struct vsi_profile *p, *profile;
+	struct port *port = port_find_by_name(vd->ifname);
+
+	printf("%s(%i): indicating vdp for for %s !\n", __func__, __LINE__, vd->ifname);
+
+	if (!port) {
+		printf("%s(%i): port not found for %s !\n", __func__, __LINE__, vd->ifname);
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
+	profile->id = ntoh24(vdp->id);
+	profile->version = vdp->version;
+	memcpy(&profile->instance, &vdp->instance, 16);
+	memcpy(&profile->mac, &vdp->mac_vlan.mac, MAC_ADDR_LEN);
+	profile->vlan = ntohs(vdp->mac_vlan.vlan);
+
+	profile->port = port;
+
+	if (vd->role == VDP_ROLE_STATION) {
+		/* do we have the profile already ? */
+		LIST_FOREACH(p, &vd->profile_head, profile) {
+			if (vdp_profile_equal(p, profile)) {
+				printf("%s(%i): station: profile found, localChange %i ackReceived %i!\n",
+				       __func__, __LINE__, p->localChange, p->ackReceived);
+
+				p->ackReceived = true;
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
+	hton24(vdp.id, profile->id);
+	vdp.version = profile->version;
+	memcpy(&vdp.instance,&profile->instance, 16);
+	vdp.format = VDP_MACVLAN_FORMAT_1;
+	vdp.entries = htons(1);
+	memcpy(&vdp.mac_vlan.mac,&profile->mac, MAC_ADDR_LEN);
+	vdp.mac_vlan.vlan = htons(profile->vlan);
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
+		fprintf(stderr, "### %s:%s:vdp_bld_vsi_tlv() failed\n",
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
+struct packed_tlv *vdp_gettlv(struct vdp_data *vd, struct vsi_profile *profile)
+{
+	int size;
+	struct packed_tlv *ptlv = NULL;
+
+	/* frees the unpacked_tlv in vdp_data
+	 * also done in vdp_bld_vsi_tlv */
+	vdp_free_tlv(vd);
+
+	if (vdp_bld_tlv(vd, profile)) {
+		fprintf(stderr, "### %s:%s vdp_bld_tlv failed\n",
+			__func__, vd->ifname);
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
+	fprintf(stderr,"### %s:%s: failed\n", __func__, vd->ifname);
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
+	if (p1->id != p2->id)
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
+ * returns the profile that has been found or added, NULL otherwise.
+ *
+ * main interface function which adds a profile to a list kept on a per-port
+ * basis. Checks if the profile is already in the list, adds it if necessary.
+ */
+struct vsi_profile *vdp_add_profile(struct vsi_profile *profile)
+{
+	struct vsi_profile *p;
+	struct vdp_data *vd;
+
+	printf("%s(%i): adding vdp profile for %s !\n", __func__, __LINE__,
+	       profile->port->ifname);
+
+	vd = vdp_data(profile->port->ifname);
+	if (!vd) {
+		printf("%s(%i): Could not find vdp_data for %s !\n", __func__, __LINE__,
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
+/* vdp_remove_profile - remove a profile from a per port list
+ * @profile: profile to remove
+ *
+ * returns 0 if removal was successful, -1 if removal failed
+ *
+ * function used in the state machines to remove a profile from a list kept on
+ * a per-port basis. Checks if the profile is in the list, removes it if there.
+ */
+int vdp_remove_profile(struct vsi_profile *profile)
+{
+	struct vsi_profile *p;
+	struct vdp_data *vd;
+
+	printf("%s(%i): removing vdp profile on %s !\n", __func__, __LINE__,
+	       profile->port->ifname);
+
+	vd = vdp_data(profile->port->ifname);
+	if (!vd) {
+		printf("%s(%i): Could not find vdp_data for %s !\n", __func__, __LINE__,
+		       profile->port->ifname);
+		return -1;
+	}
+
+	/* loop over all existing profiles and check wether
+	 * it exists. If yes, remove it. */
+	LIST_FOREACH(p, &vd->profile_head, profile) {
+		if (p) {
+			vdp_print_profile(p);
+			if (vdp_profile_equal(p, profile)) {
+				LIST_REMOVE(p, profile);
+				free(p);
+			}
+		} else {
+			return -1;
+		}
+	}
+
+	return 0;
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
+	struct vsi_profile *p;
+
+	vd = vdp_data(ifname);
+	if (!vd)
+		goto out_err;
+
+	LIST_REMOVE(vd, entry);
+
+	LIST_FOREACH(p, &vd->profile_head, profile) {
+		LIST_REMOVE(p, profile);
+		free(p);
+	}
+	vdp_free_tlv(vd);
+	free(vd);
+	fprintf(stderr, "### %s:%s vdp data removed\n", __func__, ifname);
+	return;
+out_err:
+	fprintf(stderr, "### %s:%s vdp data remove failed\n", __func__, ifname);
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
+	char *p;
+	struct vdp_data *vd;
+	struct vdp_user_data *ud;
+
+	printf("%s(%i): starting VDP for if %s !\n", __func__, __LINE__, ifname);
+
+	vd = vdp_data(ifname);
+	if (vd) {
+		fprintf(stderr, "%s:%s vdp data already exists !\n", __func__, ifname);
+		return;
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
+	if (!init_cfg()) {
+		free(vd);
+		goto out_err;
+	}
+
+	vd->role = VDP_ROLE_STATION;
+
+	if (!get_cfg(ifname, "vdp.role", (void *)&p,
+		    CONFIG_TYPE_STRING)) {
+		if (!strcasecmp(p, VAL_BRIDGE)) {
+			vd->role = VDP_ROLE_BRIDGE;
+		}
+	}
+
+	printf("%s: configured for %s mode !\n", ifname,
+	       (vd->role ==VDP_ROLE_BRIDGE) ? "bridge" : "station");
+
+	LIST_INIT(&vd->profile_head);
+
+	ud = find_module_user_data_by_if(ifname, &lldp_head, LLDP_MOD_VDP);
+	LIST_INSERT_HEAD(&ud->head, vd, entry);
+
+	ecp_init(ifname);
+
+	fprintf(stderr, "### %s:%s vdp added\n", __func__, ifname);
+	return;
+
+out_err:
+	fprintf(stderr, "### %s:%s vdp adding failed\n", __func__, ifname);
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
index 571da31..c0938af 100644
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
