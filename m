From: Nitin Gupta <ngupta@vflare.org>
Subject: [RFC] GSoC 2010: Memory Compression for Virtualized Environments
Date: Sat, 27 Mar 2010 13:08:58 +0530
Message-ID: <4BADB612.4010408__10644.4959565581$1269675835$gmane$org@vflare.org>
Reply-To: ngupta@vflare.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: KVM development list <kvm@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

I will be applying to GSoC 2010 under The Linux Foundation as mentoring
organization (Virtualization working group). Below is the application for my
planned project: "Memory Compression for Virtualized Environments"
(according to LF template). I would be thankful for any comments/feedback.

* Name

Nitin Gupta

* University / current enrollment

University of Massachusetts Amherst

* Short bio / overview of your background

I'm currently enrolled in MS (computer science) program at UMass Amherst and
have 3+ years of experience fixing memory related issues in some proprietary
kernel. I have also made contributions to the Linux kernel and Xen.

* Subscribe to the mailing list of the appropriate group and introduce yourself

Subscribed to: virtualization at lists dot linux-foundation.org

* Tell us your IRC nick with which you will use the group's IRC channel

IRC nick: ngupta (irc.oftc.net #virt)

* What platform do you use to code? Hardware specifications and OS

Linux kernel development on x86 and x86_x64.

* Did you ever code in C or C++/Perl/python/..., yes/no? what is your
experience?

Excellent C skills - programming in C since 5+ years (as hobby and
professionally).

* If you apply for a project on our ideas list, have you experience in the
areas listed under "Desired knowledge"?

This is not in ideas list but have worked extensively in all areas related to
this project.

* Were you involved in development in the project's group in the past?
What was your contribution?

I have made contributions to the Linux kernel in general:
 - Ported LZO de/compressor to kernel.
 - Developed in-memory compressed swap device (compcache/ramzswap) over a
period of 3 years. This includes a memory allocator called xvmalloc developed
from scratch. It is now included in mainline as a staging driver and is
already part of Ubuntu and (unofficial) builds of Google Android:
http://code.google.com/p/compcache/
 - Fixed d-cache aliasing problem on ARM. Same problem found and fixed on MIPS
and Sparc64.
 - Pointed out of-by-one error in swapon syscall implementation. Fixed by
Hugh Dickins in 2.6.33.
 - Implemented experimental patch for CIFS VFS implementation on kernel 2.6.8
to send multiple read requests in parallel (http://linux-mm.org/NitinGupta)

 * Were you involved in other OpenSource development projects in the past?
which, when and in what role?

 - Ported to kernel and extended TLSF allocator
allocator (http://rtportal.upv.es/rtmalloc/) with support for multiple
memory pools. This has replaced Xen's default xmalloc allocator.
 - Currently developing small IDE especially suited for large C based projects
like the Linux kernel: http://code.google.com/p/kxref/ (low priority)

 * Why have you chosen your development idea and what do you expect from
your implementation?

I have been working on the idea of memory compression for about 3 years (part
time) resulting in development of ramzswap driver which provides in-memory
compressed swap devices. This approch simplified the development however it
has some serious disadvantages:
 - It cannot compress page-cache pages
 - It incurs block I/O layer overhead
 - It requires curious hooks in block layer to function properly:
http://lkml.org/lkml/2010/1/4/534 which were later Nacked by Linus.
 - The approach makes it difficult to implement dynamic cache resizing (though
you can dynamically add/remove ramzswap devices of arbitrary size).

So, this GSoC project aims to provide a new approach for achieving memory
compression that solves all above issues: cleanly hook into reclaim path
directly, providing both swap and pagecache compression, avoiding all block I/O
overhead.

Project motivation, design and implementation details are present in this
document:
www.scribd.com/doc/28713197/Memory-Compression-for-Virtualized-Environments


Your Project

    * What do you want to achieve?

Achieve higher consolidation ratios (more VMs per host) for KVM platform using
memory compression technique at host level. This technique has already been
proven to be useful on desktop and embedded devices. I believe it has great
potential on servers too as virtualization becomes ubiquitous.

    * If you have chosen an idea from our list, why did you choose this
specific idea?

Idea not in list.

    * If you are proposing a project of your own, what is unique about it?

Please see details above.

    * What makes you suited to carry the project?

Several years of experience in Linux kernel development as reflected by
previous and on-going projects.

    * How much time do you plan to invest in the project before, during and
after the Summer of Code (We expect full time 40h/week during GSoC, but better
make this explicit)?

I will be working full-time on this project and plan to continue working till
it gets merged into mainline (and then continue as maintainer)

    * Please provide a schedule of how this time will be spent on subtasks of
the project. While this is only preliminary, you will be required to provide a
detailed plan latest at the beginning of GSoC and during the project you will
issue weekly progress reports against that plan.

Timeline: May to Aug (4 months)

Month 1: Discuss new design with mentor, prototype and finalize on approach
Month 2: Implement swap cache compression
Month 3: Implement page cache compression
Month 4: Dynamic cache resizing


(draft) Project motivation, design and implementation details:
www.scribd.com/doc/28713197/Memory-Compression-for-Virtualized-Environments


Thanks,
Nitin
