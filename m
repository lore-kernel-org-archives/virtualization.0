From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 08/28] virtio: console: remove global var
Date: Mon, 30 Nov 2009 11:15:33 +0530
Message-ID: <20091130054533.GB25052@amit-x200.redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-8-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-9-git-send-email-amit.shah@redhat.com>
	<200911301227.21515.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911301227.21515.rusty@rustcorp.com.au>
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

On (Mon) Nov 30 2009 [12:27:21], Rusty Russell wrote:
> On Sat, 28 Nov 2009 05:20:31 pm Amit Shah wrote:
> > From: Rusty Russell <rusty@rustcorp.com.au>
> > 
> > Now we can use an allocation function to remove our global console variable.
> > 
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> > ---
> >  drivers/char/virtio_console.c |   70 +++++++++++++++++++++++++++-------------
> >  1 files changed, 47 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index c133bf6..98a5249 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -32,6 +32,18 @@
> >   * across multiple devices and multiple ports per device.
> >   */
> >  struct ports_driver_data {
> > +	/*
> > +	 * This is used to keep track of the number of hvc consoles
> > +	 * spawned by this driver.  This number is given as the first
> > +	 * argument to hvc_alloc().  To correctly map an initial
> > +	 * console spawned via hvc_instantiate to the console being
> > +	 * hooked up via hvc_alloc, we need to pass the same vtermno.
> > +	 *
> > +	 * We also just assume the first console being initialised was
> > +	 * the first one that got used as the initial console.
> > +	 */
> > +	unsigned int next_vtermno;
> 
> Let's just make this a global?

There will be a few more globals introduced in the next few patches, so
I just put all the globals in a new struct to keep them in one place.

> > +static struct port *__devinit add_port(u32 vtermno)
> > +{
> > +	struct port *port;
> > +
> > +	port = kzalloc(sizeof *port, GFP_KERNEL);
> > +	if (!port)
> > +		return NULL;
> > +
> > +	port->used_len = port->offset = 0;
> > +	port->inbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> > +	if (!port->inbuf) {
> > +		kfree(port);
> > +		return NULL;
> > +	}
> > +	port->hvc = NULL;
> > +	port->vtermno = vtermno;
> > +	return port;
> > +}
> 
> Rename this to add_console_port(),

I do that later (in patch 15), splitting this off into
init_console_port().

> and split off the core part which
> does ->port setup into "int setup_port(struct port *)" for later re-use?

yeah; this function then becomes the core port init routine in patch 15.

> > +static void free_port(struct port *port)
> > +{
> > +	kfree(port->inbuf);
> > +	kfree(port);
> > +}
> 
> Similarly, free_console_port/free_port?

This comes with port hot unplug support later in the series. This part
is again what I left intact from your series.

> > +	err = -ENOMEM;
> > +	port = add_port(pdrvdata.next_vtermno);
> > +	if (!port)
> > +		goto fail;
> 
> I realize other coders do this pre-init, and it saves a line, but it also
> means that you don't get a warning about err being uninitialized if it doesn't
> get set correctly later on.
> 
> So I prefer:
> 	port = add...
> 	if (!port) {
> 		err = -ENOMEM;
> 		goto fail;
> 	}

Sure; I can do that. I just made sure all the style was consistent.

		Amit
