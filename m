From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [RFC PATCH] virtio: change config to guest endian.
Date: Wed, 23 Apr 2008 00:31:35 +1000
Message-ID: <200804230031.35760.rusty__25796.8890983195$1208874988$gmane$org@rustcorp.com.au>
References: <200804221357.34571.rusty@rustcorp.com.au>
	<480DCA88.4010407@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <480DCA88.4010407@qumranet.com>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Hollis Blanchard <hollisb@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 22 April 2008 21:22:48 Avi Kivity wrote:
> > The virtio config space was originally chosen to be little-endian,
> > because we thought the config might be part of the PCI config space
> > for virtio_pci.  It's actually a separate mmio region, so that
> > argument holds little water; as only x86 is currently using the virtio
> > mechanism, we can change this (but must do so now, before the
> > impending s390 and ppc merges).
>
> This will probably annoy Hollis which has guests that can go both ways.

Yes, I discussed this with Hollis.  But the virtio rings themselves already 
have this issue: we don't do any endian conversion on them and assume 
they're "our" endian in the guest.

We may still regret not doing *everything* little-endian, but this doesn't 
make it worse.

Thanks,
Rusty.
