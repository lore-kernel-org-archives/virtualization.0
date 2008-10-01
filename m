From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and	Linux.
Date: Wed, 01 Oct 2008 16:34:09 -0500
Message-ID: <48E3ECD1.30809__8546.70649064264$1222897255$gmane$org@codemonkey.ws>
References: <1222881242.9381.17.camel@alok-dev1> <48E3BBC1.2050607@goop.org>
	<1222894878.9381.63.camel@alok-dev1> <48E3E8DE.1080602@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48E3E8DE.1080602@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: the arch/x86 maintainers <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "avi@redhat.com" <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, akataria@vmware.com, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Alok Kataria wrote:
>
> I guess, but the bulk of the uses of this stuff are going to be 
> hypervisor-specific.  You're hard-pressed to come up with any other 
> generic uses beyond tsc.

And arguably, storing TSC frequency in CPUID is a terrible interface 
because the TSC frequency can change any time a guest is entered.  It 
really should be a shared memory area so that a guest doesn't have to 
vmexit to read it (like it is with the Xen/KVM paravirt clock).

Regards,

Anthony Liguori

>   In general, if a hypervisor is going to put something in a special 
> cpuid leaf, its because there's no other good way to represent it.  
> Generic things are generally going to appear as an emulated piece of 
> the virtualized platform, in ACPI, DMI, a hardware-defined cpuid leaf, 
> etc...
