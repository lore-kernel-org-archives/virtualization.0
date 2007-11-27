From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 3/3] virtio PCI device
Date: Tue, 27 Nov 2007 10:25:59 +0100
Message-ID: <200711271026.00084.arnd@arndb.de>
References: <11944899922822-git-send-email-aliguori@us.ibm.com>
	<474B1BF3.20901@us.ibm.com> <474BDD28.7050801@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <474BDD28.7050801-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Eric Van Hensbergen <ericvanhensbergen-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lguest <lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 27 November 2007, Avi Kivity wrote:
> > :-) =A0Do you know if there is a hard limit on the number of devices on =

> > a PCI bus? =A0My concern was that it was limited by something stupid =

> > like an 8-bit identifier.
> =

> IIRC pci slots are 8-bit, but you can have multiple buses, so =

> effectively 16 bits of device address space (discounting functions which =

> are likely not hot-pluggable).

You have an 8 bit bus number and an 8 bit device/function number.
The function number is 3 bits, so if you want to use only function 0
for everything, you are limited to a little under 8192 (2^(8+5)) devices
per PCI domain. PC style hardware cannot easily address multiple PCI
domains, but I think you can have them if you assume that the guest is
using mmconfig.

For using multiple buses, the easiest way could be to have every
device/function on bus 0 be a bridge by itself, so you end up with a
flat number space for the actual devices,

$ lspci -t
 [0000:00]-+-00.0-[0000:01]--+-00.0
           |                 +-01.0
           |                 +-02.0
           |                 + ...
           |                 \-3f.0
           +-00.1-[0000:02]--+-00.0
           |                 +-01.0
           |                 +-02.0
           |                 + ...
           |                 \-3f.0
           + ...
           |
           +-3f.6-[0000:ff]--+-00.0
                             +-01.0
                             +-02.0
                             + ...
                             \-3f.0

	Arnd <><

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
