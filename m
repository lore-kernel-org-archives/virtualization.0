From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH v2 01/11] kexec: introduce kexec_ops struct
Date: Thu, 22 Nov 2012 04:15:48 -0800
Message-ID: <87txshx28b.fsf@xmission.com>
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
	<1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
	<87lidwtego.fsf@xmission.com>
	<20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
	(Daniel Kiper's message of "Wed, 21 Nov 2012 11:52:21 +0100")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, jbeulich@suse.com, hpa@zytor.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

Daniel Kiper <daniel.kiper@oracle.com> writes:

> On Tue, Nov 20, 2012 at 08:40:39AM -0800, ebiederm@xmission.com wrote:
>> Daniel Kiper <daniel.kiper@oracle.com> writes:
>>
>> > Some kexec/kdump implementations (e.g. Xen PVOPS) could not use default
>> > functions or require some changes in behavior of kexec/kdump generic code.
>> > To cope with that problem kexec_ops struct was introduced. It allows
>> > a developer to replace all or some functions and control some
>> > functionality of kexec/kdump generic code.
>> >
>> > Default behavior of kexec/kdump generic code is not changed.
>>
>> Ick.
>>
>> > v2 - suggestions/fixes:
>> >    - add comment for kexec_ops.crash_alloc_temp_store member
>> >      (suggested by Konrad Rzeszutek Wilk),
>> >    - simplify kexec_ops usage
>> >      (suggested by Konrad Rzeszutek Wilk).
>> >
>> > Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
>> > ---
>> >  include/linux/kexec.h |   26 ++++++++++
>> >  kernel/kexec.c        |  131 +++++++++++++++++++++++++++++++++++++------------
>> >  2 files changed, 125 insertions(+), 32 deletions(-)
>> >
>> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> > index d0b8458..c8d0b35 100644
>> > --- a/include/linux/kexec.h
>> > +++ b/include/linux/kexec.h
>> > @@ -116,7 +116,33 @@ struct kimage {
>> >  #endif
>> >  };
>> >
>> > +struct kexec_ops {
>> > +	/*
>> > +	 * Some kdump implementations (e.g. Xen PVOPS dom0) could not access
>> > +	 * directly crash kernel memory area. In this situation they must
>> > +	 * allocate memory outside of it and later move contents from temporary
>> > +	 * storage to final resting places (usualy done by relocate_kernel()).
>> > +	 * Such behavior could be enforced by setting
>> > +	 * crash_alloc_temp_store member to true.
>> > +	 */
>>
>> Why in the world would Xen not be able to access crash kernel memory?
>> As currently defined it is normal memory that the kernel chooses not to
>> use.
>>
>> If relocate kernel can access that memory you definitely can access the
>> memory so the comment does not make any sense.
>
> Crash kernel memory is reserved by Xen hypervisor and Xen hypervisor
> only has access to it. dom0 does not have any mapping of this area.
> However, relocate_kernel() has access to crash kernel memory
> because it is executed by Xen hypervisor and whole machine
> memory is identity mapped.

This is all weird.  Doubly so since this code is multi-arch and you have
a set of requirements no other arch has had.

I recall that Xen uses kexec in a unique manner.  What is the hypervisor
interface and how is it used?

Is this for when the hypervisor crashes and we want a crash dump of
that?



>> > +	bool crash_alloc_temp_store;
>> > +	struct page *(*kimage_alloc_pages)(gfp_t gfp_mask,
>> > +						unsigned int order,
>> > +						unsigned long limit);
>> > +	void (*kimage_free_pages)(struct page *page);
>> > +	unsigned long (*page_to_pfn)(struct page *page);
>> > +	struct page *(*pfn_to_page)(unsigned long pfn);
>> > +	unsigned long (*virt_to_phys)(volatile void *address);
>> > +	void *(*phys_to_virt)(unsigned long address);
>> > +	int (*machine_kexec_prepare)(struct kimage *image);
>> > +	int (*machine_kexec_load)(struct kimage *image);
>> > +	void (*machine_kexec_cleanup)(struct kimage *image);
>> > +	void (*machine_kexec_unload)(struct kimage *image);
>> > +	void (*machine_kexec_shutdown)(void);
>> > +	void (*machine_kexec)(struct kimage *image);
>> > +};
>>
>> Ugh.  This is a nasty abstraction.
>>
>> You are mixing and matching a bunch of things together here.
>>
>> If you need to override machine_kexec_xxx please do that on a per
>> architecture basis.
>
> Yes, it is possible but I think that it is worth to do it at that
> level because it could be useful for other archs too (e.g. Xen ARM port
> is under development). Then we do not need to duplicate that functionality
> in arch code. Additionally, Xen requires machine_kexec_load and
> machine_kexec_unload hooks which are not available in current generic
> kexec/kdump code.


Let me be clear.  kexec_ops as you have implemented it is absolutely
unacceptable.

Your kexec_ops is not an abstraction but a hack that enshrines in stone
implementation details.

>> Special case overrides of page_to_pfn, pfn_to_page, virt_to_phys,
>> phys_to_virt, and friends seem completely inappropriate.
>
> They are required in Xen PVOPS case. If we do not do that in that way
> then we at least need to duplicate almost all generic kexec/kdump existing
> code in arch depended files. I do not mention that we need to capture
> relevant syscall and other things. I think that this is wrong way.

A different definition of phys_to_virt and page_to_pfn for one specific
function is total nonsense.

It may actually be better to have a completely different code path.
This looks more like code abuse than code reuse.

Successful code reuse depends upon not breaking the assumptions on which
the code relies, or modifying the code so that the new modified
assumptions are clear.  In this case you might as well define up as down
for all of the sense kexec_ops makes.

>> There may be a point to all of these but you are mixing and matching
>> things badly.
>
> Do you whish to split this kexec_ops struct to something which
> works with addresses and something which is reponsible for
> loading, unloading and executing kexec/kdump? I am able to change
> that but I would like to know a bit about your vision first.

My vision is that we should have code that makes sense.

My suspicion is that what you want is a cousin of the existing kexec
system call.  Perhaps what is needed is a flag to say use the firmware
kexec system call.

I absolutely do not understand what Xen is trying to do.  kexec by
design should not require any firmware specific hooks.  kexec at this
level should only need to care about the processor architeture.  Clearly
what you are doing with Xen requires special hooks separate even from
the normal paravirt hooks.  So I do not understand you are trying to do.

It needs to be clear from the code what is happening differently in the
Xen case.  Otherwise the code is unmaintainable as no one will be able
to understand it.

Eric
