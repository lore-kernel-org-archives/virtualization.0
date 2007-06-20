From: Zachary Amsden <zach-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops implementation
Date: Tue, 19 Jun 2007 17:21:57 -0700
Message-ID: <46787325.30804@vmware.com>
References: <4675F462.1010708@codemonkey.ws> <4675F9DE.6080806@goop.org>
	<4675FDCA.4040006@codemonkey.ws> <4676084F.3090901@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4676084F.3090901-TSDbQ3PG+2Y@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Well, I was suggesting we could print the banner later rather than
> forcing an earlier init.
>
> The important part is that you set your pv_ops before patching occurs,
> since that will bake the function calls into the rest of the kernel, and
> it will ignore any further changes to the paravirt_ops structure.
>
> I think Zach was originally thinking of initializing VMI much later
> (even as a module load), but the subtleties of inveigling its way into
> the kernel at that late stage got too complex.
>   

Definition: software-reliant paravirtualization is a guest-involved 
virtualization technique in which non-virtualizable operations are 
substituted in software with virtualized operations, thus making 
redirection of instruction flow necessary for correct operation.

For software-reliant paravirtualization, it is difficult to atomically 
switch from natural instructions to simulated para-instructions on the 
fly; you would need stop_machine_run that also holds off NMIs (so as to 
keep IF flag state intact across a window where non-virtualizable IRET 
instruction is not yet patched), and you would need to re-patch the 
kernel and modules dynamically.  Another problem is unloading the 
module, which requires restoring the smashed native paravirt-ops - some 
of which may have been patched, some not.  It is possible to do this 
from a module, just obtuse, and for 32-bit, not really worth the effort 
IMHO.

Definition: software-advisory paravirtualization is a guest-involved 
virtualization technique in which only advisory state is communicated to 
the hypervisor, thus making redirection of instruction flow at any 
particular point optional for more efficient virtualization (and 
non-virtualizability is eliminated by some other mechanism).

For software-advisory paravirtualization, it is totally possible to just 
switch over to new pv-ops at any time, and there need be no atomicity.  
This would make a paravirt-ops module rather easy to write; it simply 
needs to run some init code on each CPU and the patch paravirt-ops at 
leisure.

Now it is quite likely at least one developer is going to be assuming 
hardware virtualization capabilities for 64-bit paravirt, thus making an 
advisory method with module loading (and unloading) a more practical 
option than dissecting the 64-bit startup sequence.  In that case, 
perhaps having a paravirt_register function which would check to make 
sure no conflicting paravirt-ops have already been installed, printing 
the banner on success would be the most logical.  The 
paravirt_unregister function can then simply restore the native 
paravirt-ops.

More importantly, now device drivers for virtual devices would have a 
way to inquire into which set of paravirt-ops was loaded by having an 
official registered interface rather than an ad-hoc (if xxx_running == 
1) mess, and now the paravirt driver modules are nicely decoupled from 
the boot-strap code and can be loaded dynamically.

Zach

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
