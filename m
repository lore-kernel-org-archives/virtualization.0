From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH]: An implementation of HyperV  KVP  functionality
Date: Thu, 11 Nov 2010 13:15:48 -0800
Message-ID: <20101111211548.GA31373@kroah.com>
References: <4CDBE98E02000030000902C9@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
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

On Thu, Nov 11, 2010 at 01:03:10PM -0700, Ky Srinivasan wrote:
> +/*
> + * An implementation of key value pair (KVP) functionality for Linux.
> + *
> + *
> + * Copyright (C) 2010, Novell, Inc.
> + * Author : K. Y. Srinivasan <ksrinivasan@novell.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.

This is all that is needed.

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

You can delete this chunk.

> +/*
> + * KVP protocol: The user mode component first registers with the
> + * the kernel component. Subsequently, the kernel component requests, data
> + * for the specified keys. In response to this message the user mode component
> + * fills in the value corresponding to the specified key. We overload the
> + * sequence field in the cn_msg header to define our KVP message types.
> + *
> + * XXXKYS: Have a shared header file between the user and kernel (TODO)
> + */
> +
> +enum kvp_op {
> +	KVP_REGISTER = 0, /* Register the user mode component */
> +	KVP_KERNEL_GET,/*Kernel is requesting the value for the specified key*/
> +	KVP_KERNEL_SET, /*Kernel is providing the value for the specified key*/
> +	KVP_USER_GET, /*User is requesting the value for the specified key*/
> +	KVP_USER_SET /*User is providing the value for the specified key*/
> +};

As these values are shared between the kernel and userspace, you should
specifically define them.

Also, your spaces with the /* stuff is incorrect.

And, "KVP"?  That's very generic, how about, "HYPERV_KVP_..." instead?
That fits the global namespace much better.

s/kvp_op/hyperv_kvp_op/ as well.

> +#define KVP_KEY_SIZE    512
> +#define KVP_VALUE_SIZE  2048
> +
> +
> +typedef struct kvp_msg {
> +	__u32 kvp_key; /* Key */
> +	__u8  kvp_value[0]; /* Corresponding value */
> +} kvp_msg_t;

I thought that kvp_value was really KVP_VALUE_SIZE?

And no typedefs, you did run your code through checkpatch.pl, right?
Why ignore the stuff it spits back at you?


> +static char *kvp_keys[KVP_MAX_KEY] = {"FullyQualifiedDomainName",
> +				"IntegrationServicesVersion",
> +				"NetworkAddressIPv4",
> +				"NetworkAddressIPv6",
> +				"OSBuildNumber",
> +				"OSName",
> +				"OSMajorVersion",
> +				"OSMinorVersion",
> +				"OSVersion",
> +				"ProcessorArchitecture",
> +				};

Why list these at all, as more might come in the future, and the kernel
really doesn't care about them, right?

> +int
> +kvp_init(void)

All of your global symbols should have "hyperv_" on the front of them.

> --- linux.trees.git.orig/drivers/staging/hv/Makefile	2010-11-10 14:01:55.000000000 -0500
> +++ linux.trees.git/drivers/staging/hv/Makefile	2010-11-11 11:24:54.000000000 -0500
> @@ -2,7 +2,7 @@ obj-$(CONFIG_HYPERV)		+= hv_vmbus.o hv_t
>  obj-$(CONFIG_HYPERV_STORAGE)	+= hv_storvsc.o
>  obj-$(CONFIG_HYPERV_BLOCK)	+= hv_blkvsc.o
>  obj-$(CONFIG_HYPERV_NET)	+= hv_netvsc.o
> -obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
> +obj-$(CONFIG_HYPERV_UTILS)	+= hv_util.o

Ick, you just renamed the kernel module.  Did you really mean to do
this?  What tools are now going to break because you did this?  (I'm
thinking installers here...)

>  
>  hv_vmbus-y := vmbus_drv.o osd.o \
>  		 vmbus.o hv.o connection.o channel.o \
> @@ -10,3 +10,4 @@ hv_vmbus-y := vmbus_drv.o osd.o \
>  hv_storvsc-y := storvsc_drv.o storvsc.o
>  hv_blkvsc-y := blkvsc_drv.o blkvsc.o
>  hv_netvsc-y := netvsc_drv.o netvsc.o rndis_filter.o
> +hv_util-y :=  hv_utils.o kvp.o
> Index: linux.trees.git/drivers/staging/hv/kvp.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux.trees.git/drivers/staging/hv/kvp.h	2010-11-10 14:03:47.000000000 -0500

hyperv_kvp.h as this is going to be a global header file, right?

> +typedef enum {
> +	ICKvpExchangeOperationGet = 0,
> +	ICKvpExchangeOperationSet,
> +	ICKvpExchangeOperationDelete,
> +	ICKvpExchangeOperationEnumerate,
> +	ICKvpExchangeOperationCount /* Number of operations, must be last. */
> +} IC_KVP_EXCHANGE_OPERATION;
> +
> +typedef enum {
> +	ICKvpExchangePoolExternal = 0,
> +	ICKvpExchangePoolGuest,
> +	ICKvpExchangePoolAuto,
> +	ICKvpExchangePoolAutoExternal,
> +	ICKvpExchangePoolInternal,
> +	ICKvpExchangePoolCount /* Number of pools, must be last. */
> +} IC_KVP_EXCHANGE_POOL;
> +
> +typedef struct ic_kvp_hdr {
> +	u8 operation;
> +	u8 pool;
> +} ic_kvp_hdr_t;
> +
> +typedef struct ic_kvp_exchg_msg_value {
> +	u32 value_type;
> +	u32 key_size;
> +	u32 value_size;
> +	u8 key[IC_KVP_EXCHANGE_MAX_KEY_SIZE];
> +	u8 value[IC_KVP_EXCHANGE_MAX_VALUE_SIZE];
> +} ic_kvp_exchg_msg_value_t;
> +
> +typedef struct ic_kvp__msg_enumerate {
> +	u32 index;
> +	ic_kvp_exchg_msg_value_t data;
> +} ic_kvp_msg_enumerate_t;
> +
> +typedef struct ic_kvp_msg {
> +	ic_kvp_hdr_t	kvp_hdr;
> +	ic_kvp_msg_enumerate_t	kvp_data;
> +} ic_kvp_msg_t;

Again, no typedefs, and fix up the names of these structures to be
understandable :)

> --- linux.trees.git.orig/include/linux/connector.h	2010-11-09 17:22:15.000000000 -0500
> +++ linux.trees.git/include/linux/connector.h	2010-11-11 13:14:52.000000000 -0500
> @@ -42,8 +42,9 @@
>  #define CN_VAL_DM_USERSPACE_LOG		0x1
>  #define CN_IDX_DRBD			0x8
>  #define CN_VAL_DRBD			0x1
> +#define CN_KVP_IDX			0x9     /* MSFT KVP functionality */

Did you reserve this number with anyone?  Who?

> -#define CN_NETLINK_USERS		8
> +#define CN_NETLINK_USERS		10

Are you sure you incremented this properly?

thanks,

greg k-h
