From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] [virt] virtio-blk: Use ida to allocate disk index
Date: Thu, 9 Jun 2011 11:14:33 +0200
Message-ID: <20110609091433.GB11773__32379.332293249$1307610936$gmane$org@htj.dyndns.org>
References: <1306913069-23637-1-git-send-email-dwu@redhat.com>
	<87mxi1xfz0.fsf@rustcorp.com.au> <4DEF744D.9040702@redhat.com>
	<87mxhrgba6.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87mxhrgba6.fsf@rustcorp.com.au>
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
Cc: Jens Axboe <axboe@kernel.dk>, Mark Wu <dwu@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hello,

On Thu, Jun 09, 2011 at 08:51:05AM +0930, Rusty Russell wrote:
> On Wed, 08 Jun 2011 09:08:29 -0400, Mark Wu <dwu@redhat.com> wrote:
> > Hi Rusty,
> > Yes, I can't figure out an instance of disk probing in parallel either, but as
> > per the following commit, I think we still need use lock for safety. What's your opinion?
> > 
> > commit 4034cc68157bfa0b6622efe368488d3d3e20f4e6
> > Author: Tejun Heo <tj@kernel.org>
> > Date:   Sat Feb 21 11:04:45 2009 +0900
> > 
> >     [SCSI] sd: revive sd_index_lock
> > 
> >     Commit f27bac2761cab5a2e212dea602d22457a9aa6943 which converted sd to
> >     use ida instead of idr incorrectly removed sd_index_lock around id
> >     allocation and free.  idr/ida do have internal locks but they protect
> >     their free object lists not the allocation itself.  The caller is
> >     responsible for that.  This missing synchronization led to the same id
> >     being assigned to multiple devices leading to oops.
> 
> I'm confused.  Tejun, Greg, anyone can probes happen in parallel?
> 
> If so, I'll have to review all my drivers.

Unless async is explicitly used, probe happens sequentially.  IOW, if
there's no async_schedule() call, things won't happen in parallel.
That said, I think it wouldn't be such a bad idea to protect ida with
spinlock regardless unless the probe code explicitly requires
serialization.

Thanks.

-- 
tejun
