From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 12/21] Xen-paravirt: Allocate and free
	vmalloc areas
Date: Fri, 16 Feb 2007 08:46:43 -0800
Message-ID: <45D5DFF3.6040005@goop.org>
References: <20070216022449.739760547@goop.org>
	<20070216022531.417300365@goop.org>
	<20070215224322.5c73d8e9.akpm@linux-foundation.org>
	<45D55852.9000103@goop.org>
	<20070215232447.5ee67f50.akpm@linux-foundation.org>
	<45D55DB1.7040002@goop.org> <20070216091843.GB28196@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070216091843.GB28196@muc.de>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andi Kleen <ak@muc.de>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> It's for populating the pagetable in a vmalloc area.  There's magic in
>>     
>
> If the lazy setup doesn't work for you you can always call vmalloc_sync()
> early.
>   

Yes, that would work.  Unfortunately that's i386 arch-specific, whereas
the rest of this code is generic.  I guess I could just move it all to
arch/i386/mm.

    J
