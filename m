From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] xen: drop anti-dependency on X86_VISWS
Date: Thu, 07 Apr 2011 10:00:21 -0700
Message-ID: <4D9DEDA5.6020706__21804.1243184873$1302195714$gmane$org@zytor.com>
References: <1301828839.2837.143.camel@edumazet-laptop>	
	<20110403.172407.91341067.davem@davemloft.net>	
	<1301910955.23887.75.camel@zakaz.uk.xensource.com>	
	<20110406.144515.235693855.davem@davemloft.net>
	<1302159483.31620.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1302159483.31620.36.camel@localhost.localdomain>
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
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, Jeremy Fitzhardinge <Jeremy.Fitzhardinge@citrix.com>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mirq-linux@rere.qmqm.pl" <mirq-linux@rere.qmqm.pl>, "mingo@redhat.com" <mingo@redhat.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-visws-devel@lists.sf.net" <linux-visws-devel@lists.sf.net>, "tglx@linutronix.de" <tglx@linutronix.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "pazke@donpac.ru" <pazke@donpac.ru>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On 04/06/2011 11:58 PM, Ian Campbell wrote:
> 
> I'm not sure why ELAN belongs in the EXTENDED_PLATFORM option space
> rather than in the CPU choice option, since its only impact seems to be
> on -march, MODULE_PROC_FAMILY and some cpufreq drivers which doesn't
> sound like an extended platform to me but does it appear to be
> deliberate (see 9e111f3e167a "x86: move ELAN to the
> NON_STANDARD_PLATFORM section", that was the old name for
> EXTENDED_PLATFORM).
> 

Historic... we used to have nonstandard A20M# handling on Elan, until it
was discovered that we could make it work without it.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
