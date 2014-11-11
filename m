From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: TUN_F_UFO change breaks live migration
Date: Tue, 11 Nov 2014 17:57:50 +0200
Message-ID: <20141111155750.GA17418@redhat.com>
References: <20141111105849.GA8482@stefanha-thinkpad.redhat.com>
	<1415708246.3398.88.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1415708246.3398.88.camel@decadent.org.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, jelledejong@powercraft.nl, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 11, 2014 at 12:17:26PM +0000, Ben Hutchings wrote:
> On Tue, 2014-11-11 at 10:58 +0000, Stefan Hajnoczi wrote:
> > Commit 3d0ad09412ffe00c9afa201d01effdb6023d09b4 ("drivers/net: Disable
> > UFO through virtio") breaks live migration of KVM guests from older to
> > newer host kernels:
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3d0ad09412ffe00c9afa201d01effdb6023d09b4
> > 
> > The problem occurs when a guest running on a host kernel without commit
> > 3d0ad0941 in tun.ko attempts to live migration to a host with commit
> > 3d0ad0941.
> > 
> > Live migration fails in QEMU with the following error message:
> > 
> >   virtio-net: saved image requires TUN_F_UFO support
> > 
> > The old host tun.ko advertised support for TUN_F_UFO.  The new host
> > tun.ko does not and that's why QEMU aborts live migration.  QEMU cannot
> > change the features of a running virtio-net device.
> 
> Yes, this is known and was mentioned in the DSA.
> 
> > tuxcrafter provided logs from two Debian hosts migrating from
> > 3.2.60-1+deb7u3 to 3.2.63-2+deb7u1:
> > 
> > http://paste.debian.net/131264/
> > 
> > I haven't investigated enough to suggest a fix, just wanted to bring it
> > to your attention.  Soon a lot of people will be hitting this problem as
> > they upgrade their infrastructure and migrate guests - seems like a
> > critical issue.
> 
> You can work around this by making macvtap and tun still claim to
> support UFO.

If this is what we want userspace to do, let's just put the
feature flag back?


Basically userspace assumed that features will only
ever be added, never removed, so this change is
breaking it.

>  They continue to support it even if it's not advertised
> because the tap features don't reliably get propagated to virtio
> devices.
> 
> Ben.

Hmm I don't understand this last sentence.
features are actually reliably propagated to virtio devices.


> -- 
> Ben Hutchings
> Experience is directly proportional to the value of equipment destroyed.
>                                                          - Carolyn Scheppner
