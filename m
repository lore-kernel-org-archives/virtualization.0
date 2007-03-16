From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 07/26] Xen-paravirt_ops: Allow paravirt
	backend to choose kernel PMD sharing
Date: Fri, 16 Mar 2007 10:31:19 +0100
Message-ID: <20070316093119.GQ23174@elte.hu>
References: <20070301232443.195603797@goop.org>
	<20070301232526.832915500@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070301232526.832915500@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Normally when running in PAE mode, the 4th PMD maps the kernel address 
> space, which can be shared among all processes (since they all need 
> the same kernel mappings.
> 
> Xen, however, does not allow guests to have the kernel pmd shared 
> between page tables, so parameterize pgtable.c to allow both modes of 
> operation.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
