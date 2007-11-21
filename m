From: Zachary Amsden <zach-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] virtio PCI device
Date: Wed, 21 Nov 2007 10:22:57 -0800
Message-ID: <1195669377.6352.247.camel@bodhitayantram.eng.vmware.com>
References: <11944899922822-git-send-email-aliguori@us.ibm.com>
	<11944900141678-git-send-email-aliguori@us.ibm.com>
	<11944900152750-git-send-email-aliguori@us.ibm.com>
	<11944900163817-git-send-email-aliguori@us.ibm.com>
	<4742F6B7.20503@qumranet.com>	<474300AD.4060509@us.ibm.com>
	<4743076F.8000105@qumranet.com> <47435CCB.1050506@us.ibm.com>
	<4743DAA4.70800@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4743DAA4.70800-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
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
Cc: kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eric Van Hensbergen <ericvanhensbergen-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-11-21 at 09:13 +0200, Avi Kivity wrote:

> Where the device is implemented is an implementation detail that should 
> be hidden from the guest, isn't that one of the strengths of 
> virtualization?  Two examples: a file-based block device implemented in 
> qemu gives you fancy file formats with encryption and compression, while 
> the same device implemented in the kernel gives you a low-overhead path 
> directly to a zillion-disk SAN volume.  Or a user-level network device 
> capable of running with the slirp stack and no permissions vs. the 
> kernel device running copyless most of the time and using a dma engine 
> for the rest but requiring you to be good friends with the admin.
> 
> The user should expect zero reconfigurations moving a VM from one model 
> to the other.

I think that is pretty insightful, and indeed, is probably the only
reason we would ever consider using a virtio based driver.

But is this really a virtualization problem, and is virtio the right
place to solve it?  Doesn't I/O hotplug with multipathing or NIC teaming
provide the same infrastructure in a way that is useful in more than
just a virtualization context?

Zach


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
