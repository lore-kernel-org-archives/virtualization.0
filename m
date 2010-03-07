From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PULL] virtio
Date: Sun, 7 Mar 2010 13:04:57 +0200
Message-ID: <20100307110457.GB20004@redhat.com>
References: <20100307104252.GA19926@redhat.com>
	<40B76F19-1E35-4956-A34E-0A83A403F97D@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <40B76F19-1E35-4956-A34E-0A83A403F97D@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: Shirley Ma <mashirle@us.ibm.com>, Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Amit Shah <amit.shah@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Mar 07, 2010 at 11:57:23AM +0100, Alexander Graf wrote:
> 
> On 07.03.2010, at 11:42, Michael S. Tsirkin wrote:
> 
> > Linus,
> > Please pull another virtio fix: this one fixes hotplug and
> > was supposed to be applied by Rusty already
> > (http://lkml.org/lkml/2009/11/30/451), but apparently got lost,
> > somehow.
> > 
> > Thanks!
> > 
> > The following changes since commit 3119815912a220bdac943dfbdfee640414c0c611:
> >  Michael S. Tsirkin (1):
> >        virtio: fix out of range array access
> > 
> > are available in the git repository at:
> > 
> >  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git for-linus
> > 
> > Michael S. Tsirkin (1):
> >      virtio: set pci bus master enable bit
> 
> This is still missing an identifier for the hypervisor. We need to know if the guest will ever set bus master enabled or not, so we can have a compat hack in qemu to not check for it.
> 
> 
> Alex

This patch fixes hotplug with qemu 0.11-0.12 which can't make use of a new
identifier without a time machine.

IMHO we can't add new identifiers in time for 2.6.34 anyway, so if you
want to do that, please send a patch and have it queued up for the next
release. But I don't think we need an identifier for compat hack.
Hypervisor can detect buggy guests when they set status to OK without
enabling bus master first.

Makes sense?


-- 
MST
