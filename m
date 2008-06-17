From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 04/27] ia64/xen: introduce definitions necessary for
	ia64/xen hypercalls.
Date: Tue, 17 Jun 2008 16:37:45 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA3061C5C18__31663.0781897858$1213746006$gmane$org@orsmsx505.amr.corp.intel.com>
References: <12130840433561-git-send-email-yamahata@valinux.co.jp>
	<12130840432529-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12130840432529-git-send-email-yamahata@valinux.co.jp>
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
Cc: Jeremy@smtp1.linux-foundation.org, "Dong, Eddie" <eddie.dong@intel.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Robin Holt <holt@sgi.com>, "xen-ia64-devel@lists.xensource.com" <xen-ia64-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

03/27 was fine.

04/27 ... I've no idea what it is all for ... I expect I'll find out later
in the patch series :-)

One style quibble ... I don't see much of this elsewhere in the Linux code:
+/*
+ * Local variables:
+ * mode: C
+ * c-set-style: "BSD"
+ * c-basic-offset: 4
+ * tab-width: 4
+ * indent-tabs-mode: nil
+ * End:
+ */


and I hate to be a trend setter.

-Tony
