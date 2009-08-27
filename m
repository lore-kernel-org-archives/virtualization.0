From: Ryan Arnold <rsa@us.ibm.com>
Subject: Re: Extending virtio_console to support multiple ports
Date: Thu, 27 Aug 2009 09:13:28 -0500
Message-ID: <1251382408.3063.9.camel__27615.6097920195$1251397410$gmane$org@localhost.localdomain>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<20090826154552.GA31910@amit-x200.redhat.com>
	<1251349485.6267.6.camel@concordia>
	<20090827065251.GB3218@amit-x200.redhat.com>
Reply-To: rsa@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090827065251.GB3218@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, miltonm@bga.com, qemu-devel@nongnu.org, Michael Ellerman <michael@ellerman.id.au>, borntraeger@de.ibm.com, brueckner@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, alan@linux.intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2009-08-27 at 12:22 +0530, Amit Shah wrote:
> On (Thu) Aug 27 2009 [15:04:45], Michael Ellerman wrote:
>  Ryan you called his code "pure legacy baggage" if you
> > don't ;)
> > 
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commitdiff;h=d450b4ae023fb4be175389c18f4f87677da03020
> 
> Thanks for the link!
> 
> (and this general area might be the one that doesn't get major upheavals
> in 5-yr spans :-)

Actually, quite the opposite... too many cooks in the kitchen in the
last 6 years have left this code with some historical oddities.  When I
added the interrupt context code in the first place I made sure that the
driver did NOTHING in the interrupt handler except awaken the working
thread.  Someone in the subsequent years thought it'd be a good idea to
have the interrupt handler actually do the work.

Furthermore the front and backends were separated so that new front ends
can be used.  This was sometime in the last 5 years as well.

Let's just say I'm happy to pass the torch on this one.

I would suggest that someone perform throughput tests on this driver at
some point.  At the point where I stopped maintaining it I'd gotten the
driver to the point where there was no jerking output or lost data under
heavy I/O load.  I'm not sure where the driver's at now.

Ryan S. Arnold
