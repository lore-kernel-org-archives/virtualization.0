From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] xen: drop anti-dependency on X86_VISWS
Date: Thu, 07 Apr 2011 11:07:38 -0700
Message-ID: <4D9DFD6A.1060200__1815.37929825044$1302199724$gmane$org@goop.org>
References: <1301828839.2837.143.camel@edumazet-laptop>	<20110403.172407.91341067.davem@davemloft.net>	<1301910955.23887.75.camel@zakaz.uk.xensource.com>	<20110406.144515.235693855.davem@davemloft.net>
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
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, Jeremy Fitzhardinge <Jeremy.Fitzhardinge@citrix.com>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mirq-linux@rere.qmqm.pl" <mirq-linux@rere.qmqm.pl>, "mingo@redhat.com" <mingo@redhat.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "hpa@zytor.com" <hpa@zytor.com>, "linux-visws-devel@lists.sf.net" <linux-visws-devel@lists.sf.net>, "tglx@linutronix.de" <tglx@linutronix.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "pazke@donpac.ru" <pazke@donpac.ru>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On 04/06/2011 11:58 PM, Ian Campbell wrote:
> On Wed, 2011-04-06 at 22:45 +0100, David Miller wrote:
>> From: Ian Campbell <Ian.Campbell@eu.citrix.com>
>> Date: Mon, 4 Apr 2011 10:55:55 +0100
>>
>>> You mean the "!X86_VISWS" I presume? It doesn't make sense to me either.
>> No, I think 32-bit x86 allmodconfig elides XEN because of it's X86_TSC dependency.
> TSC is a real dependency of the Xen interfaces.

Not really.  The TSC register is a requirement, but that's going to be
present on any CPU which can boot Xen.  We don't need any of the
kernel's TSC machinery though.

    J
