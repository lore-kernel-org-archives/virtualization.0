From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/19] desc_struct integration
Date: Thu,  6 Dec 2007 14:16:21 -0200
Message-ID: <1196957800568-git-send-email-gcosta__40775.8406400264$1196967782$gmane$org@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Hi,

this is a series of patches that unify the struct desc_struct and friends
across x86_64 and i386. As usual, it provides paravirt capabilities as a
side-effect for x86_64.

I consider the main goal, namely, of unifying the desc_struct, an ongoing
effort, being this the beginning. A lot of old code has to be touched to
accomplish that. 

I don't consider this patch ready for inclusion. Basically, the main reason
is that I change the signatures of write_idt_entry(), write_gdt_entry(), and
write_ldt_entry(). This is needed to account for the differences between the
two architectures. (For example, gate descriptors in x86_64 are 16-byte long
and can't be represented by low and high entries). As my patch series were
64-bit only, I hadn't come across the problem before.

I think this interface is sane, but I'd like to hear opinions. Specially
from Jeremy and Zach, since it would touch xen and vmi code. The later, by
the way, is _not_ included in this series. Being the interface acked, we
still have to write it.

Thanks in advance for the review in opinions to come.
