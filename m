From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] drivers/virt: add missing linux/interrupt.h to
	fsl_hypervisor.c
Date: Fri, 22 Jul 2011 09:29:08 -0500
Message-ID: <871CCA4F-60EF-4646-8E01-8773393E88E3@kernel.crashing.org>
References: <1311108351-3056-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1311108351-3056-1-git-send-email-timur@freescale.com>
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
Cc: linuxppc-dev@linux.freescale.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On Jul 19, 2011, at 3:45 PM, Timur Tabi wrote:

> fsl_hypervisor.c calls request_irq() but does not include linux/interrupt.h.
> Normally, the driver will compile without error, but it can fail on some
> configurations.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> drivers/virt/fsl_hypervisor.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied to next

- k
