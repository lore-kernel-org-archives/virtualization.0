From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] virtio: don't always force a notification when ring is
	full
Date: Thu, 19 Jun 2008 10:14:34 +0200
Message-ID: <200806191014.34741.borntraeger@de.ibm.com>
References: <200806190940.57083.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200806190940.57083.rusty@rustcorp.com.au>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Donnerstag, 19. Juni 2008 schrieb Rusty Russell:
> We force notification when the ring is full, even if the host has
> indicated it doesn't want to know.  This seemed like a good idea at
> the time: if we fill the transmit ring, we should tell the host
> immediately.
> 
> Unfortunately this logic also applies to the receiving ring, which is
> refilled constantly.  We should introduce real notification thesholds
> to replace this logic.  Meanwhile, removing the logic altogether breaks
> the heuristics which KVM uses, so we use a hack: only notify if there are
> outgoing parts of the new buffer.


I did not yet finish the VIRTIO_F_NOTIFY_ON_EMPTY implementation for s390, so 
I cant tell for sure if it makes a difference.

Nevertheless, the patch looks good to me.
