From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 10/27] ia64/xen: xencomm conversion functions for
	hypercalls
Date: Wed, 18 Jun 2008 13:47:35 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA306213664__9645.53399612687$1213822184$gmane$org@orsmsx505.amr.corp.intel.com>
References: <12130840433561-git-send-email-yamahata@valinux.co.jp>
	<12130840431594-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12130840431594-git-send-email-yamahata@valinux.co.jp>
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
Cc: "xen-ia64-devel@lists.xensource.com" <xen-ia64-devel@lists.xensource.com>, "Dong, Eddie" <eddie.dong@intel.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> On ia64/xen, pointer arguments for hypercall is passed
> by pseudo physical address(guest physical address.)
> So such hypercalls needs address conversion functions.
> This patch implements concreate conversion functions for
s/concreate/concrete/

-Tony
