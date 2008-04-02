From: Jes Sorensen <jes@sgi.com>
Subject: Re: [02/17][PATCH] Implement smp_call_function_mask for ia64 - V8
Date: Wed, 02 Apr 2008 09:30:55 +0200
Message-ID: <47F3362F.3020504__10965.3018568226$1207121745$gmane$org@sgi.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC01048240@pdsmsx415.ccr.corp.intel.com>	<47F0AB18.2010707@sgi.com>
	<47F0FCFE.5010106@goop.org> <47F1F3B1.7020308@sgi.com>
	<47F25D6B.40704@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47F25D6B.40704@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Carsten Otte <cotte@de.ibm.com>, "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org, "Xu,
	Anthony" <anthony.xu@intel.com>, "Zhang, Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
>> I wasn't suggesting we shouldn't have both interfaces, merely
>> questioning why adding what to me seems like an unnecessary performance
>> hit for the classic case of the call.
> 
> I don't mind how many interfaces there are, so long as there only needs 
> to be one place to hook to plug in the Xen version of 
> smp_call_function_whatever.  Perhaps the answer is to just hook the IPI 
> mechanism itself rather than the whole of smp_call_function_mask...

Well we're obviously going to have at least two interfaces given that
we have the traditional Linux one and Xen seems to require something
different :-)

> Have you looked at Jens Axboe's patches to make all this stuff a lot 
> more arch-common?

Nope, do you have a pointer?

Cheers,
Jes
