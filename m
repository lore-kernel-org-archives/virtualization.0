From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [kvm-devel] [RFC PATCH] virtio: change config to guest endian.
Date: Wed, 23 Apr 2008 14:47:08 +0200
Message-ID: <200804231447.08196.borntraeger__33036.9680691094$1208955074$gmane$org@de.ibm.com>
References: <200804221357.34571.rusty@rustcorp.com.au>
	<200804231255.50248.borntraeger@de.ibm.com>
	<480F2DD5.7080007@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <480F2DD5.7080007@qumranet.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, Hollis Blanchard <hollisb@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Mittwoch, 23. April 2008 schrieb Avi Kivity:
> >>  #define VIRTIO_CONFIG_S_FAILED		0x80
> >>
> >>  #ifdef __KERNEL__
> >> -struct virtio_device;
> >> +#include <linux/virtio.h>
> >>     
> >
> > I just realized, that this breaks make headers_check as we dont export 
> > virtio.h (and we dont want to export it as it relies on scatterlist.h).
> >
> >   
> 
> It's guarded by a #ifdef __KERNEL__, so it should be alright.

Yes, you are right. Thanks
