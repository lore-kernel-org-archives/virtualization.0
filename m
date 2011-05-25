From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH] arch/tile: add /proc/tile, /proc/sys/tile, and a sysfs
	cpu attribute
Date: Wed, 25 May 2011 15:17:09 -0400
Message-ID: <4DDD55B5.6000804@tilera.com>
References: <201105181807.p4II7C5g015224@farm-0002.internal.tilera.com>
	<4DD6821F.6060707@tilera.com> <201105201713.25364.arnd@arndb.de>
	<201105202159.50780.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8609890597114798286=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201105202159.50780.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============8609890597114798286==
Content-Type: multipart/alternative;
	boundary="------------060008020307080601000906"

--------------060008020307080601000906
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

(Resending after marking LKML in my Thunderbird address book for "no HTML".)

On 5/20/2011 3:59 PM, Arnd Bergmann wrote:
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
> Another problem with the existing interface is that it doesn't currently
> support PID name spaces. That could of course be retrofitted, but having
> the data split by pid directory would make it work implicitly.
>
> Another approach would be to have a /proc/hardwall/ directory with
> one entry per hardwall instance, and symlinks from /proc/<pid>/hardwall
> to the respective file.

I went ahead and implemented this, and will send out a v2 patch shortly.  I
added the "hardwall" entry to both the tgid_base (since everything is
reflected there) but also to the tid_base_stuff[], since it can be
different (in principle) for different threads.

I played around with using a symlink, but the bottom line seems to be that
if I make it a symlink (via a SYM() macro in the table) it always has to
exist -- so what does it point to when there's no hardwall activated?  I
tried making it point to /dev/null, but that just seemed silly.  In the end
I made /proc/PID/hardwall a file, either empty, or else containing the
hardwall id.

The actual hardwalls are then in /proc/tile/hardwall/NN, where NN is the
hardwall id.  I wrote a very simple hardwall id allocate/free pair; the pid
allocator seemed too tied to task_structs.  We only need at most NR_CPUS
hardwall ids, so it's pretty simple to just use a cpumask to hold the set
of allocated hardwall IDs.

The contents of the hardwall ID file are then just a cpulist of the cpus
covered by the hardwall, rather than introducing a new convention (as
quoted above, e.g. "2x2 1,1").  Individual tasks that are in the hardwall
can be found by reading the "hardwall" files, and we can learn where they
are bound in the hardwall by reading the "stat" file as is normal for
learning process affinity.

> When you do a /sys/hypervisor/ interface, put everything into a subdirectory
> under /sys/hypervisor with the name of your hypervisor, to avoid naming
> conflicts, e.g.
>
> /sys/hypervisor/tilera-hv/board/board_serial

I don't see an easy way to put a directory in /sys/hypervisor.  It seems
complex to create a kobject and a suitable class, etc., just for a
subdirectory.  Or is there something simple I'm missing?  I'll keep looking.

I also suspect just "tile" is an adequate subdirectory name here in the
context of /sys/hypervisor, e.g. /sys/hypervisor/tile/version.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com


--------------060008020307080601000906
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=ISO-8859-1">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    (Resending after marking LKML in my Thunderbird address book for "no
    HTML".)<br>
    <br>
    On 5/20/2011 3:59 PM, Arnd Bergmann wrote:<br>
    <blockquote cite="mid:201105202159.50780.arnd@arndb.de" type="cite">
      <pre wrap="">Any chance you can still restructure the information? I would recommend
making it a first-class procfs member, since the data is really per-task.

You can add a conditional entry to tgid_base_stuff[] in fs/proc/base.c
to make it show up for each pid, and then just have the per-task information
in there to do the lookup the other way round:

# cat /proc/484/hardwall
2x2 1,1 @2,1

# cat /proc/479/hardwall
2x2 1,1 @1,1
</pre>
      <pre wrap="">Another problem with the existing interface is that it doesn't currently
support PID name spaces. That could of course be retrofitted, but having
the data split by pid directory would make it work implicitly.

Another approach would be to have a /proc/hardwall/ directory with
one entry per hardwall instance, and symlinks from /proc/&lt;pid&gt;/hardwall
to the respective file.
</pre>
    </blockquote>
    <br>
    I went ahead and implemented this, and will send out a v2 patch
    shortly.&nbsp; I added the "hardwall" entry to both the tgid_base (since
    everything is reflected there) but also to the tid_base_stuff[],
    since it can be different (in principle) for different threads.<br>
    <br>
    I played around with using a symlink, but the bottom line seems to
    be that if I make it a symlink (via a SYM() macro in the table) it
    always has to exist -- so what does it point to when there's no
    hardwall activated?&nbsp; I tried making it point to /dev/null, but that
    just seemed silly.&nbsp; In the end I made /proc/PID/hardwall a file,
    either empty, or else containing the hardwall id.<br>
    <br>
    The actual hardwalls are then in /proc/tile/hardwall/NN, where NN is
    the hardwall id.&nbsp; I wrote a very simple hardwall id allocate/free
    pair; the pid allocator seemed too tied to task_structs.&nbsp; We only
    need at most NR_CPUS hardwall ids, so it's pretty simple to just use
    a cpumask to hold the set of allocated hardwall IDs.<br>
    <br>
    The contents of the hardwall ID file are then just a cpulist of the
    cpus covered by the hardwall, rather than introducing a new
    convention (as quoted above, e.g. "2x2 1,1").&nbsp; Individual tasks that
    are in the hardwall can be found by reading the "hardwall" files,
    and we can learn where they are bound in the hardwall by reading the
    "stat" file as is normal for learning process affinity.<br>
    <br>
    <blockquote type="cite">
      <pre wrap="">When you do a <i class="moz-txt-slash"><span class="moz-txt-tag">/</span>sys/hypervisor<span class="moz-txt-tag">/</span></i> interface, put everything into a subdirectory
under /sys/hypervisor with the name of your hypervisor, to avoid naming
conflicts, e.g.

/sys/hypervisor/tilera-hv/board/board_serial
</pre>
    </blockquote>
    <br>
    I don't see an easy way to put a directory in /sys/hypervisor.&nbsp; It
    seems complex to create a kobject and a suitable class, etc., just
    for a subdirectory.&nbsp; Or is there something simple I'm missing?&nbsp; I'll
    keep looking.<br>
    <br>
    I also suspect just "tile" is an adequate subdirectory name here in
    the context of /sys/hypervisor, e.g. /sys/hypervisor/tile/version.<br>
    <pre class="moz-signature" cols="75">-- 
Chris Metcalf, Tilera Corp.
<a class="moz-txt-link-freetext" href="http://www.tilera.com">http://www.tilera.com</a></pre>
  </body>
</html>

--------------060008020307080601000906--

--===============8609890597114798286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============8609890597114798286==--
