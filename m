From: Avi Kivity <avi@redhat.com>
Subject: Re: [RFC] virtio: Support releasing lock during kick
Date: Tue, 29 Jun 2010 10:12:01 +0300
Message-ID: <4C299CC1.1020003__14623.7859655686$1277795598$gmane$org@redhat.com>
References: <1277328242-10685-1-git-send-email-stefanha@linux.vnet.ibm.com>	<20100628155505.GB4717@amt.cnet>
	<AANLkTikhPJnw81hhh3PQGSwv7Hkd56YMlOZQM0N-fTLp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikhPJnw81hhh3PQGSwv7Hkd56YMlOZQM0N-fTLp@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 06/29/2010 10:08 AM, Stefan Hajnoczi wrote:
>
> Is it incorrect to have the following pattern?
> spin_lock_irqsave(q->queue_lock);
> spin_unlock(q->queue_lock);
> spin_lock(q->queue_lock);
> spin_unlock_irqrestore(q->queue_lock);
>    

Perfectly legitimate.  spin_lock_irqsave() is equivalent to 
local_irq_save() followed by spin_lock() (with the potential 
optimization that we can service interrupts while spinning).

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
