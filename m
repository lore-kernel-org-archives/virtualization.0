From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 01/12] VMCI: context implementation.
Date: Wed, 21 Nov 2012 13:04:46 -0800
Message-ID: <1353531886.24807.43.camel@joe-AO722>
References: <20121121202625.13252.86346.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121121203109.13252.92744.stgit@promb-2n-dhcp175.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121121203109.13252.92744.stgit@promb-2n-dhcp175.eng.vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: George Zhang <georgezhang@vmware.com>
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2012-11-21 at 12:31 -0800, George Zhang wrote:
> VMCI Context code maintains state for vmci and allows the driver to communicate
> with multiple VMs

Just some trivial notes.

> diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
[]

It'd be nicer if you added this #define before any #include
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
so that pr_<level> messages are prefixed.
(never mind, found a similar macro in patch 12/12)

> +#include <linux/vmw_vmci_defs.h>
> +#include <linux/vmw_vmci_api.h>
[]
> +	context = kzalloc(sizeof(*context), GFP_KERNEL);
> +	if (!context) {
> +		pr_warn("Failed to allocate memory for VMCI context.\n");

OOM logging messages aren't necessary as alloc failures
are already logged with a stack trace.

That goes for the entire patch series.

> +	/* Fire event to all subscribers. */
> +	array_size = vmci_handle_arr_get_size(subscriber_array);
> +	for (i = 0; i < array_size; i++) {
> +		int result;
> +		struct vmci_event_msg *e_msg;
> +		struct vmci_event_payld_ctx *ev_payload;
> +		char buf[sizeof(*e_msg) + sizeof(*ev_payload)];

Maybe just use
	struct vmci_event_msg e_msg;
	struct vmci_event_payld_ctx ev_payload;
and change the addressing or use a cast as appropriate?

> +	/* Allocate guest call entry and add it to the target VM's queue. */
> +	dq_entry = kmalloc(sizeof(*dq_entry), GFP_KERNEL);
> +	if (dq_entry == NULL) {
> +		pr_warn("Failed to allocate memory for datagram.\n");

Another unnecessary OOM message.

You also have some inconsistency in whether or not your
logging messages use a terminating period.  I suggest
you just delete all the periods.
	s/\.\\n"/\\n"/g
