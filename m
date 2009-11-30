From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 09/28] virtio: console: struct ports for multiple ports
	per device.
Date: Mon, 30 Nov 2009 11:20:25 +0530
Message-ID: <20091130055025.GC25052@amit-x200.redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-9-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-10-git-send-email-amit.shah@redhat.com>
	<200911301239.52400.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911301239.52400.rusty@rustcorp.com.au>
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

On (Mon) Nov 30 2009 [12:39:52], Rusty Russell wrote:
> On Sat, 28 Nov 2009 05:20:32 pm Amit Shah wrote:
> > @@ -196,7 +216,9 @@ static void virtcons_apply_config(struct virtio_device *dev)
> >  		dev->config->get(dev,
> >  				 offsetof(struct virtio_console_config, rows),
> >  				 &ws.ws_row, sizeof(u16));
> > -		hvc_resize(port->hvc, ws);
> > +		/* This is the pre-multiport style: we use control messages
> > +		 * these days which specify the port.  So this means port 0. */
> > +		hvc_resize(find_port_by_vtermno(0)->hvc, ws);
> >  	}
> 
> We end up doing this in a couple of places; perhaps we should have something
> like:
> 	/*
> 	 * Before multiple console support, we always had a single console.
> 	 * Code paths without those features can use this.
> 	 */
> 	static struct port *old_style_unique_console(void)
> 	{
> 		return find_port_by_vtermno(0);
> 	}

(Again) in a later patch, I rename the function to resize_console() and
call that one from the config interrupt as well as from the
hvc notifier.

> >  	err = -ENOMEM;
> > -	port = add_port(pdrvdata.next_vtermno);
> > +	port = kzalloc(sizeof *port, GFP_KERNEL);
> >  	if (!port)
> >  		goto fail;
> 
> I still dislike kzalloc.  I think I've said this before :)

I remember seeing it in another thread I think (or was it in a blog post
about you liking the ability to run it through valgrind?).

The init function becomes a bit longer in that case, since we'll have to
init all the known state. But I'm fine with that.

However, there's one exception: when allocating buffers, I'd prefer to
do a kzalloc() since the buffers are sent across the guest/host boundary
and we don't want to leak data in either direction.

(Just mentioning this again since it's the last comment: I'll respin the
series once you have a chance to review the other patches too.)

Also: if you think the approach is OK and give an ACK for the approach,
I can also proceed in parallel with the host bits for QEMU.

Thanks, Rusty!

		Amit
