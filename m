From: Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [kvm-unit-tests PATCH] x86: hyperv_synic: Hyper-V SynIC test
Date: Mon, 2 Nov 2015 15:48:37 +0300
Message-ID: <20151102124836.GA6221@rkaganb.sw.ru>
References: <1445853369-24435-1-git-send-email-asmetanin@virtuozzo.com>
	<56375402.7060406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <56375402.7060406@redhat.com>
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
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Andrey Smetanin <asmetanin@virtuozzo.com>, "Denis
	V. Lunev" <den@openvz.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 02, 2015 at 01:16:02PM +0100, Paolo Bonzini wrote:
> On 26/10/2015 10:56, Andrey Smetanin wrote:
> > Hyper-V SynIC is a Hyper-V synthetic interrupt controller.
> > 
> > The test runs on every vCPU and performs the following steps:
> > * read from all Hyper-V SynIC MSR's
> > * setup Hyper-V SynIC evt/msg pages
> > * setup SINT's routing
> > * inject SINT's into destination vCPU by 'hyperv-synic-test-device'
> > * wait for SINT's isr's completion
> > * clear Hyper-V SynIC evt/msg pages and destroy SINT's routing
> > 
> > Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
> > Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > CC: Vitaly Kuznetsov <vkuznets@redhat.com>
> > CC: "K. Y. Srinivasan" <kys@microsoft.com>
> > CC: Gleb Natapov <gleb@kernel.org>
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > CC: Roman Kagan <rkagan@virtuozzo.com>
> > CC: Denis V. Lunev <den@openvz.org>
> > CC: qemu-devel@nongnu.org
> > CC: virtualization@lists.linux-foundation.org
> 
> Bad news.
> 
> The test breaks with APICv, because of the following sequence of events:

Thanks for testing and analyzing this!

(... running around looking for an APICv-capable machine to be able to
catch this ourselves before we resubmit ...)

> The question then is... does Hyper-V actually use auto-EOI interrupts?
> If it doesn't, we might as well not implement them... :/

As Den wrote, we've yet to see a hyperv device which doesn't :(

Roman.
