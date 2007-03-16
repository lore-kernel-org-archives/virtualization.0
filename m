From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 08/26] Xen-paravirt_ops: add hooks to
 intercept mm creation and destruction
Date: Fri, 16 Mar 2007 10:38:42 -0700
Message-ID: <45FAD622.2080306@goop.org>
References: <20070301232443.195603797@goop.org>
	<20070301232527.110592372@goop.org>
	<20070316093016.GP23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316093016.GP23174@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, linux-arch@vger.kernel.org, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>> Add hooks to allow a paravirt implementation to track the lifetime of 
>> an mm.
>>     
>
> (i guess this one should be merged with the ARCH-define cleanup patch)
>   

Already done.  In fact, I think I did it before the last patch post. 
Are you looking at an uptodate series of patches?
