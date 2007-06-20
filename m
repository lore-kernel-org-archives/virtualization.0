From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops implementation
Date: Wed, 20 Jun 2007 09:22:22 -0500
Message-ID: <4679381E.9090404@codemonkey.ws>
References: <4675F462.1010708@codemonkey.ws> <4675F9DE.6080806@goop.org>
	<4675FDCA.4040006@codemonkey.ws> <4676084F.3090901@goop.org>
	<46787325.30804@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46787325.30804-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Zachary Amsden <zach-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Cc: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>, kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> For software-reliant paravirtualization, it is difficult to atomically 
> switch from natural instructions to simulated para-instructions on the 
> fly; you would need stop_machine_run that also holds off NMIs (so as 
> to keep IF flag state intact across a window where non-virtualizable 
> IRET instruction is not yet patched), and you would need to re-patch 
> the kernel and modules dynamically.  Another problem is unloading the 
> module, which requires restoring the smashed native paravirt-ops - 
> some of which may have been patched, some not.  It is possible to do 
> this from a module, just obtuse, and for 32-bit, not really worth the 
> effort IMHO.
>
> Definition: software-advisory paravirtualization is a guest-involved 
> virtualization technique in which only advisory state is communicated 
> to the hypervisor, thus making redirection of instruction flow at any 
> particular point optional for more efficient virtualization (and 
> non-virtualizability is eliminated by some other mechanism).
>
> For software-advisory paravirtualization, it is totally possible to 
> just switch over to new pv-ops at any time, and there need be no 
> atomicity.  This would make a paravirt-ops module rather easy to 
> write; it simply needs to run some init code on each CPU and the patch 
> paravirt-ops at leisure.
>
> Now it is quite likely at least one developer is going to be assuming 
> hardware virtualization capabilities for 64-bit paravirt, thus making 
> an advisory method with module loading (and unloading) a more 
> practical option than dissecting the 64-bit startup sequence.

I don't agree that having paravirt_ops within a normal module is all 
that useful.  By the time modules can be loaded, the kernel has 
completely booted.  There should only be a handful of paravirt_ops 
implementations and they aren't large so I don't think there's a big 
size savings either.

>   In that case, perhaps having a paravirt_register function which 
> would check to make sure no conflicting paravirt-ops have already been 
> installed, printing the banner on success would be the most logical.  
> The paravirt_unregister function can then simply restore the native 
> paravirt-ops.
>
> More importantly, now device drivers for virtual devices would have a 
> way to inquire into which set of paravirt-ops was loaded by having an 
> official registered interface rather than an ad-hoc (if xxx_running == 
> 1) mess, and now the paravirt driver modules are nicely decoupled from 
> the boot-strap code and can be loaded dynamically.

I'm not familiar with the particular problem here, but I don't think 
that driver modules should be checking to see what paravirt_ops is 
active.  Each VMM has it's own discovery mechanism (KVM and Xen are both 
based on CPUID) so that seems like a much better method to use.

Regards,

Anthony Liguori

> Zach
>


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
