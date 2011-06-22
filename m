From: Gleb Natapov <gleb@redhat.com>
Subject: Re: Make virtio vq size configurable by a guest.
Date: Wed, 22 Jun 2011 13:21:23 +0300
Message-ID: <20110622102123.GG491@redhat.com>
References: <20110620131624.GZ491@redhat.com> <878vswhrhf.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <878vswhrhf.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 21, 2011 at 11:32:04AM +0930, Rusty Russell wrote:
> On Mon, 20 Jun 2011 16:16:24 +0300, Gleb Natapov <gleb@redhat.com> wrote:
> > Hi,
> > 
> > Currently in virtio host dictates the size and layout of vq that should
> > be used.  To talk to a device that has one vq with 128 elements guest
> > needs to allocate at least 2 pages. Usually this is not a problem, but
> > sometimes guest runs in a resource restricted environment and then it may
> > not have enough memory to initialize all virtio devices present in the
> > system. One such environment is a BIOS. Seabios currently has virtio block
> > support. Since the BIOS should be able to access the disk even after OS
> > is launched vq should be allocated from a special memory region that will
> > be marked as unavailable to an OS, but such memory is scarce. Because vq
> > is so huge only a couple of virtio disks can be initialized by the BIOS.
> > 
> > It would be nice if a guest will be able to tell to a host what vq size
> > should be used instead. BIOS issues only one request at a time anyway,
> > so it needs only one element in vq. It does not care about performance
> > to much either, so it can tell to a host to not align used index to a
> > page boundary. This way vq of one element shouldn't take more then a couple
> > hundreds of bytes.
> 
> Unfortunately, a virtqueue *always* takes at least 2 pages.  That's
> because we split the host/guest part on page boundaries.  (2 pages per
> disk is "huge"?  Really?)
> 
"Huge" only for a BIOS environment, not when normal guest is running. The
problem is those two pages should be allocated from a memory that is
marked as reserved in e820 map since the queue has to be active after
BIOS passes control to an OS. Currently Seabios reserve up to 64K for this
memory pool (memory that is not actually allocated is not marked as
reserved in e820).

> So really, you want to negotiate the ring size and the 'align'
> parameter.  A new feature could allow this, but there may be valid
> reasons for a host to want to place an upper limit, too.
> 
What kind of reason can it be except performance? AFAIK KVM does not have such
restrictions.

--
			Gleb.
