From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH] x86/xen: remove duplicated include
Date: Tue, 5 Oct 2010 13:44:33 +0200
Message-ID: <20101005134433.511e84f4@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Remove duplicated include.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 arch/x86/xen/enlighten.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 7d46c84..3396891 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -58,7 +58,6 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/reboot.h>
-#include <asm/setup.h>
 #include <asm/stackprotector.h>
 #include <asm/hypervisor.h>
 
-- 
1.7.2.2
