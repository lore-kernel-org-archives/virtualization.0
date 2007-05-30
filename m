From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH 2/3][PARAVIRT] Make IO delay a NOP
Date: Wed, 30 May 2007 09:53:02 -0500
Message-ID: <465D8FCE.1000409@us.ibm.com>
References: <465D8F03.7000201@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030607090201030303060303"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <465D8F03.7000201@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel <kvm-devel@lists.sourceforge.net>
Cc: virtualization <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------030607090201030303060303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards,

Anthony Liguori

--------------030607090201030303060303
Content-Type: text/x-patch;
 name="paravirt-no-iodelay.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="paravirt-no-iodelay.diff"

Subject: [PATCH][PARAVIRT] Make IO delay a NOP for paravirt guests

No delay is required in between PIO operations under KVM guests so make IO
delay a NOP.  This was originally part of Ingo Molnar's paravirt series.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

Index: kvm/arch/i386/kernel/kvm.c
===================================================================
--- kvm.orig/arch/i386/kernel/kvm.c	2007-05-30 09:30:42.000000000 -0500
+++ kvm/arch/i386/kernel/kvm.c	2007-05-30 09:31:46.000000000 -0500
@@ -28,9 +28,17 @@
 static DEFINE_PER_CPU(struct kvm_vcpu_para_state, para_state);
 extern unsigned char hypercall_addr[4];
 
+/*
+ * No need for any "IO delay" on KVM
+ */
+static void kvm_io_delay(void)
+{
+}
+
 static void kvm_guest_setup(void)
 {
 	paravirt_ops.name = "KVM";
+	paravirt_ops.io_delay = kvm_io_delay;
 	paravirt_ops.paravirt_enabled = 1;
 }
 

--------------030607090201030303060303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------030607090201030303060303--
