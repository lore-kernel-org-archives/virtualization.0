From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/5] Add vhost-blk support
Date: Tue, 17 Jul 2012 13:49:20 +0300
Message-ID: <20120717104920.GJ7949@redhat.com>
References: <1342107302-28116-1-git-send-email-asias@redhat.com>
	<CAJSP0QWgmXns89se+xdGgM6i1_hsfVWPQ8caHua9d-dDA4CTDQ@mail.gmail.com>
	<50052276.2080906@redhat.com> <500527BA.9000001@redhat.com>
	<20120717094526.GC7949@redhat.com> <50053B09.2060703@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <50053B09.2060703@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-aio@kvack.org, target-devel@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Anthony Liguori <anthony@codemonkey.ws>, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 17, 2012 at 12:14:33PM +0200, Paolo Bonzini wrote:
> Il 17/07/2012 11:45, Michael S. Tsirkin ha scritto:
> >> So it begs the question, is it going to be used in production, or just a
> >> useful reference tool?
> > 
> > Sticking to raw already makes virtio-blk faster, doesn't it?
> > In that vhost-blk looks to me like just another optimization option.
> > Ideally I think user just should not care where do we handle virtio:
> > in-kernel or in userspace.  One can imagine it being enabled/disabled
> > automatically if none of the features unsupported by it are used.
> 
> Ok, that would make more sense.  One difference between vhost-blk and
> vhost-net is that for vhost-blk there are also management actions that
> would trigger the switch, for example a live snapshot.
> So a prerequisite for vhost-blk would be that it is possible to disable
> it on the fly while the VM is running, as soon as all in-flight I/O is
> completed.

It applies for vhost-net too. For example if you bring link down,
we switch to userspace. So vhost-net supports this switch on the fly.

> (Note that, however, this is not possible for vhost-scsi,
> because it
> really exposes different hardware to the guest.  It must not happen that
> a kernel upgrade or downgrade toggles between userspace SCSI and
> vhost-scsi, for example).

I would say this is not a prerequisite for merging in qemu.
It might be a required feature for production but it
is also solvable at the management level.

Imagine an "enable-live-snapshots" flag in libvirt, on by default.
Can only be changed while guest is down. If you turn it off,
you get a bit more speed since vhost-blk/vhost-scsi gets enabled.
Also pls note that a backend can support live snapshots.
If it does libvirt thinkably could detect that
and enable vhost-scsi even with enable-live-snapshots on.

> >> having to
> >> support the API; having to handle transition from one more thing when
> >> something better comes out.
> > 
> > Well this is true for any code. If the limited featureset which
> > vhost-blk can accelerate is something many people use, then accelerating
> > by 5-15% might outweight support costs.
> 
> It is definitely what people use if they are interested in performance.
> 
> Paolo

In that case it seems to me we should stop using the featureset as
an argument and focus on whether the extra code is worth the 5-15% gain.
No one seems to have commented on that so everyone on list thinks that
aspect is OK? Any explicit ACKs?

Kernel merge windows is coming up and I would like to see whether
any of vhost-blk / vhost-scsi is going to be actually used by userspace.
I guess we could tag it for staging but would be nice to avoid that.

-- 
MST
