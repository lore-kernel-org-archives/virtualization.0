From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH] arch/tile: add /proc/tile, /proc/sys/tile, and a sysfs
	cpu attribute
Date: Fri, 20 May 2011 11:00:47 -0400
Message-ID: <4DD6821F.6060707__43083.7681786672$1305903699$gmane$org@tilera.com>
References: <201105181807.p4II7C5g015224@farm-0002.internal.tilera.com>
	<201105191722.17685.arnd@arndb.de> <4DD67A31.90802@tilera.com>
	<201105201637.20925.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201105201637.20925.arnd@arndb.de>
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

On 5/20/2011 10:37 AM, Arnd Bergmann wrote:
> On Friday 20 May 2011 16:26:57 Chris Metcalf wrote:
>>>>>> /proc/tile/hardwall
>>>>>>   Information on the set of currently active hardwalls (note that
>>>>>>   the implementation is already present in arch/tile/kernel/hardwall.c;
>>>>>>   this change just enables it)
> Ah, I see. I didn't notice that it was in the other file. You are
> absolutely right, this does not belong into /sys/hypervisor and
> fits well into procfs, we just need to find the right place.
>> Perhaps in this case it would be reasonable to just have the hardwall
>> subsystem put the file in /proc/driver/hardwall, or even /proc/hardwall? 
>> Or I could make the /dev/hardwall char device dump out the ASCII text that
>> we currently get from /proc/hardwall if you read from it, which is a little
>> weird but not inconceivable.  For example it currently shows things like this:
>>
>> # cat /proc/tile/hardwall
>> 2x2 1,1 pids: 484@2,1 479@1,1
>> 2x2 0,3 pids:
>>
>> In this example "2x2 1,1" is a 2x2 grid of cpus starting at grid (x,y)
>> position (1,1), with task 484 bound to the cpu at (x,y) position (2,1).
> Any chance you can still restructure the information? I would recommend
> making it a first-class procfs member, since the data is really per-task.
>
> You can add a conditional entry to tgid_base_stuff[] in fs/proc/base.c
> to make it show up for each pid, and then just have the per-task information
> in there to do the lookup the other way round:
>
> # cat /proc/484/hardwall
> 2x2 1,1 @2,1
>
> # cat /proc/479/hardwall
> 2x2 1,1 @1,1

It's not unreasonable to do what you're suggesting, i.e. "what's this
task's hardwall?", but it's not something that we've come up with any kind
of use case for in the past, so I'm not currently planning to implement
this.  If we did, I agree, your solution looks like the right one.

The proposed /proc/tile/hardwall really is intended as system-wide
information.  Each hardwall (one line in the output file example above)
corresponds to a "struct file" that may be shared by multiple processes (or
threads).  Processes may pass the "struct file" to other processes via fork
(and maybe exec), or by passing it over Unix sockets.  Then those processes
can choose a cpu within a hardwall rectangle, affinitize to that cpu only,
"activate" the hardwall fd with an ioctl(), and then get access from the OS
so they can work together within a hardwall to exchange data across the
Tilera "user dynamic network" (a wormhole routed grid network that moves
data at 32 bits/cycle with almost no latency).  Processes can create a new
hardwall as long as it doesn't overlap geometrically with any other
existing hardwall on the system.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
