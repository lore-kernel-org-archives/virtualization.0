From: Dor Laor <dor.laor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [kvm-devel] [PATCH 3/3] virtio PCI device
Date: Tue, 27 Nov 2007 15:27:25 +0200
Message-ID: <474C1B3D.3050905@qumranet.com>
References: <11944899922822-git-send-email-aliguori@us.ibm.com>	<11944900141678-git-send-email-aliguori@us.ibm.com>	<11944900152750-git-send-email-aliguori@us.ibm.com>	<11944900163817-git-send-email-aliguori@us.ibm.com>	<4742F6B7.20503@qumranet.com>	<474300AD.4060509@us.ibm.com>	<4743076F.8000105@qumranet.com>	<47435CCB.1050506@us.ibm.com>	<4743DAA4.70800@qumranet.com>	<4747051C.3090903@us.ibm.com>	<4747122F.1070905@qumranet.com>	<474B1BF3.20901@us.ibm.com>	<474BDD28.7050801@qumranet.com>
	<474BDEDE.6060603@de.ibm.com>	<474BE319.502@qumranet.com>
	<474BEDAB.3000305@de.ibm.com>	<474BEF28.9010005@qumranet.com>
	<474BF157.3080709@de.ibm.com>
Reply-To: dor.laor-atKUWr5tajBWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0290008509=="
Return-path: <lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
In-Reply-To: <474BF157.3080709-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/lguest>
List-Post: <mailto:lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
List-Help: <mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=subscribe>
Mime-version: 1.0
Sender: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Errors-To: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: carsteno-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org
Cc: Eric Van Hensbergen <ericvanhensbergen-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, carsteno-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lguest <lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--===============0290008509==
Content-Type: multipart/alternative;
 boundary="------------060205080908080905070503"

This is a multi-part message in MIME format.
--------------060205080908080905070503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Carsten Otte wrote:
> Avi Kivity wrote:
>   
>>> We intend to bind our virtio devices to PCI too, so that they look the 
>>> same in Linux userland across architectures.
>>>       
>> Ouch.
>>     
> That was my initial opinion too, but HPA has come up with a lean and 
> clean PCI binding for lguest. I think we should seriously consider 
> using that over the current qemu device emulation based thing.
>
>   
There are two solutions for this problem:
1. Use hypercalls and supply mechanism for hypercall patching for qemu.
    This way we can make s390 & qemu/xen happy.
2. Have two transport mechanism for virtio.
    Actually this is what we have today (but not yet merged) - lguest 
uses the pci config space
    but without using Anthony's pci module.
    We'll have virtio host i(qemu/kernel) implementation for the shared 
memory and interface.
    We'll have pci transport for x86 that glues the above and a virtual 
transport for s390 and paravirt_ops.
    Both transports will be based on Rusty's config space.
    This is the idea I suggested in Tuscon:

     -----         ------------            ---------
     | 9p |         |  network |             |  block |
     ------       ------------            ---------
                      | virtio interface|
                      ----------------
                -----------                   
--------------------------------------------------
                | virtio_pci|      OR       | virtio_vbus (includes 
configs & hypercall/portio) |
                -----------                   
--------------------------------------------------
           -----------           -------------
           | virtio_ring|            |virtio_config|
           -----------           -------------

Regards,
Dor
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> kvm-devel mailing list
> kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/kvm-devel
>
>   


--------------060205080908080905070503
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Carsten Otte wrote:
<blockquote cite="mid:474BF157.3080709-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org" type="cite">
  <pre wrap="">Avi Kivity wrote:
  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">We intend to bind our virtio devices to PCI too, so that they look the 
same in Linux userland across architectures.
      </pre>
    </blockquote>
    <pre wrap="">Ouch.
    </pre>
  </blockquote>
  <pre wrap=""><!---->That was my initial opinion too, but HPA has come up with a lean and 
clean PCI binding for lguest. I think we should seriously consider 
using that over the current qemu device emulation based thing.

  </pre>
</blockquote>
There are two solutions for this problem:<br>
1. Use hypercalls and supply mechanism for hypercall patching for qemu.<br>
&nbsp;&nbsp;&nbsp; This way we can make s390 &amp; qemu/xen happy.<br>
2. Have two transport mechanism for virtio.<br>
&nbsp;&nbsp;&nbsp; Actually this is what we have today (but not yet merged) - lguest
uses the pci config space<br>
&nbsp;&nbsp;&nbsp; but without using Anthony's pci module.<br>
&nbsp;&nbsp;&nbsp; We'll have virtio host i(qemu/kernel) implementation for the shared
memory and interface.<br>
&nbsp;&nbsp;&nbsp; We'll have pci transport for x86 that glues the above and a virtual
transport for s390 and paravirt_ops.<br>
&nbsp;&nbsp;&nbsp; Both transports will be based on Rusty's config space.<br>
&nbsp;&nbsp;&nbsp; This is the idea I suggested in Tuscon:<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; -----&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ------------&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---------<br>
&nbsp;&nbsp;&nbsp;&nbsp; | 9p | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; network | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; block |<br>
&nbsp;&nbsp;&nbsp;&nbsp; ------&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ------------&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---------<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | virtio interface|<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ----------------<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ----------- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
--------------------------------------------------<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | virtio_pci| &nbsp;&nbsp;&nbsp;&nbsp; OR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | virtio_vbus (includes
configs &amp; hypercall/portio) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ----------- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
--------------------------------------------------<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -----------&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -------------<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | virtio_ring| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |virtio_config|<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -----------&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -------------<br>
<br>
Regards,<br>
Dor<br>
<blockquote cite="mid:474BF157.3080709-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org" type="cite">
  <pre wrap="">-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
<a class="moz-txt-link-freetext" href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a>
_______________________________________________
kvm-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/kvm-devel">https://lists.sourceforge.net/lists/listinfo/kvm-devel</a>

  </pre>
</blockquote>
<br>
</body>
</html>

--------------060205080908080905070503--

--===============0290008509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Lguest mailing list
Lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
https://ozlabs.org/mailman/listinfo/lguest

--===============0290008509==--
