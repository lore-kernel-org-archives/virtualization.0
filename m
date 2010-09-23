From: John Fastabend <john.r.fastabend@intel.com>
Subject: Re: [E1000-eedc] [PATCH 02/10] implementation of IEEE 802.1Qbg in
	lldpad, part 1
Date: Thu, 23 Sep 2010 12:34:51 -0700
Message-ID: <4C9BABDB.3040404@intel.com>
References: <1282739262-14968-1-git-send-email-jens@linux.vnet.ibm.com>	<1282739262-14968-3-git-send-email-jens@linux.vnet.ibm.com>
	<4C9AA43B.9000702@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4C9AA43B.9000702@intel.com>
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

On 9/22/2010 5:50 PM, John Fastabend wrote:
> On 8/25/2010 5:27 AM, Jens Osterkamp wrote:
>> This patch contains the first part of an initial implementation of the
>> IEEE 802.1Qbg standard: it implements code for the exchange of EVB
>> capabilities between a host with virtual machines and an adjacent switch.
>> For this it adds a new EVB TLV to LLDP.
>>
>> Exchange of EVB TLV may be enabled or disabled on a per port basis.
>> Information about the information negotiated by the protocol can be
>> queried on the commandline with lldptool.
>>
>> This patch adds support for querying and setting parameters used in
>> the exchange of EVB TLV messages.
>> The parameters that can be set are:
>>
>>         - forwarding mode
>>         - host protocol capabilities (RTE, ECP, VDP)
>>         - no. of supported VSIs
>>         - retransmission timer exponent (RTE)
>>
>> The parameters are implemented as a local policy: all frames received by
>> an adjacent switch are validated against this policy and taken over where
>> appropriate. Negotiated parameters are stored in lldpads config, picked up
>> again and used at the next start.
>>
>> The patch applies to lldpad 0.9.38 and still contains code to log protocol
>> activity more verbosely than it would be necessary in the final version.
>>
>> Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
>> ---
>>  Makefile.am             |   10 +-
>>  include/lldp.h          |   19 ++
>>  include/lldp_evb.h      |   80 ++++++
>>  include/lldp_evb_clif.h |   51 ++++
>>  include/lldp_evb_cmds.h |   31 +++
>>  include/lldp_tlv.h      |    1 +
>>  lldp_evb.c              |  658 +++++++++++++++++++++++++++++++++++++++++++++++
>>  lldp_evb_clif.c         |  226 ++++++++++++++++
>>  lldp_evb_cmds.c         |  512 ++++++++++++++++++++++++++++++++++++
>>  lldpad.c                |    2 +
>>  lldptool.c              |    2 +
>>  11 files changed, 1588 insertions(+), 4 deletions(-)
>>  create mode 100644 include/lldp_evb.h
>>  create mode 100644 include/lldp_evb_clif.h
>>  create mode 100644 include/lldp_evb_cmds.h
>>  create mode 100644 lldp_evb.c
>>  create mode 100644 lldp_evb_clif.c
>>  create mode 100644 lldp_evb_cmds.c
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index 743e16f..d59a6fa 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -37,7 +37,7 @@ lldpad_include_HEADERS = include/dcb_types.h include/dcbtool.h \
>>  include/dcb_osdep.h include/clif.h include/lldp_dcbx_cmds.h include/common.h \
>>  include/lldpad.h include/os.h include/includes.h include/lldp_mand_cmds.h \
>>  include/clif_msgs.h include/lldp_basman_cmds.h include/lldp_8023_cmds.h \
>> -include/lldp_med_cmds.h include/lldp_dcbx_cfg.h
>> +include/lldp_med_cmds.h include/lldp_dcbx_cfg.h include/lldp_evb_cmds.h
>>
>>  noinst_HEADERS = include/config.h include/ctrl_iface.h \
>>  include/dcb_driver_if_types.h include/dcb_driver_interface.h \
>> @@ -47,7 +47,7 @@ include/event_iface.h include/messages.h include/parse_cli.h include/version.h \
>>  include/lldptool_cli.h include/list.h \
>>  include/lldp_mand_clif.h include/lldp_basman_clif.h include/lldp_med_clif.h \
>>  include/lldp_8023_clif.h include/lldp_dcbx_clif.h include/lldptool.h \
>> -include/lldp_rtnl.h
>> +include/lldp_rtnl.h include/lldp_evb_clif.h
>>
>>  lldpad_SOURCES = lldpad.c config.c  drv_cfg.c ctrl_iface.c event_iface.c eloop.c \
>>  common.c os_unix.c lldp_dcbx_cmds.c log.c lldpad_shm.c \
>> @@ -62,10 +62,12 @@ lldp_dcbx_cfg.c include/lldp_dcbx_cfg.h \
>>  lldp_util.c include/lldp_util.h \
>>  lldp_mand.c include/lldp_mand.h \
>>  lldp_mand_cmds.c lldp_basman_cmds.c lldp_8023_cmds.c lldp_med_cmds.c \
>> +lldp_evb_cmds.c \
>>  lldp_tlv.c include/lldp_tlv.h \
>>  lldp_basman.c include/lldp_basman.h    \
>>  lldp_med.c include/lldp_med.h \
>> -lldp_8023.c include/lldp_8023.h
>> +lldp_8023.c include/lldp_8023.h \
>> +lldp_evb.c include/lldp_evb.h
>>
>>
>>
>> @@ -74,7 +76,7 @@ $(lldpad_include_HEADERS) $(noinst_HEADERS)
>>
>>  lldptool_SOURCES = lldptool.c clif.c lldptool_cmds.c common.c os_unix.c \
>>  lldp_mand_clif.c lldp_basman_clif.c lldp_med_clif.c lldp_8023_clif.c \
>> -lldp_dcbx_clif.c $(lldpad_include_HEADERS) $(noinst_HEADERS)
>> +lldp_dcbx_clif.c lldp_evb_clif.c $(lldpad_include_HEADERS) $(noinst_HEADERS)
>>
>>  nltest_SOURCES = nltest.c nltest.h
>>
>> diff --git a/include/lldp.h b/include/lldp.h
>> index 66532bd..e00ba7a 100644
>> --- a/include/lldp.h
>> +++ b/include/lldp.h
>> @@ -45,6 +45,8 @@
>>  /* Telecommunications Industry Association TR-41 Committee */
>>  #define OUI_TIA_TR41   0x0012bb
>>
>> +#define OUI_IEEE_8021Qbg       0x001b3f
>> +
>>  /* IEEE 802.3AB Clause 9: TLV Types */
>>  #define CHASSIS_ID_TLV    1
>>  #define PORT_ID_TLV       2
>> @@ -186,5 +188,22 @@ enum {
>>  #define LLDP_8023_LINKAGG_CAPABLE      (1 << 0)
>>  #define LLDP_8023_LINKAGG_ENABLED      (1 << 1)
>>
>> +/* IEEE 802.1Qbg subtype */
>> +#define LLDP_EVB_SUBTYPE               0
>> +
>> +/* forwarding mode */
>> +#define LLDP_EVB_CAPABILITY_FORWARD_STANDARD           (1 << 7)
>> +#define LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY   (1 << 6)
>> +
>> +/* EVB supported protocols */
>> +#define LLDP_EVB_CAPABILITY_PROTOCOL_RTE               (1 << 2)
>> +#define LLDP_EVB_CAPABILITY_PROTOCOL_ECP               (1 << 1)
>> +#define LLDP_EVB_CAPABILITY_PROTOCOL_VDP               (1 << 0)
>> +
>> +/* EVB specific values */
>> +#define LLDP_EVB_DEFAULT_MAX_VSI                       4096
>> +#define LLDP_EVB_DEFAULT_SVSI                          3295
>> +#define LLDP_EVB_DEFAULT_RTE                           15
>> +
>>  void somethingChangedLocal(char *ifname);
>>  #endif /* _LLDP_H */
>> diff --git a/include/lldp_evb.h b/include/lldp_evb.h
>> new file mode 100644
>> index 0000000..667f9ad
>> --- /dev/null
>> +++ b/include/lldp_evb.h
>> @@ -0,0 +1,80 @@
>> +/*******************************************************************************
>> +
>> +  implementation of EVB TLVs for LLDP
>> +  (c) Copyright IBM Corp. 2010
>> +
>> +  Author(s): Jens Osterkamp <jens@linux.vnet.ibm.com>
>> +
>> +  This program is free software; you can redistribute it and/or modify it
>> +  under the terms and conditions of the GNU General Public License,
>> +  version 2, as published by the Free Software Foundation.
>> +
>> +  This program is distributed in the hope it will be useful, but WITHOUT
>> +  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> +  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> +  more details.
>> +
>> +  You should have received a copy of the GNU General Public License along with
>> +  this program; if not, write to the Free Software Foundation, Inc.,
>> +  51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
>> +
>> +  The full GNU General Public License is included in this distribution in
>> +  the file called "COPYING".
>> +
>> +*******************************************************************************/
>> +
>> +#ifndef _LLDP_EVB_H
>> +#define _LLDP_EVB_H
>> +
>> +#include "lldp_mod.h"
>> +
>> +#define LLDP_MOD_EVB   OUI_IEEE_8021Qbg
>> +#define LLDP_OUI_SUBTYPE       { 0x00, 0x1b, 0x3f, 0x00 }
>> +
>> +typedef enum {
>> +       EVB_OFFER_CAPABILITIES = 0,
>> +       EVB_CONFIGURE,
>> +       EVB_CONFIRMATION
>> +} evb_state;
>> +
>> +struct tlv_info_evb {
>> +       u8 oui[3];
>> +       u8 sub;
>> +       /* supported forwarding mode */
>> +       u8 smode;
>> +       /* supported capabilities */
>> +       u8 scap;
>> +       /* currently configured forwarding mode */
>> +       u8 cmode;
>> +       /* currently configured capabilities */
>> +       u8 ccap;
>> +       /* supported no. of vsi */
>> +       u16 svsi;
>> +       /* currently configured no. of vsi */
>> +       u16 cvsi;
>> +       /* retransmission exponent */
>> +       u8 rte;
>> +} __attribute__ ((__packed__));
>> +
>> +struct evb_data {
>> +       char ifname[IFNAMSIZ];
>> +       struct unpacked_tlv *evb;
>> +       struct tlv_info_evb *tie;
>> +       /* local policy */
>> +       struct tlv_info_evb *policy;
>> +       int state;
>> +       LIST_ENTRY(evb_data) entry;
>> +};
>> +
>> +struct evb_user_data {
>> +       LIST_HEAD(evb_head, evb_data) head;
>> +};
>> +
>> +struct lldp_module *evb_register(void);
>> +void evb_unregister(struct lldp_module *mod);
>> +struct packed_tlv *evb_gettlv(struct port *port);
>> +void evb_ifdown(char *);
>> +void evb_ifup(char *);
>> +struct evb_data *evb_data(char *ifname);
>> +
>> +#endif /* _LLDP_EVB_H */
>> diff --git a/include/lldp_evb_clif.h b/include/lldp_evb_clif.h
>> new file mode 100644
>> index 0000000..acaee5e
>> --- /dev/null
>> +++ b/include/lldp_evb_clif.h
>> @@ -0,0 +1,51 @@
>> +/*******************************************************************************
>> +
>> +  implementation of EVB TLVs for LLDP
>> +  (c) Copyright IBM Corp. 2010
>> +
>> +  Author(s): Jens Osterkamp <jens@linux.vnet.ibm.com>
>> +
>> +  This program is free software; you can redistribute it and/or modify it
>> +  under the terms and conditions of the GNU General Public License,
>> +  version 2, as published by the Free Software Foundation.
>> +
>> +  This program is distributed in the hope it will be useful, but WITHOUT
>> +  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> +  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> +  more details.
>> +
>> +  You should have received a copy of the GNU General Public License along with
>> +  this program; if not, write to the Free Software Foundation, Inc.,
>> +  51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
>> +
>> +  The full GNU General Public License is included in this distribution in
>> +  the file called "COPYING".
>> +
>> +*******************************************************************************/
>> +
>> +#ifndef _LLDP_EVB_CLIF_H
>> +#define _LLDP_EVB_CLIF_H
>> +
>> +struct lldp_module *evb_cli_register(void);
>> +void evb_cli_unregister(struct lldp_module *);
>> +int evb_print_tlv(u32, u16, char *);
>> +
>> +#define EVB_BUF_SIZE                   256
>> +
>> +#define ARG_EVB_FORWARDING_MODE                "fmode"
>> +
>> +#define VAL_EVB_FMODE_BRIDGE           "bridge"
>> +#define VAL_EVB_FMODE_REFLECTIVE_RELAY "reflectiverelay"
>> +
>> +#define ARG_EVB_CAPABILITIES           "capabilities"
>> +
>> +#define VAL_EVB_CAPA_RTE               "rte"
>> +#define VAL_EVB_CAPA_ECP               "ecp"
>> +#define VAL_EVB_CAPA_VDP               "vdp"
>> +#define VAL_EVB_CAPA_NONE              "none"
>> +
>> +#define ARG_EVB_VSIS                   "vsis"
>> +
>> +#define ARG_EVB_RTE                    "rte"
>> +
>> +#endif
>> diff --git a/include/lldp_evb_cmds.h b/include/lldp_evb_cmds.h
>> new file mode 100644
>> index 0000000..1367e5d
>> --- /dev/null
>> +++ b/include/lldp_evb_cmds.h
>> @@ -0,0 +1,31 @@
>> +/*******************************************************************************
>> +
>> +  implementation of EVB TLVs for LLDP
>> +  (c) Copyright IBM Corp. 2010
>> +
>> +  Author(s): Jens Osterkamp <jens@linux.vnet.ibm.com>
>> +
>> +  This program is free software; you can redistribute it and/or modify it
>> +  under the terms and conditions of the GNU General Public License,
>> +  version 2, as published by the Free Software Foundation.
>> +
>> +  This program is distributed in the hope it will be useful, but WITHOUT
>> +  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> +  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> +  more details.
>> +
>> +  You should have received a copy of the GNU General Public License along with
>> +  this program; if not, write to the Free Software Foundation, Inc.,
>> +  51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
>> +
>> +  The full GNU General Public License is included in this distribution in
>> +  the file called "COPYING".
>> +
>> +*******************************************************************************/
>> +
>> +#ifndef _LLDP_EVB_CMDS_H
>> +#define _LLDP_EVB_CMDS_H
>> +
>> +struct arg_handlers *evb_get_arg_handlers();
>> +
>> +#endif
>> diff --git a/include/lldp_tlv.h b/include/lldp_tlv.h
>> index a32cc71..fe3a75a 100644
>> --- a/include/lldp_tlv.h
>> +++ b/include/lldp_tlv.h
>> @@ -144,6 +144,7 @@ int tlv_ok(struct unpacked_tlv *tlv);
>>  #define TLVID_8021(sub)                TLVID(OUI_IEEE_8021, (sub))
>>  #define TLVID_8023(sub)                TLVID(OUI_IEEE_8023, (sub))
>>  #define TLVID_MED(sub)         TLVID(OUI_TIA_TR41, (sub))
>> +#define TLVID_8021Qbg(sub)     TLVID(OUI_IEEE_8021Qbg, (sub))
>>
>>  /* the size in bytes needed for a packed tlv from unpacked tlv */
>>  #define TLVSIZE(t) ((t) ? (2 + (t)->length) : 0)
>> diff --git a/lldp_evb.c b/lldp_evb.c
>> new file mode 100644
>> index 0000000..4213137
>> --- /dev/null
>> +++ b/lldp_evb.c
>> @@ -0,0 +1,658 @@
>> +/*******************************************************************************
>> +
>> +  implementation of EVB TLVs for LLDP
>> +  (c) Copyright IBM Corp. 2010
>> +
>> +  Author(s): Jens Osterkamp <jens@linux.vnet.ibm.com>
>> +
>> +  This program is free software; you can redistribute it and/or modify it
>> +  under the terms and conditions of the GNU General Public License,
>> +  version 2, as published by the Free Software Foundation.
>> +
>> +  This program is distributed in the hope it will be useful, but WITHOUT
>> +  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> +  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> +  more details.
>> +
>> +  You should have received a copy of the GNU General Public License along with
>> +  this program; if not, write to the Free Software Foundation, Inc.,
>> +  51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
>> +
>> +  The full GNU General Public License is included in this distribution in
>> +  the file called "COPYING".
>> +
>> +*******************************************************************************/
>> +
>> +#include <net/if.h>
>> +#include <sys/queue.h>
>> +#include <sys/socket.h>
>> +#include <sys/ioctl.h>
>> +#include <sys/utsname.h>
>> +#include <linux/if_bridge.h>
>> +#include <string.h>
>> +#include "lldp.h"
>> +#include "lldp_evb.h"
>> +#include "messages.h"
>> +#include "config.h"
>> +#include "common.h"
>> +#include "lldp_mand_clif.h"
>> +#include "lldp_evb_clif.h"
>> +#include "lldp_evb_cmds.h"
>> +
>> +extern struct lldp_head lldp_head;
>> +
>> +struct evb_data *evb_data(char *ifname)
>> +{
>> +       struct evb_user_data *ud;
>> +       struct evb_data *ed = NULL;
>> +
>> +       ud = find_module_user_data_by_if(ifname, &lldp_head, LLDP_MOD_EVB);
>> +       if (ud) {
>> +               LIST_FOREACH(ed, &ud->head, entry) {
>> +                       if (!strncmp(ifname, ed->ifname, IFNAMSIZ))
>> +                               return ed;
>> +               }
>> +       }
>> +       return NULL;
>> +}
>> +
>> +static void evb_print_tlvinfo(struct tlv_info_evb *tie)
>> +{
>> +       printf("%s(%i): supported forwarding mode: %02x\n", __FILE__, __LINE__,  tie->smode);
>> +       printf("%s(%i): configured forwarding mode: %02x\n", __FILE__, __LINE__,  tie->cmode);
>> +       printf("%s(%i): supported capabilities: %02x\n", __FILE__, __LINE__,  tie->scap);
>> +       printf("%s(%i): configured capabilities: %02x\n", __FILE__, __LINE__,  tie->ccap);
>> +       printf("%s(%i): supported no. of vsis: %04i\n", __FILE__, __LINE__,  tie->svsi);
>> +       printf("%s(%i): configured no. of vsis: %04i\n", __FILE__, __LINE__,  tie->cvsi);
>> +       printf("%s(%i): rte: %02i\n\n", __FILE__, __LINE__,  tie->rte);
>> +}
>> +
>> +/*
>> + * evb_bld_cfg_tlv - build the EVB TLV
>> + * @ed: the evb data struct
>> + *
>> + * Returns 0 on success
>> + */
>> +static int evb_bld_cfg_tlv(struct evb_data *ed)
>> +{
>> +       int rc = 0;
>> +       int i;
>> +       struct unpacked_tlv *tlv = NULL;
>> +
>> +       /* free ed->evb if it exists */
>> +       FREE_UNPKD_TLV(ed, evb);
>> +
>> +       if (!is_tlv_txenabled(ed->ifname, TLVID_8021Qbg(LLDP_EVB_SUBTYPE))) {
>> +               fprintf(stderr, "%s:%s:EVB tx is currently disabled !\n",
>> +                       __func__, ed->ifname);
>> +               rc = EINVAL;
>> +               goto out_err;
>> +       }
>> +
>> +       tlv = create_tlv();
>> +       if (!tlv)
>> +               goto out_err;
>> +
>> +       tlv->type = ORG_SPECIFIC_TLV;
>> +       tlv->length = sizeof(struct tlv_info_evb);
>> +       tlv->info = (u8 *)malloc(tlv->length);
>> +       if(!tlv->info) {
>> +               free(tlv);
>> +               tlv = NULL;
>> +               rc = ENOMEM;
>> +               goto out_err;
>> +       }
>> +       memcpy(tlv->info, ed->tie, tlv->length);
>> +
>> +       printf("### %s:type %i, length %i, info ", __func__, tlv->type, tlv->length);
>> +
>> +       for (i=0; i < tlv->length; i++) {
>> +               printf("%02x ", tlv->info[i]);
>> +       }
>> +
> 
> Remove the extra braces around the for statement. Granted the rest of
> lldpad may not follow a consistent coding style but lets try going
> forward and hopefully I get around to lldpad soon.
> 
> 
>> +       printf("\n");
>> +
>> +       ed->evb = tlv;
>> +out_err:
>> +       return rc;
>> +}
>> +
>> +static void evb_free_tlv(struct evb_data *ed)
>> +{
>> +       if (ed) {
>> +               FREE_UNPKD_TLV(ed, evb);
>> +       }
> 
> Same here extra braces.
> 
>> +}
>> +
>> +/* evb_init_cfg_tlv:
>> + *
>> + * fill up tlv_info_evb structure with reasonable info
>> + */
>> +static int evb_init_cfg_tlv(struct evb_data *ed)
>> +{
>> +       char arg_path[EVB_BUF_SIZE];
>> +       char *param;
>> +
>> +       /* load policy from config */
>> +       ed->policy = (struct tlv_info_evb *) calloc(1, sizeof(struct tlv_info_evb));
> 
> Use malloc instead of callod() of one.
> 

On second thought disregard this nit. Keep the calloc() calls if you want and ignore the comment. I guess you save a memset() this way...

Thanks,
John
