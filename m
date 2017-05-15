From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: Support of lguest?
Date: Mon, 15 May 2017 16:22:12 +0200
Message-ID: <87r2zqi4iz.fsf@vitty.brq.redhat.com>
References: <7696c3d8-0ede-2704-34bb-d3d7dac6883d@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7696c3d8-0ede-2704-34bb-d3d7dac6883d@suse.com> (Juergen Gross's
	message of "Mon, 15 May 2017 16:09:25 +0200")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>
Cc: lguest@lists.ozlabs.org, xen-devel <xen-devel@lists.xenproject.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Juergen Gross <jgross@suse.com> writes:

> Lguest and Xen pv-guests are the only users of pv_mmu_ops (with the
> one exception of the .exit_mmap member, which is being used by Xen
> HVM-guests, too).
>
> As it is possible now to build a kernel without Xen pv-guest support
> while keeping PVH and PVHVM support, I thought about putting most
> pv_mmu_ops functions in #ifdef CONFIG_XEN_HAS_PVMMU sections.

There is an ongoing work to enable PV TLB flushing for Hyper-V guests:
http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2017-April/104411.html

it utilizes .flush_tlb_others member in pv_mmu_ops.

hopefully, this work will be merged in 4.13.

-- 
  Vitaly
