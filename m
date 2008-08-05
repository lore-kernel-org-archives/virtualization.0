From: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: Too many I/O controller patches
Date: Tue, 05 Aug 2008 11:33:39 +0530
Message-ID: <4897ED3B.7020006__45294.0757539638$1217916685$gmane$org@linux.vnet.ibm.com>
References: <20080804.175126.193692178.ryov@valinux.co.jp>
	<1217870433.20260.101.camel@nimitz> <489748E6.5080106@gmail.com>
	<1217876521.20260.123.camel@nimitz> <48976A2A.9060600@gmail.com>
	<6599ad830808042255y59215481l5463d4dca9fb2001@mail.gmail.com>
Reply-To: balbir@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <6599ad830808042255y59215481l5463d4dca9fb2001@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Menage <menage@google.com>
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@sourceware.org, Dave Hansen <dave@linux.vnet.ibm.com>, righi.andrea@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Paul Menage wrote:
> On Mon, Aug 4, 2008 at 1:44 PM, Andrea Righi <righi.andrea@gmail.com> wrote:
>> A safer approach IMHO is to force the tasks to wait synchronously on
>> each operation that directly or indirectly generates i/o.
>>
>> In particular the solution used by the io-throttle controller to limit
>> the dirty-ratio in memory is to impose a sleep via
>> schedule_timeout_killable() in balance_dirty_pages() when a generic
>> process exceeds the limits defined for the belonging cgroup.
>>
>> Limiting read operations is a lot more easy, because they're always
>> synchronized with i/o requests.
> 
> I think that you're conflating two issues:
> 
> - controlling how much dirty memory a cgroup can have at any given
> time (since dirty memory is much harder/slower to reclaim than clean
> memory)
> 
> - controlling how much effect a cgroup can have on a given I/O device.
> 
> By controlling the rate at which a task can generate dirty pages,
> you're not really limiting either of these. I think you'd have to set
> your I/O limits artificially low to prevent a case of a process
> writing a large data file and then doing fsync() on it, which would
> then hit the disk with the entire file at once, and blow away any QoS
> guarantees for other groups.
> 
> As Dave suggested, I think it would make more sense to have your
> page-dirtying throttle points hook into the memory controller instead,
> and allow the memory controller to track/limit dirty pages for a
> cgroup, and potentially do throttling as part of that.

Yes, that would be nicer. The IO controller should control both read and write
and dirty pages is mostly related to writes.

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
