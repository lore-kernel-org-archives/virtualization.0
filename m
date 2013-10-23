From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC 1/7] virtio_ring: add new functions
	virtqueue{_set_broken()/_is_broken()}
Date: Wed, 23 Oct 2013 10:36:25 +1030
Message-ID: <87zjq0j1fi.fsf@rustcorp.com.au>
References: <1382445911-55657-1-git-send-email-graalfs@linux.vnet.ibm.com>
	<1382445911-55657-2-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1382445911-55657-2-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heinz Graalfs <graalfs@linux.vnet.ibm.com>, mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
> This patch adds 2 new functions:
>
> virtqueue_set_broken(): to be called when a virtqueue kick operation fails.
>
> virtqueue_is_broken(): can be called to query the virtqueue state after a host
> was kicked.
>
> Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>

Thanks for doing this!

But as shown by the following patches, the separation of kick and broken
test is a bad API.  We should make virtqueue_kick() and
virtqueue_notify() return a bool (ie. vq->broken).

We'll still need virtqueue_is_broken(), as it would be nice to make all
callers to virtqueue_get_buf() check it as well.

Cheers,
Rusty.
