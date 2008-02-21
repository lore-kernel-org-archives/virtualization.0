From: yamahata@valinux.co.jp
Subject: [PATCH 00/11] Xen arch portability patches
Date: Thu, 21 Feb 2008 17:45:30 +0900
Message-ID: <20080221084530.470680000__35509.5411222011$1203629424$gmane$org@ls.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20080221212809.GD16885%yamahata@valinux.co.jp>
Resent-To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        virtualization@lists.linux-foundation.org
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: xen-devel@lists.xensource.com, linux-ia64@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Hi. Recently the xen-ia64 community started to make efforts to merge 
xen/ia64 Linux to upstream. The first step is to merge up domU portion.
This patchset is preliminary for xen/ia64 domU linux making the current
xen/x86 domU code more arch generic and adding missing definitions and
files.

Diffstat:
 arch/x86/xen/Makefile                |    4 +-
 arch/x86/xen/grant-table.c           |   91 +++++++++++++
 drivers/xen/Makefile                 |    3 +-
 {arch/x86 => drivers}/xen/events.c   |   34 ++++--
 {arch/x86 => drivers}/xen/features.c |    0 
 drivers/xen/grant-table.c            |   37 +-----
 drivers/xen/xenbus/xenbus_client.c   |    6 +-
 drivers/xen/xencomm.c                |  232 ++++++++++++++++++++++++++++++++++
 include/asm-x86/xen/hypervisor.h     |   10 ++
 include/asm-x86/xen/interface.h      |   24 ++++
 include/{ => asm-x86}/xen/page.h     |    0 
 include/xen/events.h                 |    1 +
 include/xen/grant_table.h            |    6 +
 include/xen/interface/callback.h     |  119 +++++++++++++++++
 include/xen/interface/grant_table.h  |   11 ++-
 include/xen/interface/vcpu.h         |    5 +
 include/xen/interface/xen.h          |   22 +++-
 include/xen/interface/xencomm.h      |   41 ++++++
 include/xen/page.h                   |  181 +--------------------------
 include/xen/xencomm.h                |   77 +++++++++++
 20 files changed, 673 insertions(+), 231 deletions(-)

-- 
yamahata
