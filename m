From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 24/29] ia64/pv_ops/xen: implement xen pv_time_ops.
Date: Thu, 17 Jul 2008 07:21:37 -0700
Message-ID: <487F5571.5000803__21376.9368514933$1216304742$gmane$org@goop.org>
References: <12162606614068-git-send-email-yamahata@valinux.co.jp>
	<12162606623288-git-send-email-yamahata@valinux.co.jp>
	<487EDC6C.5000407@goop.org>
	<20080717061127.GF25137%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080717061127.GF25137%yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: xen-ia64-devel@lists.xensource.com, tony.luck@intel.com, linux-ia64@vger.kernel.org, Alex Williamson <alex.williamson@hp.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Isaku Yamahata wrote:
> I had explained about that.
> I had considered that option. However my conclusion is not share 
> he implementation because xen/ia64 timer interrupt isn't
> paravirtualized with VCPUOP_xxx hypercall. But xen/ia64 emulates
> ar.itm register. (ar.itm is interval time match register which triggers
> interrupt when interval time counter becomes same value)
>
> Since timer interruption is virtualized differently on xen/ia64,
> the different implementation is a natural consequence.

OK, that means the clockevent and clocksource part would be different.  
But the runstate accounting should still be the same, no?

    J
