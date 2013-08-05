From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V11 15/18] kvm : Paravirtual ticketlocks support for
	linux guests running on KVM hypervisor
Date: Mon, 05 Aug 2013 20:09:51 +0530
Message-ID: <51FFB937.6050003__21089.3194810071$1375713256$gmane$org@linux.vnet.ibm.com>
References: <51F0ED31.3040200@linux.vnet.ibm.com>
	<20130731062440.GK28372@redhat.com>
	<51FA1087.9080908@linux.vnet.ibm.com>
	<20130802092539.GB28327@gmail.com>
	<20130802095406.GB30072@redhat.com>
	<20130805094603.GA29303@gmail.com>
	<20130805095901.GL2258@redhat.com>
	<20130805135222.GA32429@gmail.com>
	<1952910281.9619371.1375711538505.JavaMail.root@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1952910281.9619371.1375711538505.JavaMail.root@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: jeremy@goop.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, Ingo Molnar <mingo@kernel.org>, stefano stabellini <stefano.stabellini@eu.citrix.com>, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad wilk <konrad.wilk@oracle.com>, ouyang@cs.pitt.edu, avi kivity <avi.kivity@gmail.com>, tglx@linutronix.de, chegu vinod <chegu_vinod@hp.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, srivatsa vaddagiri <srivatsa.vaddagiri@gmail.com>, attilio rao <attilio.rao@citrix.com>, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/05/2013 07:35 PM, Paolo Bonzini wrote:
>>>> I guess you'd want to carry this in the KVM tree or so - maybe in a
>>>> separate branch because it changes Xen as well?
>>>
>>> It changes KVM host and guest side, XEN and common x86 spinlock code. I
>>> think it would be best to merge common x86 spinlock bits and guest side
>>> KVM/XEN bits through tip tree and host KVM part will go through KVM
>>> tree. If this is OK with you, Ingo, and XEN folks Raghavendra can send
>>> two separate patch series one for the tip and one for KVM host side.
>>
>> Sure, that's fine - if the initial series works fine in isolation as well
>> (i.e. won't break anything).
>
> It would be a big problem if it didn't!  Raghavendra, please send the
> two separate series as Gleb explained above.
>

Yes. Sure.  The patches have been split in that way.

Only thing I am thinking is about KVM_FEATURE_PV_UNHALT, and 
KVM_HC_KICK_CPU definition in the below hunk, that is needed by guest
as well. may be this header file change can be a separate patch so that
duplicate can be handled easily during merge?

I do testing of all combination after splitting and post.

diff --git a/arch/x86/include/uapi/asm/kvm_para.h 
b/arch/x86/include/uapi/asm/kvm_para.h
index 06fdbd9..94dc8ca 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -23,6 +23,7 @@
  #define KVM_FEATURE_ASYNC_PF           4
  #define KVM_FEATURE_STEAL_TIME         5
  #define KVM_FEATURE_PV_EOI             6
+#define KVM_FEATURE_PV_UNHALT          7

diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
index cea2c5c..2841f86 100644
--- a/include/uapi/linux/kvm_para.h
+++ b/include/uapi/linux/kvm_para.h
@@ -19,6 +19,7 @@
  #define KVM_HC_MMU_OP                  2
  #define KVM_HC_FEATURES                        3
  #define KVM_HC_PPC_MAP_MAGIC_PAGE      4
+#define KVM_HC_KICK_CPU                        5
