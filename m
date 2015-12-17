From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_ring: use smp_store_mb
Date: Thu, 17 Dec 2015 16:43:53 +0200
Message-ID: <20151217164343-mutt-send-email-mst__25911.9007656865$1450363463$gmane$org@redhat.com>
References: <1450347932-16325-1-git-send-email-mst@redhat.com>
	<20151217105238.GA6375@twins.programming.kicks-ass.net>
	<20151217131554-mutt-send-email-mst@redhat.com>
	<20151217135726.GA6344@twins.programming.kicks-ass.net>
	<20151217161124-mutt-send-email-mst@redhat.com>
	<20151217143910.GD6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20151217143910.GD6344@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 17, 2015 at 03:39:10PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 17, 2015 at 04:33:44PM +0200, Michael S. Tsirkin wrote:
> > On Thu, Dec 17, 2015 at 02:57:26PM +0100, Peter Zijlstra wrote:
> > > 
> > > You could of course go fix that instead of mutilating things into
> > > sort-of functional state.
> > 
> > Yes, we'd just need to touch all architectures, all for
> > the sake of UP which almost no one uses.
> > Basically, we need APIs that explicitly are
> > for talking to another kernel on a different CPU on
> > the same SMP system, and implemented identically
> > between CONFIG_SMP and !CONFIG_SMP on all architectures.
> > 
> > Do you think this is something of general usefulness,
> > outside virtio?
> 
> I'm not aware of any other case, but if there are more parts of virt
> that need this then I see no problem adding it.
> 
> That is, virt in general is the only use-case that I can think of,
> because this really is an artifact of interfacing with an SMP host while
> running an UP kernel.
> 
> But I'm really not familiar with virt, so I do not know if there's more
> sites outside of virtio that could use this.
> 
> Touching all archs is a tad tedious, but its fairly straight forward.

Thanks, will take a stub at this.
