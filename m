From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 3/25][V3] irq_flags / halt routines
Date: Wed, 15 Aug 2007 11:09:29 -0700
Message-ID: <20070815180929.GX3672__28559.3289918781$1187201577$gmane$org@sequoia.sous-sol.org>
References: <11871822062386-git-send-email-gcosta@redhat.com>
	<11871822163867-git-send-email-gcosta@redhat.com>
	<20070815135554.GE3406@bingen.suse.de>
	<5d6222a80708150718v14f26343q7467385e7919fa76@mail.gmail.com>
	<20070815154243.GH3406@bingen.suse.de>
	<46C31736.2050001@redhat.com>
	<20070815163640.GJ3406@bingen.suse.de>
	<46C3283B.5090804@redhat.com>
	<20070815164729.GU3672@sequoia.sous-sol.org>
	<46C3312D.40106@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <46C3312D.40106@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, shai@scalemp.com, kiran@scalemp.com, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

* Glauber de Oliveira Costa (gcosta@redhat.com) wrote:
> Only caveat, is that it has to be done before smp gets in the game, and 
> with interrupts disabled. (which makes the function in vsmp.c not eligible).
> 
> My current option is to force VSMP to use PARAVIRT, as said before, and 
> then fill paravirt_arch_setup, which is currently unused, with code to 
> replace the needed paravirt_ops.fn.
> 
> I don't know if there is any method to dynamically determine (at this 
> point) that we are in a vsmp arch, and if there are not, it will have to 
> get ifdefs anyway. But at least, they are far more local.

between __cacheline_aligned_in_smp and other compile time bits based on
VSMP specific INTERNODE_CACHE, etc. I think compile time the way to go.

> I am okay with both, but after all the explanation, I don't think that 
> adding a new pvops is a bad idea. It would make things less cumbersome 
> in this case. Also, hacks like this save_fl may require changes to the 
> hypervisor, right? I don't even know where such hypervisor is, and how 
> easy it is to replace it (it may be deeply hidden in firmware)

No hypervisor change needed.  Just the pv backend needs to return 0 or
X86_EFLAGS_IF for save_flags (and similar translation on restore_flags).
Xen uses a simple shared memory flag and does something which you could
roughly translate into this:

	xen_save_flags()
	if (xen_vcpu_interrupts_enabled)
		return X86_EFLAGS_IF;
	else
		return 0;

This doesn't require any hypervisor changes.  Similarly, VSMP could do
something along the lines of:

	vsmp_save_flags()
	flags = native_save_flags();
	if (flags & X86_EFLAGS_IF) || (flags & X86_EFLAGS_AC)
		return X86_EFLAGS_IF;
	else
		return 0;

> A question raises here: Would vsmp turn paravirt_enabled to 1 ?

Probably not.  It's mostly native and I'm not sure it would want the
bits disabled from if (paravirt_enabled()) tests.
