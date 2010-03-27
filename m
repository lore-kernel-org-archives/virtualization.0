From: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC] GSoC 2010: Memory Compression for Virtualized Environments
Date: Sat, 27 Mar 2010 10:01:32 +0100
Message-ID: <9583F974-0EA0-40E2-9285-C04ECA395FC1__29019.4759298631$1269680551$gmane$org@suse.de>
References: <4BADB612.4010408@vflare.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4BADB612.4010408@vflare.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: ngupta@vflare.org
Cc: KVM development list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 27.03.2010, at 08:38, Nitin Gupta wrote:

> Hi,
> 
> I will be applying to GSoC 2010 under The Linux Foundation as mentoring
> organization (Virtualization working group). Below is the application for my
> planned project: "Memory Compression for Virtualized Environments"
> (according to LF template). I would be thankful for any comments/feedback.
> 
> * Name
> 
> Nitin Gupta
> 
> * University / current enrollment
> 
> University of Massachusetts Amherst
> 
> * Short bio / overview of your background
> 
> I'm currently enrolled in MS (computer science) program at UMass Amherst and
> have 3+ years of experience fixing memory related issues in some proprietary
> kernel. I have also made contributions to the Linux kernel and Xen.
> 
> * Subscribe to the mailing list of the appropriate group and introduce yourself
> 
> Subscribed to: virtualization at lists dot linux-foundation.org
> 
> * Tell us your IRC nick with which you will use the group's IRC channel
> 
> IRC nick: ngupta (irc.oftc.net #virt)
> 
> * What platform do you use to code? Hardware specifications and OS
> 
> Linux kernel development on x86 and x86_x64.
> 
> * Did you ever code in C or C++/Perl/python/..., yes/no? what is your
> experience?
> 
> Excellent C skills - programming in C since 5+ years (as hobby and
> professionally).

s/since/for/

> 
> * If you apply for a project on our ideas list, have you experience in the
> areas listed under "Desired knowledge"?
> 
> This is not in ideas list but have worked extensively in all areas related to
> this project.
> 
> * Were you involved in development in the project's group in the past?
> What was your contribution?
> 
> I have made contributions to the Linux kernel in general:
> - Ported LZO de/compressor to kernel.
> - Developed in-memory compressed swap device (compcache/ramzswap) over a
> period of 3 years. This includes a memory allocator called xvmalloc developed
> from scratch. It is now included in mainline as a staging driver and is
> already part of Ubuntu and (unofficial) builds of Google Android:
> http://code.google.com/p/compcache/
> - Fixed d-cache aliasing problem on ARM. Same problem found and fixed on MIPS
> and Sparc64.
> - Pointed out of-by-one error in swapon syscall implementation. Fixed by
> Hugh Dickins in 2.6.33.
> - Implemented experimental patch for CIFS VFS implementation on kernel 2.6.8
> to send multiple read requests in parallel (http://linux-mm.org/NitinGupta)
> 
> * Were you involved in other OpenSource development projects in the past?
> which, when and in what role?
> 
> - Ported to kernel and extended TLSF allocator
> allocator (http://rtportal.upv.es/rtmalloc/) with support for multiple
> memory pools. This has replaced Xen's default xmalloc allocator.
> - Currently developing small IDE especially suited for large C based projects
> like the Linux kernel: http://code.google.com/p/kxref/ (low priority)
> 
> * Why have you chosen your development idea and what do you expect from
> your implementation?
> 
> I have been working on the idea of memory compression for about 3 years (part
> time) resulting in development of ramzswap driver which provides in-memory
> compressed swap devices. This approch simplified the development however it
> has some serious disadvantages:
> - It cannot compress page-cache pages
> - It incurs block I/O layer overhead
> - It requires curious hooks in block layer to function properly:
> http://lkml.org/lkml/2010/1/4/534 which were later Nacked by Linus.
> - The approach makes it difficult to implement dynamic cache resizing (though
> you can dynamically add/remove ramzswap devices of arbitrary size).
> 
> So, this GSoC project aims to provide a new approach for achieving memory
> compression that solves all above issues: cleanly hook into reclaim path
> directly, providing both swap and pagecache compression, avoiding all block I/O
> overhead.
> 
> Project motivation, design and implementation details are present in this
> document:
> www.scribd.com/doc/28713197/Memory-Compression-for-Virtualized-Environments

Very interesting project.

I'm not 100% sure it's a good idea to waste CPU time on page cache compression, but then again I guess with 64-core systems coming up CPU power is a lot cheaper than I/O. You should definitely keep NUMA in mind while doing this though. The target systems for this certainly aren't single node systems ;-).

Another thing that I realized while reading through this is that I'm missing the virtualization link. You do explain it in the introduction, but I certainly fail to see why this should be limited to virtualization. It'd improve swapping penalty in general.

Either way, I'm eager to see this get accepted :-).


Alex
