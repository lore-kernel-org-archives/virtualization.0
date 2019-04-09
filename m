From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 03/12] s390/mm: force swiotlb for protected
	virtualization
Date: Tue, 9 Apr 2019 05:22:41 -0700
Message-ID: <20190409122241.GA9312@infradead.org>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
	<20190404231622.52531-4-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190404231622.52531-4-pasic@linux.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

> +++ b/arch/s390/include/asm/dma-mapping.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_S390_DMA_MAPPING_H
> +#define _ASM_S390_DMA_MAPPING_H
> +
> +#include <linux/dma-contiguous.h>
> +
> +static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
> +{
> +	return NULL;
> +}
> +
> +#endif /* _ASM_S390_DMA_MAPPING_H */
> +

Congratulations!  You ust create an entirely pointless duplicate of
include/asm-generic/dma-mapping.h.
