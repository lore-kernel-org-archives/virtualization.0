From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v10 2/7] virtio-pmem: Add virtio pmem driver
Date: Tue, 21 May 2019 09:51:35 -0400
Message-ID: <20190521094543-mutt-send-email-mst__40936.4799897716$1558446711$gmane$org@kernel.org>
References: <20190521133713.31653-1-pagupta@redhat.com>
	<20190521133713.31653-3-pagupta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190521133713.31653-3-pagupta@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pankaj Gupta <pagupta@redhat.com>
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, david@fromorbit.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, adilger.kernel@dilger.ca, zwisler@kernel.org, aarcange@redhat.com, dave.jiang@intel.com, jstaron@google.com, linux-nvdimm@lists.01.org, vishal.l.verma@intel.com, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl, rdunlap@infradead.org, riel@surriel.com, yuval.shaia@oracle.com, stefanha@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com, lcapitulino@redhat.com, nilal@redhat.com, tytso@mit.edu, xiaoguangrong.eric@gmail.com, snitzer@redhat.com, darrick.wong@oracle.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, imammedo@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 21, 2019 at 07:07:08PM +0530, Pankaj Gupta wrote:
> diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
> new file mode 100644
> index 000000000000..7a3e2fe52415
> --- /dev/null
> +++ b/include/uapi/linux/virtio_pmem.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/*
> + * Definitions for virtio-pmem devices.
> + *
> + * Copyright (C) 2019 Red Hat, Inc.
> + *
> + * Author(s): Pankaj Gupta <pagupta@redhat.com>
> + */
> +
> +#ifndef _UAPI_LINUX_VIRTIO_PMEM_H
> +#define _UAPI_LINUX_VIRTIO_PMEM_H
> +
> +#include <linux/types.h>
> +#include <linux/virtio_types.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_config.h>
> +
> +struct virtio_pmem_config {
> +	__le64 start;
> +	__le64 size;
> +};
> +

config generally should be __u64.
Are you sure sparse does not complain?


> +#define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
> +
> +struct virtio_pmem_resp {
> +	/* Host return status corresponding to flush request */
> +	__virtio32 ret;
> +};
> +
> +struct virtio_pmem_req {
> +	/* command type */
> +	__virtio32 type;
> +};
> +
> +#endif
> -- 
> 2.20.1

Sorry why are these __virtio32 not __le32?

-- 
MST
