From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH RESEND] ptp: add VMware virtual PTP clock driver
Date: Thu, 05 Mar 2020 17:25:39 -0800 (PST)
Message-ID: <20200305.172539.2236241791008844069.davem@davemloft.net>
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

Thanks for your explanation of why this is a reasonable driver, makes sense.

Applied to net-next.
