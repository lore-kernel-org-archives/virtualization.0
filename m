From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_net: free transmit skbs in a timer
Date: Fri, 2 May 2008 20:55:25 +1000
Message-ID: <200805022055.25870.rusty__12370.7807194025$1209725899$gmane$org@rustcorp.com.au>
References: <1209565906-9019-1-git-send-email-markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1209565906-9019-1-git-send-email-markmc@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 01 May 2008 00:31:46 Mark McLoughlin wrote:
> virtio_net currently only frees old transmit skbs just
> before queueing new ones. If the queue is full, it then
> enables interrupts and waits for notification that more
> work has been performed.

Hi Mark,

   This patch is fine, but it's better to do it from skb_xmit_done().  Of 
course, this is usually called from an interrupt handler, so it's not 
entirely trivial: we can't free the skbs there.

   A softirq is probably the answer here, but AFAICT that's old fashioned.  
Not sure what the right way of doing this is now...

Rusty.
