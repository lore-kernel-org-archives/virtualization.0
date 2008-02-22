From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [PATCH 13/28] ia64/xen: introduce xen hypercall routines
	necessary for domU.
Date: Fri, 22 Feb 2008 12:54:57 +0900
Message-ID: <20080222035457.GB2406%yamahata__23478.0227103785$1203652637$gmane$org@valinux.co.jp>
References: <20080221091731.641745000@ls.local.valinux.co.jp>
	<20080221091902.716789000@ls.local.valinux.co.jp>
	<47BE0D7E.7080301@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <47BE0D7E.7080301@goop.org>
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
Cc: virtualization@lists.linux-foundation.org, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 21, 2008 at 03:47:10PM -0800, Jeremy Fitzhardinge wrote:
> yamahata@valinux.co.jp wrote:
> >+static inline unsigned long
> >+HYPERVISOR_machtophys(unsigned long mfn)
> >+{
> >+	unsigned long ret = mfn;
> >+	if (is_running_on_xen())
> >  
> 
> Do you often call hypercalls when not booting under Xen?  It seems to me 
> this check should have already been done at a higher layer, and it 
> needn't be repeated here.

IA64 pv_ops frame work doesn't exist yet so that xen code does
in order to boot on both native and xen for now.
I expect those check will be eliminated during developing ia64 pv_ops.

-- 
yamahata
