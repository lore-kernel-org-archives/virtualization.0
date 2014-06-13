From: Markus Armbruster <armbru@redhat.com>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Fri, 13 Jun 2014 10:46:29 +0200
Message-ID: <87ppidnqmy.fsf@blackfin.pond.sub.org>
References: <20140610184818.2e490419@nbschild1> <53978375.6090707@6wind.com>
	<87ppie1v4r.fsf@blackfin.pond.sub.org>
	<20140612094413.15e56938@nbschild1>
	<87vbs6qjhj.fsf_-_@blackfin.pond.sub.org> <5399CF09.8030803@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5399CF09.8030803@6wind.com> (Vincent JARDIN's message of "Thu,
	12 Jun 2014 18:02:17 +0200")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vincent JARDIN <vincent.jardin@6wind.com>
Cc: Henning Schild <henning.schild@siemens.com>, virtualization@lists.linux-foundation.org, David Marchand <david.marchand@6wind.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

Some dropped quoted text restored.

Vincent JARDIN <vincent.jardin@6wind.com> writes:

> Markus,
>
> see inline (I am not on all mailing list, please, keep the cc list).
>
>> Sure!  The reasons for my dislike range from practical to
>> philosophical.
>>
>> My practical concerns include:
>>
>> 1. ivshmem code needs work, but has no maintainer
> See David's contributions:
>   http://patchwork.ozlabs.org/patch/358750/

We're grateful for David's patch for qemu-char.c, but this isn't ivshmem
maintenance, yet.

>>   - Error handling is generally poor.  For instance, "device_add
>>     ivshmem" kills your guest instantly.
>>
>>   - More subjectively, I don't trust the code to be robust against
>>     abuse by our own guest, or the other guests sharing the memory.
>>     Convincing me would take a code audit.
>>
>>   - MAINTAINERS doesn't cover ivshmem.c.
>>
>>   - The last non-trivial commit that isn't obviously part of some
>>     tree-wide infrastructure or cleanup work is from September 2012
>>     (commit c08ba66).
>>
>> 2. There is no libvirt support
>
> One can use qemu without libvivrt.

You asked me for my reasons for disliking ivshmem.  This is one.

Sure, I can drink my water through a straw while standing on one foot,
but that doesn't mean I have to like it.  And me not liking it doesn't
mean the next guy shouldn't like it.  To each their own.

>> 3. Out-of-tree server program required for full functionality
>>
>>   Interrupts require a "shared memory server" running in the host (see
>>   docs/specs/ivshmem_device_spec.txt).  It doesn't tell where to find
>>   one.  The initial commit 6cbf4c8 points to
>>   <www.gitorious.org/nahanni>.  That repository's last commit is from
>>   September 2012.  He's dead, Jim.
>>
>>   ivshmem_device_spec.txt is silent on what the server is supposed to
>>   do.
>
> We have the source code, it provides the documentation to write our
> own better server program.

Good for you.  Not good enough for the QEMU community.

QEMU features requiring on out-of-tree software to be useful are fine,
as long as said out-of-tree software is readily available to QEMU
developers and users.

Free software with a community around it and packaged in major distros
qualifies.  If you haven't got that, talk to us to find out whether what
you've got qualifies, and if not, what you'd have to do to make it
qualify.

Back when we accepted ivshmem, the out-of-tree parts it needs were well
below the "community & packaged" bar.  But folks interested in it talked
to us, and the fact that it's in shows that QEMU maintainers decided
what they had then was enough.

Unfortunately, we now have considerably less: Nahanni appears to be
dead.

An apparently dead git repository you can study is not enough.  The fact
that you hold an improved reimplementation privately is immaterial.  So
is the (plausible) claim that others could also create a
reimplementation.

>>   If this server requires privileges: I don't trust it without an
>>   audit.
>>
>> 4. Out-of-tree kernel uio driver required
>
> No, it is optional.

Good to know.  Would you be willing to send a patch to
ivshmem_device_spec.txt clarifying that?

>>   The device is "intended to be used with the provided UIO driver"
>>   (ivshmem_device_spec.txt again).  As far as I can tell, the "provided
>>   UIO driver" is the one in the dead Nahanni repo.
>>
>>   By now, you should be expecting this: I don't trust that one either.
>>
>> These concerns are all fixable, but it'll take serious work, and time.
>> Something like:
>>
>> * Find a maintainer for the device model
> I guess, we can find it into the DPDK.org community.
>> * Review and fix its code
>>
>> * Get the required kernel module upstream
>
> which module? uio, it is not required.
>
>> * Get all the required parts outside QEMU packaged in major distros, or
>>    absorbed into QEMU
>
> Redhat did disable it. why? it is there in QEMU.

Up to now, I've been wearing my QEMU hat.  Let me exchange it for my Red
one for a bit.

We (Red Hat) don't just package & ship metric tons of random free
software.  We package & ship useful free software we can support for
many, many years.

Sometimes, we find that we have to focus serious development resources
on making something useful supportable (Paolo mentioned qcow2).  We
obviously can't focus on everything, though.

Anyway, ivshmem didn't make the cut for RHEL-7.0.  Sorry if that
inconveniences you.  To get it into RHEL, you need to show it's both
useful and supportable.  Building a community around it would go a long
way towards that.

If you want to discuss this in more detail with us, you may want to try
communication channels provided by your RHEL subscription in addition to
the QEMU development mailing list.  Don't be shy, you're paying for it!

As always, I'm not speaking for myself, not my employer.

Okay, wearing my QEMU hat again.

>> In short, create a viable community around ivshmem, either within the
>> QEMU community, or separately but cooperating.
>
> At least, DPDK.org community is a community using it.

Using something isn't the same as maintaining something.  But it's a
necessary first step.

[...]
