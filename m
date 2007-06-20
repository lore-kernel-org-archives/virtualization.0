From: Zachary Amsden <zach-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops implementation
Date: Wed, 20 Jun 2007 13:37:21 -0700
Message-ID: <46799001.5020807@vmware.com>
References: <4675F462.1010708@codemonkey.ws> <4675F9DE.6080806@goop.org>
	<4675FDCA.4040006@codemonkey.ws> <4676084F.3090901@goop.org>
	<46787325.30804@vmware.com> <4679381E.9090404@codemonkey.ws>
	<46794899.6070708@goop.org> <46798174.2060304@vmware.com>
	<46798597.4020903@codemonkey.ws> <4679882B.7070605@vmware.com>
	<46798C99.8010303@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46798C99.8010303-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
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
Cc: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>, kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> Zachary Amsden wrote:
>> Anthony Liguori wrote:
>>> But what's the value in having it not in the kernel?  Let's take Xen 
>>> and lhype out of the picture because it clearly has to be there for 
>>> them.  You have a little less in the kernel now but then your kernel 
>>> boots more slowly.  There's already a noticable difference in 
>>> boot-time with the KVM paravirt_ops implementation.  I imagine there 
>>> is for VMI too.
>>
>> If it isn't compiled in the core kernel, then a distro need not do 
>> anything special to distribute VMI or KVM support - other than 
>> compile support for paravirt-ops.  Then the paravirt-ops module can 
>> be installed along with the guest tools and drivers, but need not be 
>> on install media.
>
> Typically, distros do not support third-party modules so that's not a 
> very useful property.  Further, that just encourages out-of-kernel 
> modules and worst yet, binary modules.
>
> In fact, the whole install "guest tools" is fundamentally broken in 
> this respect.  Guest tools always end up installing closed source 
> drivers.  Plus, these things aren't available during distro 
> installation typically so you end up with a sucky user experience.

Agree.

>
>> Basically, it just makes it easier on distributors and allows any old 
>> kernel with paravirt-ops module support to run on any modern, new 
>> hypervisor - that might not have even existed at the time the distro 
>> was created.
>
> Yeah, I'm not buying it.  Is it really that much easier to backport a 
> module than it is to just roll out a new kernel for an older distro?
>
> BTW, isn't this the whole point of the VMI ROM? :-)

Yes, but if we want to stay with that forward compatibility story, we 
need a way to allow paravirt device probing to be completely orthogonal 
to paravirt-ops probing.  Either the VMware hypervisor needs to NOT 
implement a CPUID leaf, keeping the same ROM based detection, or other 
VMI client drivers (say, as a wild example, a KVM driver running on a 
VMI to KVM paravirt-ops backend) need not to check CPUID leaf as a 
condition of execution.

We at least would like to use a CPUID leaf for the core paravirt-ops on 
64-bit and get rid of the need for ROM probing in that case, which would 
mean we either need a CPUID sub-leaf for the device model, a completely 
identical device model, or completely orthogonal device probing.  Since 
there hasn't been a formal specification for how the device probing 
should work, or, at least, I don't know all the details of how device 
probing works for all the various hypervisors, I worry that weird ad-hoc 
tests could trample the compatibility effort.

The completely identical device model is of course ideal, but the 
implementation and consolidation of that is a long term prospect to move 
towards, not something that will happen immediately.  We at least 
emulate physical hardware devices already, and will continue to need 
drivers compatible with those models for some time.

Zach

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
