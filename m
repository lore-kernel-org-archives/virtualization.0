From: Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH 1/2] kvm/x86: Hyper-V synthetic interrupt controller
Date: Fri, 9 Oct 2015 18:53:09 +0300
Message-ID: <20151009155307.GU27239__4311.50305453247$1444649897$gmane$org@rkaganb.sw.ru>
References: <1444397988-20167-1-git-send-email-den@openvz.org>
	<1444397988-20167-2-git-send-email-den@openvz.org>
	<5617D259.8070101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5617D259.8070101@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Andrey Smetanin <asmetanin@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 09, 2015 at 04:42:33PM +0200, Paolo Bonzini wrote:
> You need to add SYNIC vectors to the EOI exit bitmap, so that APICv
> (Xeon E5 or higher, Ivy Bridge or newer) is handled correctly.  You also
> need to check the auto EOI exit bitmap in __apic_accept_irq, and avoid
> going through kvm_x86_ops->deliver_posted_interrupt for auto EOI
> vectors.  Something like
> 
> 	if (kvm_x86_ops->deliver_posted_interrupt &&
> 	    !test_bit(...))
> 
> in place of the existing "if (kvm_x86_ops->deliver_posted_interrupt)".

Indeed, missed that path, thanks!

> I really don't like this auto-EOI extension, but I guess that's the
> spec. :( If it wasn't for it, you could do everything very easily in
> userspace using Google's proposed MSR exit.

I guess you're right.  We'd probably have to (ab)use MSI for SINT
delivery, though.  Anyway the need to implement auto-EOI rules that out.

Thanks for the quick review, we'll try to address your comments in the
next round.

Roman.
