From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] Re: [PATCH] xen: drop anti-dependency on X86_VISWS
Date: Thu, 14 Apr 2011 01:20:22 -0700
Message-ID: <4DA6AE46.8060205__27863.3648100824$1302769383$gmane$org@goop.org>
References: <1301828839.2837.143.camel@edumazet-laptop>	
	<20110403.172407.91341067.davem@davemloft.net>	
	<1301910955.23887.75.camel@zakaz.uk.xensource.com>	
	<20110406.144515.235693855.davem@davemloft.net>	
	<1302159483.31620.36.camel@localhost.localdomain>	
	<4D9DFD6A.1060200@goop.org>	
	<1302244694.31620.44.camel@localhost.localdomain>	
	<4D9F28FE.9000803@goop.org>
	<4D9F48E8020000780003AA48@vpn.id2.novell.com>	
	<4D9F52D4.6030700@goop.org>
	<1302345292.10419.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1302345292.10419.15.camel@localhost.localdomain>
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
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, Jeremy Fitzhardinge <Jeremy.Fitzhardinge@citrix.com>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, David Miller <davem@davemloft.net>, Jan Beulich <JBeulich@novell.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mirq-linux@rere.qmqm.pl" <mirq-linux@rere.qmqm.pl>, "pazke@donpac.ru" <pazke@donpac.ru>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/09/2011 03:34 AM, Ian Campbell wrote:
>>> Actually it does - see the "#ifndef CONFIG_X86_CMPXCHG" section
>>> in asm/cmpxchg_32.h.
>> Hm, OK.  Still, I'm happiest with that dependency in case someone
>> knobbles the cpu to exclude cmpxchg and breaks things.
> Dropping the TSC patch is sensible though?

You mean dropping the TSC dependency?  Yes, I think so.

    J
