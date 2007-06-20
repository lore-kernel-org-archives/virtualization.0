From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops implementation
Date: Wed, 20 Jun 2007 14:07:34 -0700
Message-ID: <46799716.9040402@goop.org>
References: <4675F462.1010708@codemonkey.ws> <4675F9DE.6080806@goop.org>
	<4675FDCA.4040006@codemonkey.ws> <4676084F.3090901@goop.org>
	<46787325.30804@vmware.com> <4679381E.9090404@codemonkey.ws>
	<46794899.6070708@goop.org> <46798174.2060304@vmware.com>
	<46798597.4020903@codemonkey.ws> <4679882B.7070605@vmware.com>
	<46798C99.8010303@codemonkey.ws> <46799001.5020807@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46799001.5020807-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
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
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Yes, but if we want to stay with that forward compatibility story, we 
> need a way to allow paravirt device probing to be completely 
> orthogonal to paravirt-ops probing.  Either the VMware hypervisor 
> needs to NOT implement a CPUID leaf, keeping the same ROM based 
> detection, or other VMI client drivers (say, as a wild example, a KVM 
> driver running on a VMI to KVM paravirt-ops backend) need not to check 
> CPUID leaf as a condition of execution.

Yes, this is something that keeps coming up.  hpa originally floated the 
idea of reserving some PCI bus namespace as a gateway for probing for 
virtual/paravirtual devices, and Jun Nakajima proposed it again in the 
context of smart hardware which is virtualization friendly (ie, how to 
represent PCI-IOV to guests).

I'm not wildly happy about the idea of using PCI for probing for 
otherwise completely non-PCI devices, but some kind of probing mechanism 
might be nice in the general case.  Xen deals with it with Xenbus, but I 
figure I'm unlikely to convince everyone to adopt that.

> We at least would like to use a CPUID leaf for the core paravirt-ops 
> on 64-bit and get rid of the need for ROM probing in that case, which 
> would mean we either need a CPUID sub-leaf for the device model, a 
> completely identical device model, or completely orthogonal device 
> probing.

Well, cpuid leaf 0x40000000 seems to be gaining currency as a 
(semi-?)formal way for hypervisors to advertise themselves, so that 
seems completely doable.

>   Since there hasn't been a formal specification for how the device 
> probing should work, or, at least, I don't know all the details of how 
> device probing works for all the various hypervisors, I worry that 
> weird ad-hoc tests could trample the compatibility effort.

Yes.  That's the thinking behind using PCI as a somewhat common 
mechanism for device discovery.  s390 folks hate it, of course.

> The completely identical device model is of course ideal, but the 
> implementation and consolidation of that is a long term prospect to 
> move towards, not something that will happen immediately.  We at least 
> emulate physical hardware devices already, and will continue to need 
> drivers compatible with those models for some time.

Well, physical devices and completely emulated physical devices are 
fairly straightforward - do it like real hardware.  Its the semi-virtual 
devices which pose problems.  Either device emulations with a bit of 
performance paravirtualization sprinkled over them, or virtualization 
friendly devices which allow safe direct guest access, but need some 
paravirtual management interfaces as well.

    J

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
