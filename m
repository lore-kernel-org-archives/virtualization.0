From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 0/2] ia64/pv_ops documentation and pv checker
Date: Wed, 21 May 2008 16:31:10 +0900
Message-ID: <12113550722147-git-send-email-yamahata__17449.1379097619$1211355583$gmane$org@valinux.co.jp>
References: <1FE6DD409037234FAB833C420AA843EC0162EBE6@orsmsx424.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1FE6DD409037234FAB833C420AA843EC0162EBE6@orsmsx424.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tony.luck@intel.com, linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, eddie.dong@intel.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Here is .S paravirtualization checker and the draft of
the ia64/pv_ops documentation. These patches doesn't change kernel binary.
[PATCH 1/2] ia64/pv_ops: paravirtualized istruction checker.
[PATCH 2/2] ia64/pv_ops: documentation on ia64/pv_ops

The pv checker patch is to show my idea. CPP trick doesn't work because
some instructions includes "."(dot) which CPP doesn't handle well.
So I resorted to use sed in Makefile. Presumably the sed script should
be moved into a separated file.
Although the pv checker doesn't cover all the cases, I expect it can
detect most cases.

thanks,
