From: Dor Laor <dlaor@redhat.com>
Subject: Re: [PATCH]: An implementation of HyperV  KVP  functionality
Date: Sun, 14 Nov 2010 12:46:15 +0200
Message-ID: <4CDFBDF7.2080701@redhat.com>
References: <4CDBE98E02000030000902C9@novprvoes0310.provo.novell.com>
Reply-To: dlaor@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <4CDBE98E02000030000902C9@novprvoes0310.provo.novell.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Ky Srinivasan <ksrinivasan@novell.com>
Cc: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On 11/11/2010 10:03 PM, Ky Srinivasan wrote:

> + * An implementation of key value pair (KVP) functionality for Linux.
> + *
> + *
> + * Copyright (C) 2010, Novell, Inc.
> + * Author : K. Y. Srinivasan<ksrinivasan@novell.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more
> + * details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + */
> +
> +
> +#include<linux/net.h>
> +#include<linux/nls.h>
> +#include<linux/connector.h>
> +
> +#include "logging.h"
> +#include "osd.h"
> +#include "vmbus.h"
> +#include "vmbus_packet_format.h"
> +#include "vmbus_channel_interface.h"
> +#include "version_info.h"
> +#include "channel.h"
> +#include "vmbus_private.h"
> +#include "vmbus_api.h"
> +#include "utils.h"
> +#include "kvp.h"
> +
> +
> +/*
> + *
> + * The following definitions are shared with the user-mode component; do not
> + * change any of this without making the corresponding changes in
> + * the KVP user-mode component.
> + */
> +
> +#define CN_KVP_VAL             0x1 /* This supports queries from the kernel */
> +#define CN_KVP_USER_VAL       0x2 /* This supports queries from the user */
> +
> +
> +/*
> + * KVP protocol: The user mode component first registers with the

Is there a spec that describes all of the possible messages?
For Linux virtio we use it in parallel to the code to make sure all 
potential guest OS will follow the same standard.

What about live migration semantics like migrate while transaction is 
on? and having the guest aware of the migration so the host data will be 
updated?

..


> main(void)
> {
> 	int fd, len, sock_opt;
> 	int error;
> 	struct cn_msg *message;
> 	struct pollfd pfd;
> 	struct nlmsghdr *incoming_msg;
> 	struct cn_msg	*incoming_cn_msg;
> 	char	*key_value;
> 	kvp_key_name_t key_name;
>
> 	daemon(1, 0);
> 	openlog("KVP", 0, LOG_USER);
> 	syslog(LOG_INFO, "KVP starting; pid is:%d", getpid());
> 	/*
> 	 * Retrieve OS release information.
> 	 */
> 	kvp_get_os_info();
>
> 	fd = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_CONNECTOR);

This is nice. One of the first tried for virtio-serial was to use 
netlink. We even wanted unix_domain socket for AF_VIRT that will reach 
the host but davem nacked it.
