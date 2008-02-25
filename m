From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 0/4] ia64/xen: paravirtualization of hand written assembly code
Date: Mon, 25 Feb 2008 12:16:42 +0900
Message-ID: <12039094061834-git-send-email-yamahata__29822.3576545299$1203909611$gmane$org@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-ia64@vger.kernel.org
Cc: xen-ia64-devel@lists.xensource.com, kvm-ia64-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi. The patch I send before was too large so that it was dropped from
the maling list. I'm sending again with smaller size.
This patch set is the xen paravirtualization of hand written assenbly
code. And I expect that much clean up is necessary before merge.
We really need the feed back before starting actual clean up as Eddie
already said before.

Eddie discussed how to clean up and suggested several ways.
  1: Dual IVT source code, dual IVT table. (The way this patch set adopted)
  2: Same IVT source code, but dual/mulitple compile to generate
     dual/multiple IVT table using assembler macro.
  3: Single IVT table, using indirect function call for pv_ops using
     branch/binary patching.

At this moment my preference is the option 2. Please comment.

thanks,
