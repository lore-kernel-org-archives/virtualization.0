From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [vmw_vmci 01/11] Apply VMCI context code
Date: Thu, 26 Jul 2012 16:48:50 -0700
Message-ID: <20120726234850.GB3849@kroah.com>
References: <1343345980-32397-1-git-send-email-astiegmann@vmware.com>
	<1343345980-32397-2-git-send-email-astiegmann@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1343345980-32397-2-git-send-email-astiegmann@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Andrew Stiegmann (stieg)" <astiegmann@vmware.com>
Cc: pv-drivers@vmware.com, vm-crosstalk@vmware.com, linux-kernel@vger.kernel.org, cschamp@vmware.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 26, 2012 at 04:39:30PM -0700, Andrew Stiegmann (stieg) wrote:
> Context code maintains state for vmci and allows the driver
> to communicate with multiple VMs.
> 
> Signed-off-by: Andrew Stiegmann (stieg) <astiegmann@vmware.com>

One tiny nit:

> diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
> new file mode 100644
> index 0000000..46faf10
> --- /dev/null
> +++ b/drivers/misc/vmw_vmci/vmci_context.c
> @@ -0,0 +1,1269 @@
> +/*
> + * VMware VMCI Driver
> + *
> + * Copyright (C) 2012 VMware, Inc. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation version 2 and no later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> + * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + * for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

Are you prepared to track the office movements of the FSF for the next
40 years to keep this up to date?  If not, please don't include it, it's
not needed at all.

greg k-h
