From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops implementation
Date: Wed, 20 Jun 2007 17:39:17 -0500
Message-ID: <4679AC95.8010503@codemonkey.ws>
References: <4675F462.1010708@codemonkey.ws> <4675F9DE.6080806@goop.org>
	<4675FDCA.4040006@codemonkey.ws> <4676084F.3090901@goop.org>
	<46787325.30804@vmware.com> <4679381E.9090404@codemonkey.ws>
	<46794899.6070708@goop.org> <46798174.2060304@vmware.com>
	<46798597.4020903@codemonkey.ws> <4679882B.7070605@vmware.com>
	<46798B16.5090407@goop.org> <46798D9B.5000400@codemonkey.ws>
	<46799157.3070805@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46799157.3070805-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
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
> Anthony Liguori wrote:
>> I've been thinking about this wrt the hypercall page in KVM.  The 
>> problem is that in a model like KVM (or presumably VMI), migration 
>> gets really difficult if you have anything but a trivial hypercall 
>> page since the hypercall page will change after migration.
>>
>> If you cannot guarantee the guest isn't executing code within the 
>> hypercall page (or in your case, doing something with paravirt_ops), 
>> then you cannot safely migrate.
>
> Unless you also migrate the hypercall page itself and impose migration 
> restrictions on compatible hypercall pages.

Compatible hypercall pages == identical hypercall pages.  This also 
comes into play with save/restore.  If you save a guest, then upgrade 
the hypervisor, if the new hypervisor uses a different hypercall page 
(perhaps b/c an internal interface has changed), you run into the same 
problem.

> Although I favor the guarantee that execution within the hypercall 
> page is finished - it is important for protecting against 
> non-reentrancy as well.  Think about interrupts during batching / 
> queueing operations.

I think this is pretty straight forward to do without guest 
cooperation.  You merely have to let the guest run a little longer until 
vcpu->eip is not in the hypercall page.  This just becomes part of the 
criteria for convergence in migration.  The guest could get nasty and 
loop hard on calling into the hypercall page or, worse yet, rewrite 
portions of the hypercall page so that execution stayed indefinitely 
there.  That could be mitigated with heuristics but that's probably not 
all that important.

Of course, you also have to guarantee that the hypercall page doesn't 
maintain any state (at least, within the page itself).  That's 
definitely a limiting factor.

Regards,

Anthony Liguori

> Zach
>


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
