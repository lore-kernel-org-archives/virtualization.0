From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 22/26] Xen-paravirt_ops: Add early printk
	support via hvc console
Date: Fri, 16 Mar 2007 09:52:08 +0100
Message-ID: <20070316085208.GD23174@elte.hu>
References: <20070301232443.195603797@goop.org>
	<20070301232529.031999567@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070301232529.031999567@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Add early printk support via hvc console, enable using
> "earlyprintk=xen" on the kernel command line.
> 
> From: Gerd Hoffmann <kraxel@suse.de>
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
