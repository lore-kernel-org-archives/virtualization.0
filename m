From: Brian Jackson <iggy@theiggy.com>
Subject: Re: Learning question regarding virtio and partvirt_ops
Date: Tue, 29 Sep 2009 14:02:31 -0500
Message-ID: <200909291402.31796.iggy@theiggy.com>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com>
	<1254242989.7803.11.camel@ank32.eng.vmware.com>
	<8AFC7968D54FB448A30D8F38F259C5620E784325@TK5EX14MBXC114.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C5620E784325@TK5EX14MBXC114.redmond.corp.microsoft.com>
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
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 29 September 2009 12:55:05 pm Hank Janssen wrote:
> Greetings all,
> 
> I guess this is my official first port on the virtualization mailing list.
> 
> So any errors in posting and the correctness of asking questions in the
>  present And future are mine alone :)
> 
> I am one of the Microsoft developers responsible for Hyper-V support for
>  Linux.
> 
> I had the pleasure of meeting Anthony Liguori and Chris Wright last week at
>  the Linux Plumbers Conference in Portland.
> 
> The discussion was around virtio and possibly using some virtio for the
>  Hyper-V work. Since I am still much a novice with virtio, I wanted to ask
>  the general wisdom on the list.
> 
> There is also paravirt_ops, and I am trying to understand the relationship
>  of paravirt_ops And the kernel, virtio and the kernel and possible
>  relation between paravirt_ops and virtio.


PV_ops is about optimizing things like time, cpu, irq, mmu, apic, locking, and 
other similar functions.

Virtio is about optimizing I/O. There are currently drivers for networking, 
block devices, rng, memory ballooning, console, and maybe others that I don't 
remember offhand.


> 
> Is there a place somebody can point me towards that gives me a better
>  understanding of These two systems, how they compliment/do not compliment,
>  are the same or are not the same. And what is the general direction of the
>  people on the list regarding these systems.

The source as usual. Namely arch/x86/include/asm/paravirt_types.h for pv_ops. 
Pointing out specific places to look for virtio is hard since the drivers are 
spread all over the kernel tree in the directories they belong. A quick find 
on the kernel source tree should help.


> 
> Why you would use one over the other, or if they can be combined in some
>  way.

Lguest uses both. Xen uses pv_ops. KVM uses both. 

> 
> I know this might be a loaded question, but there you have it :)
> 
> Anthony and Chris can only be blamed for telling me that this is a good
>  list to have These discussions on. Everything else is my fault :)
> 
> Thanks,
> 
> Hank.
