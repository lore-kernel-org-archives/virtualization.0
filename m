From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH 2/3] virtio ring implementation
Date: Tue, 25 Sep 2007 09:43:38 +1000
Message-ID: <1190677418.27805.231.camel__4987.01791880212$1190677540$gmane$org@localhost.localdomain>
References: <1190625194.27805.199.camel@localhost.localdomain>
	<1190625256.27805.201.camel@localhost.localdomain>
	<1190625307.27805.203.camel@localhost.localdomain>
	<46F7BF41.9060705@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46F7BF41.9060705@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dor.laor@qumranet.com
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-09-24 at 15:44 +0200, Dor Laor wrote:
> Seems like there is a problem with shared irq line, the interrupt
> handler always returns IRQ_HANDLED (except for the trivial case
> were the callback is null).
>
> It can be solved by having a host irq counter (in the shared ring) and
> a guest irq counter and return
> mb(); return (host_counter!=guest_counter)? IRQ_HANDLED:IRQ_NONE;

Or we could make the callback return irqreturn_t and have an explicit
"disable" hook to disable interrupts.

Using the return value of the callback to disable the queue has always
made be a little uncomfortable, but it's slightly more efficient than a
separate hook.

Thanks,
Rusty.
