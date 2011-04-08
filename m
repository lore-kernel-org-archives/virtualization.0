From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] xen: drop anti-dependency on X86_VISWS
Date: Fri, 08 Apr 2011 08:25:50 -0700
Message-ID: <4D9F28FE.9000803__22384.8331174397$1302276411$gmane$org@goop.org>
References: <1301828839.2837.143.camel@edumazet-laptop>	
	<20110403.172407.91341067.davem@davemloft.net>	
	<1301910955.23887.75.camel@zakaz.uk.xensource.com>	
	<20110406.144515.235693855.davem@davemloft.net>	
	<1302159483.31620.36.camel@localhost.localdomain>	
	<4D9DFD6A.1060200@goop.org>
	<1302244694.31620.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1302244694.31620.44.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ian Campbell <Ian.Campbell@eu.citrix.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, Jeremy Fitzhardinge <Jeremy.Fitzhardinge@citrix.com>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, David Miller <davem@davemloft.net>, "mirq-linux@rere.qmqm.pl" <mirq-linux@rere.qmqm.pl>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "pazke@donpac.ru" <pazke@donpac.ru>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/07/2011 11:38 PM, Ian Campbell wrote:
>> Not really.  The TSC register is a requirement, but that's going to be
>> present on any CPU which can boot Xen.  We don't need any of the
>> kernel's TSC machinery though.
> So why the Kconfig dependency then? In principal a kernel compiled for a
> non-TSC processor (which meets the other requirements for Xen, such as
> PAE support) will run just fine under Xen on a newer piece of hardware.

Not sure where it came from.  It was probably never needed, or just
added for some secondary effect we wanted.

> Is there any downside to this patch (is X86_CMPXCHG in the same sort of
> boat?)

Only if we don't use cmpxchg in shared memory with other domains or the
hypervisor.  (I don't think it will dynamically switch between real and
emulated cmpxchg depending on availability.)

    J
