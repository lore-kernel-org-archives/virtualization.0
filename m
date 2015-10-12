From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [Qemu-devel] [PATCH 2/2] kvm/x86: Hyper-V kvm exit
Date: Mon, 12 Oct 2015 22:21:10 +0000
Message-ID: <BY2PR0301MB16549B1B49BE47814EB8B52FA0310@BY2PR0301MB1654.namprd03.prod.outlook.com>
References: <1444397988-20167-1-git-send-email-den@openvz.org>
	<1444397988-20167-3-git-send-email-den@openvz.org>
	<561BB8D2.60402@redhat.com> <561BB9A9.2070102@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <561BB9A9.2070102@openvz.org>
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
To: "Denis V. Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "rkagan@virtuozzo.com" <rkagan@virtuozzo.com>, Andrey Smetanin <asmetanin@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Denis V. Lunev [mailto:den@openvz.org]
> Sent: Monday, October 12, 2015 6:46 AM
> To: Eric Blake <eblake@redhat.com>
> Cc: Gleb Natapov <gleb@kernel.org>; qemu-devel@nongnu.org;
> virtualization@lists.linux-foundation.org; rkagan@virtuozzo.com; Paolo
> Bonzini <pbonzini@redhat.com>; Andrey Smetanin
> <asmetanin@virtuozzo.com>; Vitaly Kuznetsov <vkuznets@redhat.com>; KY
> Srinivasan <kys@microsoft.com>
> Subject: Re: [Qemu-devel] [PATCH 2/2] kvm/x86: Hyper-V kvm exit
> 
> On 10/12/2015 04:42 PM, Eric Blake wrote:
> > On 10/09/2015 07:39 AM, Denis V. Lunev wrote:
> >> From: Andrey Smetanin <asmetanin@virtuozzo.com>
> >>
> >> A new vcpu exit is introduced to notify the userspace of the
> >> changes in Hyper-V synic configuraion triggered by guest writing to the
> > s/configuraion/configuration/
> > Is 'synic' intended?  Is it short for something (if so, spelling it out
> > may help)?
> >
> >
> >> +++ b/Documentation/virtual/kvm/api.txt
> >> @@ -3331,6 +3331,12 @@ the userspace IOAPIC should process the EOI
> and retrigger the interrupt if
> >>   it is still asserted.  Vector is the LAPIC interrupt vector for which the
> >>   EOI was received.
> >>
> >> +		/* KVM_EXIT_HYPERV */
> >> +                struct kvm_hyperv_exit hyperv;
> >> +Indicates that the VCPU's exits into userspace to process some tasks
> > s/VCPU's/VCPU/
> >
> >> +related with Hyper-V emulation. Currently used to synchronize modified
> >> +Hyper-V synic state with userspace.
> > Again, is 'synic' intended?  Hmm, I see it throughout the patch, so it
> > looks intentional, but I keep trying to read it as a typo for 'sync'.
> >
> this is not a typo :)

Yes; the Hyper-V public functional spec has chosen this name;
it stands for Synthetic Interrupt Controller.

K. Y
