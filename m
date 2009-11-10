From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 01/15] virtio_console: Initialize hv_ops struct at
	declaration instead of in the probe() routine
Date: Tue, 10 Nov 2009 23:37:39 +1030
Message-ID: <200911102337.39372.rusty@rustcorp.com.au>
References: <1257846101-23258-1-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-2-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257846101-23258-2-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 10 Nov 2009 08:11:27 pm Amit Shah wrote:
> Initialize the hv_ops function pointers using C99 style. However, we
> need to re-init the 'put_chars' field to our implementation in the
> probe() routine as we replace it for early_init to use the caller's
> put_chars implementation.

(I've decided one email for all the feedback, because obviously the merge
of the two series will cause substantial changes)

It's interesting to contrast this with mine.  There's nothing *wrong*
with this, but the larger issue of making as much kernel data const lead
me to the separate early_put_chars hook.

Re: [PATCH 02/15] virtio_console: We support only one device at a time

> We support only one virtio_console device at a time. If multiple are
> found, error out if one is already initialized.

I like this; it should be integrated early in my series; technically it's
a fix.  But it should use dev_err() (or dev_warn maybe) not pr_err().

Re: [PATCH 03/15] virtio_console: Club all globals into one struct

I chose "port" as a name; it's better once we're finished than
"struct virtio_console_struct".  You also dropped the static, which is
sloppy.

Re: [PATCH 04/15] virtio_console: Introduce a workqueue for handling host->guest notifications

This one I disagree with.  The host will wait until a buffer comes available.
It has to anyway, and it should work just fine.  *If* we need speed, then we
might need workqueues so we reduce guest exits, but I don't think we need that
yet.

Will defer most of the other patches until we sort this issue out.  But one
minor thing:

Re: [PATCH 10/15] virtio_console: Register with sysfs and create a 'name' attribute

Is there a better way to have that attribute dynamic, rather than just having
the sysfs file there but empty if it has no name?

I think get_port_from_dev_t cannot fail (BUG() at the end?).

Thanks!
Rusty.
