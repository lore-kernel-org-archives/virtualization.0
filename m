From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Use memset(0) instead of setting cb_mode explicitly
Date: Fri, 4 Jan 2008 14:03:47 +1100
Message-ID: <200801041403.47243.rusty__32570.6651238308$1199416037$gmane$org@rustcorp.com.au>
References: <11993758341994-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11993758341994-git-send-email-aliguori@us.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: kvm-devel@lists.sourceforge.net, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 04 January 2008 02:57:14 Anthony Liguori wrote:
> hrtimer's only have a cb_mode if CONFIG_HIGH_RES_TIMER is enabled.  This
> patch memset()s the tx_timer structure to 0 which has the same effect as
> setting cb_mode to HRTIMER_CB_SOFTIRQ without requiring
> CONFIG_HIGH_RES_TIMER to be set.  This seems to be what other drivers do.

Thanks, applied.

Rusty.
