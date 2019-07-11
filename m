From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v5 1/8] s390/mm: force swiotlb for protected virtualization
Date: Thu, 11 Jul 2019 18:48:40 -0300
Message-ID: <87k1codyyv.fsf@morokweng.localdomain>
References: <20190612111236.99538-1-pasic@linux.ibm.com>
	<20190612111236.99538-2-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: <20190612111236.99538-2-pasic@linux.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Christoph Hellwig <hch@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org


Hello Halil,

Halil Pasic <pasic@linux.ibm.com> writes:

> On s390, protected virtualization guests have to use bounced I/O
> buffers.  That requires some plumbing.
>
> Let us make sure, any device that uses DMA API with direct ops correctly
> is spared from the problems, that a hypervisor attempting I/O to a
> non-shared page would bring.
>
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/Kconfig                   |  4 +++
>  arch/s390/include/asm/mem_encrypt.h | 18 +++++++++++
>  arch/s390/mm/init.c                 | 47 +++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 arch/s390/include/asm/mem_encrypt.h
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 109243fdb6ec..88d8355b7bf7 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -1,4 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> +config ARCH_HAS_MEM_ENCRYPT
> +        def_bool y
> +
>  config MMU
>  	def_bool y
>  

ARCH_HAS_MEM_ENCRYPT is already defined in arch/Kconfig, so I think you
can just select it in config S390 like you do with SWIOTLB.

> @@ -187,6 +190,7 @@ config S390
>  	select VIRT_CPU_ACCOUNTING
>  	select ARCH_HAS_SCALED_CPUTIME
>  	select HAVE_NMI
> +	select SWIOTLB
>  
>  
>  config SCHED_OMIT_FRAME_POINTER

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
