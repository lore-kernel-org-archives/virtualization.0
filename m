From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH] arch/tile: add /proc/tile, /proc/sys/tile, and a sysfs
	cpu attribute
Date: Wed, 25 May 2011 16:31:37 -0400
Message-ID: <4DDD6729.7070201__7166.29972816936$1306355631$gmane$org@tilera.com>
References: <201105181807.p4II7C5g015224@farm-0002.internal.tilera.com>
	<201105202159.50780.arnd@arndb.de> <4DDD55ED.2080607@tilera.com>
	<201105252220.23948.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201105252220.23948.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 5/25/2011 4:20 PM, Arnd Bergmann wrote:
> On Wednesday 25 May 2011 21:18:05 Chris Metcalf wrote:
>> The contents of the hardwall ID file are then just a cpulist of the cpus
>> covered by the hardwall, rather than introducing a new convention (as
>> quoted above, e.g. "2x2 1,1").  Individual tasks that are in the hardwall
>> can be found by reading the "hardwall" files, and we can learn where they
>> are bound in the hardwall by reading the "stat" file as is normal for
>> learning process affinity.
> Be careful with listing PID values in the hardwall files, as the PIDs
> may not be unique or visible if you combine this with PID name spaces.
> I guess the right solution would be to only list the tasks that are
> present in the name space of the thread reading the file.

Sorry not to be clearer -- I am no longer listing any PID values in the
hardwall files, for that exact reason.  You have to look at
/proc/*/hardwall (or /proc/*/tasks/*/hardwall) to find the files that are
in a particular hardwall.  This pattern is not one that's normally directly
useful, though, so I'm happy leaving it to userspace if it's desired.

>>> When you do a /sys/hypervisor/ interface, put everything into a subdirectory
>>> under /sys/hypervisor with the name of your hypervisor, to avoid naming
>>> conflicts, e.g.
>>>
>>> /sys/hypervisor/tilera-hv/board/board_serial
> I just checked for other users. The only one I could find was
> drivers/xen/sys-hypervisor.c, and it also doesn't use a subdirectory to
> identify that hypervisor. It's probably more consistent if you also don't
> do it then.
>
> You can create a directory with multiple files using sysfs_create_group()
> as the xen code does, but not nested directories.

I'll look into sysfs_create_group(), and then send a revised patch with all
the /proc and /sys changes.  Thanks!

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
