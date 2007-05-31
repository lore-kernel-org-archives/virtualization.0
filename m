From: "Dor Laor" <dor.laor@qumranet.com>
Subject: RE: [kvm-devel] [PATCH RFC 1/3] virtio infrastructure
Date: Thu, 31 May 2007 06:01:35 -0700
Message-ID: <64F9B87B6B770947A9F8391472E032160C0EFE7C__31871.0119034678$1180616544$gmane$org@ehost011-8.exch011.intermedia.net>
References: <1180613947.11133.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <1180613947.11133.58.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, Xen Mailing List <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, jmk@plan9.bell-labs.com, Herbert Xu <herbert@gondor.apana.org.au>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

>This attempts to implement a "virtual I/O" layer which should allow
>common drivers to be efficiently used across most virtual I/O
>mechanisms.  It will no-doubt need further enhancement.
>
>The details of probing the device are left to hypervisor-specific
>code: it simple constructs the "struct virtio_device" and hands it to
>the probe function (eg. virtnet_probe() or virtblk_probe()).
>
>The virtio drivers add and detach input and output buffers; as the
>buffers are used up their associated "used" pointers are filled in.
>
>I have written two virtio device drivers (net and block) and two
>virtio implementations (for lguest): a read-write socket-style
>implementation, and a more efficient descriptor-based implementation).
>
>Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

That's the exact things I was planning to add to KVM/Linux.
All virtual I/O devices should have common interface and share the core
functionality. Since Xen PV drivers are already performance optimized
and 
feature rich, we were planning to generalize the hypervisor-specific
backend in order to reuse them.
This is a good step toward such sharing.
Cheers, Dor.
