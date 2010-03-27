From: Nitin Gupta <ngupta@vflare.org>
Subject: Re: [RFC] GSoC 2010: Memory Compression for Virtualized Environments
Date: Sat, 27 Mar 2010 15:17:02 +0530
Message-ID: <4BADD416.5080807__1847.74045269496$1269683417$gmane$org@vflare.org>
References: <4BADB612.4010408@vflare.org>
	<9583F974-0EA0-40E2-9285-C04ECA395FC1@suse.de>
Reply-To: ngupta@vflare.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <9583F974-0EA0-40E2-9285-C04ECA395FC1@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: KVM development list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 03/27/2010 02:31 PM, Alexander Graf wrote:
> 
> On 27.03.2010, at 08:38, Nitin Gupta wrote:
> 
<snip>

>> So, this GSoC project aims to provide a new approach for achieving memory
>> compression that solves all above issues: cleanly hook into reclaim path
>> directly, providing both swap and pagecache compression, avoiding all block I/O
>> overhead.
>>
>> Project motivation, design and implementation details are present in this
>> document:
>> www.scribd.com/doc/28713197/Memory-Compression-for-Virtualized-Environments
> 
> Very interesting project.
> 
> I'm not 100% sure it's a good idea to waste CPU time on page cache compression, but then again I guess with 64-core systems coming up CPU power is a lot cheaper than I/O. You should definitely keep NUMA in mind while doing this though. The target systems for this certainly aren't single node systems ;-).
> 

The target is certainly large scale systems. For 64-bit etc. crazy machines it might
be worth to even dedicate 1 or 2 cores for de/compression (though not necessary).
Even for desktops, 4 cores are now so common.

Then comes embedded, where other issues also come into picture -- slow random writes
on flash cards, wear-leveling issues, power to de/compress vs writing to flash etc.

I highlighted virtualization since large scale systems (and virtualization workload) are
easily justifiable for this feature :)

> Another thing that I realized while reading through this is that I'm missing the virtualization link. You do explain it in the introduction, but I certainly fail to see why this should be limited to virtualization. It'd improve swapping penalty in general.
> 

It is not limited to virtualization case and it does improve I/O penalty in non-virtualized case too
(as shown by compcache work). I highlighted virtualization only because its looks like an important
use case and benefits of memory compression are yet to be explored in this area.


On a side note: another project proposal I'm going to submit is:
 "Virtual Co-processor: Flexible and Scalable Virtual Machines"
you can see draft of the paper here:
http://www.scribd.com/doc/23978468/Virtual-Co-processors-Flexible-and-Scalable-Virtual-Machines



> Either way, I'm eager to see this get accepted :-).
> 

And I'm eager to start work on this :)


Thanks for your comments.
Nitin
