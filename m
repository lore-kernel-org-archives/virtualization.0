From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] virtio_net: free transmit skbs in a timer
Date: Tue, 13 May 2008 10:47:02 +0300
Message-ID: <48294776.3010504__13273.8284919926$1210664947$gmane$org@qumranet.com>
References: <1209565906-9019-1-git-send-email-markmc@redhat.com>	<200805022055.25870.rusty@rustcorp.com.au>
	<1210624663.14409.20.camel@muff>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1210624663.14409.20.camel@muff>
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

Mark McLoughlin wrote:
> virtio_net currently only frees old transmit skbs just
> before queueing new ones. If the queue is full, it then
> enables interrupts and waits for notification that more
> work has been performed.
>
> However, a side-effect of this scheme is that there are
> always xmit skbs left dangling when no new packets are
> sent, against the Documentation/networking/driver.txt
> guideline:
>
>   "... it is not allowed for your TX mitigation scheme
>    to let TX packets "hang out" in the TX ring unreclaimed
>    forever if no new TX packets are sent."
>
> Add a timer to ensure that any time we queue new TX
> skbs, we will shortly free them again.
>
> This fixes an easily reproduced hang at shutdown where
> iptables attempts to unload nf_conntrack and nf_conntrack
> waits for an skb it is tracking to be freed, but virtio_net
> never frees it.
>   

Sorry to barge in late, but IMO the timer should be on the host, which 
is cheaper than on the guest (well, a 100ms timer is likely zero cost, 
but  I still don't like it).

the host should fire a tx completion interrupt whenever the completion 
queue has "enough" entries, where we can define "enough" now as the 
halfway mark or a timer expiry, whichever comes earlier.

We can later improve "enough" to be "just enough so the timer never 
triggers" and adjust it dynamically.  It probably doesn't matter for 
Linux, but I don't want to punish guests that can do true async 
networking and depend on timely completion notification.

-- 
error compiling committee.c: too many arguments to function
