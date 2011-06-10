From: "David Laight" <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 7/7] [v5] drivers/virt: introduce Freescale
	hypervisormanagement driver
Date: Fri, 10 Jun 2011 09:32:08 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD8B__10129.1591571227$1307736907$gmane$org@saturn3.aculab.com>
References: <201106092213.13755.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <201106092213.13755.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>, Timur Tabi <timur@freescale.com>, linuxppc-dev@lists.ozlabs.org
Cc: konrad.wilk@oracle.com, greg@kroah.com, kumar.gala@freescale.com, linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-console@vger.kernel.org, virtualization@lists.linux-foundation.org, alan@lxorguk.ukuu.org.uk
List-Id: virtualization@lists.linuxfoundation.org

 
> > +enum fsl_hv_ioctl_cmd {
> > +       FSL_HV_IOCTL_PARTITION_RESTART = _IOWR(0, 1, struct
fsl_hv_ioctl_restart),
...
> > +};
> 
> Using a #define here is usually preferred because then you 
> can use #ifdef in a user application to check if a given
> value has been assigned.

It is also possible to add:
#define FSL_HV_IOCTL_PARTITION_RESTART FSL_HV_IOCTL_PARTITION_RESTART
to have much the same effect.
But there are many cases where #defines are better.
I only tend to use enums when the constanst are beting generated
by the expansion of a #define.

> More importantly, the code you have chose (0) conflicts with 
> existing drivers (frame buffer, scsi and wavefront among others).
> Please chose a free one and
> add it to Documentation/ioctl/ioctl-number.txt in the same patch.

It is rather a PITA that, when 'int' went from 16 to 32 bits, the
BSD people used the high 16 bits for size/flags rather than
using the extra bits to help make ioctl's unique.
Linux seems to have copied BSD here - rather than SYSV.

One problem with clashing ioctl commands is when systems like
NetBSD are running linux binaries and need to translate ioctl
buffers to/from native format. If the ioctl commands are
unique this can be done much more easily.

	David
