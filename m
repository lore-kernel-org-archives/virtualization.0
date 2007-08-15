From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 3/25][V3] irq_flags / halt routines
Date: Wed, 15 Aug 2007 14:00:29 -0300
Message-ID: <46C3312D.40106__31114.9681605913$1187197466$gmane$org@redhat.com>
References: <11871821854176-git-send-email-gcosta@redhat.com>
	<1187182197314-git-send-email-gcosta@redhat.com>
	<11871822062386-git-send-email-gcosta@redhat.com>
	<11871822163867-git-send-email-gcosta@redhat.com>
	<20070815135554.GE3406@bingen.suse.de>
	<5d6222a80708150718v14f26343q7467385e7919fa76@mail.gmail.com>
	<20070815154243.GH3406@bingen.suse.de>
	<46C31736.2050001@redhat.com>
	<20070815163640.GJ3406@bingen.suse.de>
	<46C3283B.5090804@redhat.com>
	<20070815164729.GU3672@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070815164729.GU3672@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: lguest@ozlabs.org, shai@scalemp.com, kiran@scalemp.com, linux-kernel@vger.kernel.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright escreveu:
> * Glauber de Oliveira Costa (gcosta@redhat.com) wrote:
>> As alternatives what we have now, we can either keep the paravirt_ops as 
>> it is now for the native case, just hooking the vsmp functions in place 
>> of the normal one, (there are just three ops anyway), refill the 
>> paravirt_ops entirely in somewhere like vsmp.c, or similar (or maybe 
>> even assigning paravirt_ops.fn = vsmp_fn on the fly, but early enough).

It will definitely keep the code shorter, and to be honest, I'd feel 
more confortable with (since I don't know the subtles of the architecture).

Only caveat, is that it has to be done before smp gets in the game, and 
with interrupts disabled. (which makes the function in vsmp.c not eligible).

My current option is to force VSMP to use PARAVIRT, as said before, and 
then fill paravirt_arch_setup, which is currently unused, with code to 
replace the needed paravirt_ops.fn.

I don't know if there is any method to dynamically determine (at this 
point) that we are in a vsmp arch, and if there are not, it will have to 
get ifdefs anyway. But at least, they are far more local.

> This is the best (just override pvops.fn for the few needed for VSMP).
> The irq_disabled_flags() is the only problem.  For i386 we dropped it
> (disabled_flags) as a pvop and forced the backend to provide a flags
> (via save_flags) that conforms to IF only.

I am okay with both, but after all the explanation, I don't think that 
adding a new pvops is a bad idea. It would make things less cumbersome 
in this case. Also, hacks like this save_fl may require changes to the 
hypervisor, right? I don't even know where such hypervisor is, and how 
easy it is to replace it (it may be deeply hidden in firmware)

A question raises here: Would vsmp turn paravirt_enabled to 1 ?
