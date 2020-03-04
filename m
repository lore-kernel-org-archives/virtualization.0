From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH RESEND] ptp: add VMware virtual PTP clock driver
Date: Wed, 04 Mar 2020 14:04:10 -0800 (PST)
Message-ID: <20200304.140410.731261448085906331.davem@davemloft.net>
References: <20200228053230.GA457139@sc2-cpbu2-b0737.eng.vmware.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200228053230.GA457139@sc2-cpbu2-b0737.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vithampi@vmware.com
Cc: richardcochran@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Pv-drivers@vmware.com, virtualization@lists.linux-foundation.org, x86@kernel.org, thellstrom@vmware.com, jgross@suse.com
List-Id: virtualization@lists.linuxfoundation.org

From: Vivek Thampi <vithampi@vmware.com>
Date: Fri, 28 Feb 2020 05:32:46 +0000

> Add a PTP clock driver called ptp_vmw, for guests running on VMware ESXi
> hypervisor. The driver attaches to a VMware virtual device called
> "precision clock" that provides a mechanism for querying host system time.
> Similar to existing virtual PTP clock drivers (e.g. ptp_kvm), ptp_vmw
> utilizes the kernel's PTP hardware clock API to implement a clock device
> that can be used as a reference in Chrony for synchronizing guest time with
> host.
> 
> The driver is only applicable to x86 guests running in VMware virtual
> machines with precision clock virtual device present. It uses a VMware
> specific hypercall mechanism to read time from the device.
> 
> Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
> Signed-off-by: Vivek Thampi <vithampi@vmware.com>
> ---
>  Based on feedback, resending patch to include a broader audience.

If it's just providing a read of an accurate timesource, I think it's kinda
pointless to provide a full PTP driver for it.
