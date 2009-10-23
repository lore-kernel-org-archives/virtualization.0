From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: INDIRECT and NEXT
Date: Fri, 23 Oct 2009 08:36:48 +0200
Message-ID: <20091023063648.GC10821@redhat.com>
References: <20091004143734.GB17578@redhat.com>
	<200910191304.20748.rusty@rustcorp.com.au>
	<20091022093745.GA27765@redhat.com>
	<200910231401.24419.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200910231401.24419.rusty@rustcorp.com.au>
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
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 23, 2009 at 02:01:23PM +1030, Rusty Russell wrote:
> On Thu, 22 Oct 2009 08:07:45 pm Michael S. Tsirkin wrote:
> > Imagine an indirect entry where NEXT bit is also set.
> 
> Hmm, so it's not obvious whether the kvm userspace code handles it
> correctly either.

You mean qemu? I think it doesn't, either: code there looks basically
like lguest.

> Want to hack something up to use NEXT + INDIRECT, then we can actually test
> it?  If it doesn't work, this will have to be a new feature bit.
> 
> Also, we have a limitation that you can't have more descriptors than the ring
> size, even with indirect, due to overzealous checks...

Yes ... so I wonder: do we want to fix all this and add a feature bit,
or wait until some guest actually wants to use such descriptors?
For vhost, I implemented INDIRECT without this limitation
since it looked neater to me to have a separate function for indirect
anyway. This is because direct virtqueues are virtually contigious,
so I can access them just by copy from user, but indirect
can be spread around and so I have to go through extra translations.

> Thanks,
> Rusty.
