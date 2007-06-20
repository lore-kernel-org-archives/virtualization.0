From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops implementation
Date: Wed, 20 Jun 2007 13:33:30 -0700
Message-ID: <46798F1A.4090901@goop.org>
References: <4675F462.1010708@codemonkey.ws> <4675F9DE.6080806@goop.org>
	<4675FDCA.4040006@codemonkey.ws> <4676084F.3090901@goop.org>
	<46787325.30804@vmware.com> <4679381E.9090404@codemonkey.ws>
	<46794899.6070708@goop.org> <46798174.2060304@vmware.com>
	<46798597.4020903@codemonkey.ws> <4679882B.7070605@vmware.com>
	<46798B16.5090407@goop.org> <46798D9B.5000400@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46798D9B.5000400-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Cc: Zachary Amsden <zach-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> I've been thinking about this wrt the hypercall page in KVM.  The 
> problem is that in a model like KVM (or presumably VMI), migration 
> gets really difficult if you have anything but a trivial hypercall 
> page since the hypercall page will change after migration.
>
> If you cannot guarantee the guest isn't executing code within the 
> hypercall page (or in your case, doing something with paravirt_ops), 
> then you cannot safely migrate. 

Hm, you need to quiesce the kernel in some way when you do a migrate, so 
making sure it isn't in a hypercall would be just part of that.  In 
general you'd make sure all but one CPU is parked somewhere, and the 
remaining CPU is doing the suspend, right?

The tricky part for Xen in all this is how to make sure all mfn 
references are visible to the hypervisor/toolstack so they can be 
remapped; hypercall page contents are not a concern by comparison.

    J

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
