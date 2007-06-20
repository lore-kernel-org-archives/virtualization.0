From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops implementation
Date: Wed, 20 Jun 2007 12:47:18 -0700
Message-ID: <46798446.1030600@goop.org>
References: <4675F462.1010708@codemonkey.ws> <4675F9DE.6080806@goop.org>
	<4675FDCA.4040006@codemonkey.ws> <4676084F.3090901@goop.org>
	<46787325.30804@vmware.com> <4679381E.9090404@codemonkey.ws>
	<46794899.6070708@goop.org> <46798174.2060304@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46798174.2060304-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
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
> For a VMM which supports both full emulation and para-virtualization, 
> testing CPUID leaves is not sufficient to determine applicability of a 
> paravirt device driver.  This only indicates the presence of the 
> functionality, not the fact that the functionality has been 
> activated.  For 32-bit Xen, this might be an already assumed fact - 
> but for VMI, KVM, and HV assisted Xen, which do support guests running 
> without paravirt, you need a way to test whether the particular family 
> of paravirt has been activated - for device drivers which assume 
> paravirt semantics might well require this activation to work, or need 
> to behave differently in an unactivated environment (emulate 
> hypercalls with port I/O, for example).

paravirt_ops-style paravirtualization and paravirt device drivers are 
more or less completely orthogonal.  An unmodified OS running under hvm 
Xen can still have paravirt drivers which can detect the presence of 
Xenbus and do all the appropriate things.  It would presumably be a 
matter of loading xenbus.ko, which would probe for the presence of the 
Xen device infrastructure, and that in turn would start pulling in the 
appropriate paravirt drivers.  The state (or existence) of struct 
paravirt_ops is immaterial.

> Thus, all the paravirt drivers as modules would need to test if 
> (xen_running) or (vmi_enabled) or (kvm_active), and then all these 
> symbols need to be exported, and now you have an ad-hoc activation 
> detection system for each brand of paravirt.

No, I think not.  Normal bus/device probing should be able to deal with it.

> Better to have a standard interface, IMHO, where a paravirt-ops 
> "parent" module gets registered and activated, and then well defined 
> symbols to query that activation.  You also have module dependencies 
> between the parent and child which are nicely modeled with the module 
> system (xenbus dependes on xen, vmitimer depends on vmi, etc..).

To a large extent that already exists in the device model.

    J

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
