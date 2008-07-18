From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 24/29] ia64/pv_ops/xen: implement xen pv_time_ops.
Date: Fri, 18 Jul 2008 11:25:31 -0700
Message-ID: <4880E01B.6060902__25152.3655759685$1216405668$gmane$org@goop.org>
References: <12162606614068-git-send-email-yamahata@valinux.co.jp>
	<12162606623288-git-send-email-yamahata@valinux.co.jp>
	<487EDC6C.5000407@goop.org>
	<20080717061127.GF25137%yamahata@valinux.co.jp>
	<487F5571.5000803@goop.org>
	<20080718021732.GD26892%yamahata@valinux.co.jp>
	<4880216F.6040900@goop.org>
	<57C9024A16AD2D4C97DC78E552063EA3065E3595@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <57C9024A16AD2D4C97DC78E552063EA3065E3595@orsmsx505.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Isaku Yamahata <yamahata@valinux.co.jp>, "xen-ia64-devel@lists.xensource.com" <xen-ia64-devel@lists.xensource.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Alex Williamson <alex.williamson@hp.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Luck, Tony wrote:
>
> ITC is never synchronized between cpus.  On some systems all processor ITC
> may be driven from the same clock ... so an "offset from absolute system time"
> would work on those systems. But on others the ITC on different processors
> may be driven from different crystals, so the *rate* may be different. The
> difference may be small if the crystals have the same nominal frequency, but
> in the worst case the rates may be readically different (e.g. in some SGI
> systems ~1.2GHz on some cpus and ~1.6GHz on others).
>   

OK.  The patch in question has code like:

+	if (!time_after(delta_itm + new_itm, ia64_get_itc()))
+		stolentick = ia64_get_itc() - new_itm;
+
+	do_div(stolentick, NS_PER_TICK);


Which makes me assume that ia64_get_itc() is returning nanoseconds; does 
it do the adjustment from the itc's actual rate to nanoseconds?  Could 
it also apply an offset?

    J
