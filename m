From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 2/7] virtio-pmem: Add virtio pmem driver
Date: Tue, 21 May 2019 12:24:14 -0400 (EDT)
Message-ID: <176786650.30122184.1558455854322.JavaMail.zimbra__41972.455223889$1558455898$gmane$org@redhat.com>
References: <20190521133713.31653-1-pagupta@redhat.com>
	<20190521133713.31653-3-pagupta@redhat.com>
	<20190521094543-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190521094543-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: rdunlap@infradead.org, jack@suse.cz, kvm@vger.kernel.org, david@fromorbit.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org, aarcange@redhat.com, dave jiang <dave.jiang@intel.com>, jstaron@google.com, linux-nvdimm@lists.01.org, vishal l verma <vishal.l.verma@intel.com>, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com, imammedo@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com, nilal@redhat.com, tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, snitzer@redhat.com, cohuck@redhat.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.k
List-Id: virtualization@lists.linuxfoundation.org


> > diff --git a/include/uapi/linux/virtio_pmem.h
> > b/include/uapi/linux/virtio_pmem.h
> > new file mode 100644
> > index 000000000000..7a3e2fe52415
> > --- /dev/null
> > +++ b/include/uapi/linux/virtio_pmem.h
> > @@ -0,0 +1,35 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> > +/*
> > + * Definitions for virtio-pmem devices.
> > + *
> > + * Copyright (C) 2019 Red Hat, Inc.
> > + *
> > + * Author(s): Pankaj Gupta <pagupta@redhat.com>
> > + */
> > +
> > +#ifndef _UAPI_LINUX_VIRTIO_PMEM_H
> > +#define _UAPI_LINUX_VIRTIO_PMEM_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/virtio_types.h>
> > +#include <linux/virtio_ids.h>
> > +#include <linux/virtio_config.h>
> > +
> > +struct virtio_pmem_config {
> > +	__le64 start;
> > +	__le64 size;
> > +};
> > +
> 
> config generally should be __u64.
> Are you sure sparse does not complain?

I used this because VIRTIO 1.1 spec says: 
"The device configuration space uses the little-endian format for multi-byte fields. "

and __le64 looks ok to me. Also, its used in other driver config as welle.g virtio-vsock

> 
> 
> > +#define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
> > +
> > +struct virtio_pmem_resp {
> > +	/* Host return status corresponding to flush request */
> > +	__virtio32 ret;
> > +};
> > +
> > +struct virtio_pmem_req {
> > +	/* command type */
> > +	__virtio32 type;
> > +};
> > +
> > +#endif
> > --
> > 2.20.1
> 
> Sorry why are these __virtio32 not __le32?

I used __virtio32 for data fields for guest and host supporting different endianess.
 
Thanks,
Pankaj
> 
> --
> MST
> 
> 
