From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [RFC/PATCH 14/15] guest: detect when running on kvm
Date: Thu, 20 Mar 2008 10:16:02 -0700
Message-ID: <20080320101602.f2737c94.randy.dunlap__38544.8405323133$1206033829$gmane$org@oracle.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030326.6690.65.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206030326.6690.65.camel@cotte.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Carsten Otte <cotte@de.ibm.com>
Cc: aliguori@us.ibm.com, EHRHARDT@de.ibm.com, hollisb@us.ibm.com, arnd@arndb.de, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 20 Mar 2008 17:25:26 +0100 Carsten Otte wrote:

> From: Christian Borntraeger <borntraeger@de.ibm.com>
> From: Carsten Otte <cotte@de.ibm.com>
> 
> This patch adds functionality to detect if the kernel runs under the KVM
> hypervisor. A macro MACHINE_IS_KVM is exported for device drivers. This
> allows drivers to skip device detection if the systems runs non-virtualized.
> We also define a preferred console to avoid having the ttyS0, which is a line
> mode only console.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Carsten Otte <cotte@de.ibm.com>
> ---
>  arch/s390/Kconfig        |    7 +++++++
>  arch/s390/kernel/early.c |    4 ++++
>  arch/s390/kernel/setup.c |   10 +++++++---
>  include/asm-s390/setup.h |    1 +
>  4 files changed, 19 insertions(+), 3 deletions(-)
> 
> Index: kvm/arch/s390/kernel/early.c
> ===================================================================
> --- kvm.orig/arch/s390/kernel/early.c
> +++ kvm/arch/s390/kernel/early.c
> @@ -143,6 +143,10 @@ static noinline __init void detect_machi
>  	/* Running on a P/390 ? */
>  	if (cpuinfo->cpu_id.machine == 0x7490)
>  		machine_flags |= 4;
> +
> +	/* Running under KVM ? */
> +	if (cpuinfo->cpu_id.version == 0xfe)

Hi,

Where are these magic numbers documented?  (0x7490, 0xfe, etc.)


> +		machine_flags |= 64;
>  }
>  
>  #ifdef CONFIG_64BIT

---
~Randy
