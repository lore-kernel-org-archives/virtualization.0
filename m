From: Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH 1/2] kvm/x86: Hyper-V synthetic interrupt controller
Date: Mon, 12 Oct 2015 14:05:56 +0300
Message-ID: <20151012110554.GA2586__16435.8529415496$1444649909$gmane$org@rkaganb.sw.ru>
References: <1444397988-20167-1-git-send-email-den@openvz.org>
	<1444397988-20167-2-git-send-email-den@openvz.org>
	<5617D259.8070101@redhat.com> <561B6741.8080309@de.ibm.com>
	<20151012104848.396407b9.cornelia.huck@de.ibm.com>
	<561B763C.9050907@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <561B763C.9050907@redhat.com>
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
Cc: Gleb Natapov <gleb@kernel.org>, Andrey Smetanin <asmetanin@virtuozzo.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Denis V. Lunev" <den@openvz.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 12, 2015 at 10:58:36AM +0200, Paolo Bonzini wrote:
> On 12/10/2015 10:48, Cornelia Huck wrote:
> > Going back to Paolo's original question, I think changing the check
> > to !KVM_IRQ_ROUTING_IRQCHIP makes sense, if I understand the code
> > correctly. They seem to be the only special one.
> 
> Great.  Roman, Denis, can you do this then?

Sure, gonna be in the next round.

Thanks,
Roman.
