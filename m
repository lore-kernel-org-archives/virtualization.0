From: Juergen Gross <jgross@suse.com>
Subject: Support of lguest?
Date: Mon, 15 May 2017 16:09:25 +0200
Message-ID: <7696c3d8-0ede-2704-34bb-d3d7dac6883d@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, xen-devel <xen-devel@lists.xenproject.org>, lguest@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

Lguest and Xen pv-guests are the only users of pv_mmu_ops (with the
one exception of the .exit_mmap member, which is being used by Xen
HVM-guests, too).

As it is possible now to build a kernel without Xen pv-guest support
while keeping PVH and PVHVM support, I thought about putting most
pv_mmu_ops functions in #ifdef CONFIG_XEN_HAS_PVMMU sections. If there
wouldn't be lguest...

So my question: is anybody still using lguest or would like to keep it?

If yes, I'd add CONFIG_PARAVIRT_MMU selected by CONFIG_XEN_PV and
CONFIG_LGUEST_GUEST.

If no, I'd remove lguest support and just use CONFIG_XEN_HAS_PVMMU,
in case nobody would like me to use CONFIG_PARAVIRT_MMU even if
lguest isn't there any more.


Juergen
