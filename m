From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops implementation
Date: Wed, 20 Jun 2007 13:16:22 -0700
Message-ID: <46798B16.5090407@goop.org>
References: <4675F462.1010708@codemonkey.ws> <4675F9DE.6080806@goop.org>
	<4675FDCA.4040006@codemonkey.ws> <4676084F.3090901@goop.org>
	<46787325.30804@vmware.com> <4679381E.9090404@codemonkey.ws>
	<46794899.6070708@goop.org> <46798174.2060304@vmware.com>
	<46798597.4020903@codemonkey.ws> <4679882B.7070605@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4679882B.7070605-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
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
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Basically, it just makes it easier on distributors and allows any old 
> kernel with paravirt-ops module support to run on any modern, new 
> hypervisor - that might not have even existed at the time the distro 
> was created.

Hey, isn't that what VMI's for? ;)

I'd been thinking about the possibility of allowing the domain builder 
to provide a new paravirt_ops implementation to the booting kernel.  It 
would be akin to a kernel module, in that its built for a specific 
kernel, but obviously run a lot earlier.  But at this point I think the 
idea is too crack-ridden to be taken seriously.

>> In the case of KVM, the paravirt_ops implementation is orthogonal to 
>> paravirt device drivers.  A PV device driver can happily exist even 
>> if the paravirt_ops backend isn't activated.  This is assuming that 
>> hypercalls aren't used btw.  If hypercalls are desirable to use, then 
>> the paravirt_ops backend would have to EXPORT_GPL the hypercall 
>> interface.  I imagine returning a specific errno would suffice.
>
> I'm mostly in agreement on that - although making dual hypercall / I/O 
> emulated drivers is a bit more work. 

Semi-paravirtualized real-hardware drivers seems like a difficult 
mishmash.  I would hope we could deal with it with a virtio-like thing.

    J

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
