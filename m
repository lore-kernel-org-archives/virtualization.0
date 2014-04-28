From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/1] virtio_ccw: introduce device_lost in virtio_ccw_device
Date: Mon, 28 Apr 2014 11:24:30 +0930
Message-ID: <87fvkyte09.fsf@rustcorp.com.au>
References: <1398429327-31391-1-git-send-email-graalfs@linux.vnet.ibm.com>
	<1398429327-31391-2-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1398429327-31391-2-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
> When a device is lost, the common I/O layer calls the notification
> handler with CIO_GONE: In that event, flag device_lost as true.
>
> In case the device had been flagged as lost when the remove/offline callbacks
> are called, call the new virtio_break_device() function prior to invoking
> device_unregister(). This avoids hangs of I/O triggered via the device
> unregistration callbacks.
>
> Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Thanks!

Applied,
Rusty.
