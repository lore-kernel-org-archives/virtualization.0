From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [git pull] lguest: paravirt boot code
Date: Tue, 23 Oct 2007 08:55:06 +0200
Message-ID: <200710230855.06253.borntraeger__38233.5472073921$1193122716$gmane$org@de.ibm.com>
References: <200710221237.14542.rusty@rustcorp.com.au>
	<alpine.LFD.0.999.0710221927131.30120@woody.linux-foundation.org>
	<200710231603.21620.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200710231603.21620.rusty@rustcorp.com.au>
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
To: virtualization@lists.linux-foundation.org
Cc: lguest <lguest@ozlabs.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag, 23. Oktober 2007 schrieb Rusty Russell:
>=A0=A0=A0=A0=A0=A0=A0=A0git://git.kernel.org/pub/scm/linux/kernel/git/ru=
sty/linux-2.6-lguest.git
> This should be fairly clean: 45 lguest patches including the more gener=
ic
> drivers (aimed to be used by KVM as well, and hopefully others) and the=
 start
> of separation of arch-specific from general lguest code.

>  drivers/net/virtio_net.c              |  435 +++++++++
>  drivers/virtio/Kconfig                |    8 +
>  drivers/virtio/Makefile               |    2 +
>  drivers/virtio/config.c               |   13 +
>  drivers/virtio/virtio.c               |  189 ++++
>  drivers/virtio/virtio_ring.c          |  313 +++++++
>  drivers/block/virtio_blk.c            |  308 +++++++
>  drivers/char/virtio_console.c         |  225 +++++

Having virtio in Linus tree would make my life easier wiring it up for=20
virtualization on s390.

For all virtio patches:

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>


That reminds me that I promised Rusty to look at one small issue in virti=
o
net driver. Nothing that should hold of the merge. I will sent the patch =
via
Rusty when its ready.=20
