From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 7/7] [v5] drivers/virt: introduce Freescale hypervisor
	management driver
Date: Thu, 9 Jun 2011 12:40:10 -0700
Message-ID: <20110609124010.6335559e.randy.dunlap__31131.1472826221$1307648564$gmane$org@oracle.com>
References: <1307646794-26374-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1307646794-26374-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Timur Tabi <timur@freescale.com>
Cc: arnd@arndb.de, konrad.wilk@oracle.com, benh@kernel.crashing.org, kumar.gala@freescale.com, linux-kernel@vger.kernel.org, cmetcalf@tilera.com, dsaxena@linaro.org, linux-console@vger.kernel.org, greg@kroah.com, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 9 Jun 2011 14:13:14 -0500 Timur Tabi wrote:

> Add the drivers/virt directory, which houses drivers that support
> virtualization environments, and add the Freescale hypervisor management
> driver.
> 
> The Freescale hypervisor management driver provides several services to
> drivers and applications related to the Freescale hypervisor:
> 
> 1. An ioctl interface for querying and managing partitions
> 
> 2. A file interface to reading incoming doorbells
> 
> 3. An interrupt handler for shutting down the partition upon receiving the
>    shutdown doorbell from a manager partition
> 
> 4. A kernel interface for receiving callbacks when a managed partition
>    shuts down.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  drivers/Kconfig                |    2 +
>  drivers/Makefile               |    3 +
>  drivers/virt/Kconfig           |   32 ++
>  drivers/virt/Makefile          |    5 +
>  drivers/virt/fsl_hypervisor.c  |  983 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/Kbuild           |    1 +
>  include/linux/fsl_hypervisor.h |  231 ++++++++++
>  7 files changed, 1257 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/virt/Kconfig
>  create mode 100644 drivers/virt/Makefile
>  create mode 100644 drivers/virt/fsl_hypervisor.c
>  create mode 100644 include/linux/fsl_hypervisor.h

> diff --git a/include/linux/fsl_hypervisor.h b/include/linux/fsl_hypervisor.h
> new file mode 100644
> index 0000000..d1ca2b1
> --- /dev/null
> +++ b/include/linux/fsl_hypervisor.h
> @@ -0,0 +1,231 @@

[snip]

> +/**
> + * enum fsl_hv_ioctl_cmd - ioctl commands
> + * @FSL_HV_IOCTL_PARTITION_RESTART: restart another partition
> + * @FSL_HV_IOCTL_PARTITION_GET_STATUS: get a partition's status
> + * @FSL_HV_IOCTL_PARTITION_START: boot another partition
> + * @FSL_HV_IOCTL_PARTITION_STOP: stop this or another partition
> + * @FSL_HV_IOCTL_MEMCPY: copy data from one partition to another
> + * @FSL_HV_IOCTL_DOORBELL: ring a doorbell
> + * @FSL_HV_IOCTL_GETPROP: get a property from another guest's device tree
> + * @FSL_HV_IOCTL_SETPROP: set a property in another guest's device tree
> + *
> + * This enum lists the available ioctl commands for the Freescale hypervisor
> + * management driver.  The meaning
> + */
> +enum fsl_hv_ioctl_cmd {
> +	FSL_HV_IOCTL_PARTITION_RESTART = _IOWR(0, 1, struct fsl_hv_ioctl_restart),
> +	FSL_HV_IOCTL_PARTITION_GET_STATUS = _IOWR(0, 2, struct fsl_hv_ioctl_status),
> +	FSL_HV_IOCTL_PARTITION_START = _IOWR(0, 3, struct fsl_hv_ioctl_start),
> +	FSL_HV_IOCTL_PARTITION_STOP = _IOWR(0, 4, struct fsl_hv_ioctl_stop),
> +	FSL_HV_IOCTL_MEMCPY = _IOWR(0, 5, struct fsl_hv_ioctl_memcpy),
> +	FSL_HV_IOCTL_DOORBELL = _IOWR(0, 6, struct fsl_hv_ioctl_doorbell),
> +	FSL_HV_IOCTL_GETPROP = _IOWR(0, 7, struct fsl_hv_ioctl_prop),
> +	FSL_HV_IOCTL_SETPROP = _IOWR(0, 8, struct fsl_hv_ioctl_prop),
> +};

Missing an entry in Documentation/ioctl/ioctl-number.txt for 0 (with conflict!).

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
