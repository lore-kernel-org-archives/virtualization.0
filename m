From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [RFC PATCH] virtio: change config to guest endian.
Date: Thu, 24 Apr 2008 01:53:41 +1000
Message-ID: <200804240153.42251.rusty@rustcorp.com.au>
References: <200804221357.34571.rusty@rustcorp.com.au>
	<200804231255.50248.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804231255.50248.borntraeger@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel@lists.sourceforge.net, Hollis Blanchard <hollisb@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 23 April 2008 20:55:50 Christian Borntraeger wrote:
> Am Dienstag, 22. April 2008 schrieb Rusty Russell:
> [...]
>
> > diff -r a098f19a6da5 include/linux/virtio_config.h
> > --- a/include/linux/virtio_config.h	Sun Apr 20 14:41:02 2008 +1000
> > +++ b/include/linux/virtio_config.h	Sun Apr 20 15:07:45 2008 +1000
> > @@ -16,7 +16,7 @@
> >  #define VIRTIO_CONFIG_S_FAILED		0x80
> >
> >  #ifdef __KERNEL__
> > -struct virtio_device;
> > +#include <linux/virtio.h>
>
> I just realized, that this breaks make headers_check as we dont export
> virtio.h (and we dont want to export it as it relies on scatterlist.h).

It's under #ifdef __KERNEL__ though?

Cheers,
Rusty.
