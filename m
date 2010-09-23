From: John Fastabend <john.r.fastabend@intel.com>
Subject: Re: [E1000-eedc] [PATCH 04/10] ECP implementation
Date: Wed, 22 Sep 2010 17:50:53 -0700
Message-ID: <4C9AA46D.2040802@intel.com>
References: <1282739262-14968-1-git-send-email-jens@linux.vnet.ibm.com>
	<1282739262-14968-5-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1282739262-14968-5-git-send-email-jens@linux.vnet.ibm.com>
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
> This is the implementation of the edge control protocol (ECP) as specified
> in IEEE 802.1Qbg.
> 
> For this it extends the infrastructure defined lldpad to send and receive
> ECP frames with a new (yet to be defined) ethertype.
> Received frames are validated and analyzed before the content is handed to the
> upper layer protocol (ULP, VDP in this case) for further processing. Frames
> to be transmitted are compiled from VSI (guest interface) profiles registered
> on a interface.
> Reception and transmission of ECP frames is controlled by RX and TX state
> machines, timeouts are handled timeout functions.
> The patch still contains a lot of debug code to allow low-level protocol
> analysis.
> 
> Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>

I am hesitant to apply these without a defined ethertype. Presumably this will come out of the IEEE DCB task group.

> ---
>  Makefile.am        |    2 +
>  ecp/ecp.c          |   77 +++++++
>  ecp/ecp.h          |   92 ++++++++
>  ecp/ecp_rx.c       |  597 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  ecp/ecp_tx.c       |  467 ++++++++++++++++++++++++++++++++++++++++
>  include/lldp_evb.h |    6 +
>  include/lldp_vdp.h |  157 ++++++++++++++
>  lldp/l2_packet.h   |    2 +
>  lldp/ports.h       |   25 ++-
>  9 files changed, 1422 insertions(+), 3 deletions(-)
>  create mode 100644 ecp/ecp.c
>  create mode 100644 ecp/ecp.h
>  create mode 100644 ecp/ecp_rx.c
>  create mode 100644 ecp/ecp_tx.c
>  create mode 100644 include/lldp_vdp.h
> 
> diff --git a/Makefile.am b/Makefile.am
> index d59a6fa..061f2ee 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -56,6 +56,8 @@ $(lldpad_include_HEADERS) $(noinst_HEADERS) \
>  lldp/ports.c lldp/agent.c lldp/l2_packet_linux.c lldp/tx.c \
>  lldp/rx.c lldp/agent.h lldp/l2_packet.h lldp/mibdata.h lldp/ports.h \
>  lldp/states.h \
> +ecp/ecp.c ecp/ecp_tx.c \
> +ecp/ecp_rx.c \
>  include/lldp.h include/lldp_mod.h \
>  lldp_dcbx.c include/lldp_dcbx.h tlv_dcbx.c include/tlv_dcbx.h \
>  lldp_dcbx_cfg.c include/lldp_dcbx_cfg.h \
> diff --git a/ecp/ecp.c b/ecp/ecp.c
> new file mode 100644
> index 0000000..ecf68f9
> --- /dev/null
> +++ b/ecp/ecp.c
> @@ -0,0 +1,77 @@

snip snip

> +}
> +
> +/* ecp_rx_validate_frame - wrapper around ecp_rx_validateFrame
> + * @port: currently used port
> + *
> + * no return value
> + *
> + * sets rcvFrame to false and validates frame. used in ECP_RX_RECEIVE_ECPDU
> + * state of ecp_rx_run_sm
> + */
> +void ecp_rx_validate_frame(struct port *port)
> +{
> +       port->ecp.rx.rcvFrame = false;
> +       ecp_rx_validateFrame(port);
> +       return;
> +}
> +
> +/* ecp_rx_ProcessFrame - process received ecp frames
> + * @port: currently used port
> + *
> + * no return value
> + *
> + * walks through the packed vsi tlvs in an ecp frame, extracts them
> + * and passes them to the VDP ULP with vdp_indicate.
> + */
> +void ecp_rx_ProcessFrame(struct port * port)
> +{
> +       u16 tlv_cnt = 0;
> +       u8  tlv_type = 0;
> +       u16 tlv_length = 0;
> +       u16 tlv_offset = 0;
> +       u16 *tlv_head_ptr = NULL;
> +       u8  frame_error = 0;
> +       bool tlv_stored     = false;
> +       int err;
> +       struct lldp_module *np;
> +       struct ecp_hdr *ecp_hdr;
> +
> +       printf("%s(%i)-%s: processing frame \n", __func__, __LINE__, port->ifname);
> +
> +       assert(port->ecp.rx.framein && port->ecp.rx.sizein);
> +
> +       tlv_offset = sizeof(struct l2_ethhdr);
> +
> +       ecp_print_framein(port);
> +
> +       ecp_hdr = (struct ecp_hdr *)&port->ecp.rx.framein[tlv_offset];
> +
> +       printf("%s(%i)-%s: ecp packet with subtype %04x, mode %02x, sequence nr %04x\n",
> +              __func__, __LINE__, port->ifname, ecp_hdr->subtype, ecp_hdr->mode, ecp_hdr->seqnr);
> +
> +       /* FIXME: already done in ecp_rx_validateFrame ? */
> +       if (ecp_hdr->subtype != ECP_SUBTYPE) {
> +               printf("ERROR: unknown subtype !\n");
> +               frame_error++;
> +               goto out;
> +       }

Agreed looks like above can be removed.

> +
> +       /* processing of VSI_TLVs starts here */
> +
> +       tlv_offset += sizeof(struct ecp_hdr);
> +
> +       do {
> +               tlv_cnt++;
> +               if (tlv_offset > port->ecp.rx.sizein) {
> +                       printf("%s(%i)-%s: ERROR: Frame overrun! tlv_offset %i, sizein %i cnt %i\n",
> +                              __func__, __LINE__, port->ifname, tlv_offset, port->ecp.rx.sizein, tlv_cnt);
> +                       frame_error++;
> +                       goto out;
> +               }
> +
> +               tlv_head_ptr = (u16 *)&port->ecp.rx.framein[tlv_offset];
> +               tlv_length = htons(*tlv_head_ptr) & 0x01FF;
> +               tlv_type = (u8)(htons(*tlv_head_ptr) >> 9);
> +
> +               u16 tmp_offset = tlv_offset + tlv_length;
> +               if (tmp_offset > port->ecp.rx.sizein) {
> +                       printf("ERROR: Frame overflow error: offset=%d, "
> +                               "rx.size=%d \n", tmp_offset, port->ecp.rx.sizein);
> +                       frame_error++;
> +                       goto out;
> +               }
> +
> +               u8 *info = (u8 *)&port->ecp.rx.framein[tlv_offset +
> +                                       sizeof(*tlv_head_ptr)];
> +
> +               struct unpacked_tlv *tlv = create_tlv();
> +
> +               if (!tlv) {
> +                       printf("ERROR: Failed to malloc space for "
> +                               "incoming TLV. \n");
> +                       goto out;
> +               }
> +
> +               if ((tlv_length == 0) && (tlv->type != TYPE_0)) {
> +                               printf("ERROR: tlv_length == 0\n");
> +                               free_unpkd_tlv(tlv);
> +                               goto out;
> +               }
> +
> +               tlv->type = tlv_type;
> +               tlv->length = tlv_length;
> +               tlv->info = (u8 *)malloc(tlv_length);
> +               if (tlv->info) {
> +                       memset(tlv->info,0, tlv_length);
> +                       memcpy(tlv->info, info, tlv_length);
> +               } else {
> +                       printf("ERROR: Failed to malloc space for incoming "
> +                               "TLV info \n");
> +                       free_unpkd_tlv(tlv);
> +                       goto out;
> +               }
> +
> +               /* Validate the TLV */
> +               tlv_offset += sizeof(*tlv_head_ptr) + tlv_length;
> +
> +               if (tlv->type == TYPE_127) { /* private TLV */
> +                       /* TODO: give VSI TLV to VDP */
> +               }
> +
> +               if ((tlv->type != TYPE_0) && !tlv_stored) {
> +                       printf("\n%s: allocated TLV (%lu) "
> +                                  " was not stored! (%p)\n", __func__, tlv->type,
> +                                  tlv);
> +                       tlv = free_unpkd_tlv(tlv);
> +                       port->ecp.stats.statsTLVsUnrecognizedTotal++;
> +               }
> +
> +               tlv = NULL;
> +               tlv_stored = false;
> +       } while(tlv_type != 0);
> +
> +out:
> +       if (frame_error) {
> +               port->ecp.stats.statsFramesDiscardedTotal++;
> +               port->ecp.stats.statsFramesInErrorsTotal++;
> +               port->ecp.rx.badFrame = true;
> +       }
> +
> +       return;
> +}
> +

snip

> +
> +/* ecp_build_ECPDU - create an ecp protocol data unit
> + * @port: currently used port
> + * @mode: mode to create pdu with (REQ or ACK)
> + *
> + * returns true on success, false on failure
> + *
> + * creates the frame header with the ports mac address, the ecp header with REQ
> + * or ACK mode, plus a list of packed TLVs created from the profiles on this
> + * port.
> + */
> +bool ecp_build_ECPDU(struct port *port, int mode)
> +{
> +       struct l2_ethhdr eth;
> +       struct ecp_hdr ecp_hdr;
> +       u8  own_addr[ETH_ALEN];
> +       u32 fb_offset = 0;
> +       u32 datasize = 0;
> +       struct packed_tlv *ptlv =  NULL;
> +       struct lldp_module *np;
> +       struct vdp_data *vd;
> +       struct vsi_profile *p;
> +
> +       if (port->ecp.tx.frameout) {
> +               free(port->ecp.tx.frameout);
> +               port->ecp.tx.frameout = NULL;
> +       }
> +
> +       /* TODO: different multicast address for sending ECP over S-channel (multi_cast_source_s)
> +        * S-channels to implement later */
> +       memcpy(eth.h_dest, multi_cast_source, ETH_ALEN);
> +       l2_packet_get_own_src_addr(port->ecp.l2,(u8 *)&own_addr);
> +       memcpy(eth.h_source, &own_addr, ETH_ALEN);
> +       eth.h_proto = htons(ETH_P_ECP);
> +       port->ecp.tx.frameout = (u8 *)malloc(ETH_FRAME_LEN);
> +       if (port->ecp.tx.frameout == NULL) {
> +               printf("InfoECPDU: Failed to malloc frame buffer \n");
> +               return false;
> +       }
> +       memset(port->ecp.tx.frameout,0,ETH_FRAME_LEN);
> +       memcpy(port->ecp.tx.frameout, (void *)&eth, sizeof(struct l2_ethhdr));
> +       fb_offset += sizeof(struct l2_ethhdr);
> +
> +       ecp_hdr.oui[0] = 0x0;
> +       ecp_hdr.oui[1] = 0x1b;
> +       ecp_hdr.oui[2] = 0x3f;
> +
> +       ecp_hdr.pad1 = 0x0;
> +
> +       ecp_hdr.subtype = ECP_SUBTYPE;
> +       switch(mode) {
> +       case VDP_PROFILE_REQ:
> +               ecp_hdr.mode = ECP_REQUEST;
> +               break;
> +       case VDP_PROFILE_ACK:
> +               ecp_hdr.mode = ECP_ACK;
> +               break;
> +       default:
> +               printf("%s(%i): unknown mode for %s !\n", __func__, __LINE__,
> +                      port->ifname);
> +       }
> +
> +       ecp_hdr.seqnr = port->ecp.lastSequence;
> +
> +       if ((sizeof(struct ecp_hdr)+fb_offset) > ETH_MAX_DATA_LEN)
> +                               goto error;
> +       memcpy(port->ecp.tx.frameout+fb_offset, (void *)&ecp_hdr, sizeof(struct ecp_hdr));
> +       datasize += sizeof(struct ecp_hdr);
> +       fb_offset += sizeof(struct ecp_hdr);
> +
> +       /* TODO: create tlvs from profiles here */
> +
> +       /* The End TLV marks the end of the LLDP PDU */
> +       ptlv = pack_end_tlv();
> +       if (!ptlv || ((ptlv->size + fb_offset) > ETH_MAX_DATA_LEN))
> +               goto error;
> +       memcpy(port->ecp.tx.frameout + fb_offset, ptlv->tlv, ptlv->size);
> +       datasize += ptlv->size;
> +       fb_offset += ptlv->size;
> +       ptlv =  free_pkd_tlv(ptlv);
> +
> +       if (datasize < ETH_MIN_DATA_LEN)
> +               port->ecp.tx.sizeout = ETH_MIN_PKT_LEN;

Might also be worth checking ETH_MAX_DATA_LEN after the above TODO adding profiles is done.

> +       else
> +               port->ecp.tx.sizeout = fb_offset;
> +
> +       return true;
> +
> +error:
> +       ptlv = free_pkd_tlv(ptlv);
> +       if (port->ecp.tx.frameout)
> +               free(port->ecp.tx.frameout);
> +       port->ecp.tx.frameout = NULL;
> +       printf("InfoECPDU: packed TLV too large for tx frame\n");
> +       return false;
> +}
> +

Please merge the relevant pieces of this patch with the following patch so it does not add 'struct ecp' to the port structure then immediately move it to vdp_data in the following patch.

Thanks,
John.
