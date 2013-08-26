From: Kent Overstreet <kmo@daterainc.com>
Subject: Re: [PATCH-v3 1/4] idr: Percpu ida
Date: Mon, 26 Aug 2013 13:14:37 -0700
Message-ID: <20130826201437.GA13621__41789.478591136$1377548088$gmane$org@kmo-pixel>
References: <1376694549-20609-1-git-send-email-nab@linux-iscsi.org>
	<1376694549-20609-2-git-send-email-nab@linux-iscsi.org>
	<20130820143157.f91bf59d16352989b54e431e@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130820143157.f91bf59d16352989b54e431e@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Andi Kleen <andi@firstfloor.org>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, lkml <linux-kernel@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, target-devel <target-devel@vger.kernel.org>, Christoph Lameter <cl@gentwo.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 20, 2013 at 02:31:57PM -0700, Andrew Morton wrote:
> On Fri, 16 Aug 2013 23:09:06 +0000 "Nicholas A. Bellinger" <nab@linux-iscsi.org> wrote:
> 
> > From: Kent Overstreet <kmo@daterainc.com>
> > 
> > Percpu frontend for allocating ids. With percpu allocation (that works),
> > it's impossible to guarantee it will always be possible to allocate all
> > nr_tags - typically, some will be stuck on a remote percpu freelist
> > where the current job can't get to them.
> > 
> > We do guarantee that it will always be possible to allocate at least
> > (nr_tags / 2) tags - this is done by keeping track of which and how many
> > cpus have tags on their percpu freelists. On allocation failure if
> > enough cpus have tags that there could potentially be (nr_tags / 2) tags
> > stuck on remote percpu freelists, we then pick a remote cpu at random to
> > steal from.
> > 
> > Note that there's no cpu hotplug notifier - we don't care, because
> > steal_tags() will eventually get the down cpu's tags. We _could_ satisfy
> > more allocations if we had a notifier - but we'll still meet our
> > guarantees and it's absolutely not a correctness issue, so I don't think
> > it's worth the extra code.
> >
> > ...
> >
> >  include/linux/idr.h |   53 +++++++++
> >  lib/idr.c           |  316 +++++++++++++++++++++++++++++++++++++++++++++++++--
> 
> I don't think this should be in idr.[ch] at all.  It has no
> relationship with the existing code.  Apart from duplicating its
> functionality :(

Well, in the full patch series it does make use of the non-percpu ida.
I'm still hoping to get the ida/idr rewrites in.
