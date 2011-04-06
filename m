From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] xen: drop anti-dependency on X86_VISWS
Date: Wed, 06 Apr 2011 14:45:15 -0700 (PDT)
Message-ID: <20110406.144515.235693855.davem__29041.9918056161$1302126678$gmane$org@davemloft.net>
References: <1301828839.2837.143.camel@edumazet-laptop>
	<20110403.172407.91341067.davem@davemloft.net>
	<1301910955.23887.75.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1301910955.23887.75.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ian.Campbell@eu.citrix.com
Cc: randy.dunlap@oracle.com, Jeremy.Fitzhardinge@citrix.com, eric.dumazet@gmail.com, konrad.wilk@oracle.com, netdev@vger.kernel.org, mirq-linux@rere.qmqm.pl, xen-devel@lists.xensource.com, hpa@zytor.com, linux-visws-devel@lists.sf.net, tglx@linutronix.de, virtualization@lists.linux-foundation.org, pazke@donpac.ru, mingo@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Ian Campbell <Ian.Campbell@eu.citrix.com>
Date: Mon, 4 Apr 2011 10:55:55 +0100

> You mean the "!X86_VISWS" I presume? It doesn't make sense to me either.

No, I think 32-bit x86 allmodconfig elides XEN because of it's X86_TSC dependency.

And, well, you could type "make allmodconfig" on your tree and see for
yourself instead of asking me :-)
