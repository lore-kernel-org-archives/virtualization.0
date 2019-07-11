From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH v2] virtio_pmem: fix sparse warning
Date: Thu, 11 Jul 2019 14:46:11 -0400 (EDT)
Message-ID: <1464566100.41069898.1562870771867.JavaMail.zimbra__6382.74774407677$1562871263$gmane$org@redhat.com>
References: <20190710175832.17252-1-pagupta@redhat.com>
	<20190711134648-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190711134648-mutt-send-email-mst@kernel.org>
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
Cc: linux-nvdimm@lists.01.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, yuval shaia <yuval.shaia@oracle.com>, virtualization@lists.linux-foundation.org, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


> 
> On Wed, Jul 10, 2019 at 11:28:32PM +0530, Pankaj Gupta wrote:
> > This patch fixes below sparse warning related to __virtio
> > type in virtio pmem driver. This is reported by Intel test
> > bot on linux-next tree.
> > 
> > nd_virtio.c:56:28: warning: incorrect type in assignment
> > 				(different base types)
> > nd_virtio.c:56:28:    expected unsigned int [unsigned] [usertype] type
> > nd_virtio.c:56:28:    got restricted __virtio32
> > nd_virtio.c:93:59: warning: incorrect type in argument 2
> > 				(different base types)
> > nd_virtio.c:93:59:    expected restricted __virtio32 [usertype] val
> > nd_virtio.c:93:59:    got unsigned int [unsigned] [usertype] ret
> > 
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> > 
> > This fixes a warning, so submitting it as a separate
> > patch on top of virtio pmem series.
> > 
> >  include/uapi/linux/virtio_pmem.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/uapi/linux/virtio_pmem.h
> > b/include/uapi/linux/virtio_pmem.h
> > index efcd72f2d20d..7a7435281362 100644
> > --- a/include/uapi/linux/virtio_pmem.h
> > +++ b/include/uapi/linux/virtio_pmem.h
> > @@ -10,7 +10,7 @@
> >  #ifndef _UAPI_LINUX_VIRTIO_PMEM_H
> >  #define _UAPI_LINUX_VIRTIO_PMEM_H
> >  
> > -#include <linux/types.h>
> > +#include <linux/virtio_types.h>
> >  #include <linux/virtio_ids.h>
> >  #include <linux/virtio_config.h>
> >  
> > @@ -23,12 +23,12 @@ struct virtio_pmem_config {
> >  
> >  struct virtio_pmem_resp {
> >  	/* Host return status corresponding to flush request */
> > -	__u32 ret;
> > +	__virtio32 ret;
> >  };
> >  
> >  struct virtio_pmem_req {
> >  	/* command type */
> > -	__u32 type;
> > +	__virtio32 type;
> >  };
> >  
> >  #endif
> 
> Same comment as previously: pls use __le and fix accessors.

Now, I think I got it. 

__virtio is for legacy devices to solve the endianess. 
By default virtio 1.0 and later are little endian.
Will send updated patch soon.

Thank you,
Pankaj

> 
> > --
> > 2.20.1
> 
