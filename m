From: John Fastabend <john.r.fastabend@intel.com>
Subject: Re: [E1000-eedc] [PATCH 05/10] implementation of VDP
Date: Wed, 22 Sep 2010 17:55:28 -0700
Message-ID: <4C9AA580.2010102@intel.com>
References: <1282739262-14968-1-git-send-email-jens@linux.vnet.ibm.com>
	<1282739262-14968-6-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1282739262-14968-6-git-send-email-jens@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Osterkamp <jens@linux.vnet.ibm.com>
Cc: "chrisw@redhat.com" <chrisw@redhat.com>, "evb@yahoogroups.com" <evb@yahoogroups.com>, "e1000-eedc@lists.sourceforge.net" <e1000-eedc@lists.sourceforge.net>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 8/25/2010 5:27 AM, Jens Osterkamp wrote:
> This patch contains an initial implemention of VDP as specified in IEEE
> 802.1Qbg.
> VDP serves as the upper layer protocol (ULP) for TLVs communicated via the
> ECP protocol.
> For this it registers as a new module in lldpad. The VDP module supports a
> station and a bridge role. As a station, new VSI (virtual station interface)
> profiles can be registered to the VDP module using lldptool or libvirt.
> These profiles are then announced to an adjacent switch. Transmitted profiles
> are processed to the desired state by the VDP station state machine.
> As a bridge, the VDP module waits for new profiles received in TLVs by ECP.
> The received profiles are processed to the desired state by a VDP bridge
> state machine.
> 
> VDP module parameters are stored in the "vdp" section under the appropriate
> interface.
> 
> The patch still contains a lot of debug code to allow analysis of VDP
> protocol behavior.
> 
> Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
> ---
>  Makefile.am        |    8 +-
>  ecp/ecp.c          |   22 +-
>  ecp/ecp.h          |   19 +-
>  ecp/ecp_rx.c       |  350 ++++++++--------
>  ecp/ecp_tx.c       |  292 ++++++++------
>  include/lldp.h     |    1 +
>  include/lldp_vdp.h |   10 +-
>  lldp/ports.h       |   14 -
>  lldp_vdp.c         | 1140 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  lldpad.c           |    2 +
>  10 files changed, 1517 insertions(+), 341 deletions(-)
>  create mode 100644 lldp_vdp.c
> 
> 

snip

> 
>  /* ecp_build_ECPDU - create an ecp protocol data unit
> - * @port: currently used port
> + * @vd: currently used port
>   * @mode: mode to create pdu with (REQ or ACK)
>   *
>   * returns true on success, false on failure
> @@ -86,7 +88,7 @@ void ecp_print_frameout(struct port *port)
>   * or ACK mode, plus a list of packed TLVs created from the profiles on this
>   * port.
>   */
> -bool ecp_build_ECPDU(struct port *port, int mode)
> +bool ecp_build_ECPDU(struct vdp_data *vd, int mode)
>  {
>         struct l2_ethhdr eth;
>         struct ecp_hdr ecp_hdr;
> @@ -94,28 +96,26 @@ bool ecp_build_ECPDU(struct port *port, int mode)
>         u32 fb_offset = 0;
>         u32 datasize = 0;
>         struct packed_tlv *ptlv =  NULL;
> -       struct lldp_module *np;
> -       struct vdp_data *vd;
>         struct vsi_profile *p;
> 
> -       if (port->ecp.tx.frameout) {
> -               free(port->ecp.tx.frameout);
> -               port->ecp.tx.frameout = NULL;
> +       if (vd->ecp.tx.frameout) {
> +               free(vd->ecp.tx.frameout);
> +               vd->ecp.tx.frameout = NULL;
>         }
> 
>         /* TODO: different multicast address for sending ECP over S-channel (multi_cast_source_s)
>          * S-channels to implement later */
>         memcpy(eth.h_dest, multi_cast_source, ETH_ALEN);
> -       l2_packet_get_own_src_addr(port->ecp.l2,(u8 *)&own_addr);
> +       l2_packet_get_own_src_addr(vd->ecp.l2,(u8 *)&own_addr);
>         memcpy(eth.h_source, &own_addr, ETH_ALEN);
>         eth.h_proto = htons(ETH_P_ECP);
> -       port->ecp.tx.frameout = (u8 *)malloc(ETH_FRAME_LEN);
> -       if (port->ecp.tx.frameout == NULL) {
> +       vd->ecp.tx.frameout = (u8 *)malloc(ETH_FRAME_LEN);
> +       if (vd->ecp.tx.frameout == NULL) {
>                 printf("InfoECPDU: Failed to malloc frame buffer \n");
>                 return false;
>         }
> -       memset(port->ecp.tx.frameout,0,ETH_FRAME_LEN);
> -       memcpy(port->ecp.tx.frameout, (void *)&eth, sizeof(struct l2_ethhdr));
> +       memset(vd->ecp.tx.frameout,0,ETH_FRAME_LEN);
> +       memcpy(vd->ecp.tx.frameout, (void *)&eth, sizeof(struct l2_ethhdr));
>         fb_offset += sizeof(struct l2_ethhdr);
> 
>         ecp_hdr.oui[0] = 0x0;
> @@ -134,111 +134,140 @@ bool ecp_build_ECPDU(struct port *port, int mode)
>                 break;
>         default:
>                 printf("%s(%i): unknown mode for %s !\n", __func__, __LINE__,
> -                      port->ifname);
> +                      vd->ifname);
>         }
> 
> -       ecp_hdr.seqnr = port->ecp.lastSequence;
> +       ecp_hdr.seqnr = vd->ecp.lastSequence;
> 
>         if ((sizeof(struct ecp_hdr)+fb_offset) > ETH_MAX_DATA_LEN)
>                                 goto error;
> -       memcpy(port->ecp.tx.frameout+fb_offset, (void *)&ecp_hdr, sizeof(struct ecp_hdr));
> +       memcpy(vd->ecp.tx.frameout+fb_offset, (void *)&ecp_hdr, sizeof(struct ecp_hdr));
>         datasize += sizeof(struct ecp_hdr);
>         fb_offset += sizeof(struct ecp_hdr);
> 
> -       /* TODO: create tlvs from profiles here */
> +       /* create packed_tlvs for all profiles on this interface */
> +       LIST_FOREACH(p, &vd->profile_head, profile) {
> +               if(!p) {
> +                       printf("%s(%i): list vd->profile_head empty !\n", __func__, __LINE__);
> +                       continue;
> +               }
> +
> +               if (p->localChange != mode) {
> +                       printf("%s(%i): not sending out profile !\n", __func__, __LINE__);
> +                       continue;
> +               }
> +
> +               ptlv = vdp_gettlv(vd, p);
> +
> +               if(!ptlv) {
> +                       printf("%s(%i): ptlv not created !\n", __func__, __LINE__);
> +                       continue;
> +               }
> +
> +               if (ptlv) {
> +                       if ((ptlv->size+fb_offset) > ETH_MAX_DATA_LEN)
> +                               goto error;
> +                       memcpy(vd->ecp.tx.frameout+fb_offset,
> +                              ptlv->tlv, ptlv->size);
> +                       datasize += ptlv->size;
> +                       fb_offset += ptlv->size;
> +               }
> +       }
> 
>         /* The End TLV marks the end of the LLDP PDU */
>         ptlv = pack_end_tlv();
>         if (!ptlv || ((ptlv->size + fb_offset) > ETH_MAX_DATA_LEN))
>                 goto error;
> -       memcpy(port->ecp.tx.frameout + fb_offset, ptlv->tlv, ptlv->size);
> +       memcpy(vd->ecp.tx.frameout + fb_offset, ptlv->tlv, ptlv->size);
>         datasize += ptlv->size;
>         fb_offset += ptlv->size;
>         ptlv =  free_pkd_tlv(ptlv);
> 
>         if (datasize < ETH_MIN_DATA_LEN)
> -               port->ecp.tx.sizeout = ETH_MIN_PKT_LEN;
> +               vd->ecp.tx.sizeout = ETH_MIN_PKT_LEN;


check ETH_MAX_DATA_LEN here as well as min length.

>         else
> -               port->ecp.tx.sizeout = fb_offset;
> +               vd->ecp.tx.sizeout = fb_offset;
> 
>         return true;
> 
>  error:
>         ptlv = free_pkd_tlv(ptlv);
> -       if (port->ecp.tx.frameout)
> -               free(port->ecp.tx.frameout);
> -       port->ecp.tx.frameout = NULL;
> +       if (vd->ecp.tx.frameout)
> +               free(vd->ecp.tx.frameout);
> +       vd->ecp.tx.frameout = NULL;
>         printf("InfoECPDU: packed TLV too large for tx frame\n");
>         return false;
>  }
> 
>  /* ecp_tx_Initialize - initializes the ecp tx state machine
> - * @port: currently used port
> + * @vd: currently used port
>   *
>   * no return value
>   *
>   * initializes some variables for the ecp tx state machine.
>   */
> -void ecp_tx_Initialize(struct port *port)
> +void ecp_tx_Initialize(struct vdp_data *vd)
>  {
> -       if (port->ecp.tx.frameout) {
> -               free(port->ecp.tx.frameout);
> -               port->ecp.tx.frameout = NULL;
> +       if (vd->ecp.tx.frameout) {
> +               free(vd->ecp.tx.frameout);
> +               vd->ecp.tx.frameout = NULL;
>         }
> -       port->ecp.tx.localChange = VDP_PROFILE_REQ;
> -       port->ecp.lastSequence = ECP_SEQUENCE_NR_START;
> -       port->ecp.stats.statsFramesOutTotal = 0;
> -       port->ecp.ackTimerExpired = false;
> -       port->ecp.retries = 0;
> -       l2_packet_get_port_state(port->ecp.l2, (u8 *)&(port->portEnabled));
> +       vd->ecp.tx.localChange = VDP_PROFILE_REQ;
> +       vd->ecp.lastSequence = ECP_SEQUENCE_NR_START;
> +       vd->ecp.stats.statsFramesOutTotal = 0;
> +       vd->ecp.ackTimerExpired = false;
> +       vd->ecp.retries = 0;
> +
> +       struct port *port = port_find_by_name(vd->ifname);
> +       l2_packet_get_port_state(vd->ecp.l2, (u8 *)&(port->portEnabled));
> 
>         return;
>  }
> 
>  /* ecp_txFrame - transmit ecp frame
> - * @port: currently used port
> + * @vd: currently used port
>   *
>   * returns the number of characters sent on success, -1 on failure
>   *
>   * sends out the frame stored in the frameout structure using l2_packet_send.
>   */
> -u8 ecp_txFrame(struct port *port)
> +u8 ecp_txFrame(struct vdp_data *vd)
>  {
>         int status = 0;
> 
> -       status = l2_packet_send(port->ecp.l2, (u8 *)&multi_cast_source,
> -               htons(ETH_P_ECP),port->ecp.tx.frameout,port->ecp.tx.sizeout);
> -       port->ecp.stats.statsFramesOutTotal++;
> +       status = l2_packet_send(vd->ecp.l2, (u8 *)&multi_cast_source,
> +               htons(ETH_P_ECP),vd->ecp.tx.frameout,vd->ecp.tx.sizeout);
> +       vd->ecp.stats.statsFramesOutTotal++;
> 
>         return status;
>  }
> 
>  /* ecp_tx_create_frame - create ecp frame
> - * @port: currently used port
> + * @vd: currently used port
>   *
>   * no return value
>   *
>   *
>   */
> -void ecp_tx_create_frame(struct port *port)
> +void ecp_tx_create_frame(struct vdp_data *vd)
>  {
>         /* send REQs */
> -       if (port->ecp.tx.localChange & VDP_PROFILE_REQ) {
> -               printf("%s(%i)-%s: sending REQs\n", __func__, __LINE__, port->ifname);
> -               ecp_build_ECPDU(port, VDP_PROFILE_REQ);
> -               ecp_print_frameout(port);
> -               ecp_txFrame(port);
> +       if (vd->ecp.tx.localChange & VDP_PROFILE_REQ) {
> +               printf("%s(%i)-%s: sending REQs\n", __func__, __LINE__, vd->ifname);
> +               ecp_build_ECPDU(vd, VDP_PROFILE_REQ);
> +               ecp_print_frameout(vd);
> +               ecp_txFrame(vd);
>         }
> 
>         /* send ACKs */
> -       if (port->ecp.tx.localChange & VDP_PROFILE_ACK) {
> -               printf("%s(%i)-%s: sending ACKs\n", __func__, __LINE__, port->ifname);
> -               ecp_build_ECPDU(port, VDP_PROFILE_ACK);
> -               ecp_print_frameout(port);
> -               ecp_txFrame(port);
> +       if (vd->ecp.tx.localChange & VDP_PROFILE_ACK) {
> +               printf("%s(%i)-%s: sending ACKs\n", __func__, __LINE__, vd->ifname);
> +               ecp_build_ECPDU(vd, VDP_PROFILE_ACK);
> +               ecp_print_frameout(vd);
> +               ecp_txFrame(vd);
>         }
> 
> -       port->ecp.tx.localChange = 0;
> +       vd->ecp.tx.localChange = 0;
>         return;
>  }
> 
> @@ -253,32 +282,32 @@ void ecp_tx_create_frame(struct port *port)
>   */
>  static void ecp_tx_timeout_handler(void *eloop_data, void *user_ctx)
>  {
> -       struct port *port;
> +       struct vdp_data *vd;
> 
> -       port = (struct port *) user_ctx;
> +       vd = (struct vdp_data *) user_ctx;
> 
> -       port->ecp.ackTimerExpired = true;
> +       vd->ecp.ackTimerExpired = true;
> 
>         printf("%s(%i)-%s: timer expired\n", __func__, __LINE__,
> -              port->ifname);
> +              vd->ifname);
> 
> -       ecp_tx_run_sm(port);
> +       ecp_tx_run_sm(vd);
>  }
> 
>  /* ecp_tx_stop_ackTimer - stop the ECP ack timer
> - * @port: currently used port
> + * @vd: currently used port
>   *
>   * returns the number of removed handlers
>   *
>   * stops the ECP ack timer. used when a ack frame for the port has been
>   * received.
>   */
> -static int ecp_tx_stop_ackTimer(struct port *port)
> +static int ecp_tx_stop_ackTimer(struct vdp_data *vd)
>  {
>         printf("%s(%i)-%s: stopping timer\n", __func__, __LINE__,
> -              port->ifname);
> +              vd->ifname);
> 
> -       return eloop_cancel_timeout(ecp_tx_timeout_handler, NULL, (void *) port);
> +       return eloop_cancel_timeout(ecp_tx_timeout_handler, NULL, (void *) vd);
>  }
> 
>  /* ecp_tx_start_ackTimer - starts the ECP ack timer
> @@ -288,23 +317,23 @@ static int ecp_tx_stop_ackTimer(struct port *port)
>   *
>   * starts the ack timer when a frame has been sent out.
>   */
> -static void ecp_tx_start_ackTimer(struct port *port)
> +static void ecp_tx_start_ackTimer(struct vdp_data *vd)
>  {
>         unsigned int secs, usecs;
> 
> -       port->ecp.ackTimerExpired = false;
> +       vd->ecp.ackTimerExpired = false;
> 
>         secs = ECP_TRANSMISSION_TIMER / ECP_TRANSMISSION_DIVIDER;
>         usecs = ECP_TRANSMISSION_TIMER % ECP_TRANSMISSION_DIVIDER;
> 
>         printf("%s(%i)-%s: starting timer\n", __func__, __LINE__,
> -              port->ifname);
> +              vd->ifname);
> 
> -       eloop_register_timeout(secs, usecs, ecp_tx_timeout_handler, NULL, (void *) port);
> +       eloop_register_timeout(secs, usecs, ecp_tx_timeout_handler, NULL, (void *) vd);
>  }
> 
>  /* ecp_tx_change_state - changes the ecp tx sm state
> - * @port: currently used port
> + * @vd: currently used port
>   * @newstate: new state for the sm
>   *
>   * no return value
> @@ -312,39 +341,36 @@ static void ecp_tx_start_ackTimer(struct port *port)
>   * checks state transistion for consistency and finally changes the state of
>   * the profile.
>   */
> -static void ecp_tx_change_state(struct port *port, u8 newstate)
> +static void ecp_tx_change_state(struct vdp_data *vd, u8 newstate)
>  {
>         switch(newstate) {
> -       case ECP_TX_IDLE:
> -               break;
>         case ECP_TX_INIT_TRANSMIT:
> -               assert(port->ecp.tx.state == ECP_TX_IDLE);
>                 break;
>         case ECP_TX_TRANSMIT_ECPDU:
> -               assert((port->ecp.tx.state == ECP_TX_INIT_TRANSMIT) ||
> -                      (port->ecp.tx.state == ECP_TX_WAIT_FOR_ACK) ||
> -                      (port->ecp.tx.state == ECP_TX_REQUEST_PDU));
> +               assert((vd->ecp.tx.state == ECP_TX_INIT_TRANSMIT) ||
> +                      (vd->ecp.tx.state == ECP_TX_WAIT_FOR_ACK) ||
> +                      (vd->ecp.tx.state == ECP_TX_REQUEST_PDU));
>                 break;
>         case ECP_TX_WAIT_FOR_ACK:
> -               assert(port->ecp.tx.state == ECP_TX_TRANSMIT_ECPDU);
> +               assert(vd->ecp.tx.state == ECP_TX_TRANSMIT_ECPDU);
>                 break;
>         case ECP_TX_REQUEST_PDU:
> -               assert(port->ecp.tx.state == ECP_TX_WAIT_FOR_ACK);
> +               assert(vd->ecp.tx.state == ECP_TX_WAIT_FOR_ACK);
>                 break;
>         default:
>                 printf("ERROR: The ECP_TX State Machine is broken!\n");
> -               log_message(MSG_ERR_TX_SM_INVALID, "%s", port->ifname);
> +               log_message(MSG_ERR_TX_SM_INVALID, "%s", vd->ifname);
>         }
> 
>         printf("%s(%i)-%s: state change %s -> %s\n", __func__, __LINE__,
> -              port->ifname, ecp_tx_states[port->ecp.tx.state], ecp_tx_states[newstate]);
> +              vd->ifname, ecp_tx_states[vd->ecp.tx.state], ecp_tx_states[newstate]);
> 
> -       port->ecp.tx.state = newstate;
> +       vd->ecp.tx.state = newstate;
>         return;
>  }
> 
>  /* ecp_set_tx_state - sets the ecp tx sm state
> - * @port: currently used port
> + * @vd: currently used port
>   *
>   * returns true or false
>   *
> @@ -352,116 +378,116 @@ static void ecp_tx_change_state(struct port *port, u8 newstate)
>   * variables. returns true or false depending on wether the state machine
>   * can be run again with the new state or can stop at the current state.
>   */
> -static bool ecp_set_tx_state(struct port *port)
> +static bool ecp_set_tx_state(struct vdp_data *vd)
>  {
> +       struct port *port = port_find_by_name(vd->ifname);
> +
> +       if (!port) {
> +               printf("%s(%i): port not found !\n", __func__, __LINE__);
> +               return 0;
> +       }
> +
>         if ((port->portEnabled == false) && (port->prevPortEnabled == true)) {
>                 printf("set_tx_state: port was disabled\n");
> -               ecp_tx_change_state(port, ECP_TX_INIT_TRANSMIT);
> +               ecp_tx_change_state(vd, ECP_TX_INIT_TRANSMIT);
>         }
>         port->prevPortEnabled = port->portEnabled;
> 
> -       switch (port->ecp.tx.state) {
> -       case ECP_TX_IDLE:
> -               if (port->portEnabled) {
> -                       ecp_tx_change_state(port, ECP_TX_INIT_TRANSMIT);
> -                       return true;
> -               }
> -               return false;
> +       switch (vd->ecp.tx.state) {
>         case ECP_TX_INIT_TRANSMIT:
>                 if (port->portEnabled && ((port->adminStatus == enabledRxTx) ||
>                         (port->adminStatus == enabledTxOnly))) {
> -                       ecp_tx_change_state(port, ECP_TX_TRANSMIT_ECPDU);
> +                       ecp_somethingChangedLocal(vd, VDP_PROFILE_REQ);
> +                       ecp_tx_change_state(vd, ECP_TX_TRANSMIT_ECPDU);
>                         return true;
>                 }
>                 return false;
>         case ECP_TX_TRANSMIT_ECPDU:
>                 if ((port->adminStatus == disabled) ||
>                         (port->adminStatus == enabledRxOnly)) {
> -                       ecp_tx_change_state(port, ECP_TX_INIT_TRANSMIT);
> +                       ecp_tx_change_state(vd, ECP_TX_INIT_TRANSMIT);
>                         return true;
>                 }
> -               ecp_tx_change_state(port, ECP_TX_WAIT_FOR_ACK);
> +               ecp_tx_change_state(vd, ECP_TX_WAIT_FOR_ACK);
>                 return true;
>         case ECP_TX_WAIT_FOR_ACK:
> -               if (port->ecp.ackTimerExpired) {
> -                       port->ecp.retries++;
> -                       if (port->ecp.retries < ECP_MAX_RETRIES) {
> -                               ecp_somethingChangedLocal(port, VDP_PROFILE_REQ);
> -                               ecp_tx_change_state(port, ECP_TX_TRANSMIT_ECPDU);
> +               if (vd->ecp.ackTimerExpired) {
> +                       vd->ecp.retries++;
> +                       if (vd->ecp.retries < ECP_MAX_RETRIES) {
> +                               ecp_somethingChangedLocal(vd, VDP_PROFILE_REQ);
> +                               ecp_tx_change_state(vd, ECP_TX_TRANSMIT_ECPDU);
>                                 return true;
>                         }
> -                       if (port->ecp.retries == ECP_MAX_RETRIES) {
> +                       if (vd->ecp.retries == ECP_MAX_RETRIES) {
>                                 printf("%s(%i)-%s: 1 \n", __func__, __LINE__,
> -                                      port->ifname);
> -                               ecp_tx_change_state(port, ECP_TX_REQUEST_PDU);
> +                                      vd->ifname);
> +                               ecp_tx_change_state(vd, ECP_TX_REQUEST_PDU);
>                                 return true;
>                         }
>                 }
> -               if (port->ecp.ackReceived && port->ecp.seqECPDU == port->ecp.lastSequence) {
> -                       port->ecp.ackReceived = false;
> -                       ecp_tx_change_state(port, ECP_TX_REQUEST_PDU);
> +               if (vd->ecp.ackReceived && vd->ecp.seqECPDU == vd->ecp.lastSequence) {
> +                       vd->ecp.ackReceived = false;
> +                       ecp_tx_change_state(vd, ECP_TX_REQUEST_PDU);
>                         return true;
>                 }
>                 return false;
>         case ECP_TX_REQUEST_PDU:
> -               if (port->ecp.tx.localChange & VDP_PROFILE_REQ) {
> -                       ecp_tx_change_state(port, ECP_TX_TRANSMIT_ECPDU);
> +               if (vd->ecp.tx.localChange & VDP_PROFILE_REQ) {
> +                       ecp_tx_change_state(vd, ECP_TX_TRANSMIT_ECPDU);
>                         return true;
>                 }
>                 return false;
>         default:
>                 printf("ERROR: The TX State Machine is broken!\n");
> -               log_message(MSG_ERR_TX_SM_INVALID, "%s", port->ifname);
> +               log_message(MSG_ERR_TX_SM_INVALID, "%s", vd->ifname);
>                 return false;
>         }
>  }
> 
>  /* ecp_tx_run_sm - state machine for ecp tx
> - * @port: currently used port
> + * @vd: currently used vdp_data
>   *
>   * no return value
>   *
>   * runs the state machine for ecp tx.
>   */
> -void ecp_tx_run_sm(struct port *port)
> +void ecp_tx_run_sm(struct vdp_data *vd)
>  {
>         do {
>                 printf("%s(%i)-%s: ecp_tx - %s\n", __func__, __LINE__,
> -                      port->ifname, ecp_tx_states[port->ecp.tx.state]);
> +                      vd->ifname, ecp_tx_states[vd->ecp.tx.state]);
> 
> -               switch(port->ecp.tx.state) {
> -               case ECP_TX_IDLE:
> -                       break;
> +               switch(vd->ecp.tx.state) {
>                 case ECP_TX_INIT_TRANSMIT:
> -                       ecp_tx_Initialize(port);
> +                       ecp_tx_Initialize(vd);
>                         break;
>                 case ECP_TX_TRANSMIT_ECPDU:
> -                       ecp_tx_create_frame(port);
> -                       ecp_tx_start_ackTimer(port);
> +                       ecp_tx_create_frame(vd);
> +                       ecp_tx_start_ackTimer(vd);
>                         break;
>                 case ECP_TX_WAIT_FOR_ACK:
> -                       if (port->ecp.ackReceived) {
> +                       if (vd->ecp.ackReceived) {
>                                 printf("%s(%i)-%s: ECP_TX_WAIT_FOR_ACK ackReceived\n", __func__, __LINE__,
> -                                      port->ifname);
> +                                      vd->ifname);
>                                 printf("%s(%i)-%s: 2: seqECPDU %x lastSequence %x \n", __func__, __LINE__,
> -                                      port->ifname, port->ecp.seqECPDU, port->ecp.lastSequence);
> -                               port->ecp.tx.localChange = 0;
> -                               ecp_tx_stop_ackTimer(port);
> -                               ecp_rx_ProcessFrame(port);
> +                                      vd->ifname, vd->ecp.seqECPDU, vd->ecp.lastSequence);
> +                               vd->ecp.tx.localChange = 0;
> +                               ecp_tx_stop_ackTimer(vd);
> +                               ecp_rx_ProcessFrame(vd);
>                         }
>                         break;
>                 case ECP_TX_REQUEST_PDU:
> -                       port->ecp.retries = 0;
> -                       port->ecp.lastSequence++;
> +                       vd->ecp.retries = 0;
> +                       vd->ecp.lastSequence++;
>                         printf("%s(%i)-%s: ECP_TX_REQUEST_PDU lastSequence %x\n", __func__, __LINE__,
> -                              port->ifname, port->ecp.lastSequence++);
> +                              vd->ifname, vd->ecp.lastSequence++);
>                         break;
>                 default:
>                         printf("%s(%i): ERROR The TX State Machine is broken!\n", __func__,
>                                __LINE__);
> -                       log_message(MSG_ERR_TX_SM_INVALID, "%s", port->ifname);
> +                       log_message(MSG_ERR_TX_SM_INVALID, "%s", vd->ifname);
>                 }
> -       } while (ecp_set_tx_state(port) == true);
> +       } while (ecp_set_tx_state(vd) == true);
> 
>         return;
>  }
> diff --git a/include/lldp.h b/include/lldp.h
> index e00ba7a..fd515cd 100644
> --- a/include/lldp.h
> +++ b/include/lldp.h
> @@ -190,6 +190,7 @@ enum {
> 
>  /* IEEE 802.1Qbg subtype */
>  #define LLDP_EVB_SUBTYPE               0
> +#define LLDP_VDP_SUBTYPE               0x2
> 
>  /* forwarding mode */
>  #define LLDP_EVB_CAPABILITY_FORWARD_STANDARD           (1 << 7)
> diff --git a/include/lldp_vdp.h b/include/lldp_vdp.h
> index 43200af..b97d8c0 100644
> --- a/include/lldp_vdp.h
> +++ b/include/lldp_vdp.h
> @@ -27,6 +27,7 @@
>  #define _LLDP_VDP_H
> 
>  #include "lldp_mod.h"
> +#include "ecp/ecp.h"
> 
>  #define LLDP_MOD_VDP           OUI_IEEE_8021Qbg+1
> 
> @@ -101,7 +102,7 @@ struct vsi_profile {
>         int mode;
>         int response;
>         u8 mgrid;
> -       u8 id[3];
> +       int id;
>         u8 version;
>         u8 instance[16];
>         u8 mac[6]; /* TODO: currently only one MAC/VLAN pair supported, more later */
> @@ -116,6 +117,7 @@ struct vsi_profile {
> 
>  struct vdp_data {
>         char ifname[IFNAMSIZ];
> +       struct ecp ecp;
>         struct unpacked_tlv *vdp;
>         int role;
>         LIST_HEAD(profile_head, vsi_profile) profile_head;
> @@ -129,7 +131,7 @@ struct vdp_user_data {
>  struct lldp_module *vdp_register(void);
>  void vdp_unregister(struct lldp_module *mod);
>  struct vdp_data *vdp_data(char *ifname);
> -struct packed_tlv *vdp_gettlv(struct port *port, struct vsi_profile *profile);
> +struct packed_tlv *vdp_gettlv(struct vdp_data *vd, struct vsi_profile *profile);
>  void vdp_vsi_sm_station(struct vsi_profile *profile);
>  struct vsi_profile *vdp_add_profile(struct vsi_profile *profile);
> 
> @@ -142,12 +144,12 @@ struct vsi_profile *vdp_add_profile(struct vsi_profile *profile);
>    c = sprintf(s, "response: %i\n", p->response); s += c; \
>    c = sprintf(s, "state: %i\n", p->state); s += c; \
>    c = sprintf(s, "mgrid: %i\n", p->mgrid); s += c; \
> -  c = sprintf(s, "id: %x%x%x\n", p->id[2], p->id[1], p->id[0]); \
> +  c = sprintf(s, "id: %x\n", p->id); \
>    s += c; \
>    c = sprintf(s, "version: %i\n", p->version); s += c; \
>    char instance[INSTANCE_STRLEN+2]; \
>    instance2str(p->instance, instance, sizeof(instance)); \
> -  c = sprintf(s, "instance: %s\n", &instance); s += c; \
> +  c = sprintf(s, "instance: %s\n", &instance[0]); s += c; \
>    char macbuf[MAC_ADDR_STRLEN+1]; \
>    mac2str(p->mac, macbuf, MAC_ADDR_STRLEN); \
>    c = sprintf(s, "mac: %s\n", macbuf); s += c; \
> diff --git a/lldp/ports.h b/lldp/ports.h
> index c2e18ec..44dc5f1 100644
> --- a/lldp/ports.h
> +++ b/lldp/ports.h
> @@ -136,19 +136,6 @@ struct porttlvs{
>         struct unpacked_tlv *last_peer;
>  };
> 
> -struct ecp {
> -       struct l2_packet_data *l2;
> -       int sequence;
> -       int retries;
> -       int ackReceived;
> -       int ackTimerExpired;
> -       u16 lastSequence;
> -       u16 seqECPDU;
> -       struct portrx rx;
> -       struct porttx tx;
> -       struct portstats stats;
> -};
> -
>  struct port {
>         char *ifname;
>         u8 hw_resetting;
> @@ -169,7 +156,6 @@ struct port {
>         /* not sure */
>         struct porttlvs tlvs;
> 
> -       struct ecp ecp;
>         struct port *next;
>  };
> 
> diff --git a/lldp_vdp.c b/lldp_vdp.c
> new file mode 100644
> index 0000000..7d5936b
> --- /dev/null
> +++ b/lldp_vdp.c
> @@ -0,0 +1,1140 @@
> +/*******************************************************************************
> +
> +  implementation of VDP according to IEEE 802.1Qbg
> +  (c) Copyright IBM Corp. 2010
> +
> +  Author(s): Jens Osterkamp <jens@linux.vnet.ibm.com>
> +
> +  This program is free software; you can redistribute it and/or modify it
> +  under the terms and conditions of the GNU General Public License,
> +  version 2, as published by the Free Software Foundation.
> +
> +  This program is distributed in the hope it will be useful, but WITHOUT
> +  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> +  more details.
> +
> +  You should have received a copy of the GNU General Public License along with
> +  this program; if not, write to the Free Software Foundation, Inc.,
> +  51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
> +
> +  The full GNU General Public License is included in this distribution in
> +  the file called "COPYING".
> +
> +*******************************************************************************/
> +
> +#include <net/if.h>
> +#include <sys/queue.h>
> +#include <sys/socket.h>
> +#include <sys/ioctl.h>
> +#include <sys/utsname.h>
> +#include <linux/if_bridge.h>
> +#include "lldp.h"
> +#include "lldp_vdp.h"
> +#include "ecp/ecp.h"
> +#include "eloop.h"
> +#include "lldp_evb.h"
> +#include "messages.h"
> +#include "config.h"
> +#include "common.h"
> +#include "lldp_vdp_clif.h"
> +#include "lldp_vdp_cmds.h"
> +
> +/* vdp_data - searches vdp_data in the list of modules for this port
> + * @ifname: interface name to search for
> + *
> + * returns vdp_data on success, NULL on error
> + *
> + * searches the list of user_data for the VDP module user_data.
> + */
> +struct vdp_data *vdp_data(char *ifname)
> +{
> +       struct vdp_user_data *ud;
> +       struct vdp_data *vd = NULL;
> +
> +       ud = find_module_user_data_by_if(ifname, &lldp_head, LLDP_MOD_VDP);
> +       if (ud) {
> +               LIST_FOREACH(vd, &ud->head, entry) {
> +                       if (!strncmp(ifname, vd->ifname, IFNAMSIZ))
> +                               return vd;
> +               }
> +       }
> +       return NULL;
> +}
> +
> +/* vdp_free_tlv - free tlv in vdp_data
> + * @vd: vdp_data
> + *
> + * no return value
> + *
> + * frees up tlv in vdp_data. used in vdp_free_data.
> + */
> +static void vdp_free_tlv(struct vdp_data *vd)
> +{
> +       if (vd) {
> +               FREE_UNPKD_TLV(vd, vdp);
> +       }
> +}
> +
> +/* vdp_free_data - frees up vdp data
> + * @ud: user data structure
> + *
> + * no return value
> + *
> + * removes vd_structure from the user_data list. frees up tlv in vdp_data.
> + * used in vdp_unregister.
> + */
> +static void vdp_free_data(struct vdp_user_data *ud)
> +{
> +       struct vdp_data *vd;
> +       if (ud) {
> +               while (!LIST_EMPTY(&ud->head)) {
> +                       vd = LIST_FIRST(&ud->head);
> +                       LIST_REMOVE(vd, entry);
> +                       vdp_free_tlv(vd);
> +                       free(vd);
> +               }
> +       }
> +}
> +
> +/* vdp_print_profile - print a vsi profile
> + * @profile: profile to print
> + *
> + * no return value
> + *
> + * prints the contents of a profile first to a string using the PRINT_PROFILE
> + * macro, and then to the screen. Used for debug purposes.
> + */
> +static inline void vdp_print_profile(struct vsi_profile *profile)
> +{
> +       char *s, *t;
> +
> +       s = t = malloc(VDP_BUF_SIZE);
> +
> +        if (!s) {
> +               printf("%s(%i): unable to allocate string !\n", __func__, __LINE__);
> +        }
> +
> +       PRINT_PROFILE(t, profile);
> +
> +       printf("profile: %s\n", s);
> +
> +       free(s);
> +}
> +
> +/* vdp_somethingChangedLocal - set flag if profile has changed
> + * @profile: profile to set the flag for
> + * @mode: mode to set the flag to
> + *
> + * no return value
> + *
> + * set the localChange flag with a mode to indicate a profile has changed.
> + * used next time when a ecpdu with profiles is sent out.
> + */
> +void vdp_somethingChangedLocal(struct vsi_profile *profile, int mode)
> +{
> +       profile->localChange = mode;
> +}
> +
> +/* vdp_ackTimer_expired - checks for expired ack timer
> + * @profile: profile to be checked
> + *
> + * returns true or false
> + *
> + * returns value of profile->ackTimerExpired, true if ack timer has expired,
> + * false otherwise.
> + */
> +static bool vdp_ackTimer_expired(struct vsi_profile *profile)
> +{
> +       return profile->ackTimerExpired;
> +}
> +
> +/* vdp_timeout_handler - handles the ack timer expiry
> + * @eloop_data: data structure of event loop
> + * @user_ctx: user context, profile here
> + *
> + * no return value
> + *
> + * called when the VDP ack timer has expired. sets a flag and calls the VDP
> + * state machine.
> + */
> +void vdp_timeout_handler(void *eloop_data, void *user_ctx)
> +{
> +       struct vsi_profile *profile;
> +
> +       profile = (struct vsi_profile *) user_ctx;
> +
> +       profile->ackTimerExpired = true;
> +
> +       printf("%s(%i)-%s: timer expired\n", __func__, __LINE__,
> +              profile->port->ifname);
> +
> +       vdp_vsi_sm_station(profile);
> +}
> +
> +/* vdp_stop_ackTimer - stop the VDP ack timer
> + * @profile: profile to process
> + *
> + * returns the number of removed handlers
> + *
> + * stops the VDP ack timer. used when a ack frame for the profile has been
> + * received.
> + */
> +static int vdp_stop_ackTimer(struct vsi_profile *profile)
> +{
> +       printf("%s(%i)-%s: stopping timer\n", __func__, __LINE__,
> +              profile->port->ifname);
> +
> +       return eloop_cancel_timeout(vdp_timeout_handler, NULL, (void *) profile);
> +}
> +
> +/* vdp_start_ackTimer - starts the VDP ack timer
> + * @profile: profile to process
> + *
> + * returns 0 on success, -1 on error
> + *
> + * starts the ack timer when a frame has been sent out.
> + */
> +static int vdp_start_ackTimer(struct vsi_profile *profile)
> +{
> +       unsigned int secs, usecs;
> +
> +       profile->ackTimerExpired = false;
> +
> +       secs = VDP_TRANSMISSION_TIMER / VDP_TRANSMISSION_DIVIDER;
> +       usecs = VDP_TRANSMISSION_TIMER % VDP_TRANSMISSION_DIVIDER;
> +
> +       printf("%s(%i)-%s: starting timer\n", __func__, __LINE__,
> +              profile->port->ifname);
> +
> +       return eloop_register_timeout(secs, usecs, vdp_timeout_handler, NULL, (void *) profile);
> +}
> +
> +/* vdp_vsi_change_station_state - changes the VDP station sm state
> + * @profile: profile to process
> + * @newstate: new state for the sm
> + *
> + * no return value
> + *
> + * actually changes the state of the profile
> + */
> +void vdp_vsi_change_station_state(struct vsi_profile *profile, u8 newstate)
> +{
> +       switch(newstate) {
> +       case VSI_UNASSOCIATED:
> +               break;
> +       case VSI_ASSOC_PROCESSING:
> +               assert((profile->state == VSI_PREASSOCIATED) ||
> +                      (profile->state == VSI_UNASSOCIATED));
> +               break;
> +       case VSI_ASSOCIATED:
> +               assert(profile->state == VSI_ASSOC_PROCESSING);
> +               break;
> +       case VSI_PREASSOC_PROCESSING:
> +               assert(profile->state == VSI_UNASSOCIATED);
> +               break;
> +       case VSI_PREASSOCIATED:
> +               assert(profile->state == VSI_PREASSOC_PROCESSING);
> +               break;
> +       case VSI_DEASSOC_PROCESSING:
> +               assert((profile->state == VSI_PREASSOCIATED) ||
> +                      (profile->state == VSI_ASSOCIATED));
> +               break;
> +       case VSI_EXIT:
> +               assert((profile->state == VSI_ASSOC_PROCESSING) ||
> +                      (profile->state == VSI_PREASSOC_PROCESSING) ||
> +                      (profile->state == VSI_DEASSOC_PROCESSING) ||
> +                      (profile->state == VSI_PREASSOCIATED) ||
> +                      (profile->state == VSI_ASSOCIATED));
> +               break;
> +       default:
> +               printf("ERROR: The VDP station State Machine is broken!\n");
> +               break;
> +       }
> +
> +       printf("%s(%i)-%s: state change %s -> %s\n", __func__, __LINE__,
> +              profile->port->ifname, vsi_states[profile->state], vsi_states[newstate]);
> +
> +       profile->state = newstate;
> +}
> +
> +/* vdp_vsi_set_station_state - sets the vdp sm station state
> + * @profile: profile to process
> + *
> + * returns true or false
> + *
> + * switches the state machine to the next state depending on the input
> + * variables. returns true or false depending on wether the state machine
> + * can be run again with the new state or can stop at the current state.
> + */
> +static bool vdp_vsi_set_station_state(struct vsi_profile *profile)
> +{
> +       switch(profile->state) {
> +       case VSI_UNASSOCIATED:
> +               if ((profile->mode == VDP_MODE_PREASSOCIATE) ||
> +                   (profile->mode == VDP_MODE_PREASSOCIATE_WITH_RR)) {
> +                       vdp_vsi_change_station_state(profile, VSI_PREASSOC_PROCESSING);
> +                       return true;
> +               } else if (profile->mode == VDP_MODE_ASSOCIATE) {
> +                       vdp_vsi_change_station_state(profile, VSI_ASSOC_PROCESSING);
> +                       return true;
> +               }
> +               return false;
> +       case VSI_ASSOC_PROCESSING:
> +               if (profile->ackReceived) {
> +                       vdp_vsi_change_station_state(profile, VSI_ASSOCIATED);
> +                       return true;
> +               } else if (!profile->ackReceived && vdp_ackTimer_expired(profile)) {
> +                       vdp_vsi_change_station_state(profile, VSI_EXIT);
> +                       return true;
> +               }
> +               return false;
> +       case VSI_ASSOCIATED:
> +               if (profile->mode == VDP_MODE_PREASSOCIATE) {
> +                       vdp_vsi_change_station_state(profile, VSI_PREASSOC_PROCESSING);
> +                       return true;
> +               } else if (profile->mode == VDP_MODE_DEASSOCIATE) {
> +                       vdp_vsi_change_station_state(profile, VSI_DEASSOC_PROCESSING);
> +                       return true;
> +               }
> +               return false;
> +       case VSI_PREASSOC_PROCESSING:
> +               if (profile->ackReceived) {
> +                       vdp_vsi_change_station_state(profile, VSI_PREASSOCIATED);
> +                       return true;
> +               } else if (vdp_ackTimer_expired(profile)) {
> +                       vdp_vsi_change_station_state(profile, VSI_EXIT);
> +                       return true;
> +               }
> +       case VSI_PREASSOCIATED:
> +               if (profile->mode == VDP_MODE_DEASSOCIATE) {
> +                       vdp_vsi_change_station_state(profile, VSI_DEASSOC_PROCESSING);
> +                       return true;
> +               }
> +               if (profile->mode == VDP_MODE_ASSOCIATE) {
> +                       vdp_vsi_change_station_state(profile, VSI_ASSOC_PROCESSING);
> +                       return true;
> +               }
> +               return false;
> +       case VSI_DEASSOC_PROCESSING:
> +               if ((profile->ackReceived) || vdp_ackTimer_expired(profile)) {
> +                       vdp_vsi_change_station_state(profile, VSI_EXIT);
> +                       return true;
> +               }
> +               return false;
> +       case VSI_EXIT:
> +               return false;
> +       default:
> +               printf("ERROR: The VSI RX State Machine is broken!\n");
> +               log_message(MSG_ERR_RX_SM_INVALID, "");
> +               return false;
> +       }
> +}
> +
> +/* vdp_vsi_sm_station - state machine for vdp station role
> + * @profile: profile for which the state is processed
> + *
> + * no return value
> + *
> + * runs the state machine for the station role of VDP.
> + */
> +void vdp_vsi_sm_station(struct vsi_profile *profile)
> +{
> +       struct vdp_data *vd = vdp_data(profile->port->ifname);
> +
> +       vdp_vsi_set_station_state(profile);
> +       do {
> +               printf("%s(%i)-%s: station - %s\n", __func__, __LINE__,
> +                      profile->port->ifname, vsi_states[profile->state]);
> +
> +               switch(profile->state) {
> +               case VSI_UNASSOCIATED:
> +                       break;
> +               case VSI_ASSOC_PROCESSING:
> +                       vdp_somethingChangedLocal(profile, VDP_PROFILE_REQ);
> +                       ecp_somethingChangedLocal(vd, VDP_PROFILE_REQ);
> +                       ecp_tx_run_sm(vd);
> +                       vdp_start_ackTimer(profile);
> +                       break;
> +               case VSI_ASSOCIATED:
> +                        vdp_stop_ackTimer(profile);
> +                        /* TODO:
> +                         * vsiError = ProcRxandSetCfg(remoteTLV, localtlv, vsistate);
> +                        *       if (!vsiError) vsistate=ASSOCIATED */
> +                       break;
> +               case VSI_PREASSOC_PROCESSING:
> +                       /* send out profile */
> +                       vdp_somethingChangedLocal(profile, VDP_PROFILE_REQ);
> +                       ecp_somethingChangedLocal(vd, VDP_PROFILE_REQ);
> +                       ecp_tx_run_sm(vd);
> +                       vdp_start_ackTimer(profile);
> +                       break;
> +               case VSI_PREASSOCIATED:
> +                       profile->ackReceived = false;
> +                       vdp_somethingChangedLocal(profile, VDP_PROFILE_NOCHANGE);
> +                       vdp_stop_ackTimer(profile);
> +                       /* TODO  vsiError = ProcRxandSetCfg(remoteTLV, localtlv, vsistate);
> +                        *       if (!vsiError) vsistate=PREASSOCIATED */
> +                       break;
> +               case VSI_DEASSOC_PROCESSING:
> +                       vdp_somethingChangedLocal(profile, VDP_PROFILE_REQ);
> +                       vdp_start_ackTimer(profile);
> +                       break;
> +               case VSI_EXIT:
> +                       /* TODO: something went wrong, remove this profile */
> +                       break;
> +               default:
> +                       printf("ERROR: The VSI RX station State Machine is broken!\n");
> +                       log_message(MSG_ERR_TX_SM_INVALID, "");
> +               }
> +       } while (vdp_vsi_set_station_state(profile) == true);
> +
> +}
> +
> +/* vdp_vsi_change_bridge_state - changes the VDP bridge sm state
> + * @profile: profile to process
> + * @newstate: new state for the sm
> + *
> + * no return value
> + *
> + * actually changes the state of the profile
> + */
> +static void vdp_vsi_change_bridge_state(struct vsi_profile *profile, u8 newstate)
> +{
> +       switch(newstate) {
> +       case VSI_UNASSOCIATED:
> +               break;
> +       case VSI_ASSOC_PROCESSING:
> +               assert((profile->state == VSI_UNASSOCIATED) ||
> +                     (profile->state == VSI_PREASSOCIATED) ||
> +                     (profile->state == VSI_ASSOCIATED));
> +               break;
> +       case VSI_ASSOCIATED:
> +               assert(profile->state == VSI_ASSOC_PROCESSING);
> +               break;
> +       case VSI_PREASSOC_PROCESSING:
> +               assert((profile->state == VSI_UNASSOCIATED) ||
> +                     (profile->state == VSI_PREASSOCIATED) ||
> +                     (profile->state == VSI_ASSOCIATED));
> +               break;
> +       case VSI_PREASSOCIATED:
> +               assert(profile->state == VSI_PREASSOC_PROCESSING);
> +               break;
> +       case VSI_DEASSOC_PROCESSING:
> +               assert((profile->state == VSI_UNASSOCIATED) ||
> +                     (profile->state == VSI_PREASSOCIATED) ||
> +                     (profile->state == VSI_ASSOCIATED));
> +               break;
> +       case VSI_EXIT:
> +               assert((profile->state == VSI_DEASSOC_PROCESSING) ||
> +                     (profile->state == VSI_PREASSOC_PROCESSING) ||
> +                     (profile->state == VSI_ASSOC_PROCESSING));
> +               break;
> +       default:
> +               printf("ERROR: The VDP bridge State Machine is broken!\n");
> +               break;
> +       }
> +       profile->state = newstate;
> +}
> +
> +/* vdp_vsi_set_bridge_state - sets the vdp sm bridge state
> + * @profile: profile to process
> + *
> + * returns true or false
> + *
> + * switches the state machine to the next state depending on the input
> + * variables. returns true or false depending on wether the state machine
> + * can be run again with the new state or can stop at the current state.
> + */
> +static bool vdp_vsi_set_bridge_state(struct vsi_profile *profile)
> +{
> +       switch(profile->state) {
> +       case VSI_UNASSOCIATED:
> +               if ((profile->mode == VDP_MODE_DEASSOCIATE)) /* || (INACTIVE)) */ {
> +                       vdp_vsi_change_bridge_state(profile, VSI_DEASSOC_PROCESSING);
> +                       return true;
> +               } else if (profile->mode == VDP_MODE_ASSOCIATE) {
> +                       vdp_vsi_change_bridge_state(profile, VSI_ASSOC_PROCESSING);
> +                       return true;
> +               } else if (profile->mode == VDP_MODE_PREASSOCIATE) {
> +                       vdp_vsi_change_bridge_state(profile, VSI_PREASSOC_PROCESSING);
> +                       return true;
> +               }
> +               return false;
> +       case VSI_ASSOC_PROCESSING:
> +               /* TODO: handle error case
> +               if (!vsiError) ||
> +                  (vsiError && vsiState == Assoc) {
> +                  */
> +               if (profile->mode == VDP_MODE_ASSOCIATE) {
> +                       vdp_vsi_change_bridge_state(profile, VSI_ASSOCIATED);
> +                       return true;
> +               }
> +               return false;
> +       case VSI_ASSOCIATED:
> +               if (profile->mode == VDP_MODE_ASSOCIATE) /* || ( INACTIVE )*/ {
> +                       vdp_vsi_change_bridge_state(profile, VSI_DEASSOC_PROCESSING);
> +                       return true;
> +               } else if (profile->mode == VDP_MODE_PREASSOCIATE) {
> +                       vdp_vsi_change_bridge_state(profile, VSI_PREASSOC_PROCESSING);
> +                       return true;
> +               }  else if (profile->mode == VDP_MODE_ASSOCIATE) {
> +                       vdp_vsi_change_bridge_state(profile, VSI_ASSOC_PROCESSING);
> +                       return true;
> +               }
> +               return false;
> +       case VSI_PREASSOC_PROCESSING:
> +                if (profile->response != VDP_RESPONSE_SUCCESS) {
> +                       vdp_vsi_change_bridge_state(profile, VSI_EXIT);
> +                       return true;
> +                }
> +               vdp_vsi_change_bridge_state(profile, VSI_PREASSOCIATED);
> +               return false;
> +       case VSI_PREASSOCIATED:
> +               if (profile->mode == VDP_MODE_ASSOCIATE) {
> +                       vdp_vsi_change_bridge_state(profile, VSI_ASSOC_PROCESSING);
> +                       return true;
> +               } else if (profile->mode == VDP_MODE_DEASSOCIATE ) {
> +                       vdp_vsi_change_bridge_state(profile, VSI_DEASSOC_PROCESSING);
> +                       return true;
> +               }  else if (profile->mode == VDP_MODE_PREASSOCIATE ) {
> +                       vdp_vsi_change_bridge_state(profile, VSI_PREASSOC_PROCESSING);
> +                       return true;
> +               }
> +               return false;
> +       case VSI_DEASSOC_PROCESSING:
> +               vdp_vsi_change_bridge_state(profile, VSI_EXIT);
> +               return false;
> +       case VSI_EXIT:
> +               return false;
> +       default:
> +               printf("ERROR: The VSI RX State Machine (bridge) is broken!\n");
> +               log_message(MSG_ERR_RX_SM_INVALID, "");
> +               return false;
> +       }
> +}
> +
> +/* vdp_vsi_sm_bridge - state machine for vdp bridge role
> + * @profile: profile for which the state is processed
> + *
> + * no return value
> + *
> + * runs the state machine for the bridge role of VDP.
> + */
> +static void vdp_vsi_sm_bridge(struct vsi_profile *profile)
> +{
> +       struct vdp_data *vd = vdp_data(profile->port->ifname);
> +
> +       vdp_vsi_set_bridge_state(profile);
> +       do {
> +               printf("%s(%i)-%s: bridge - %s\n", __func__, __LINE__,
> +                      profile->port->ifname, vsi_states[profile->state]);
> +               switch(profile->state) {
> +               case VSI_UNASSOCIATED:
> +                       break;
> +               case VSI_ASSOC_PROCESSING:
> +                       /* TODO: vsiError = ProcRxandSetCfg(remoteTLV, localtlv, vsistate);
> +                        *       if (vsiError)
> +                        *              txTLV(Assoc NACK)
> +                        *       else
> +                        *              txTLV(Assoc ACK) */
			   */

move the */ to a line on its own.

> +                       break;
> +               case VSI_ASSOCIATED:
> +                       break;
> +               case VSI_PREASSOC_PROCESSING:
> +                       /* TODO: vsiError = ProcRxandSetCfg(remoteTLV, localtlv, vsistate);
> +                        *       if (vsiError)
> +                        *              txTLV(PreAssoc NACK)
> +                        *       else
> +                        *              txTLV(PreAssoc ACK) */

same here.

> +                       /* for now, we always succeed */
> +                       profile->response = VDP_RESPONSE_SUCCESS;
> +                       printf("%s(%i)-%s: framein %p, sizein %i\n", __func__, __LINE__,
> +                              profile->port->ifname, vd->ecp.rx.framein,
> +                              vd->ecp.rx.sizein);
> +                       ecp_rx_send_ack_frame(profile->port);
> +                       break;
> +               case VSI_PREASSOCIATED:
> +                       printf("%s(%i)-%s: \n", __func__, __LINE__, profile->port->ifname);
> +                       break;
> +               case VSI_DEASSOC_PROCESSING:
> +                       /* TODO: txTLV(DeAssoc ACK) */
> +                       break;
> +               case VSI_EXIT:
> +                       /* TODO: something went wrong, remove this profile */
> +                       break;
> +               default:
> +                       printf("ERROR: The VSI RX bridge State Machine is broken!\n");
> +                       log_message(MSG_ERR_TX_SM_INVALID, "");
> +               }
> +       } while (vdp_vsi_set_bridge_state(profile) == true);
> +
> +}
> +
> +/*
> + * vdp_print_vsi_tlv - print the raw contents of a VSI TLV
> + * @tlv: the unpacked tlv which gets printed
> + *
> + * No return value
> + *
> + * used for protocol debug purposes
> + */
> +static void vdp_print_vsi_tlv(struct unpacked_tlv *tlv)
> +{
> +       int i;
> +
> +       printf("### %s:type %i, length %i, info:\n", __func__, tlv->type, tlv->length);
> +
> +       for (i=0; i < tlv->length; i++) {
> +               printf("%02x ", tlv->info[i]);
> +               if (!((i+1) % 16))
> +                       printf("\n");
> +       }
> +
> +       printf("\n");
> +}
> +
> +/*
> + * vdp_validate_tlv - validates vsi tlvs
> + * @vdp: decoded vsi tlv
> + *
> + * Returns 0 on success, 1 on error
> + *
> + * checks the contents of an already decoded vsi tlv for inconsistencies
> + */
> +static int vdp_validate_tlv(struct tlv_info_vdp *vdp)
> +{
> +       if (ntoh24(vdp->oui) != OUI_IEEE_8021Qbg) {
> +               printf("vdp->oui %06x \n", ntoh24(vdp->oui));
> +               goto out_err;
> +       }
> +
> +       if (vdp->sub != LLDP_VDP_SUBTYPE) {
> +               printf("vdp->sub %02x \n", vdp->sub);
> +               goto out_err;
> +       }
> +
> +       if ((vdp->mode < VDP_MODE_PREASSOCIATE) ||
> +               (vdp->mode > VDP_MODE_DEASSOCIATE)) {
> +               printf("Unknown mode %02x in vsi tlv !\n", vdp->mode);
> +               goto out_err;
> +       }
> +
> +       if ((vdp->response < VDP_RESPONSE_SUCCESS) ||
> +               (vdp->response > VDP_RESPONSE_OUT_OF_SYNC)) {
> +               printf("Unknown response %02x \n", vdp->response);
> +               goto out_err;
> +       }
> +
> +       if (vdp->format != VDP_MACVLAN_FORMAT_1) {
> +               printf("Unknown format %02x in vsi tlv !\n", vdp->format);
> +               goto out_err;
> +       }
> +
> +       if (ntohs(vdp->entries) != 1) {
> +               printf("Multiple entries %02x in vsi tlv !\n", vdp->entries);
> +               goto out_err;
> +       }
> +
> +       return 0;
> +
> +out_err:
> +       return 1;
> +}
> +
> +/*
> + * vdp_indicate - receive VSI TLVs from ECP
> + * @port: the port on which the tlv was received
> + * @tlv: the unpacked tlv to receive
> + * @ecp_mode: the mode under which the tlv was received (ACK or REQ)
> + *
> + * Returns 0 on success
> + *
> + * receives a vsi tlv and creates a profile. Take appropriate action
> + * depending on the role of the (receive) port
> + */
> +int vdp_indicate(struct vdp_data *vd, struct unpacked_tlv *tlv, int ecp_mode)
> +{
> +       struct tlv_info_vdp *vdp;
> +       struct vsi_profile *p, *profile;
> +       struct port *port = port_find_by_name(vd->ifname);
> +
> +       printf("%s(%i): indicating vdp for for %s !\n", __func__, __LINE__, vd->ifname);
> +
> +       if (!port) {
> +               printf("%s(%i): port not found for %s !\n", __func__, __LINE__, vd->ifname);
> +               goto out_err;
> +       }
> +
> +       vdp = malloc(sizeof(struct tlv_info_vdp));
> +
> +       if (!vdp) {
> +               printf("%s(%i): unable to allocate vdp !\n", __func__, __LINE__);
> +               goto out_err;
> +       }
> +
> +       memset(vdp, 0, sizeof(struct tlv_info_vdp));
> +       memcpy(vdp, tlv->info, tlv->length);
> +
> +       if (vdp_validate_tlv(vdp)) {
> +               printf("%s(%i): Invalid TLV received !\n", __func__, __LINE__);
> +               goto out_err;
> +       }
> +
> +       profile = malloc(sizeof(struct vsi_profile));
> +
> +        if (!profile) {
> +               printf("%s(%i): unable to allocate profile !\n", __func__, __LINE__);
> +               goto out_vdp;
> +        }
> +
> +       memset(profile, 0, sizeof(struct vsi_profile));
> +
> +       profile->mode = vdp->mode;
> +       profile->response = vdp->response;
> +
> +       profile->mgrid = vdp->mgrid;
> +       profile->id = ntoh24(vdp->id);
> +       profile->version = vdp->version;
> +       memcpy(&profile->instance, &vdp->instance, 16);
> +       memcpy(&profile->mac, &vdp->mac_vlan.mac, MAC_ADDR_LEN);
> +       profile->vlan = ntohs(vdp->mac_vlan.vlan);
> +
> +       profile->port = port;
> +       printf("%s(%i):\n", __func__, __LINE__);
> +
> +       if (vd->role == VDP_ROLE_STATION) {
> +               /* do we have the profile already ? */
> +               LIST_FOREACH(p, &vd->profile_head, profile) {
> +                       if (vdp_profile_equal(p, profile)) {
> +                               printf("%s(%i): station: profile found, localChange %i ackReceived %i!\n",
> +                                      __func__, __LINE__, p->localChange, p->ackReceived);
> +
> +                               if (ecp_mode == ECP_ACK)
> +                                       p->ackReceived = true;
> +
> +                               vdp_vsi_sm_station(p);
> +                       } else {
> +                               printf("%s(%i): station: profile not found !\n", __func__, __LINE__);
> +                               /* ignore profile */
> +                       }
> +               }
> +       }
> +
> +       if (vd->role == VDP_ROLE_BRIDGE) {
> +               /* do we have the profile already ? */
> +               LIST_FOREACH(p, &vd->profile_head, profile) {
> +                       if (vdp_profile_equal(p, profile)) {
> +                               break;
> +                       }
> +               }
> +
> +               if (p) {
> +                       printf("%s(%i): bridge: profile found !\n", __func__, __LINE__);
> +               } else {
> +                       printf("%s(%i): bridge: profile not found !\n", __func__, __LINE__);
> +                       /* put it in the list  */
> +                       profile->state = VSI_UNASSOCIATED;
> +                       LIST_INSERT_HEAD(&vd->profile_head, profile, profile );
> +               }
> +
> +               vdp_vsi_sm_bridge(profile);
> +       }
> +
> +       return 0;
> +
> +out_vdp:
> +       free(vdp);
> +out_err:
> +       printf("%s(%i): error !\n", __func__, __LINE__);
> +       return 1;
> +
> +}
> +
> +/*
> + * vdp_bld_vsi_tlv - build the VDP VSI TLV
> + * @vd: vdp_data structure for this port
> + * @profile: profile the vsi tlv is created from
> + *
> + * Returns 0 on success, ENOMEM otherwise
> + *
> + * creates a vdp structure from an existing profile
> + */
> +static int vdp_bld_vsi_tlv(struct vdp_data *vd, struct vsi_profile *profile)
> +{
> +       int rc = 0;
> +       struct unpacked_tlv *tlv = NULL;
> +       struct tlv_info_vdp vdp;
> +
> +       FREE_UNPKD_TLV(vd, vdp);
> +
> +       memset(&vdp, 0, sizeof(vdp));
> +
> +       hton24(vdp.oui, OUI_IEEE_8021Qbg);
> +       vdp.sub = LLDP_VDP_SUBTYPE;
> +       vdp.mode = profile->mode;
> +       vdp.response = 0;
> +       vdp.mgrid = profile->mgrid;
> +       hton24(vdp.id, profile->id);
> +       vdp.version = profile->version;
> +       memcpy(&vdp.instance,&profile->instance, 16);
> +       vdp.format = VDP_MACVLAN_FORMAT_1;
> +       vdp.entries = htons(1);
> +       memcpy(&vdp.mac_vlan.mac,&profile->mac, MAC_ADDR_LEN);
> +       vdp.mac_vlan.vlan = htons(profile->vlan);
> +
> +       tlv = create_tlv();
> +       if (!tlv)
> +               goto out_err;
> +
> +       tlv->type = ORG_SPECIFIC_TLV;
> +       tlv->length = sizeof(vdp);
> +       tlv->info = (u8 *)malloc(tlv->length);
> +       if(!tlv->info) {
> +               free(tlv);
> +               tlv = NULL;
> +               rc = ENOMEM;
> +               goto out_err;
> +       }
> +       memcpy(tlv->info, &vdp, tlv->length);
> +
> +       vd->vdp = tlv;
> +
> +out_err:
> +       return rc;
> +}
> +
> +/* vdp_bld_tlv - builds a tlv from a profile
> + * @vd: vdp_data structure for this port
> + * @profile: profile the vsi tlv is created from
> + *
> + * returns 0 on success, != 0 on error
> + *
> + * wrapper function around vdp_bld_vsi_tlv. adds some checks and calls
> + * vdp_bld_vsi_tlv.
> +*/
> +
> +static int vdp_bld_tlv(struct vdp_data *vd, struct vsi_profile *profile)
> +{
> +       int rc = 0;
> +
> +       if (!port_find_by_name(vd->ifname)) {
> +               rc = EEXIST;
> +               goto out_err;
> +       }
> +
> +       if (!init_cfg()) {
> +               rc = ENOENT;
> +               goto out_err;
> +       }
> +
> +       if (vdp_bld_vsi_tlv(vd, profile)) {
> +               fprintf(stderr, "### %s:%s:vdp_bld_cfg_tlv() failed\n",

should be "vdp_bld_vsi_tlv failed".

> +                               __func__, vd->ifname);
> +               rc = EINVAL;
> +               goto out_err_destroy;
> +       }
> +
> +out_err_destroy:
> +       destroy_cfg();
> +
> +out_err:
> +       return rc;
> +}
> +
> +/* vdp_gettlv - get the tlv for a profile
> + * @port: the port on which the tlv was received
> + * @profile: profile the vsi tlv is created from
> + *
> + * returns 0 on success
> + *
> + * this is the interface function called from ecp_build_ECPDU. It returns the
> + * packed tlv for a profile.
> + */
> +struct packed_tlv *vdp_gettlv(struct vdp_data *vd, struct vsi_profile *profile)
> +{
> +       int size;
> +       struct packed_tlv *ptlv = NULL;
> +
> +       /* frees the unpacked_tlv in vdp_data
> +        * also done in vdp_bld_vsi_tlv */
> +       vdp_free_tlv(vd);
> +
> +       if (vdp_bld_tlv(vd, profile)) {
> +               fprintf(stderr, "### %s:%s vdp_bld_tlv failed\n",
> +                       __func__, vd->ifname);
> +               goto out_err;
> +       }
> +
> +       size = TLVSIZE(vd->vdp);
> +
> +       if (!size) {
> +               printf("%s(%i): size %i of unpacked_tlv not correct !\n", __func__, __LINE__,
> +                      size);
> +               goto out_err;
> +       }
> +
> +       ptlv = create_ptlv();
> +       if (!ptlv)
> +               goto out_err;
> +
> +       ptlv->tlv = malloc(size);
> +       if (!ptlv->tlv)
> +               goto out_free;
> +
> +       ptlv->size = 0;
> +       PACK_TLV_AFTER(vd->vdp, ptlv, size, out_free);
> +
> +       return ptlv;
> +
> +out_free:
> +       ptlv = free_pkd_tlv(ptlv);
> +out_err:
> +       fprintf(stderr,"### %s:%s: failed\n", __func__, vd->ifname);
> +       return NULL;
> +}
> +
> +/* vdp_profile_equal - checks for equality of 2 profiles
> + * @p1: profile 1
> + * @p2: profile 2
> + *
> + * returns 1 on success, 0 on error
> + *
> + * compares mgrid, id, version, instance, mac and vlan of 2 profiles to find
> + * out if they are equal.
> + */
> +int vdp_profile_equal(struct vsi_profile *p1, struct vsi_profile *p2)
> +{
> +       if (p1->mgrid != p2->mgrid)
> +               return 0;
> +
> +       if (p1->id == p2->id)
> +               return 0;
> +
> +       if (p1->version != p2->version)
> +               return 0;
> +
> +       if (memcmp(p1->instance, p2->instance, 16))
> +               return 0;
> +
> +       if (memcmp(p1->mac, p2->mac, MAC_ADDR_LEN))
> +               return 0;
> +
> +       if (p1->vlan != p2->vlan)
> +               return 0;
> +
> +       return 1;
> +}
> +
> +/* vdp_add_profile - adds a profile to a per port list
> + * @profile: profile to add
> + *
> + * returns the profile that has been found or added
> + *
> + * main interface function which adds a profile to a list kept on a per-port
> + * basis. Checks if the profile is already in the list, adds it if necessary.
> + */
> +struct vsi_profile *vdp_add_profile(struct vsi_profile *profile)
> +{
> +       struct vsi_profile *p;
> +       struct vdp_data *vd;
> +
> +       printf("%s(%i): adding vdp profile for %s !\n", __func__, __LINE__,
> +              profile->port->ifname);
> +
> +       vd = vdp_data(profile->port->ifname);
> +       if (!vd) {
> +               printf("%s(%i): Could not find vdp_data for %s !\n", __func__, __LINE__,
> +                      profile->port->ifname);
> +               return NULL;
> +       }
> +
> +       vdp_print_profile(profile);
> +
> +       /* loop over all existing profiles and check wether
> +        * one for this combination already exists. If yes, check,
> +        * if the MAC/VLAN pair already exists. If not, add it.
> +        * Note: currently only one MAC/VLAN pair supported ! */
> +       LIST_FOREACH(p, &vd->profile_head, profile) {
> +               if (p) {
> +                       vdp_print_profile(p);

This is a lot of debug output.

> +                       if (vdp_profile_equal(p, profile)) {
> +                               if (p->mode == profile->mode) {
> +                                       printf("%s(%i): profile already exists, ignoring !\n",
> +                                              __func__, __LINE__);
> +                                       return NULL;

comment at top of function "return the profile that has been found or added" seems to indicate this should return the profile not NULL. I suspect a fix to the comment should suffice.

> +                               } else {
> +                                       printf("%s(%i): taking new mode !\n", __func__,
> +                                              __LINE__);
> +                                       p->mode = profile->mode;
> +                                       return p;
> +                               }
> +                       }
> +               }
> +       }
> +
> +       LIST_INSERT_HEAD(&vd->profile_head, profile, profile );
> +
> +       return profile;
> +}
> +
> +/* vdp_ifdown - tear down vdp structures for a interface
> + * @ifname: name of the interface
> + *
> + * no return value
> + *
> + * interface function to lldpad. tears down vdp specific structures if
> + * interface "ifname" goes down.
> + */
> +void vdp_ifdown(char *ifname)
> +{
> +       struct vdp_data *vd;
> +       struct vsi_profile *p;
> +
> +       vd = vdp_data(ifname);
> +       if (!vd)
> +               goto out_err;
> +
> +       LIST_REMOVE(vd, entry);
> +
> +       LIST_FOREACH(p, &vd->profile_head, profile) {
> +               free(p);
> +               LIST_REMOVE(p, profile);

This is should be

LIST_REMOVE(p, profile);
free(p);

not the other way around.

> +       }
> +       vdp_free_tlv(vd);
> +       free(vd);
> +       fprintf(stderr, "### %s:port %s removed\n", __func__, ifname);
> +       return;
> +out_err:
> +       fprintf(stderr, "### %s:port %s adding failed\n", __func__, ifname);

this is not adding a port and nothing failed the ifname has not been added.

> +
> +       return;
> +}
> +
> +/* vdp_ifup - build up vdp structures for a interface
> + * @ifname: name of the interface
> + *
> + * no return value
> + *
> + * interface function to lldpad. builds up vdp specific structures if
> + * interface "ifname" goes down.
> + */
> +void vdp_ifup(char *ifname)
> +{
> +       char *p;
> +       struct vdp_data *vd;
> +       struct vdp_user_data *ud;
> +
> +       printf("%s(%i): starting VDP for if %s !\n", __func__, __LINE__, ifname);
> +
> +       vd = vdp_data(ifname);
> +       if (vd) {
> +               fprintf(stderr, "%s:%s already exists\n", __func__, ifname);
> +               goto out_err;

This prints the error in out_err incorrectly.

> +       }
> +
> +       /* not found, alloc/init per-port module data */
> +       vd = (struct vdp_data *) calloc(1, sizeof(struct vdp_data));

Use malloc instead of calloc() of one.

> +       if (!vd) {
> +               fprintf(stderr, "### %s:%s malloc %ld failed\n",
> +                        __func__, ifname, sizeof(*vd));
> +               goto out_err;
> +       }
> +       strncpy(vd->ifname, ifname, IFNAMSIZ);
> +
> +       if (!init_cfg())
> +               goto out_err;

memory leak of 'vd' if init_cfg fails.

> +
> +       vd->role = VDP_ROLE_STATION;
> +
> +       if (!get_cfg(ifname, "vdp.role", (void *)&p,
> +                   CONFIG_TYPE_STRING)) {
> +               if (!strcasecmp(p, VAL_BRIDGE)) {
> +                       vd->role = VDP_ROLE_BRIDGE;
> +               }
> +       }
> +
> +       printf("%s: configured for %s mode !\n", ifname,
> +              (vd->role ==VDP_ROLE_BRIDGE) ? "bridge" : "station");
> +
> +       LIST_INIT(&vd->profile_head);
> +
> +       ud = find_module_user_data_by_if(ifname, &lldp_head, LLDP_MOD_VDP);
> +       LIST_INSERT_HEAD(&ud->head, vd, entry);
> +
> +       ecp_init(ifname);
> +
> +       fprintf(stderr, "### %s:port %s added\n", __func__, ifname);
> +       return;
> +
> +out_err:
> +       fprintf(stderr, "### %s:port %s adding failed\n", __func__, ifname);
> +       return;
> +}
> +
> +static const struct lldp_mod_ops vdp_ops =  {
> +       .lldp_mod_register      = vdp_register,
> +       .lldp_mod_unregister    = vdp_unregister,
> +       .lldp_mod_ifup          = vdp_ifup,
> +       .lldp_mod_ifdown        = vdp_ifdown,
> +       .get_arg_handler        = vdp_get_arg_handlers,
> +};
> +
> +/* vdp_register - register vdp module to lldpad
> + * @none
> + *
> + * returns lldp_module struct on success, NULL on error
> + *
> + * allocates a module structure with vdp module information and returns it
> + * to lldpad.
> + */
> +struct lldp_module *vdp_register(void)
> +{
> +       struct lldp_module *mod;
> +       struct vdp_user_data *ud;
> +
> +       mod = malloc(sizeof(*mod));
> +       if (!mod) {
> +               fprintf(stderr, "failed to malloc module data\n");
> +               log_message(MSG_ERR_SERVICE_START_FAILURE,
> +                       "%s", "failed to malloc module data");
> +               goto out_err;
> +       }
> +       ud = malloc(sizeof(struct vdp_user_data));
> +       if (!ud) {
> +               free(mod);
> +               fprintf(stderr, "failed to malloc module user data\n");
> +               log_message(MSG_ERR_SERVICE_START_FAILURE,
> +                       "%s", "failed to malloc module user data");
> +               goto out_err;
> +       }
> +       LIST_INIT(&ud->head);
> +       mod->id = LLDP_MOD_VDP;
> +       mod->ops = &vdp_ops;
> +       mod->data = ud;
> +       fprintf(stderr, "### %s:done\n", __func__);
> +       return mod;
> +
> +out_err:
> +       fprintf(stderr, "### %s:failed\n", __func__);
> +       return NULL;
> +}
> +
> +/* vdp_unregister - unregister vdp module from lldpad
> + * @none
> + *
> + * no return value
> + *
> + * frees vdp module structure.
> + */
> +void vdp_unregister(struct lldp_module *mod)
> +{
> +       if (mod->data) {
> +               vdp_free_data((struct vdp_user_data *) mod->data);
> +               free(mod->data);
> +       }
> +       free(mod);
> +       fprintf(stderr, "### %s:done\n", __func__);
> +}
> +
> +
> diff --git a/lldpad.c b/lldpad.c
> index 571da31..c0938af 100644
> --- a/lldpad.c
> +++ b/lldpad.c
> @@ -50,6 +50,7 @@
>  #include "lldp_med.h"
>  #include "lldp_8023.h"
>  #include "lldp_evb.h"
> +#include "lldp_vdp.h"
>  #include "config.h"
>  #include "lldpad_shm.h"
>  #include "clif.h"
> @@ -65,6 +66,7 @@ struct lldp_module *(*register_tlv_table[])(void) = {
>         med_register,
>         ieee8023_register,
>         evb_register,
> +       vdp_register,
>         NULL,
>  };
> 
> --


Few minor nits otherwise looks good. Please merge relevant parts with patch 4 though.

Thanks!
John
