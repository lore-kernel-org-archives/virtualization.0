From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch 13/21] Xen-paravirt: Add nosegneg capability
 to the vsyscall page notes
Date: Thu, 15 Feb 2007 22:06:37 -0800
Message-ID: <45D549ED.4000206@vmware.com>
References: <20070216022449.739760547@goop.org>
	<20070216022531.495288020@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070216022531.495288020@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Add the "nosegneg" fake capabilty to the vsyscall page notes. This is
> used by the runtime linker to select a glibc version which then
> disables negative-offset accesses to the thread-local segment via
> %gs. These accesses require emulation in Xen (because segments are
> truncated to protect the hypervisor address space) and avoiding them
> provides a measurable performance boost.
>
> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
>   

Acked-by: Zachary Amsden <zach@vmware.com>

We would like to see this by dynamic, but that is much more difficult to 
achieve, and seeing your recent linker issues, I don't think this should 
gate merging this code.  The performance loss for us I believe to be 
negligible, and the fix is quite a bit more complicated than something 
achievable in the .21 timeframe.

Zach
