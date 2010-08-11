From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] paravirt: noreplace-paravirt is implemented for x86 and
 ia-64
Date: Wed, 11 Aug 2010 18:34:09 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008111832510.2702@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

kernel-parameters.txt lists 'noreplace-paravirt' parameter as being
limited to X86-32, which is incorrect -- it's actually supported by
x86-32, x86-64 and ia-64.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 Documentation/kernel-parameters.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index d529b13..8ed3a77 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1777,7 +1777,7 @@ and is between 256 and 4096 characters. It is defined in the file
 	norandmaps	Don't use address space randomization.  Equivalent to
 			echo 0 > /proc/sys/kernel/randomize_va_space
 
-	noreplace-paravirt	[X86-32,PV_OPS] Don't patch paravirt_ops
+	noreplace-paravirt	[X86,IA-64,PV_OPS] Don't patch paravirt_ops
 
 	noreplace-smp	[X86-32,SMP] Don't replace SMP instructions
 			with UP alternatives
-- 
1.7.2.1
