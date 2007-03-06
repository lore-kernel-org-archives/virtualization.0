From: "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: RE: Xen & VMI?
Date: Tue, 6 Mar 2007 09:17:39 -0800
Message-ID: <8FFF7E42E93CC646B632AB40643802A80229779B@scsmsx412.amr.corp.intel.com>
References: <45ED82D9.6050204@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
In-Reply-To: <45ED82D9.6050204@codemonkey.ws>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Anthony Liguori <anthony@codemonkey.ws>, Ingo Molnar <mingo@elte.hu>
Cc: virtualization <virtualization@lists.osdl.org>, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> Ingo Molnar wrote:
>> * Gerd Hoffmann <kraxel@suse.de> wrote:
>> =

>>>>> So in the end you would still have two different hypervisor ABI's,
>>>>> the VMI ROM just hides that.
>>>> oh, but that way i have cleverly pushed the problem out of Linux
>>>> and into the VMI-ROM's domain ;) Which is all i care about.
>>> Fine, so lets move kvm paravirtualitzation into vmi too (proof of
>>> concept code by Anthony Liguori exists) and kill one more item on
>>> the (linux) QA test matrix?  (just following your arguments, not
>>> that I'm confident it would actually help reducing QA effort).
>> =

>> yes - although obviously a KVM Linux guest does not need such an
>> interface - but it's a nice proof of concept to integrate other guest
>> OSs into KVM.
> =

> I disagree that a KVM Linux guest does not benefit from VMI.  Right
> now, your KVM paravirt interface only covers CR3 target caching and
> apic enhancements (neither of which I believe have made it into
> 2.6.21). Inevitably, things like MMU batching will be added.

I think a KVM Linux would benefit more from paravirt ops, rather than
VMI. The higher-level interface such as the one in Xen, espeically for
I/O, interrupt controllers, timer, SMP, etc. actually simplifies the
implementation of the VMM, and improve performance of the guest. Even
for MMU, direct page tables, for example, would work better for
hardware-based virtualization because the processor can use the native
page tables. =


> =

> Using paravirt_ops, this is going to require new kernels for the
>   guests. Every new paravirtualization feature will require a new
>   guest kernel. With VMI, one can add these features to any 2.6.21+
> guest by just modifying the ROM (assuming a newer host).  Some
> features will require new VMI entry points but quite a lot will fall
> under the current entry points.
> =

> Of all the hypervisors, KVM is the easiest to use VMI with.  QEMU
> already supports option ROM loading and Zach just made some changes to
> allow a native ROM to be implemented very easily.
> =

> If we're going to use VMI for anything other than VMware, it seems to
> be that KVM should be what we use it for.
> =

> Regards,
> =

> Anthony Liguori
> =

>> 	Ingo
> =


Jun
---
Intel Open Source Technology Center
