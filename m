From: Vincent JARDIN <vincent.jardin@6wind.com>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Fri, 13 Jun 2014 11:26:56 +0200
Message-ID: <539AC3E0.9090404@6wind.com>
References: <20140610184818.2e490419@nbschild1> <53978375.6090707@6wind.com>
	<87ppie1v4r.fsf@blackfin.pond.sub.org>
	<20140612094413.15e56938@nbschild1>
	<87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>
	<5399CF09.8030803@6wind.com> <87ppidnqmy.fsf@blackfin.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87ppidnqmy.fsf@blackfin.pond.sub.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Henning Schild <henning.schild@siemens.com>, Olivier MATZ <olivier.matz@6wind.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, David Marchand <david.marchand@6wind.com>, virtualization@lists.linux-foundation.org, "thomas.monjalon@6wind.com" <thomas.monjalon@6wind.com>
List-Id: virtualization@lists.linuxfoundation.org

(+merging with Paolo's email because of overlaps)

>> see inline (I am not on all mailing list, please, keep the cc list).
>>

>>> 1. ivshmem code needs work, but has no maintainer
>> See David's contributions:
>>    http://patchwork.ozlabs.org/patch/358750/
>
> We're grateful for David's patch for qemu-char.c, but this isn't ivshmem
> maintenance, yet.

others can come (doc), see below.

>>> 2. There is no libvirt support
>>
>> One can use qemu without libvivrt.
>
> You asked me for my reasons for disliking ivshmem.  This is one.
>
> Sure, I can drink my water through a straw while standing on one foot,
> but that doesn't mean I have to like it.  And me not liking it doesn't
> mean the next guy shouldn't like it.  To each their own.

I like using qemu without libvirt, libvirt is not part of qemu.
Let's avoid trolling about it ;)

> Back when we accepted ivshmem, the out-of-tree parts it needs were well
> below the "community & packaged" bar.  But folks interested in it talked
> to us, and the fact that it's in shows that QEMU maintainers decided
> what they had then was enough.
>
> Unfortunately, we now have considerably less: Nahanni appears to be
> dead.

agree and to bad it is dead. We should let Nahanni dead since ivshmem is =

a QEMU topic now, see below. Does it make sense?

>
> An apparently dead git repository you can study is not enough.  The fact
> that you hold an improved reimplementation privately is immaterial.  So
> is the (plausible) claim that others could also create a
> reimplementation.

Got the point. What's about a patch to =

docs/specs/ivshmem_device_spec.txt that improves it?

I can make qemu's ivshmem better:
   - keep explaining memnic for instance,
   - explain how to write other ivshmem.

does it help?

>>> 4. Out-of-tree kernel uio driver required
>>
>> No, it is optional.
>
> Good to know.  Would you be willing to send a patch to
> ivshmem_device_spec.txt clarifying that?

got the point, yes,

>>> * Get all the required parts outside QEMU packaged in major distros, or
>>>     absorbed into QEMU
>>
>> Redhat did disable it. why? it is there in QEMU.
>
> Up to now, I've been wearing my QEMU hat.  Let me exchange it for my Red
> one for a bit.
>
> We (Red Hat) don't just package & ship metric tons of random free
> software.  We package & ship useful free software we can support for
> many, many years.
>
> Sometimes, we find that we have to focus serious development resources
> on making something useful supportable (Paolo mentioned qcow2).  We
> obviously can't focus on everything, though.

Good open technology should rule. ivshmem has use cases. And I go agree =

with you, it is like the phoenix, it has to be re-explained/documented =

to be back to life. I was not aware that the QEMU community was missing =

ivshmem contributors (my bad I did not check MAINTAINERS).

> Anyway, ivshmem didn't make the cut for RHEL-7.0.  Sorry if that
> inconveniences you.  To get it into RHEL, you need to show it's both
> useful and supportable.  Building a community around it would go a long
> way towards that.

understood.

> If you want to discuss this in more detail with us, you may want to try
> communication channels provided by your RHEL subscription in addition to
> the QEMU development mailing list.  Don't be shy, you're paying for it!

done. I was focusing on DPDK.org and ignorant of QEMU's status, thinking =

Redhat was covering it. How to know which part of an opensource software =

are and are not included into Redhat. Sales are ignorant about it ;). =

Redhat randomly disables some files at compilation (for some good =

reasons I guess, but not public rationals or I am missing something).

Feel free to open this PR to anyone:
   https://bugzilla.redhat.com/show_bug.cgi?id=3D1088332

>>> In short, create a viable community around ivshmem, either within the
>>> QEMU community, or separately but cooperating.
>>
>> At least, DPDK.org community is a community using it.
>
> Using something isn't the same as maintaining something.  But it's a
> necessary first step.

understood, after David's patch, documentation will come.

(now Paolo's email since there were some overlaps)

 > Markus especially referred to parts *outside* QEMU: the server, the
 > uio driver, etc.  These out-of-tree, non-packaged parts of ivshmem
 > are one of the reasons why Red Hat has disabled ivshmem in RHEL7.

You made the right choices, these out-of-tree packages are not required. =

You can use QEMU's ivshmem without any of the out-of-tree packages. The =

out-of-tree packages are just some examples of using ivshmem.

 > He also listed many others.  Basically for parts of QEMU that are not
 > of high quality, we either fix them (this is for example what we did
 > for qcow2) or disable them.  Not just ivshmem suffered this fate, for
 > example many network cards, sound cards, SCSI storage adapters.

I and David (cc) are working on making it better based on the issues =

that are found.

 > Now, vhost-user is in the process of being merged for 2.1.  Compared =

to the DPDK solution:

now, you cannot compare vhost-user to DPDK/ivshmem; both should exsit =

because they have different scope and use cases. It is like comparing =

two different(A) models of IPC:
   - vhost-user -> networking use case specific
   - ivshmem -> framework to be generic to have shared memory for many =

use cases (HPC, in-memory-database, a network too like memnic).

Later one, some news services will be needed for shared memory. virtio =

will come in picture (see VIRTIO_F_RING_SHMEM_ADDR's threads). =

Currently, ivhsmem is the only "stable" option since there remains many =

unsolved issues with virtio and shared memory.

 > * it doesn't require hugetlbfs (which only enabled shared memory by
 > chance in older QEMU releases, that was never documented)

ivhsmem does not require hugetlbfs. It is optional.

 > * it doesn't require ivshmem (it does require shared memory, which
 > will also be added to 2.1)

somehow I agree: we need both models: vhost-user and ivshmem because of =

the previous (A) comments.

 > * it doesn't require the kernel driver from the DPDK sample

ivhsmem does not require DPDK kernel driver. see memnic's PMD:
   http://dpdk.org/browse/memnic/tree/pmd/pmd_memnic.c

 > * it is not just shared memory, but also defines an interface to use
 > it (another of Markus's points)

agreed Paolo: but you short narrow it for networking use cases only. =

Shared memory =E0 la ivshmem provides other features (see (A) again).

 >
 > vhost-user is superior, and it is superior because it has been
 > designed
 > from the get-go through cooperation of all interested parties (namely
 > QEMU and snabbswitch).

It is not an argument. vhost-user is a specific case.

Best regards,
   Vincent
