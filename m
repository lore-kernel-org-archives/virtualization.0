From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH v3 01/11] kexec: introduce kexec firmware support
Date: Thu, 27 Dec 2012 19:06:13 -0800
Message-ID: <874nj6ooyi.fsf@xmission.com>
References: <2f3acfe3-c608-43d8-b76a-6ba69a872692@default>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2f3acfe3-c608-43d8-b76a-6ba69a872692@default> (Daniel Kiper's
	message of "Thu, 27 Dec 2012 16:18:56 -0800 (PST)")
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
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, hpa@zytor.com, kexec@lists.infradead.org, x86@kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, jbeulich@suse.com, maxim.uvarov@oracle.com, tglx@linutronix.de, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Daniel Kiper <daniel.kiper@oracle.com> writes:

>> Daniel Kiper <daniel.kiper@oracle.com> writes:
>>
>> > Some kexec/kdump implementations (e.g. Xen PVOPS) could not use default
>> > Linux infrastructure and require some support from firmware and/or hypervisor.
>> > To cope with that problem kexec firmware infrastructure was introduced.
>> > It allows a developer to use all kexec/kdump features of given firmware
>> > or hypervisor.
>>
>> As this stands this patch is wrong.
>>
>> You need to pass an additional flag from userspace through /sbin/kexec
>> that says load the kexec image in the firmware.  A global variable here
>> is not ok.
>>
>> As I understand it you are loading a kexec on xen panic image.  Which
>> is semantically different from a kexec on linux panic image.  It is not
>> ok to do have a silly global variable kexec_use_firmware.
>
> Earlier we agreed that /sbin/kexec should call kexec syscall with
> special flag. However, during work on Xen kexec/kdump v3 patch
> I stated that this is insufficient because e.g. crash_kexec()
> should execute different code in case of use of firmware support too.

That implies you have the wrong model of userspace.

Very simply there is:
linux kexec pass through to xen kexec.

And
linux kexec (ultimately pv kexec because the pv machine is a slightly
different architecture).

> Sadly syscall does not save this flag anywhere.

> Additionally, I stated
> that kernel itself has the best knowledge which code path should be
> used (firmware or plain Linux). If this decision will be left to userspace
> then simple kexec syscall could crash system at worst case (e.g. when
> plain Linux kexec will be used in case when firmware kaxec should be
> used).

And that path selection bit is strongly non-sense.  You are advocating
hardcoding unnecessary policy in the kernel.

If for dom0 you need crash_kexec to do something different from domU
you should be able to load a small piece of code via kexec that makes
the hypervisor calls you need.

> However, if you wish I could add this flag to syscall.

I do wish.  We need to distinguish between the kexec firmware pass
through, and normal kexec.

> Additionally, I could
> add function which enables firmware support and then kexec_use_firmware
> variable will be global only in kexec.c module.

No.  kexec_use_firmware is the wrong mental model.

Do not mix the kexec pass through and the normal kexec case.

We most definitely need to call different code in the kexec firmware
pass through case.

For normal kexec we just need to use a paravirt aware version of
machine_kexec and machine_kexec_shutdown.

>> Furthermore it is not ok to have a conditional
>> code outside of header files.
>
> I agree but how to dispatch execution e.g. in crash_kexec()
> if we would like (I suppose) compile kexec firmware
> support conditionally?

The classic pattern is to have the #ifdefs in the header and have an
noop function that is inlined when the functionality is compiled out.
This allows all of the logic to always be compiled.

Eric
