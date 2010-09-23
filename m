From: John Fastabend <john.r.fastabend@intel.com>
Subject: Re: [E1000-eedc] [PATCH 06/10] VDP commandline interface
Date: Wed, 22 Sep 2010 17:57:12 -0700
Message-ID: <4C9AA5E8.8050603@intel.com>
References: <1282739262-14968-1-git-send-email-jens@linux.vnet.ibm.com>
	<1282739262-14968-7-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1282739262-14968-7-git-send-email-jens@linux.vnet.ibm.com>
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
> This patch implements the command line interface to control the VDP module.
> In station role, it allows to register a new VSI (guest interface) profile
> and query its state. In bridge role, it allows to query the state of all
> registered profiles.
> With lldptool it is possible to set the role from default "station" to
> "bridge".
> The configuration of the role for a port is saved to lldpads config file.
> 
> Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
> ---
>  Makefile.am             |   12 +-
>  include/lldp_vdp_clif.h |   39 +++++
>  include/lldp_vdp_cmds.h |   44 ++++++
>  lldp_vdp_clif.c         |  136 ++++++++++++++++
>  lldp_vdp_cmds.c         |  394 +++++++++++++++++++++++++++++++++++++++++++++++
>  lldptool.c              |    2 +
>  6 files changed, 622 insertions(+), 5 deletions(-)
>  create mode 100644 include/lldp_vdp_clif.h
>  create mode 100644 include/lldp_vdp_cmds.h
>  create mode 100644 lldp_vdp_clif.c
>  create mode 100644 lldp_vdp_cmds.c
> 
> diff --git a/Makefile.am b/Makefile.am
> index 4b69389..9a3baf4 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -37,7 +37,8 @@ lldpad_include_HEADERS = include/dcb_types.h include/dcbtool.h \
>  include/dcb_osdep.h include/clif.h include/lldp_dcbx_cmds.h include/common.h \
>  include/lldpad.h include/os.h include/includes.h include/lldp_mand_cmds.h \
>  include/clif_msgs.h include/lldp_basman_cmds.h include/lldp_8023_cmds.h \
> -include/lldp_med_cmds.h include/lldp_dcbx_cfg.h include/lldp_evb_cmds.h
> +include/lldp_med_cmds.h include/lldp_dcbx_cfg.h include/lldp_evb_cmds.h \
> +include/lldp_vdp_cmds.h
> 
>  noinst_HEADERS = include/config.h include/ctrl_iface.h \
>  include/dcb_driver_if_types.h include/dcb_driver_interface.h \
> @@ -47,7 +48,7 @@ include/event_iface.h include/messages.h include/parse_cli.h include/version.h \
>  include/lldptool_cli.h include/list.h \
>  include/lldp_mand_clif.h include/lldp_basman_clif.h include/lldp_med_clif.h \
>  include/lldp_8023_clif.h include/lldp_dcbx_clif.h include/lldptool.h \
> -include/lldp_rtnl.h include/lldp_evb_clif.h
> +include/lldp_rtnl.h include/lldp_evb_clif.h include/lldp_vdp_clif.h
> 
>  lldpad_SOURCES = lldpad.c config.c  drv_cfg.c ctrl_iface.c event_iface.c eloop.c \
>  common.c os_unix.c lldp_dcbx_cmds.c log.c lldpad_shm.c \
> @@ -64,20 +65,21 @@ lldp_dcbx_cfg.c include/lldp_dcbx_cfg.h \
>  lldp_util.c include/lldp_util.h \
>  lldp_mand.c include/lldp_mand.h \
>  lldp_mand_cmds.c lldp_basman_cmds.c lldp_8023_cmds.c lldp_med_cmds.c \
> -lldp_evb_cmds.c \
> +lldp_evb_cmds.c lldp_vdp_cmds.c \
>  lldp_tlv.c include/lldp_tlv.h \
>  lldp_basman.c include/lldp_basman.h    \
>  lldp_med.c include/lldp_med.h \
>  lldp_8023.c include/lldp_8023.h \
>  lldp_evb.c include/lldp_evb.h \
> -lldp_vdp.c include/lldp_vdp.h
> +lldp_vdp.c include/lldp_vdp.h \
> +lldp_vdp_cmds.h
> 
>  dcbtool_SOURCES = dcbtool.c clif.c dcbtool_cmds.c parse_cli.l \
>  $(lldpad_include_HEADERS) $(noinst_HEADERS)
> 
>  lldptool_SOURCES = lldptool.c clif.c lldptool_cmds.c common.c os_unix.c \
>  lldp_mand_clif.c lldp_basman_clif.c lldp_med_clif.c lldp_8023_clif.c \
> -lldp_dcbx_clif.c lldp_evb_clif.c $(lldpad_include_HEADERS) \
> +lldp_dcbx_clif.c lldp_evb_clif.c lldp_vdp_clif.c $(lldpad_include_HEADERS) \
>  $(noinst_HEADERS)
> 
>  nltest_SOURCES = nltest.c nltest.h
> diff --git a/include/lldp_vdp_clif.h b/include/lldp_vdp_clif.h
> new file mode 100644
> index 0000000..adb6333
> --- /dev/null
> +++ b/include/lldp_vdp_clif.h
> @@ -0,0 +1,39 @@
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
> +#ifndef _LLDP_VDP_CLIF_H
> +#define _LLDP_VDP_CLIF_H
> +
> +struct lldp_module *vdp_cli_register(void);
> +void vdp_cli_unregister(struct lldp_module *);
> +int vdp_print_tlv(u32, u16, char *);
> +
> +#define VDP_BUF_SIZE                   256
> +
> +#define VDP_PREFIX                     "vdp"
> +#define ARG_VDP_MODE                   "mode"
> +#define ARG_VDP_ROLE                   "role"
> +
> +#endif
> diff --git a/include/lldp_vdp_cmds.h b/include/lldp_vdp_cmds.h
> new file mode 100644
> index 0000000..5e64c27
> --- /dev/null
> +++ b/include/lldp_vdp_cmds.h
> @@ -0,0 +1,44 @@
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
> +#ifndef _LLDP_VDP_CMDS_H
> +#define _LLDP_VDP_CMDS_H
> +
> +struct arg_handlers *vdp_get_arg_handlers();
> +
> +enum {
> +       MODE = 0,
> +       MGRID,
> +       TYPEID,
> +       TYPEIDVERSION,
> +       INSTANCEID,
> +       MAC,
> +       VLAN,
> +};
> +
> +#define VAL_STATION    "station"
> +#define VAL_BRIDGE     "bridge"
> +
> +#endif
> diff --git a/lldp_vdp_clif.c b/lldp_vdp_clif.c
> new file mode 100644
> index 0000000..aa357e9
> --- /dev/null
> +++ b/lldp_vdp_clif.c
> @@ -0,0 +1,136 @@
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
> +#include "includes.h"
> +#include "common.h"
> +#include <stdio.h>
> +#include <syslog.h>
> +#include <sys/un.h>
> +#include <sys/stat.h>
> +#include "lldp_mod.h"
> +#include "lldptool.h"
> +#include "lldp.h"
> +#include "lldp_vdp.h"
> +#include "lldp_vdp_clif.h"
> +
> +void vdp_print_cfg_tlv(u16, char *info);
> +int vdp_print_help();
> +
> +u32 vdp_lookup_tlv_name(char *tlvid_str);
> +

snip

> +
> +static int get_arg_mode(struct cmd *cmd, char *arg, char *argvalue,
> +                              char *obuf)
> +{
> +       char *s, *t;
> +       struct vsi_profile *np;
> +       struct vdp_data *vd;
> +
> +       if (cmd->cmd != cmd_gettlv)
> +               return cmd_invalid;
> +
> +       switch (cmd->tlvid) {
> +       case ((LLDP_MOD_VDP) << 8) | LLDP_VDP_SUBTYPE:
> +               break;
> +       case INVALID_TLVID:
> +               return cmd_invalid;
> +       default:
> +               return cmd_not_applicable;
> +       }
> +
> +       s = t = malloc(VDP_BUF_SIZE);

memory leak on s or maybe I missed something.

> +       if (!s)
> +               return cmd_invalid;
> +       memset(s, 0, VDP_BUF_SIZE);
> +
> +       vd = vdp_data(cmd->ifname);
> +       if (!vd) {
> +               printf("%s(%i): vdp_data for %s not found !\n", __func__, __LINE__,
> +                      cmd->ifname);
> +               return cmd_invalid;
> +       }
> +
> +       LIST_FOREACH(np, &vd->profile_head, profile) {
> +               PRINT_PROFILE(t, np);
> +       }
> +
> +       sprintf(obuf, "%02x%s%04x%s", (unsigned int) strlen(arg), arg,
> +               (unsigned int) strlen(s), s);
> +
> +       return cmd_success;
> +}
> +

Thanks,
John.
