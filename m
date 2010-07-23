From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 11/17] ECP implementation
Date: Fri, 23 Jul 2010 12:34:27 +0200
Message-ID: <1279881273-10261-12-git-send-email-jens@linux.vnet.ibm.com>
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

This is the implementation of the edge control protocol (ECP) as specified
in IEEE 802.1Qbg.

For this it extends the infrastructure defined lldpad to send and receive
ECP frames with a new (yet to be defined) ethertype.
Received frames are validated and analyzed before the content is handed to the
upper layer protocol (ULP, VDP in this case) for further processing. Frames
to be transmitted are compiled from VSI (guest interface) profiles registered
on a interface.
Reception and transmission of ECP frames is controlled by RX and TX state
machines, timeouts are handled timeout functions.
The patch still contains a lot of debug code to allow low-level protocol
analysis.

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 Makefile.am        |    2 +
 ecp/ecp.c          |   77 +++++++
 ecp/ecp.h          |   92 ++++++++
 ecp/ecp_rx.c       |  597 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 ecp/ecp_tx.c       |  467 ++++++++++++++++++++++++++++++++++++++++
 include/lldp_evb.h |    6 +
 include/lldp_vdp.h |  157 ++++++++++++++
 lldp/l2_packet.h   |    2 +
 lldp/ports.h       |   25 ++-
 lldp_evb.c         |    2 +
 10 files changed, 1424 insertions(+), 3 deletions(-)
 create mode 100644 ecp/ecp.c
 create mode 100644 ecp/ecp.h
 create mode 100644 ecp/ecp_rx.c
 create mode 100644 ecp/ecp_tx.c
 create mode 100644 include/lldp_vdp.h

diff --git a/Makefile.am b/Makefile.am
index d59a6fa..061f2ee 100644
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
diff --git a/ecp/ecp.c b/ecp/ecp.c
new file mode 100644
index 0000000..ecf68f9
--- /dev/null
+++ b/ecp/ecp.c
@@ -0,0 +1,77 @@
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
+#include "messages.h"
+#include "config.h"
+#include "common.h"
+#include "lldp/l2_packet.h"
+#include "lldp/ports.h"
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
+	struct port *port;
+
+	port = port_find_by_name(ifname);
+
+	if (!port) {
+		printf("%s(%i): unable to find port %s ! \n", __func__, __LINE__, ifname);
+		goto fail;
+	}
+
+	port->ecp.l2 = l2_packet_init(port->ifname, NULL, ETH_P_ECP,
+		ecp_rx_ReceiveFrame, port, 1);
+	if (!port->ecp.l2) {
+		printf("ERROR: Failed to open register layer 2 access to "
+			"ETH_P_ECP\n");
+		goto fail;
+	}
+
+	ecp_tx_run_sm(port);
+	ecp_rx_run_sm(port);
+
+	return 0;
+
+fail:
+	return -1;
+}
diff --git a/ecp/ecp.h b/ecp/ecp.h
new file mode 100644
index 0000000..d08f873
--- /dev/null
+++ b/ecp/ecp.h
@@ -0,0 +1,92 @@
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
+#include "lldp/ports.h"
+#include "lldp_mod.h"
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
+struct ecp_hdr {
+	u8 oui[3];
+	u8 pad1;
+	u16 subtype;
+	u8 mode;
+	u16 seqnr;
+} __attribute__ ((__packed__));
+
+enum {
+	ECP_TX_IDLE,
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
+void ecp_tx_run_sm(struct port *);
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
+void ecp_rx_run_sm(struct port *);
+
+#endif /* _ECP_H */
diff --git a/ecp/ecp_rx.c b/ecp/ecp_rx.c
new file mode 100644
index 0000000..d8c050f
--- /dev/null
+++ b/ecp/ecp_rx.c
@@ -0,0 +1,597 @@
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
+#include "ecp.h"
+#include "lldp.h"
+#include "lldpad.h"
+#include "lldp_mod.h"
+#include "clif_msgs.h"
+#include "lldp_mand.h"
+
+/* ecp_rx_Initialize - initializes the ecp rx state machine
+ * @port: port for the state machine
+ *
+ * no return value
+ *
+ * initialize some variables, get rid of old frame if necessary
+ */
+void ecp_rx_Initialize(struct port *port)
+{
+	port->ecp.rx.rcvFrame = false;
+	port->ecp.rx.badFrame = false;
+
+	port->ecp.ackReceived = 0;
+
+	if (port->rx.framein) {
+		free(port->rx.framein);
+		port->rx.framein = NULL;
+	}
+	port->rx.sizein = 0;
+
+	return;
+}
+
+/* ecp_rx_freeFrame - free up received frame
+ * @port: port for the state machine
+ *
+ * no return value
+ *
+ * frees up an old received frame, set pointer to NULL and size to 0.
+ */
+void ecp_rx_freeFrame(struct port *port)
+{
+	free(port->ecp.rx.framein);
+	port->ecp.rx.framein = NULL;
+	port->ecp.rx.sizein = 0;
+}
+
+/* ecp_print_framein - print raw received frame
+ * @port: port for the state machine
+ *
+ * no return value
+ *
+ * prints out a raw version of a received frame. useful for low-level protocol
+ * debugging.
+ */
+void ecp_print_framein(struct port *port)
+{
+	int i;
+
+	for (i=0; i < port->ecp.rx.sizein; i++) {
+		printf("%02x ", port->ecp.rx.framein[i]);
+		if (!((i+1) % 16))
+			printf("\n");
+	}
+
+	printf("\n");
+}
+
+/* ecp_rx_send_ack_frame - send out ack frame for received frame
+ * @port: port for the state machine
+ *
+ * no return value
+ *
+ * creates an ack frame for a just received frame, prints the about to be
+ * sent frame and finally transmits it.
+ */
+void ecp_rx_send_ack_frame(struct port *port)
+{
+	ecp_rx_SendAckFrame(port);
+
+	ecp_print_frameout(port);
+
+	ecp_txFrame(port);
+
+	return;
+}
+
+/* ecp_rx_ReceiveFrame - receive ecp frame
+ * @ctx: rx callback context, struct port * in this case
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
+	struct port * port;
+	u8  frame_error = 0;
+	u8  own_addr[ETH_ALEN];
+	u16 tlv_offset;
+	struct l2_ethhdr *hdr;
+	struct l2_ethhdr example_hdr,*ex;
+	struct ecp_hdr *ecp_hdr;
+	char msg[2] = "";
+
+	if (ctx)
+		port = (struct port *)ctx;
+
+	printf("%s(%i)-%s: received packet with size %i\n", __func__, __LINE__,
+	       port->ifname, len);
+
+	if (port->adminStatus == disabled || port->adminStatus == enabledTxOnly)
+		return;
+
+	if (port->ecp.rx.framein &&
+	    port->ecp.rx.sizein == len &&
+	    (memcmp(buf, port->ecp.rx.framein, len) == 0)) {
+		port->ecp.stats.statsFramesInTotal++;
+		return;
+	}
+
+	if (port->ecp.rx.framein)
+		free(port->ecp.rx.framein);
+
+	port->ecp.rx.framein = (u8 *)malloc(len);
+	if (port->ecp.rx.framein == NULL) {
+		printf("ERROR - could not allocate memory for rx'ed frame\n");
+		return;
+	}
+	memcpy(port->ecp.rx.framein, buf, len);
+
+	port->ecp.rx.sizein = (u16)len;
+	ex = &example_hdr;
+	memcpy(ex->h_dest, multi_cast_source, ETH_ALEN);
+	ex->h_proto = htons(ETH_P_ECP);
+	hdr = (struct l2_ethhdr *)port->ecp.rx.framein;
+
+	if ((memcmp(hdr->h_dest,ex->h_dest, ETH_ALEN) != 0)) {
+		printf("ERROR multicast address error in incoming frame. "
+			"Dropping frame.\n");
+		frame_error++;
+		free(port->ecp.rx.framein);
+		port->ecp.rx.framein = NULL;
+		port->ecp.rx.sizein = 0;
+		return;
+	}
+
+	if (hdr->h_proto != example_hdr.h_proto) {
+		printf("ERROR Ethertype not ECP ethertype but ethertype "
+			"'%x' in incoming frame.\n", htons(hdr->h_proto));
+		frame_error++;
+		free(port->ecp.rx.framein);
+		port->ecp.rx.framein = NULL;
+		port->ecp.rx.sizein = 0;
+		return;
+	}
+
+	if (!frame_error) {
+		port->ecp.stats.statsFramesInTotal++;
+		port->ecp.rx.rcvFrame = 1;
+	}
+
+	tlv_offset = sizeof(struct l2_ethhdr);
+
+	ecp_hdr = (struct ecp_hdr *)&port->ecp.rx.framein[tlv_offset];
+
+	port->ecp.seqECPDU = ecp_hdr->seqnr;
+
+	switch(ecp_hdr->mode) {
+	case ECP_REQUEST:
+		port->ecp.ackReceived = false;
+		ecp_rx_run_sm(port);
+		break;
+	case ECP_ACK:
+		port->ecp.ackReceived = true;
+		printf("%s(%i)-%s: received ack frame \n", __func__, __LINE__, port->ifname);
+		ecp_print_framein(port);
+		ecp_tx_run_sm(port);
+		port->ecp.ackReceived = false;
+		break;
+	default:
+		printf("ERROR: unknown mode %i!\n", ecp_hdr->mode);
+		return;
+	}
+
+	ecp_rx_freeFrame(port);
+}
+
+/* ecp_rx_validateFrame - validates received frame
+ * @port: port used by ecp
+ *
+ * no return value
+ *
+ * checks wether received frame has correct subtype and mode
+ */
+
+void ecp_rx_validateFrame(struct port * port)
+{
+	u16 tlv_offset = 0;
+	struct ecp_hdr *ecp_hdr;
+
+	printf("%s(%i)-%s: validating frame \n", __func__, __LINE__, port->ifname);
+
+	assert(port->ecp.rx.framein && port->ecp.rx.sizein);
+
+	tlv_offset = sizeof(struct l2_ethhdr);
+
+	ecp_hdr = (struct ecp_hdr *)&port->ecp.rx.framein[tlv_offset];
+
+	printf("%s(%i)-%s: ecp packet with subtype %04x, mode %02x, sequence nr %04x\n",
+	       __func__, __LINE__, port->ifname, ecp_hdr->subtype, ecp_hdr->mode, ecp_hdr->seqnr);
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
+	port->ecp.seqECPDU = ecp_hdr->seqnr;
+}
+
+/* ecp_rx_SendAckFrame - send ack frame
+ * @port: port used by ecp
+ *
+ * currently always returns 0
+ *
+ * copies current received frame over to frame out, fills in address of this
+ * port and set mode field to ACK. used by ecp_rx_send_ack_frame.
+ */
+int ecp_rx_SendAckFrame(struct port * port)
+{
+	u16 tlv_offset = 0;
+	struct ecp_hdr *ecp_hdr;
+	struct l2_ethhdr *hdr;
+	u8 own_addr[ETH_ALEN];
+
+	printf("%s(%i)-%s: acking frame \n", __func__, __LINE__, port->ifname);
+
+	assert(port->ecp.rx.framein && port->ecp.rx.sizein);
+
+	/* copy over to frameout */
+	port->ecp.tx.frameout = (u8 *)malloc(ETH_FRAME_LEN);
+	memcpy(port->ecp.tx.frameout, port->ecp.rx.framein, port->ecp.rx.sizein);
+	port->ecp.tx.sizeout = port->ecp.rx.sizein;
+
+	/* use my own addr to send ACK */
+	hdr = (struct l2_ethhdr *)port->ecp.tx.frameout;
+	l2_packet_get_own_src_addr(port->ecp.l2,(u8 *)&own_addr);
+	memcpy(hdr->h_source, &own_addr, ETH_ALEN);
+
+	tlv_offset = sizeof(struct l2_ethhdr);
+	ecp_hdr = (struct ecp_hdr *)&port->ecp.tx.frameout[tlv_offset];
+	ecp_hdr->mode = ECP_ACK;
+
+	return 0;
+}
+
+/* ecp_rx_validate_frame - wrapper around ecp_rx_validateFrame
+ * @port: currently used port
+ *
+ * no return value
+ *
+ * sets rcvFrame to false and validates frame. used in ECP_RX_RECEIVE_ECPDU
+ * state of ecp_rx_run_sm
+ */
+void ecp_rx_validate_frame(struct port *port)
+{
+	port->ecp.rx.rcvFrame = false;
+	ecp_rx_validateFrame(port);
+	return;
+}
+
+/* ecp_rx_ProcessFrame - process received ecp frames
+ * @port: currently used port
+ *
+ * no return value
+ *
+ * walks through the packed vsi tlvs in an ecp frame, extracts them
+ * and passes them to the VDP ULP with vdp_indicate.
+ */
+void ecp_rx_ProcessFrame(struct port * port)
+{
+	u16 tlv_cnt = 0;
+	u8  tlv_type = 0;
+	u16 tlv_length = 0;
+	u16 tlv_offset = 0;
+	u16 *tlv_head_ptr = NULL;
+	u8  frame_error = 0;
+	bool tlv_stored     = false;
+	int err;
+	struct lldp_module *np;
+	struct ecp_hdr *ecp_hdr;
+
+	printf("%s(%i)-%s: processing frame \n", __func__, __LINE__, port->ifname);
+
+	assert(port->ecp.rx.framein && port->ecp.rx.sizein);
+
+	tlv_offset = sizeof(struct l2_ethhdr);
+
+	ecp_print_framein(port);
+
+	ecp_hdr = (struct ecp_hdr *)&port->ecp.rx.framein[tlv_offset];
+
+	printf("%s(%i)-%s: ecp packet with subtype %04x, mode %02x, sequence nr %04x\n",
+	       __func__, __LINE__, port->ifname, ecp_hdr->subtype, ecp_hdr->mode, ecp_hdr->seqnr);
+
+	/* FIXME: already done in ecp_rx_validateFrame ? */
+	if (ecp_hdr->subtype != ECP_SUBTYPE) {
+		printf("ERROR: unknown subtype !\n");
+		frame_error++;
+		goto out;
+	}
+
+	/* processing of VSI_TLVs starts here */
+
+	tlv_offset += sizeof(struct ecp_hdr);
+
+	do {
+		tlv_cnt++;
+		if (tlv_offset > port->ecp.rx.sizein) {
+			printf("%s(%i)-%s: ERROR: Frame overrun! tlv_offset %i, sizein %i cnt %i\n",
+			       __func__, __LINE__, port->ifname, tlv_offset, port->ecp.rx.sizein, tlv_cnt);
+			frame_error++;
+			goto out;
+		}
+
+		tlv_head_ptr = (u16 *)&port->ecp.rx.framein[tlv_offset];
+		tlv_length = htons(*tlv_head_ptr) & 0x01FF;
+		tlv_type = (u8)(htons(*tlv_head_ptr) >> 9);
+
+		u16 tmp_offset = tlv_offset + tlv_length;
+		if (tmp_offset > port->ecp.rx.sizein) {
+			printf("ERROR: Frame overflow error: offset=%d, "
+				"rx.size=%d \n", tmp_offset, port->ecp.rx.sizein);
+			frame_error++;
+			goto out;
+		}
+
+		u8 *info = (u8 *)&port->ecp.rx.framein[tlv_offset +
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
+			/* TODO: give VSI TLV to VDP */
+		}
+
+		if ((tlv->type != TYPE_0) && !tlv_stored) {
+			printf("\n%s: allocated TLV (%lu) "
+				   " was not stored! (%p)\n", __func__, tlv->type,
+				   tlv);
+			tlv = free_unpkd_tlv(tlv);
+			port->ecp.stats.statsTLVsUnrecognizedTotal++;
+		}
+
+		tlv = NULL;
+		tlv_stored = false;
+	} while(tlv_type != 0);
+
+out:
+	if (frame_error) {
+		port->ecp.stats.statsFramesDiscardedTotal++;
+		port->ecp.stats.statsFramesInErrorsTotal++;
+		port->ecp.rx.badFrame = true;
+	}
+
+	return;
+}
+
+/* ecp_rx_change_state - changes the ecp rx sm state
+ * @port: currently used port
+ * @newstate: new state for the sm
+ *
+ * no return value
+ *
+ * checks state transistion for consistency and finally changes the state of
+ * the profile.
+ */
+void ecp_rx_change_state(struct port *port, u8 newstate)
+{
+	switch(newstate) {
+	case ECP_RX_IDLE:
+		break;
+	case ECP_RX_INIT_RECEIVE:
+		break;
+	case ECP_RX_RECEIVE_WAIT:
+		assert((port->ecp.rx.state == ECP_RX_INIT_RECEIVE) ||
+		       (port->ecp.rx.state == ECP_RX_IDLE) ||
+		       (port->ecp.rx.state == ECP_RX_SEND_ACK) ||
+		       (port->ecp.rx.state == ECP_RX_RESEND_ACK));
+		break;
+	case ECP_RX_RECEIVE_ECPDU:
+		assert(port->ecp.rx.state == ECP_RX_RECEIVE_WAIT);
+		break;
+	case ECP_RX_SEND_ACK:
+		assert(port->ecp.rx.state == ECP_RX_RECEIVE_ECPDU);
+		break;
+	case ECP_RX_RESEND_ACK:
+		assert(port->ecp.rx.state == ECP_RX_RECEIVE_ECPDU);
+		break;
+	default:
+		printf("ERROR: The ECP_RX State Machine is broken!\n");
+		log_message(MSG_ERR_RX_SM_INVALID, "%s", port->ifname);
+	}
+
+	printf("%s(%i)-%s: state change %s -> %s\n", __func__, __LINE__,
+	       port->ifname, ecp_rx_states[port->ecp.rx.state], ecp_rx_states[newstate]);
+
+	port->ecp.rx.state = newstate;
+}
+
+/* ecp_set_rx_state - sets the ecp rx sm state
+ * @port: currently used port
+ *
+ * returns true or false
+ *
+ * switches the state machine to the next state depending on the input
+ * variables. returns true or false depending on wether the state machine
+ * can be run again with the new state or can stop at the current state.
+ */
+bool ecp_set_rx_state(struct port *port)
+{
+	if (port->portEnabled == false) {
+		ecp_rx_change_state(port, ECP_RX_IDLE);
+	}
+
+	switch(port->ecp.rx.state) {
+	case ECP_RX_IDLE:
+		if (port->portEnabled == true) {
+			ecp_rx_change_state(port, ECP_RX_INIT_RECEIVE);
+			return true;
+		}
+		return false;
+	case ECP_RX_INIT_RECEIVE:
+		if ((port->adminStatus == enabledRxTx) ||
+			(port->adminStatus == enabledRxOnly)) {
+			ecp_rx_change_state(port, ECP_RX_RECEIVE_WAIT);
+			return true;
+		}
+		return false;
+	case ECP_RX_RECEIVE_WAIT:
+		if ((port->adminStatus == disabled) ||
+			(port->adminStatus == enabledTxOnly)) {
+			ecp_rx_change_state(port, ECP_RX_IDLE);
+			return true;
+		}
+		if (port->ecp.rx.rcvFrame == true) {
+			ecp_rx_change_state(port, ECP_RX_RECEIVE_ECPDU);
+			return true;
+		}
+		return false;
+	case ECP_RX_RECEIVE_ECPDU:
+		if (port->ecp.seqECPDU == port->ecp.lastSequence) {
+			printf("%s(%i):-(%s) seqECPDU %x, lastSequence %x\n", __func__, __LINE__,
+			       port->ifname, port->ecp.seqECPDU, port->ecp.lastSequence);
+			ecp_rx_change_state(port, ECP_RX_RESEND_ACK);
+			return true;
+		}
+		if (port->ecp.seqECPDU != port->ecp.lastSequence) {
+			ecp_rx_change_state(port, ECP_RX_SEND_ACK);
+			return true;
+		}
+		return false;
+	case ECP_RX_SEND_ACK:
+		ecp_rx_change_state(port, ECP_RX_RECEIVE_WAIT);
+		return false;
+	case ECP_RX_RESEND_ACK:
+		ecp_rx_change_state(port, ECP_RX_RECEIVE_WAIT);
+		return false;
+	default:
+		printf("ERROR: The ECP_RX State Machine is broken!\n");
+		log_message(MSG_ERR_RX_SM_INVALID, "%s", port->ifname);
+		return false;
+	}
+}
+
+/* ecp_rx_run_sm - state machine for ecp rx
+ * @port: currently used port
+ *
+ * no return value
+ *
+ * runs the state machine for ecp rx.
+ */
+void ecp_rx_run_sm(struct port *port)
+{
+	ecp_set_rx_state(port);
+	do {
+		printf("%s(%i)-%s: ecp_rx - %s\n", __func__, __LINE__,
+		       port->ifname, ecp_rx_states[port->ecp.tx.state]);
+
+		switch(port->ecp.rx.state) {
+		case ECP_RX_IDLE:
+			break;
+		case ECP_RX_INIT_RECEIVE:
+			ecp_rx_Initialize(port);
+			break;
+		case ECP_RX_RECEIVE_WAIT:
+			break;
+		case ECP_RX_RECEIVE_ECPDU:
+			ecp_rx_validate_frame(port);
+			break;
+		case ECP_RX_SEND_ACK:
+			ecp_rx_ProcessFrame(port);
+			port->ecp.lastSequence = port->ecp.seqECPDU;
+			break;
+		case ECP_RX_RESEND_ACK:
+			ecp_rx_ProcessFrame(port);
+			if (!port->ecp.ackReceived) {
+				ecp_rx_send_ack_frame(port);
+				ecp_rx_freeFrame(port);
+			}
+			break;
+		default:
+			printf("ERROR: The ECP_RX State Machine is broken!\n");
+			log_message(MSG_ERR_TX_SM_INVALID, "%s", port->ifname);
+		}
+	} while (ecp_set_rx_state(port) == true);
+
+}
diff --git a/ecp/ecp_tx.c b/ecp/ecp_tx.c
new file mode 100644
index 0000000..d31edba
--- /dev/null
+++ b/ecp/ecp_tx.c
@@ -0,0 +1,467 @@
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
+#include "ecp.h"
+#include "lldpad.h"
+#include "lldp_tlv.h"
+#include "lldp_mod.h"
+#include "lldp_mand.h"
+#include "lldp_evb.h"
+#include "include/lldp_vdp.h"
+
+/* ecp_somethingChangedLocal - set flag if port has changed
+ * @port: port to set the flag for
+ * @mode: mode to set the flag to
+ *
+ * no return value
+ *
+ * set the localChange flag with a mode to indicate a port has changed.
+ * used  to signal an ecpdu needs to be sent out.
+ */
+
+void ecp_somethingChangedLocal(struct port *port, int mode)
+{
+	if (!port)
+		return;
+
+	port->ecp.tx.localChange |= mode;
+
+	return;
+}
+
+/* ecp_print_frameout - print outbound frame
+ * @port: currently used port
+ *
+ * no return value
+ *
+ * prints a raw dump of an outbound ecp frame. useful for low-level protocol
+ * debugging.
+ */
+void ecp_print_frameout(struct port *port)
+{
+	int i;
+
+	for (i=0; i < port->ecp.tx.sizeout; i++) {
+		printf("%02x ", port->ecp.tx.frameout[i]);
+		if (!((i+1) % 16))
+			printf("\n");
+	}
+
+	printf("\n");
+}
+
+/* ecp_build_ECPDU - create an ecp protocol data unit
+ * @port: currently used port
+ * @mode: mode to create pdu with (REQ or ACK)
+ *
+ * returns true on success, false on failure
+ *
+ * creates the frame header with the ports mac address, the ecp header with REQ
+ * or ACK mode, plus a list of packed TLVs created from the profiles on this
+ * port.
+ */
+bool ecp_build_ECPDU(struct port *port, int mode)
+{
+	struct l2_ethhdr eth;
+	struct ecp_hdr ecp_hdr;
+	u8  own_addr[ETH_ALEN];
+	u32 fb_offset = 0;
+	u32 datasize = 0;
+	struct packed_tlv *ptlv =  NULL;
+	struct lldp_module *np;
+	struct vdp_data *vd;
+	struct vsi_profile *p;
+
+	if (port->ecp.tx.frameout) {
+		free(port->ecp.tx.frameout);
+		port->ecp.tx.frameout = NULL;
+	}
+
+	/* TODO: different multicast address for sending ECP over S-channel (multi_cast_source_s)
+	 * S-channels to implement later */
+	memcpy(eth.h_dest, multi_cast_source, ETH_ALEN);
+	l2_packet_get_own_src_addr(port->ecp.l2,(u8 *)&own_addr);
+	memcpy(eth.h_source, &own_addr, ETH_ALEN);
+	eth.h_proto = htons(ETH_P_ECP);
+	port->ecp.tx.frameout = (u8 *)malloc(ETH_FRAME_LEN);
+	if (port->ecp.tx.frameout == NULL) {
+		printf("InfoECPDU: Failed to malloc frame buffer \n");
+		return false;
+	}
+	memset(port->ecp.tx.frameout,0,ETH_FRAME_LEN);
+	memcpy(port->ecp.tx.frameout, (void *)&eth, sizeof(struct l2_ethhdr));
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
+		       port->ifname);
+	}
+
+	ecp_hdr.seqnr = port->ecp.lastSequence;
+
+	if ((sizeof(struct ecp_hdr)+fb_offset) > ETH_MAX_DATA_LEN)
+				goto error;
+	memcpy(port->ecp.tx.frameout+fb_offset, (void *)&ecp_hdr, sizeof(struct ecp_hdr));
+	datasize += sizeof(struct ecp_hdr);
+	fb_offset += sizeof(struct ecp_hdr);
+
+	/* TODO: create tlvs from profiles here */
+
+	/* The End TLV marks the end of the LLDP PDU */
+	ptlv = pack_end_tlv();
+	if (!ptlv || ((ptlv->size + fb_offset) > ETH_MAX_DATA_LEN))
+		goto error;
+	memcpy(port->ecp.tx.frameout + fb_offset, ptlv->tlv, ptlv->size);
+	datasize += ptlv->size;
+	fb_offset += ptlv->size;
+	ptlv =  free_pkd_tlv(ptlv);
+
+	if (datasize < ETH_MIN_DATA_LEN)
+		port->ecp.tx.sizeout = ETH_MIN_PKT_LEN;
+	else
+		port->ecp.tx.sizeout = fb_offset;
+
+	return true;
+
+error:
+	ptlv = free_pkd_tlv(ptlv);
+	if (port->ecp.tx.frameout)
+		free(port->ecp.tx.frameout);
+	port->ecp.tx.frameout = NULL;
+	printf("InfoECPDU: packed TLV too large for tx frame\n");
+	return false;
+}
+
+/* ecp_tx_Initialize - initializes the ecp tx state machine
+ * @port: currently used port
+ *
+ * no return value
+ *
+ * initializes some variables for the ecp tx state machine.
+ */
+void ecp_tx_Initialize(struct port *port)
+{
+	if (port->ecp.tx.frameout) {
+		free(port->ecp.tx.frameout);
+		port->ecp.tx.frameout = NULL;
+	}
+	port->ecp.tx.localChange = VDP_PROFILE_REQ;
+	port->ecp.lastSequence = ECP_SEQUENCE_NR_START;
+	port->ecp.stats.statsFramesOutTotal = 0;
+	port->ecp.ackTimerExpired = false;
+	port->ecp.retries = 0;
+	l2_packet_get_port_state(port->ecp.l2, (u8 *)&(port->portEnabled));
+
+	return;
+}
+
+/* ecp_txFrame - transmit ecp frame
+ * @port: currently used port
+ *
+ * returns the number of characters sent on success, -1 on failure
+ *
+ * sends out the frame stored in the frameout structure using l2_packet_send.
+ */
+u8 ecp_txFrame(struct port *port)
+{
+	int status = 0;
+
+	status = l2_packet_send(port->ecp.l2, (u8 *)&multi_cast_source,
+		htons(ETH_P_ECP),port->ecp.tx.frameout,port->ecp.tx.sizeout);
+	port->ecp.stats.statsFramesOutTotal++;
+
+	return status;
+}
+
+/* ecp_tx_create_frame - create ecp frame
+ * @port: currently used port
+ *
+ * no return value
+ *
+ *
+ */
+void ecp_tx_create_frame(struct port *port)
+{
+	/* send REQs */
+	if (port->ecp.tx.localChange & VDP_PROFILE_REQ) {
+		printf("%s(%i)-%s: sending REQs\n", __func__, __LINE__, port->ifname);
+		ecp_build_ECPDU(port, VDP_PROFILE_REQ);
+		ecp_print_frameout(port);
+		ecp_txFrame(port);
+	}
+
+	/* send ACKs */
+	if (port->ecp.tx.localChange & VDP_PROFILE_ACK) {
+		printf("%s(%i)-%s: sending ACKs\n", __func__, __LINE__, port->ifname);
+		ecp_build_ECPDU(port, VDP_PROFILE_ACK);
+		ecp_print_frameout(port);
+		ecp_txFrame(port);
+	}
+
+	port->ecp.tx.localChange = 0;
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
+	struct port *port;
+
+	port = (struct port *) user_ctx;
+
+	port->ecp.ackTimerExpired = true;
+
+	printf("%s(%i)-%s: timer expired\n", __func__, __LINE__,
+	       port->ifname);
+
+	ecp_tx_run_sm(port);
+}
+
+/* ecp_tx_stop_ackTimer - stop the ECP ack timer
+ * @port: currently used port
+ *
+ * returns the number of removed handlers
+ *
+ * stops the ECP ack timer. used when a ack frame for the port has been
+ * received.
+ */
+static int ecp_tx_stop_ackTimer(struct port *port)
+{
+	printf("%s(%i)-%s: stopping timer\n", __func__, __LINE__,
+	       port->ifname);
+
+	return eloop_cancel_timeout(ecp_tx_timeout_handler, NULL, (void *) port);
+}
+
+/* ecp_tx_start_ackTimer - starts the ECP ack timer
+ * @profile: profile to process
+ *
+ * returns 0 on success, -1 on error
+ *
+ * starts the ack timer when a frame has been sent out.
+ */
+static void ecp_tx_start_ackTimer(struct port *port)
+{
+	unsigned int secs, usecs;
+
+	port->ecp.ackTimerExpired = false;
+
+	secs = ECP_TRANSMISSION_TIMER / ECP_TRANSMISSION_DIVIDER;
+	usecs = ECP_TRANSMISSION_TIMER % ECP_TRANSMISSION_DIVIDER;
+
+	printf("%s(%i)-%s: starting timer\n", __func__, __LINE__,
+	       port->ifname);
+
+	eloop_register_timeout(secs, usecs, ecp_tx_timeout_handler, NULL, (void *) port);
+}
+
+/* ecp_tx_change_state - changes the ecp tx sm state
+ * @port: currently used port
+ * @newstate: new state for the sm
+ *
+ * no return value
+ *
+ * checks state transistion for consistency and finally changes the state of
+ * the profile.
+ */
+static void ecp_tx_change_state(struct port *port, u8 newstate)
+{
+	switch(newstate) {
+	case ECP_TX_IDLE:
+		break;
+	case ECP_TX_INIT_TRANSMIT:
+		assert(port->ecp.tx.state == ECP_TX_IDLE);
+		break;
+	case ECP_TX_TRANSMIT_ECPDU:
+		assert((port->ecp.tx.state == ECP_TX_INIT_TRANSMIT) ||
+		       (port->ecp.tx.state == ECP_TX_WAIT_FOR_ACK) ||
+		       (port->ecp.tx.state == ECP_TX_REQUEST_PDU));
+		break;
+	case ECP_TX_WAIT_FOR_ACK:
+		assert(port->ecp.tx.state == ECP_TX_TRANSMIT_ECPDU);
+		break;
+	case ECP_TX_REQUEST_PDU:
+		assert(port->ecp.tx.state == ECP_TX_WAIT_FOR_ACK);
+		break;
+	default:
+		printf("ERROR: The ECP_TX State Machine is broken!\n");
+		log_message(MSG_ERR_TX_SM_INVALID, "%s", port->ifname);
+	}
+
+	printf("%s(%i)-%s: state change %s -> %s\n", __func__, __LINE__,
+	       port->ifname, ecp_tx_states[port->ecp.tx.state], ecp_tx_states[newstate]);
+
+	port->ecp.tx.state = newstate;
+	return;
+}
+
+/* ecp_set_tx_state - sets the ecp tx sm state
+ * @port: currently used port
+ *
+ * returns true or false
+ *
+ * switches the state machine to the next state depending on the input
+ * variables. returns true or false depending on wether the state machine
+ * can be run again with the new state or can stop at the current state.
+ */
+static bool ecp_set_tx_state(struct port *port)
+{
+	if ((port->portEnabled == false) && (port->prevPortEnabled == true)) {
+		printf("set_tx_state: port was disabled\n");
+		ecp_tx_change_state(port, ECP_TX_INIT_TRANSMIT);
+	}
+	port->prevPortEnabled = port->portEnabled;
+
+	switch (port->ecp.tx.state) {
+	case ECP_TX_IDLE:
+		if (port->portEnabled) {
+			ecp_tx_change_state(port, ECP_TX_INIT_TRANSMIT);
+			return true;
+		}
+		return false;
+	case ECP_TX_INIT_TRANSMIT:
+		if (port->portEnabled && ((port->adminStatus == enabledRxTx) ||
+			(port->adminStatus == enabledTxOnly))) {
+			ecp_tx_change_state(port, ECP_TX_TRANSMIT_ECPDU);
+			return true;
+		}
+		return false;
+	case ECP_TX_TRANSMIT_ECPDU:
+		if ((port->adminStatus == disabled) ||
+			(port->adminStatus == enabledRxOnly)) {
+			ecp_tx_change_state(port, ECP_TX_INIT_TRANSMIT);
+			return true;
+		}
+		ecp_tx_change_state(port, ECP_TX_WAIT_FOR_ACK);
+		return true;
+	case ECP_TX_WAIT_FOR_ACK:
+		if (port->ecp.ackTimerExpired) {
+			port->ecp.retries++;
+			if (port->ecp.retries < ECP_MAX_RETRIES) {
+				ecp_somethingChangedLocal(port, VDP_PROFILE_REQ);
+				ecp_tx_change_state(port, ECP_TX_TRANSMIT_ECPDU);
+				return true;
+			}
+			if (port->ecp.retries == ECP_MAX_RETRIES) {
+				printf("%s(%i)-%s: 1 \n", __func__, __LINE__,
+				       port->ifname);
+				ecp_tx_change_state(port, ECP_TX_REQUEST_PDU);
+				return true;
+			}
+		}
+		if (port->ecp.ackReceived && port->ecp.seqECPDU == port->ecp.lastSequence) {
+			port->ecp.ackReceived = false;
+			ecp_tx_change_state(port, ECP_TX_REQUEST_PDU);
+			return true;
+		}
+		return false;
+	case ECP_TX_REQUEST_PDU:
+		if (port->ecp.tx.localChange & VDP_PROFILE_REQ) {
+			ecp_tx_change_state(port, ECP_TX_TRANSMIT_ECPDU);
+			return true;
+		}
+		return false;
+	default:
+		printf("ERROR: The TX State Machine is broken!\n");
+		log_message(MSG_ERR_TX_SM_INVALID, "%s", port->ifname);
+		return false;
+	}
+}
+
+/* ecp_tx_run_sm - state machine for ecp tx
+ * @port: currently used port
+ *
+ * no return value
+ *
+ * runs the state machine for ecp tx.
+ */
+void ecp_tx_run_sm(struct port *port)
+{
+	do {
+		printf("%s(%i)-%s: ecp_tx - %s\n", __func__, __LINE__,
+		       port->ifname, ecp_tx_states[port->ecp.tx.state]);
+
+		switch(port->ecp.tx.state) {
+		case ECP_TX_IDLE:
+			break;
+		case ECP_TX_INIT_TRANSMIT:
+			ecp_tx_Initialize(port);
+			break;
+		case ECP_TX_TRANSMIT_ECPDU:
+			ecp_tx_create_frame(port);
+			ecp_tx_start_ackTimer(port);
+			break;
+		case ECP_TX_WAIT_FOR_ACK:
+			if (port->ecp.ackReceived) {
+				printf("%s(%i)-%s: ECP_TX_WAIT_FOR_ACK ackReceived\n", __func__, __LINE__,
+				       port->ifname);
+				printf("%s(%i)-%s: 2: seqECPDU %x lastSequence %x \n", __func__, __LINE__,
+				       port->ifname, port->ecp.seqECPDU, port->ecp.lastSequence);
+				port->ecp.tx.localChange = 0;
+				ecp_tx_stop_ackTimer(port);
+				ecp_rx_ProcessFrame(port);
+			}
+			break;
+		case ECP_TX_REQUEST_PDU:
+			port->ecp.retries = 0;
+			port->ecp.lastSequence++;
+			printf("%s(%i)-%s: ECP_TX_REQUEST_PDU lastSequence %x\n", __func__, __LINE__,
+			       port->ifname, port->ecp.lastSequence++);
+			break;
+		default:
+			printf("%s(%i): ERROR The TX State Machine is broken!\n", __func__,
+			       __LINE__);
+			log_message(MSG_ERR_TX_SM_INVALID, "%s", port->ifname);
+		}
+	} while (ecp_set_tx_state(port) == true);
+
+	return;
+}
diff --git a/include/lldp_evb.h b/include/lldp_evb.h
index de39fd3..3ca7aa9 100644
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
index 0000000..43200af
--- /dev/null
+++ b/include/lldp_vdp.h
@@ -0,0 +1,157 @@
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
+	u8 id[3];
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
+struct packed_tlv *vdp_gettlv(struct port *port, struct vsi_profile *profile);
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
+  c = sprintf(s, "id: %x%x%x\n", p->id[2], p->id[1], p->id[0]); \
+  s += c; \
+  c = sprintf(s, "version: %i\n", p->version); s += c; \
+  char instance[INSTANCE_STRLEN+2]; \
+  instance2str(p->instance, instance, sizeof(instance)); \
+  c = sprintf(s, "instance: %s\n", &instance); s += c; \
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
index 0138efe..c2e18ec 100644
--- a/lldp/ports.h
+++ b/lldp/ports.h
@@ -136,21 +136,40 @@ struct porttlvs{
 	struct unpacked_tlv *last_peer;
 };
 
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
 struct port {
 	char *ifname;
 	u8 hw_resetting;
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
+	struct ecp ecp;
 	struct port *next;
 };
 
diff --git a/lldp_evb.c b/lldp_evb.c
index bce01b6..b1b7edc 100644
--- a/lldp_evb.c
+++ b/lldp_evb.c
@@ -354,6 +354,8 @@ static void evb_statemachine(struct evb_data *ed, struct tlv_info_evb *tie)
 		 * different parameters ? Check parameters. switch state back to
 		 * EVB_CONFIGURE ? */
 		printf("%s: state -> EVB_CONFIRMATION\n", __func__);
+		if (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_ECP)
+			ecp_init(ed->ifname);
 		break;
 	default:
 		fprintf(stderr, "EVB statemachine reached invalid state !\n");
-- 
1.7.1
