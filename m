From: Akio Takebe <takebe_akio@jp.fujitsu.com>
Subject: Re: [11/17][PATCH] kvm/ia64: add processor virtulization support.
Date: Fri, 28 Mar 2008 23:06:27 +0900
Message-ID: <89C890DCEA6547takebe_akio__10042.2554569834$1206713619$gmane$org@jp.fujitsu.com>
References: <42DFA526FC41B1429CE7279EF83C6BDCFF7EF5@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDCFF7EF5@pdsmsx415.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhang, Xiantao" <xiantao.zhang@intel.com>, Avi Kivity <avi@qumranet.com>, "Luck, Tony" <tony.luck@intel.com>, "Xu, Anthony" <anthony.xu@intel.com>, Jes Sorensen <jes>
List-Id: virtualization@lists.linuxfoundation.org

Hi, Xiantao and Anthony

>+void getfpreg(unsigned long regnum, struct ia64_fpreg *fpval,
>+				struct kvm_pt_regs *regs)
>+{
>+	/* Take floating register rotation into consideration*/
>+	if (regnum >= IA64_FIRST_ROTATING_FR)
>+		regnum = IA64_FIRST_ROTATING_FR + fph_index(regs,
>regnum);
>+#define CASE_FIXED_FP(reg)			\
>+	case  (reg) :				\
>+		ia64_stf_spill(fpval, reg);	\
>+	break
>+
>+	switch (regnum) {
>+		CASE_FIXED_FP(0);
>+		CASE_FIXED_FP(1);
>+		CASE_FIXED_FP(2);
>+		CASE_FIXED_FP(3);
>+		CASE_FIXED_FP(4);
>+		CASE_FIXED_FP(5);
>+
>+		CASE_FIXED_FP(6);
>+		CASE_FIXED_FP(7);
>+		CASE_FIXED_FP(8);
>+		CASE_FIXED_FP(9);
>+		CASE_FIXED_FP(10);
>+		CASE_FIXED_FP(11);
>+
Is this correct ? Though I don't know why xen do so.
In the case of Xen, the above parts are;

#define CASE_SAVED_FP(reg)                                      \
        case reg:                                               \
                fpval->u.bits[0] = regs->f##reg.u.bits[0];      \
                fpval->u.bits[1] = regs->f##reg.u.bits[1];      \
                break

                CASE_SAVED_FP(6);
                CASE_SAVED_FP(7);
                CASE_SAVED_FP(8);
                CASE_SAVED_FP(9);
                CASE_SAVED_FP(10);
                CASE_SAVED_FP(11);


>+void setfpreg(unsigned long regnum, struct ia64_fpreg *fpval,
>+					struct kvm_pt_regs *regs)
>+{
>+	/* Take floating register rotation into consideration*/
>+	if (regnum >= IA64_FIRST_ROTATING_FR)
>+		regnum = IA64_FIRST_ROTATING_FR + fph_index(regs,
>regnum);
>+
>+#define CASE_FIXED_FP(reg)			\
>+	case (reg) :				\
>+		ia64_ldf_fill(reg, fpval);	\
>+	break
>+
>+	switch (regnum) {
>+		CASE_FIXED_FP(2);
>+		CASE_FIXED_FP(3);
>+		CASE_FIXED_FP(4);
>+		CASE_FIXED_FP(5);
>+
>+		CASE_FIXED_FP(6);
>+		CASE_FIXED_FP(7);
>+		CASE_FIXED_FP(8);
>+		CASE_FIXED_FP(9);
>+		CASE_FIXED_FP(10);
>+		CASE_FIXED_FP(11);
>+
ditto.

#define CASE_RESTORED_FP(reg)                                   \
        case reg:                                               \
                regs->f##reg.u.bits[0] = fpval->u.bits[0];      \
                regs->f##reg.u.bits[1] = fpval->u.bits[1] ;     \
                break

                CASE_RESTORED_FP(6);
                CASE_RESTORED_FP(7);
                CASE_RESTORED_FP(8);
                CASE_RESTORED_FP(9);
                CASE_RESTORED_FP(10);
                CASE_RESTORED_FP(11);


Best Regards,

Akio Takebe
