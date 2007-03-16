From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 03/26] Xen-paravirt_ops: use paravirt_nop to
 consistently mark no-op operations
Date: Fri, 16 Mar 2007 15:10:48 -0700
Message-ID: <45FB15E8.4080406@goop.org>
References: <20070301232443.195603797@goop.org>
	<20070301232526.261284776@goop.org>
	<20070316094432.GU23174@elte.hu> <45FAE560.10401@goop.org>
	<20070316194904.GO10574@sequoia.sous-sol.org>
	<45FAF77A.8010607@goop.org>
	<20070316215916.GP10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316215916.GP10574@sequoia.sous-sol.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Chris Wright <chrisw@sous-sol.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> I mean like this (bunch of work, for a type check that we're really ignoring
> anwyay, but this is the idea...)
>   

Oh, I see.  I think this is the best argument yet for the current
arrangement...

    J
