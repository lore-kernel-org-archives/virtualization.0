From: Carsten Otte <cotte@de.ibm.com>
Subject: [RFC/PATCH 03/15 v3] preparation: address of the 64bit extint parm
	in lowcore
Date: Tue, 25 Mar 2008 18:47:15 +0100
Message-ID: <1206467235.6507.39.camel__6170.40119036591$1206467618$gmane$org@cotte.boeblingen.de.ibm.com>
References: <1206030270.6690.51.camel@cotte.boeblingen.de.ibm.com>
	<1206205354.7177.82.camel@cotte.boeblingen.de.ibm.com>
	<1206458154.6217.12.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206458154.6217.12.camel@cotte.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm-devel@lists.sourceforge.net, Avi Kivity <avi@qumranet.com>
Cc: aliguori@us.ibm.com, EHRHARDT@de.ibm.com, arnd@arndb.de, hollisb@us.ibm.com, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, borntraeger@de.ibm.com, oliver.paukstadt@millenux.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang, Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

The address 0x11b8 is used by z/VM for pfault and diag 250 I/O to
provide a 64 bit extint parameter. virtio uses the same address, so
its time to update the lowcore structure.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Carsten Otte <cotte@de.ibm.com>
---
 include/asm-s390/lowcore.h |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

Index: kvm/include/asm-s390/lowcore.h
===================================================================
--- kvm.orig/include/asm-s390/lowcore.h
+++ kvm/include/asm-s390/lowcore.h
@@ -380,27 +380,32 @@ struct _lowcore
         /* whether the kernel died with panic() or not */
         __u32        panic_magic;              /* 0xe00 */
 
-	__u8         pad13[0x1200-0xe04];      /* 0xe04 */
+	__u8         pad13[0x11b8-0xe04];      /* 0xe04 */
+
+	/* 64 bit extparam used for pfault, diag 250 etc  */
+	__u64        ext_params2;               /* 0x11B8 */
+
+	__u8         pad14[0x1200-0x11C0];      /* 0x11C0 */
 
         /* System info area */ 
 
 	__u64        floating_pt_save_area[16]; /* 0x1200 */
 	__u64        gpregs_save_area[16];      /* 0x1280 */
 	__u32        st_status_fixed_logout[4]; /* 0x1300 */
-	__u8         pad14[0x1318-0x1310];      /* 0x1310 */
+	__u8         pad15[0x1318-0x1310];      /* 0x1310 */
 	__u32        prefixreg_save_area;       /* 0x1318 */
 	__u32        fpt_creg_save_area;        /* 0x131c */
-	__u8         pad15[0x1324-0x1320];      /* 0x1320 */
+	__u8         pad16[0x1324-0x1320];      /* 0x1320 */
 	__u32        tod_progreg_save_area;     /* 0x1324 */
 	__u32        cpu_timer_save_area[2];    /* 0x1328 */
 	__u32        clock_comp_save_area[2];   /* 0x1330 */
-	__u8         pad16[0x1340-0x1338];      /* 0x1338 */ 
+	__u8         pad17[0x1340-0x1338];      /* 0x1338 */
 	__u32        access_regs_save_area[16]; /* 0x1340 */ 
 	__u64        cregs_save_area[16];       /* 0x1380 */
 
 	/* align to the top of the prefix area */
 
-	__u8         pad17[0x2000-0x1400];      /* 0x1400 */
+	__u8         pad18[0x2000-0x1400];      /* 0x1400 */
 #endif /* !__s390x__ */
 } __attribute__((packed)); /* End structure*/
