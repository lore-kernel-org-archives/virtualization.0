From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 06/10] virtio: console: fix race in port_fops_poll() and
	port unplug
Date: Fri, 19 Jul 2013 13:18:15 +0530
Message-ID: <20130719072113.GL3087@amit-x200.redhat.com>
References: <cover.1374177234.git.amit.shah@redhat.com>
	<bb9fe1cb5a1aeff6ecfc68936254045024e25e56.1374177234.git.amit.shah@redhat.com>
	<51E8E4D6.7030807@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51E8E4D6.7030807@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 19 Jul 2013 [15:03:50], Jason Wang wrote:
> On 07/19/2013 04:16 AM, Amit Shah wrote:
> > Between poll() being called and processed, the port can be unplugged.
> > Check if this happened, and bail out.
> >
> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> > ---
> >  drivers/char/virtio_console.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index 7728af9..1d4b748 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -967,6 +967,10 @@ static unsigned int port_fops_poll(struct file *filp, poll_table *wait)
> >  	unsigned int ret;
> >  
> >  	port = filp->private_data;
> > +	if (!port->guest_connected) {
> > +		/* Port was unplugged before we could proceed */
> > +		return POLLHUP;
> > +	}
> >  	poll_wait(filp, &port->waitqueue, wait);
> >  
> >  	if (!port->guest_connected) {
> Looks still racy here. Unlike port_fops_read() which check
> will_read_block(). If unplug happens after the check but before the
> poll_wait(), caller will be blocked forever.

unplug_port() calls wake_up_interruptible on the waitqueue.

(But the wake_up should be done after guest_connected is set to
false -- regression introduced in patch 7.)

		Amit
