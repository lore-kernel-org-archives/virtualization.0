From: Dor Laor <dor.laor@gmail.com>
Subject: [Virtio-for-kvm] [PATCH 4/7] userspace virtio
Date: Fri, 21 Dec 2007 16:44:05 +0200
Message-ID: <476BD135.9030403__49367.626119829$1198248342$gmane$org@qumranet.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rus>
List-Id: virtualization@lists.linuxfoundation.org

 From bf5361f9b8b00f85e93cddf853f8f7f449c8d8c2 Mon Sep 17 00:00:00 2001
From: Dor Laor <dor.laor@qumranet.com>
Date: Sun, 9 Dec 2007 12:17:36 +0200
Subject: [PATCH] Add NIC vendor option to kvm python script

It allows picking other NIC vendors than rtl8139.
Use --nictype=xxx, the ddefault is rtl8139.

Signed-off-by: Dor Laor <dor.laor@qumranet.com>
---
 kvm |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/kvm b/kvm
index 0374fbc..2a7dc85 100755
--- a/kvm
+++ b/kvm
@@ -55,6 +55,12 @@ optparser.add_option('--no-tap',
                      default = not privileged,
                      )
 
+optparser.add_option('--nictype',
+                     help = 'use this specific nic type (vendor)',
+                     dest = 'nictype',
+                     default = 'rtl8139',
+                     )
+
 optparser.add_option('--mac',
                      help = 'use this specific mac addr',
                      dest = 'mac',
@@ -239,7 +245,7 @@ if not options.notap:
         mac_components[0] = 'a0'
         mac = ':'.join(mac_components)
             
-    qemu_args += ('-net', 'nic,macaddr=%s,model=rtl8139' % (mac,),
+    qemu_args += ('-net', 'nic,macaddr=%s,model=%s' % 
(mac,options.nictype,),
                   '-net', 'tap,script=/etc/kvm/qemu-ifup',)
 
 if options.vnc:
-- 
1.5.3.3
