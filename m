From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch/tile: add /proc/tile, /proc/sys/tile,
	and a sysfs cpu attribute
Date: Fri, 20 May 2011 21:59:50 +0200
Message-ID: <201105202159.50780.arnd__13994.5957846523$1305921647$gmane$org@arndb.de>
References: <201105181807.p4II7C5g015224@farm-0002.internal.tilera.com>
	<4DD6821F.6060707@tilera.com> <201105201713.25364.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201105201713.25364.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 20 May 2011 17:13:25 Arnd Bergmann wrote:
> On Friday 20 May 2011 17:00:47 Chris Metcalf wrote:
> > > Any chance you can still restructure the information? I would recommend
> > > making it a first-class procfs member, since the data is really per-task.
> > >
> > > You can add a conditional entry to tgid_base_stuff[] in fs/proc/base.c
> > > to make it show up for each pid, and then just have the per-task information
> > > in there to do the lookup the other way round:
> > >
> > > # cat /proc/484/hardwall
> > > 2x2 1,1 @2,1
> > >
> > > # cat /proc/479/hardwall
> > > 2x2 1,1 @1,1
> > 
> > It's not unreasonable to do what you're suggesting, i.e. "what's this
> > task's hardwall?", but it's not something that we've come up with any kind
> > of use case for in the past, so I'm not currently planning to implement
> > this.  If we did, I agree, your solution looks like the right one.
> 
> It's fairly easy to aggregate in user space though, we do similar
> things for 'lsof' and 'top', which walk all of procfs in order
> to show the complete picture. This is obviously more overhead than
> walking the lists in the kernel, but still not an expensive
> operation, and it keeps the data format much simpler.

Another problem with the existing interface is that it doesn't currently
support PID name spaces. That could of course be retrofitted, but having
the data split by pid directory would make it work implicitly.

Another approach would be to have a /proc/hardwall/ directory with
one entry per hardwall instance, and symlinks from /proc/<pid>/hardwall
to the respective file.

	Arnd
