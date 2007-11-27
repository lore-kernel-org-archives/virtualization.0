From: Carsten Otte <cotte-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] virtio PCI device
Date: Tue, 27 Nov 2007 11:28:39 +0100
Message-ID: <474BF157.3080709@de.ibm.com>
References: <11944899922822-git-send-email-aliguori@us.ibm.com>	<11944900141678-git-send-email-aliguori@us.ibm.com>	<11944900152750-git-send-email-aliguori@us.ibm.com>	<11944900163817-git-send-email-aliguori@us.ibm.com>	<4742F6B7.20503@qumranet.com>	<474300AD.4060509@us.ibm.com>	<4743076F.8000105@qumranet.com>	<47435CCB.1050506@us.ibm.com>	<4743DAA4.70800@qumranet.com>	<4747051C.3090903@us.ibm.com>
	<4747122F.1070905@qumranet.com>	<474B1BF3.20901@us.ibm.com>
	<474BDD28.7050801@qumranet.com> <474BDEDE.6060603@de.ibm.com>
	<474BE319.502@qumranet.com> <474BEDAB.3000305@de.ibm.com>
	<474BEF28.9010005@qumranet.com>
Reply-To: carsteno-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <474BEF28.9010005-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Cc: Eric Van Hensbergen <ericvanhensbergen-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, carsteno-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lguest <lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
>> We intend to bind our virtio devices to PCI too, so that they look the 
>> same in Linux userland across architectures.
> 
> Ouch.
That was my initial opinion too, but HPA has come up with a lean and 
clean PCI binding for lguest. I think we should seriously consider 
using that over the current qemu device emulation based thing.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
