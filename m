From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops implementation
Date: Wed, 20 Jun 2007 15:22:49 -0500
Message-ID: <46798C99.8010303@codemonkey.ws>
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
Cc: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>, kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Anthony Liguori wrote:
>> But what's the value in having it not in the kernel?  Let's take Xen 
>> and lhype out of the picture because it clearly has to be there for 
>> them.  You have a little less in the kernel now but then your kernel 
>> boots more slowly.  There's already a noticable difference in 
>> boot-time with the KVM paravirt_ops implementation.  I imagine there 
>> is for VMI too.
>
> If it isn't compiled in the core kernel, then a distro need not do 
> anything special to distribute VMI or KVM support - other than compile 
> support for paravirt-ops.  Then the paravirt-ops module can be 
> installed along with the guest tools and drivers, but need not be on 
> install media.

Typically, distros do not support third-party modules so that's not a 
very useful property.  Further, that just encourages out-of-kernel 
modules and worst yet, binary modules.

In fact, the whole install "guest tools" is fundamentally broken in this 
respect.  Guest tools always end up installing closed source drivers.  
Plus, these things aren't available during distro installation typically 
so you end up with a sucky user experience.

> Basically, it just makes it easier on distributors and allows any old 
> kernel with paravirt-ops module support to run on any modern, new 
> hypervisor - that might not have even existed at the time the distro 
> was created.

Yeah, I'm not buying it.  Is it really that much easier to backport a 
module than it is to just roll out a new kernel for an older distro?

BTW, isn't this the whole point of the VMI ROM? :-)

Regards,

Anthony Liguori

>>
>> In the case of KVM, the paravirt_ops implementation is orthogonal to 
>> paravirt device drivers.  A PV device driver can happily exist even 
>> if the paravirt_ops backend isn't activated.  This is assuming that 
>> hypercalls aren't used btw.  If hypercalls are desirable to use, then 
>> the paravirt_ops backend would have to EXPORT_GPL the hypercall 
>> interface.  I imagine returning a specific errno would suffice.
>
> I'm mostly in agreement on that - although making dual hypercall / I/O 
> emulated drivers is a bit more work.
>
> Zach
>
>


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
