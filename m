From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: [PATCH] Move KVM, paravirt, lguest, VMI and Xen under arch-level
 Virtualization option
Date: Sat, 21 Jul 2007 17:49:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0707211748320.21737__48766.4259890609$1185033134$gmane$org@fbirervta.pbzchgretzou.qr>
References: <1184905342.10380.263.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184905342.10380.263.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


On Jul 20 2007 14:22, Rusty Russell wrote:
>Subject: [PATCH] Move KVM, paravirt, lguest,
>    VMI and Xen under arch-level Virtualization option
>
>Any objections?

Well btw, would it make sense to also rearrange the directory structure along
with it, i.e.

drivers/kvm    => drivers/virt/kvm
drivers/lguest => drivers/virt/lguest
drivers/xen    => drivers/virt/xen

Then the full kconfig (with menuconfig,if,endif) can go to
drivers/virt/Kconfig.


	Jan
-- 
