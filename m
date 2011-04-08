From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] Re: [PATCH] xen: drop anti-dependency on X86_VISWS
Date: Fri, 08 Apr 2011 11:24:20 -0700
Message-ID: <4D9F52D4.6030700__9351.4883811169$1302287150$gmane$org@goop.org>
References: <1301828839.2837.143.camel@edumazet-laptop>
	<20110403.172407.91341067.davem@davemloft.net>
	<1301910955.23887.75.camel@zakaz.uk.xensource.com>
	<20110406.144515.235693855.davem@davemloft.net>
	<1302159483.31620.36.camel@localhost.localdomain>
	<4D9DFD6A.1060200@goop.org>
	<1302244694.31620.44.camel@localhost.localdomain>
	<4D9F28FE.9000803@goop.org>
	<4D9F48E8020000780003AA48@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4D9F48E8020000780003AA48@vpn.id2.novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@novell.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, Jeremy Fitzhardinge <Jeremy.Fitzhardinge@citrix.com>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Ian Campbell <Ian.Campbell@eu.citrix.com>, "mingo@redhat.com" <mingo@redhat.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mirq-linux@rere.qmqm.pl" <mirq-linux@rere.qmqm.pl>, "pazke@donpac.ru" <pazke@donpac.ru>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On 04/08/2011 08:42 AM, Jan Beulich wrote:
>>>> On 08.04.11 at 17:25, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>> On 04/07/2011 11:38 PM, Ian Campbell wrote:
>>> Is there any downside to this patch (is X86_CMPXCHG in the same sort of
>>> boat?)
>> Only if we don't use cmpxchg in shared memory with other domains or the
>> hypervisor.  (I don't think it will dynamically switch between real and
>> emulated cmpxchg depending on availability.)
> Actually it does - see the "#ifndef CONFIG_X86_CMPXCHG" section
> in asm/cmpxchg_32.h.

Hm, OK.  Still, I'm happiest with that dependency in case someone
knobbles the cpu to exclude cmpxchg and breaks things.

    J
