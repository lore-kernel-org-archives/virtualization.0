From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] kvm/x86: Hyper-V synthetic interrupt controller
Date: Fri, 9 Oct 2015 17:58:41 +0200
Message-ID: <5617E431.3070809@redhat.com>
References: <1444397988-20167-1-git-send-email-den@openvz.org>
	<1444397988-20167-2-git-send-email-den@openvz.org>
	<5617D259.8070101@redhat.com> <20151009155307.GU27239@rkaganb.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151009155307.GU27239@rkaganb.sw.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Roman Kagan <rkagan@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, Andrey Smetanin <asmetanin@virtuozzo.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org



On 09/10/2015 17:53, Roman Kagan wrote:
> > I really don't like this auto-EOI extension, but I guess that's the
> > spec. :( If it wasn't for it, you could do everything very easily in
> > userspace using Google's proposed MSR exit.
> I guess you're right.  We'd probably have to (ab)use MSI for SINT
> delivery, though.

Not really an issue, as MSI on x86 is really just the external entry
point into the LAPIC, it makes sense that it be the external interface
into KVM's virtualized LAPIC.  Userspace split irqchip is (ab)using MSI
routes the same way.

> Anyway the need to implement auto-EOI rules that out.

Yup.  I look forward to reviewing v2!

Paolo
