From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 26/27] ia64/pv_ops: update Kconfig for paravirtualized
	guest and xen.
Date: Wed, 18 Jun 2008 15:13:13 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA306213776__44901.7674466178$1213827317$gmane$org@orsmsx505.amr.corp.intel.com>
References: <12130840433561-git-send-email-yamahata@valinux.co.jp>
	<1213084044647-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1213084044647-git-send-email-yamahata@valinux.co.jp>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Cc: "xen-ia64-devel@lists.xensource.com" <xen-ia64-devel@lists.xensource.com>, "Dong, Eddie" <eddie.dong@intel.com>, Alex Williamson <alex.williamson@hp.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> introduce CONFIG_PARAVIRT_GUEST, CONFIG_PARAVIRT for
> paravirtualized guest.
> introduce CONFING_XEN, CONFIG_IA64_XEN for xen.

s/CONFING_XEN/CONFIG_XEN/

Would it make sense to rename CONFIG_IA64_XEN to be
CONFIG_IA64_XEN_GUEST?  The comments you add to
arch/ia64/Kconfig say that this is what it means.

-Tony
