From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 3/6] virtio: console: Switch to using a port bitmap for
	port discovery
Date: Mon, 22 Mar 2010 09:34:01 +0530
Message-ID: <20100322040401.GA24577@amit-x200.redhat.com>
References: <1269000408-29962-1-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-2-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-3-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-4-git-send-email-amit.shah@redhat.com>
	<20100321112945.GA12339@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100321112945.GA12339@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: quintela@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Sun) Mar 21 2010 [13:29:45], Michael S. Tsirkin wrote:
> On Fri, Mar 19, 2010 at 05:36:45PM +0530, Amit Shah wrote:
> > Ports are now discovered by their location as given by host instead of
> > just incrementing a number and expecting the host and guest numbers stay
> > in sync. They are needed to be the same because the control messages
> > identify ports using the port id.
> > 
> > This is most beneficial to management software to properly place ports
> > at known ids so that the ids after hot-plug/unplug operations can be
> > controlled. This helps migration of guests after such hot-plug/unplug
> > operations.
> > 
> > The support for port hot-plug is removed in this commit, will be added
> > in the following commits.
> 
> It might be cleaner not to split it this way, merge the following
> commits into this one or split it in a different way.

Rusty in the past indicated he was OK with such a split since it
simplifies things and makes for easier review.

I'm fine with merging the next two patches in here too.

> > The config space is now a variable-sized array.
> 
> I think this last bit is problematic: we won't be able to add any more data if
> we have to, without a lot of complexity.

Adding new fields before the bitmap should be fine as long as we
discover features and fetch the config is the right order. If, however,
another bitmap has to be added, that'll surely be painful.

However, I don't see the need to add another bitmap for sure, and I
don't think we need more config variables too. However, we have the
control channel in case this has to be expanded.

>  Further, in the past we have
> also had problems running out of config space: see
> 3225beaba05d4f06087593f5e903ce867b6e118a.

How much config space is available? I guess there's enough for a ports
bitmap: without the ports, we're using 64 bits. And each port takes up
one bit. I guess we easily have 256 bits of space, so we can have 192
ports represented (at least) via the config space.

> There's also
> a comment in handle_control_message which suggests we
> might want a very large number of ports at some point,
> if we do using config space would be a mistake.

[Which comment?]

I can't certainly predict how many ports might be needed, but I think
we'll have other ways of communication if we need > 200 ports.

> It might be better to use a control vq for this, like virtio block ended
> up doing.  The comment in handle_control_message hints we don't want to
> pass port id in config space, but I am not sure why we can't pass it in
> message buffer.

I'm not sure which comment you're referring to really.

> > +static u32 find_next_bit_in_map(u32 *map)
> > +{
> > +	u32 port_bit;
> > +
> > +	port_bit = ffs(*map);
> > +	port_bit--; /* ffs returns bit location */
> > +
> > +	*map &= ~(1U << port_bit);
> 
> The above only works well if map is non-zero.  This happens to be the
> case the way we call it, but since this means the function is not
> generic, it might be better to opencode it to make it obvious.

You're right; when I first had a bitmap-based approach, I had a
find_next_active_port() and returned VIRTIO_CONSOLE_BAD_ID in case ffs
returned 0. This is a valid case and should be fixed. I'll send out a
v2.

> > +static u32 get_ports_map_size(u32 max_nr_ports)
> > +{
> > +	return sizeof(u32) * ((max_nr_ports + 31)/ 32);
> 
> DIV_ROUND_UP here and elsewhere?

Ah, yes, I'll use it.

> > -	for (i = 0; i < portdev->config.nr_ports; i++)
> > -		add_port(portdev, i);
> > +		for (i = 0; i < (portdev->config->max_nr_ports + 31) / 32; i++) {
> > +			u32 map, port_nr;
> > +
> > +			map = portdev->config->ports_map[i];
> > +			while (map) {
> > +				port_nr = find_next_bit_in_map(&map) + i * 32;
> > +
> > +				add_port(portdev, port_nr);
> > +				/*
> > +				 * FIXME: Send a notification to the
> > +				 * host about failed port add
> > +				 */
> 
> This FIXME is just pointing out an existing bug, correct?

Yes, a control message indicating to the host something went wrong would
be helpful for mgmt.

> > diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
> > index ae4f039..287ee44 100644
> > --- a/include/linux/virtio_console.h
> > +++ b/include/linux/virtio_console.h
> > @@ -14,15 +14,23 @@
> >  #define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
> >  #define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
> >  
> > +/*
> > + * This is the config space shared between the Host and the Guest.
> > + * The Host indicates to us the maximum number of ports this device
> > + * can hold and a port map indicating which ports are active.
> > + *
> > + * The maximum number of ports is not a round number to prevent
> > + * wastage of MSI vectors in case MSI is enabled for this device.
> 
> What does 'round number' mean in this context?

Meaning restricting the 'max_nr_ports' to multiples of 32.

> > + */
> >  struct virtio_console_config {
> >  	/* colums of the screens */
> >  	__u16 cols;
> >  	/* rows of the screens */
> >  	__u16 rows;
> > -	/* max. number of ports this device can hold */
> > +	/* max. number of ports this device can hold. */
> >  	__u32 max_nr_ports;
> > -	/* number of ports added so far */
> > -	__u32 nr_ports;
> > +	/* locations of ports in use; variable-sized array */
> 
> It's in fact a bitmap, not an array, is it?

hm, yeah; I'll update.

> > +	__u32 ports_map[0 /* (max_nr_ports + 31) / 2 */];
> 
> The array is in the packed structure. So I am not sure
> we can legally take a pointer to ports_map like this patch does in
> multiple places above: if we do compiler might assume
> alignment?

We always reference the elements in the ports_map[] in u32-sized
increments. Is there a problem?

> >  } __attribute__((packed));
> >
> Note that sizeof for variable sized structures is as far as I know a gcc
> extension. You are supposed to use offsetof. And since packed  structure
> is also an extension, we should be very careful about combining them
> together.

OK, I'll switch to offsetof(ports_map) where I use
sizeof(virtio_console_config) -- in the get_config() function.

> In fact, virtio seems to overuse packed structures: we probably can
> save a ton of code by carefully padding everything without using
> packed attribute.

Yeah; packing could be avoided. Maybe Rusty has an explanation for why
it was done this way.

		Amit
