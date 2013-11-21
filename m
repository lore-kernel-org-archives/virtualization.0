From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC 1/3] virtio: add notify() callback to virtio_driver
Date: Thu, 21 Nov 2013 12:00:55 +1030
Message-ID: <87bo1ebkxc.fsf@rustcorp.com.au>
References: <1384960923-31463-1-git-send-email-graalfs@linux.vnet.ibm.com>
	<1384960923-31463-2-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1384960923-31463-2-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heinz Graalfs <graalfs@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com, Jens Axboe <axboe@kernel.dk>, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
> Add an optional notify() callback to virtio_driver. A backend
> driver can provide this callback to perform actions for a lost
> device.
>
> notify() event values are inherited from virtio_ccw's notify()
> callback. We might want to support even more of them lateron.
>
> notify() return values are defined in include/linux/notifier.h.
>
> Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>

These patches seem sensible.  I've applied them in my pending queue,
but it'd be nice to have some feedback on the virtio_blk.c patch.

Cheers,
Rusty.
