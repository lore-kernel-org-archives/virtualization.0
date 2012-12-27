From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH v3 00/11] xen: Initial kexec/kdump implementation
Date: Thu, 27 Dec 2012 10:02:44 -0800
Message-ID: <874nj7qsor.fsf@xmission.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
	<50DBC856.6030208@zytor.com>
	<791b4922-078f-4adc-b3f3-0651f2266147@email.android.com>
	<50DC58C4.3000307@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50DC58C4.3000307@citrix.com> (Andrew Cooper's message of "Thu,
	27 Dec 2012 14:18:44 +0000")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Daniel Kiper <daniel.kiper@oracle.com>, "H. Peter Anvin" <hpa@zytor.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "jbeulich@suse.com" <jbeulich@suse.com>, "maxim.uvarov@oracle.com" <maxim.uvarov@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Cooper <andrew.cooper3@citrix.com> writes:

> On 27/12/2012 07:53, Eric W. Biederman wrote:
>> The syscall ABI still has the wrong semantics.
>>
>> Aka totally unmaintainable and umergeable.
>>
>> The concept of domU support is also strange.  What does domU support even mean, when the dom0 support is loading a kernel to pick up Xen when Xen falls over.
>
> There are two requirements pulling at this patch series, but I agree
> that we need to clarify them.

It probably make sense to split them apart a little even.

> When dom0 loads a crash kernel, it is loading one for Xen to use.  As a
> dom0 crash causes a Xen crash, having dom0 set up a kdump kernel for
> itself is completely useless.  This ability is present in "classic Xen
> dom0" kernels, but the feature is currently missing in PVOPS.

> Many cloud customers and service providers want the ability for a VM
> administrator to be able to load a kdump/kexec kernel within a
> domain[1].  This allows the VM administrator to take more proactive
> steps to isolate the cause of a crash, the state of which is most likely
> discarded while tearing down the domain.  The result being that as far
> as Xen is concerned, the domain is still alive, while the kdump
> kernel/environment can work its usual magic.  I am not aware of any
> feature like this existing in the past.

Which makes domU support semantically just the normal kexec/kdump
support.  Got it.

The point of implementing domU is for those times when the hypervisor
admin and the kernel admin are different.

For domU support modifying or adding alternate versions of
machine_kexec.c and relocate_kernel.S to add paravirtualization support
make sense.

There is the practical argument that for implementation efficiency of
crash dumps it would be better if that support came from the hypervisor
or the hypervisor environment.  But this gets into the practical reality
that the hypervisor environment does not do that today.  Furthermore
kexec all by itself working in a paravirtualized environment under Xen
makes sense.

domU support is what Peter was worrying about for cleanliness, and
we need some x86 backend ops there, and generally to be careful.


For dom0 support we need to extend the kexec_load system call, and
get it right.

When we are done I expect both dom0 and domU support of kexec to work
in dom0.  I don't know if the normal kexec or kdump case will ever make
sense in dom0 but there is no reason for that case to be broken.

> ~Andrew
>
> [1] http://lists.xen.org/archives/html/xen-devel/2012-11/msg01274.html

Eric
