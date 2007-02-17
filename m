From: Rik van Riel <riel@redhat.com>
Subject: Re: Re: [patch 14/21] Xen-paravirt: Add XEN config	options
	and disableunsupported config options.
Date: Sat, 17 Feb 2007 10:06:40 -0500
Message-ID: <45D71A00.5080104@redhat.com>
References: <C1FBAFD7.99AB%keir@xensource.com> <45D62759.7080006@vmware.com>
	<45D63255.2070801@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45D63255.2070801@vmware.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Dan Hecht <dhecht@vmware.com>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, Steven Hand <steven.hand@cl.cam.ac.uk>, linux-kernel@vger.kernel.org, Ian Pratt <Ian.Pratt@xensource.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>, Christian Limpach <Christian.Limpach@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

Dan Hecht wrote:

> Yes, and regardless of whether you run your periodic timer slower than 
> HZ, calibrating time in a VM is always difficult due to the fact the 
> kernel is time sharing the physical cpu.  Why not just ask the 
> underlying hypervisor?

Upstream Xen does just that.

I'm guessing we'll want something similar for KVM paravirt.

-- 
Politics is the struggle between those who want to make their country
the best in the world, and those who believe it already is.  Each group
calls the other unpatriotic.
