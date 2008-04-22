From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 0/3] xen: more portability patches
Date: Tue, 22 Apr 2008 16:00:03 +0900
Message-ID: <12088476062604-git-send-email-yamahata__32463.4566241459$1208848090$gmane$org@valinux.co.jp>
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
To: jeremy@goop.org
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, eddie.dong@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Jeremy.
Here are the 3 patches for ia64/xen support.
The first one is just to move manage.c under drivers/xen.
This is trivial.

The second and third ones are for compilation fix on ia64.
You may want to postpone those 2 patches to make your merge task
easy as you said before.

thanks,

Diffstat
 arch/x86/xen/Makefile              |    2 +-
 drivers/xen/Makefile               |    2 +-
 drivers/xen/balloon.c              |    8 ++++----
 {arch/x86 => drivers}/xen/manage.c |    0 
 include/xen/interface/memory.h     |   12 ++++++++----
 5 files changed, 14 insertions(+), 10 deletions(-)
 rename {arch/x86 => drivers}/xen/manage.c (100%)
