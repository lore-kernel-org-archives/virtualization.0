From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch/tile: add /proc/tile, /proc/sys/tile,
	and a sysfs cpu attribute
Date: Wed, 25 May 2011 22:34:30 +0200
Message-ID: <201105252234.30808.arnd__3980.4522916258$1306356585$gmane$org@arndb.de>
References: <201105181807.p4II7C5g015224@farm-0002.internal.tilera.com>
	<201105252220.23948.arnd@arndb.de> <4DDD6729.7070201@tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4DDD6729.7070201@tilera.com>
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

On Wednesday 25 May 2011 22:31:37 Chris Metcalf wrote:
> On 5/25/2011 4:20 PM, Arnd Bergmann wrote:
> > On Wednesday 25 May 2011 21:18:05 Chris Metcalf wrote:
> >> The contents of the hardwall ID file are then just a cpulist of the cpus
> >> covered by the hardwall, rather than introducing a new convention (as
> >> quoted above, e.g. "2x2 1,1").  Individual tasks that are in the hardwall
> >> can be found by reading the "hardwall" files, and we can learn where they
> >> are bound in the hardwall by reading the "stat" file as is normal for
> >> learning process affinity.
> > Be careful with listing PID values in the hardwall files, as the PIDs
> > may not be unique or visible if you combine this with PID name spaces.
> > I guess the right solution would be to only list the tasks that are
> > present in the name space of the thread reading the file.
> 
> Sorry not to be clearer -- I am no longer listing any PID values in the
> hardwall files, for that exact reason.  You have to look at
> /proc/*/hardwall (or /proc/*/tasks/*/hardwall) to find the files that are
> in a particular hardwall.  This pattern is not one that's normally directly
> useful, though, so I'm happy leaving it to userspace if it's desired.

Ok, thanks for the clarification.

	Arnd
