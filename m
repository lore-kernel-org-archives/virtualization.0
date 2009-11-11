From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 01/15] virtio_console: Initialize hv_ops struct at
	declaration instead of in the probe() routine
Date: Thu, 12 Nov 2009 00:12:54 +0530
Message-ID: <20091111184254.GB6416@amit-x200.redhat.com>
References: <1257846101-23258-1-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-2-git-send-email-amit.shah@redhat.com>
	<200911102337.39372.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911102337.39372.rusty@rustcorp.com.au>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Nov 10 2009 [23:37:39], Rusty Russell wrote:
> On Tue, 10 Nov 2009 08:11:27 pm Amit Shah wrote:
> > Initialize the hv_ops function pointers using C99 style. However, we
> > need to re-init the 'put_chars' field to our implementation in the
> > probe() routine as we replace it for early_init to use the caller's
> > put_chars implementation.
> 
> (I've decided one email for all the feedback, because obviously the merge
> of the two series will cause substantial changes)
> 
> It's interesting to contrast this with mine.  There's nothing *wrong*
> with this, but the larger issue of making as much kernel data const lead
> me to the separate early_put_chars hook.

Yeah; I'll use yours.

> Re: [PATCH 02/15] virtio_console: We support only one device at a time
> 
> > We support only one virtio_console device at a time. If multiple are
> > found, error out if one is already initialized.
> 
> I like this; it should be integrated early in my series; technically it's
> a fix.  But it should use dev_err() (or dev_warn maybe) not pr_err().

Sure.

> Re: [PATCH 03/15] virtio_console: Club all globals into one struct
> 
> I chose "port" as a name; it's better once we're finished than
> "struct virtio_console_struct". 

I wanted to separate out a 'virtio device' which has vqs common to all
ports and a 'port', which has its buffers, tells us if it's a console
port, and all the other port-specific stuff.

I find 'port' and 'ports' confusing. In your implementation, 'port' has
vqs.

> You also dropped the static, which is
> sloppy.

Yeah; I still have a small diff compared to my single big patch and this
is one of the hunks.

> Re: [PATCH 04/15] virtio_console: Introduce a workqueue for handling host->guest notifications
> 
> This one I disagree with.  The host will wait until a buffer comes available.
> It has to anyway, and it should work just fine.  *If* we need speed, then we
> might need workqueues so we reduce guest exits, but I don't think we need that
> yet.

So each port has a buffer that gets added to the vq and when data is
received, it would be queued in the port-specific ring. Ports may want
data to be cached when they're not open or when the userspace app is
slow in reading the data. In that case, we'll have to allocate a new
buffer to be stuffed in the vq.

For the output case too a workqueue might be needed -- the output
routine can be called from interrupt context (put_chars); so sleeping is
best deferred to a workqueue?

> Re: [PATCH 10/15] virtio_console: Register with sysfs and create a 'name' attribute
> 
> Is there a better way to have that attribute dynamic, rather than just having
> the sysfs file there but empty if it has no name?

I think it should be easy to do (but what I need to figure out first is
how to get the port from the devt given we can now support multiple
virtio console devices).

> I think get_port_from_dev_t cannot fail (BUG() at the end?).

Will add.

Thanks, Rusty!

		Amit
