From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 03/26] Xen-paravirt_ops: use paravirt_nop to
 consistently mark no-op operations
Date: Fri, 16 Mar 2007 11:43:44 -0700
Message-ID: <45FAE560.10401@goop.org>
References: <20070301232443.195603797@goop.org>
	<20070301232526.261284776@goop.org>
	<20070316094432.GU23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316094432.GU23174@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> but only as a cleanup of the current open-coded (void *) casts. My 
> problem with this is that it loses the types. Not that there is much to 
> check for, but still, this adds some assumptions about how function 
> calls look like.

I agree.  I don't generally like this kind of hack, but having a single
test for "func == paravirt_nop" to look for nop pv_ops in the patcher is
what tipped the balance.

    J
