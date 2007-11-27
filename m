From: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/3] virtio PCI device
Date: Tue, 27 Nov 2007 12:19:20 +0200
Message-ID: <474BEF28.9010005@qumranet.com>
References: <11944899922822-git-send-email-aliguori@us.ibm.com>	<11944900141678-git-send-email-aliguori@us.ibm.com>	<11944900152750-git-send-email-aliguori@us.ibm.com>	<11944900163817-git-send-email-aliguori@us.ibm.com>	<4742F6B7.20503@qumranet.com>	<474300AD.4060509@us.ibm.com>	<4743076F.8000105@qumranet.com>	<47435CCB.1050506@us.ibm.com>	<4743DAA4.70800@qumranet.com>	<4747051C.3090903@us.ibm.com>
	<4747122F.1070905@qumranet.com>	<474B1BF3.20901@us.ibm.com>
	<474BDD28.7050801@qumranet.com> <474BDEDE.6060603@de.ibm.com>
	<474BE319.502@qumranet.com> <474BEDAB.3000305@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <474BEDAB.3000305-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: carsteno-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org
Cc: Eric Van Hensbergen <ericvanhensbergen-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lguest <lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

Carsten Otte wrote:
>
>> [actually thinking a bit, this is specific to the virtio pci binding; 
>> s390 will never see any of it]
> You remember that we've lost the big debate around virtio in Tucson? 

I was in the embedded BOF.

> We intend to bind our virtio devices to PCI too, so that they look the 
> same in Linux userland across architectures.

Ouch.

-- 
error compiling committee.c: too many arguments to function


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
