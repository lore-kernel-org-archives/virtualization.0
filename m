From: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Subject: Re: [kvm-devel] [PATCH 3/3] virtio PCI device
Date: Tue, 27 Nov 2007 11:27:53 +0200
Message-ID: <474BE319.502@qumranet.com>
References: <11944899922822-git-send-email-aliguori@us.ibm.com>	<11944900141678-git-send-email-aliguori@us.ibm.com>	<11944900152750-git-send-email-aliguori@us.ibm.com>	<11944900163817-git-send-email-aliguori@us.ibm.com>	<4742F6B7.20503@qumranet.com>	<474300AD.4060509@us.ibm.com>	<4743076F.8000105@qumranet.com>	<47435CCB.1050506@us.ibm.com>	<4743DAA4.70800@qumranet.com>	<4747051C.3090903@us.ibm.com>
	<4747122F.1070905@qumranet.com>	<474B1BF3.20901@us.ibm.com>
	<474BDD28.7050801@qumranet.com> <474BDEDE.6060603@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
In-Reply-To: <474BDEDE.6060603-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/lguest>
List-Post: <mailto:lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
List-Help: <mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=subscribe>
Sender: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Errors-To: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: carsteno-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org
Cc: Eric Van Hensbergen <ericvanhensbergen-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lguest <lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

Carsten Otte wrote:
> Avi Kivity wrote:
>   
>> No, definitely not define a hypercall ABI.  The feature bit should say 
>> "this device understands a hypervisor-specific way of kicking.  consult 
>> your hypervisor manual and cpuid bits for further details.  should you 
>> not be satisfied with this method, port io is still available".
>>     
> ...unless you're lucky enough to be on s390 where pio is not available.
> I don't see why we'd have two different ways to talk to a virtio 
> device. I think we should use a hypercall for interrupt injection, 
> without support for grumpy old soldered pci features other than 
> HPA-style Lguest PCI bus organization. There are no devices that we 
> want to be backward compatible with.
>   

pio is useful for qemu, for example, and as a fallback against changing 
hypervisor calling conventions.  As Anthony points out, it makes a 
qemu-implemented device instantly available to Xen at no extra charge.

My wording was inappropriate for s390, though.  The politically correct 
version reads "this device understands a hypervisor-specific way of 
kicking. consult your hypervisor manual and platform-specific way of 
querying hypervisor information for further details. should you not be 
satisfied with this method, the standard method of kicking virtio 
devices on your platform is still available".

On s390, I imagine that "the standard method" is the fabled diag 
instruction (which, with the proper arguments, will cook your steak to 
the exact shade of medium-rare you desire).  So you will never need to 
set the "hypervisor-specific way of kicking" bit, as your standard 
method is already optimal.

Unfortunately, we have to care for platform differences, subarch 
differences (vmx/svm), hypervisor differences (with virtio), and guest 
differences (Linux/Windows/pvLinux, 32/64).  Much care is needed when 
designing the ABI here.

[actually thinking a bit, this is specific to the virtio pci binding; 
s390 will never see any of it]

-- 
error compiling committee.c: too many arguments to function
