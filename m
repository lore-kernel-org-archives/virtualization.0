From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch/tile: add /proc/tile, /proc/sys/tile,
	and a sysfs cpu attribute
Date: Fri, 20 May 2011 16:37:20 +0200
Message-ID: <201105201637.20925.arnd__966.279340400611$1305902542$gmane$org@arndb.de>
References: <201105181807.p4II7C5g015224@farm-0002.internal.tilera.com>
	<201105191722.17685.arnd@arndb.de> <4DD67A31.90802@tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4DD67A31.90802@tilera.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 20 May 2011 16:26:57 Chris Metcalf wrote:
> >>>> /proc/tile/hardwall
> >>>>   Information on the set of currently active hardwalls (note that
> >>>>   the implementation is already present in arch/tile/kernel/hardwall.c;
> >>>>   this change just enables it)
> >> This one is not a hypervisor-related file.  It just lists information about
> >> the set of Linux hardwalls currently active.  Again, it's not primarily
> >> intended for programmatic use, but as a diagnostic tool.
> > same here, I'd still put it into the hypervisor structure.
> 
> Since /proc/tile/hardwall has no connection to the hypervisor whatsoever,
> I'm reluctant to put it under /sys/hypervisor.

Ah, I see. I didn't notice that it was in the other file. You are
absolutely right, this does not belong into /sys/hypervisor and
fits well into procfs, we just need to find the right place.

> Perhaps in this case it would be reasonable to just have the hardwall
> subsystem put the file in /proc/driver/hardwall, or even /proc/hardwall? 
> Or I could make the /dev/hardwall char device dump out the ASCII text that
> we currently get from /proc/hardwall if you read from it, which is a little
> weird but not inconceivable.  For example it currently shows things like this:
> 
> # cat /proc/tile/hardwall
> 2x2 1,1 pids: 484@2,1 479@1,1
> 2x2 0,3 pids:
> 
> In this example "2x2 1,1" is a 2x2 grid of cpus starting at grid (x,y)
> position (1,1), with task 484 bound to the cpu at (x,y) position (2,1).

Any chance you can still restructure the information? I would recommend
making it a first-class procfs member, since the data is really per-task.

You can add a conditional entry to tgid_base_stuff[] in fs/proc/base.c
to make it show up for each pid, and then just have the per-task information
in there to do the lookup the other way round:

# cat /proc/484/hardwall
2x2 1,1 @2,1

# cat /proc/479/hardwall
2x2 1,1 @1,1

	Arnd
