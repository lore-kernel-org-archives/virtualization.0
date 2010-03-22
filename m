From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/6] virtio: console: Switch to using a port bitmap for
	port discovery
Date: Mon, 22 Mar 2010 14:16:32 +0200
Message-ID: <20100322121632.GA17287@redhat.com>
References: <1269000408-29962-1-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-2-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-3-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-4-git-send-email-amit.shah@redhat.com>
	<20100321112945.GA12339@redhat.com>
	<20100322040401.GA24577@amit-x200.redhat.com>
	<20100322085336.GB16574@redhat.com>
	<20100322094524.GA19148@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100322094524.GA19148@amit-x200.redhat.com>
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
Cc: quintela@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 22, 2010 at 03:15:24PM +0530, Amit Shah wrote:
> On (Mon) Mar 22 2010 [10:53:36], Michael S. Tsirkin wrote:
> > On Mon, Mar 22, 2010 at 09:34:01AM +0530, Amit Shah wrote:
> > > On (Sun) Mar 21 2010 [13:29:45], Michael S. Tsirkin wrote:
> > > > On Fri, Mar 19, 2010 at 05:36:45PM +0530, Amit Shah wrote:
> > > > > Ports are now discovered by their location as given by host instead of
> > > > > just incrementing a number and expecting the host and guest numbers stay
> > > > > in sync. They are needed to be the same because the control messages
> > > > > identify ports using the port id.
> > > > > 
> > > > > This is most beneficial to management software to properly place ports
> > > > > at known ids so that the ids after hot-plug/unplug operations can be
> > > > > controlled. This helps migration of guests after such hot-plug/unplug
> > > > > operations.
> > > > > 
> > > > > The support for port hot-plug is removed in this commit, will be added
> > > > > in the following commits.
> > > > 
> > > > It might be cleaner not to split it this way, merge the following
> > > > commits into this one or split it in a different way.
> > > 
> > > Rusty in the past indicated he was OK with such a split since it
> > > simplifies things and makes for easier review.
> > > 
> > > I'm fine with merging the next two patches in here too.
> > > 
> > > > > The config space is now a variable-sized array.
> > > > 
> > > > I think this last bit is problematic: we won't be able to add any more data if
> > > > we have to, without a lot of complexity.
> > > 
> > > Adding new fields before the bitmap should be fine as long as we
> > > discover features and fetch the config is the right order. If, however,
> > > another bitmap has to be added, that'll surely be painful.
> > 
> > Well, we'll need two structures old_config and new_config,
> > as opposed to simply extending the existing one.
> 
> True; we'd be adding fields before the ports_map. We anyway have to keep
> older fields around for backward compat, so not much changes.
> 
> > > However, I don't see the need to add another bitmap for sure, and I
> > > don't think we need more config variables too. However, we have the
> > > control channel in case this has to be expanded.
> > 
> > How about using it right now?
> 
> Just that doing hot-plug/unplug via config updates seems better for some
> reason.
> 
> > > >  Further, in the past we have
> > > > also had problems running out of config space: see
> > > > 3225beaba05d4f06087593f5e903ce867b6e118a.
> > > 
> > > How much config space is available? I guess there's enough for a ports
> > > bitmap: without the ports, we're using 64 bits. And each port takes up
> > > one bit. I guess we easily have 256 bits of space, so we can have 192
> > > ports represented (at least) via the config space.
> > 
> > 256 bytes but we are using config space for other things as well.
> > 
> > > > There's also
> > > > a comment in handle_control_message which suggests we
> > > > might want a very large number of ports at some point,
> > > > if we do using config space would be a mistake.
> > > 
> > > [Which comment?]
> > > 
> > > I can't certainly predict how many ports might be needed, but I think
> > > we'll have other ways of communication if we need > 200 ports.
> > 
> > If, say, 32 bytes are sufficient, let's just reserve a fixed size
> > array and everything will be simpler?
> 
> Yes, 32 bytes means 256 ports. Should be OK; if not, one could add more
> such devices and get more ports. But if I have to choose between fixing
> the number of ports in the config space vs using the control queue for
> the bitmap, I'll go for the latter. That's assuming we really really
> don't want to use the config space for storing the bitmap.

I guess with control queue we also simply use message per port
state change - would that be simpler than a bitmap?

> > > > It might be better to use a control vq for this, like virtio block ended
> > > > up doing.  The comment in handle_control_message hints we don't want to
> > > > pass port id in config space, but I am not sure why we can't pass it in
> > > > message buffer.
> > > 
> > > I'm not sure which comment you're referring to really.
> > 
> > We have this:
> > 
> > + * Hot unplug the port. We don't decrement nr_ports
> > + * since we don't want to deal with extra complexities
> > + * of using the lowest-available port id: We can just
> > + * pick up the nr_ports number as the id and not have
> > + * userspace send it to us. This helps us in two
> > + * ways:
> > + *
> > + * - We don't need to have a 'port_id' field in the
> > + * config space when a port is hot-added. This is a
> > + * good thing as we might queue up multiple hotplug
> > + * requests issued in our workqueue.
> > + *
> > + * - Another way to deal with this would have been to
> > + * use a bitmap of the active ports and select the
> > + * lowest non-active port from that map. That
> > + * bloats the already tight config space and we
> > + * would end up artificially limiting the
> > + * max. number of ports to sizeof(bitmap). Right
> > + * now we can support 2^32 ports (as the port id is
> > + * stored in a u32 type).
> > + *
> > 
> > Did you change your mind then?
> 
> Ah, ok. This comment got removed by the last patch in this series.
> 
> Well right now the kernel can support 2^32 ports; but the downside of
> doing it w/o bitmaps was a race in port number allocation between the
> guest and the host. Without a bitmap, we could use a port id only once,
> so after unplugging a port, a new port had to be on a new id.
> 
> With bitmaps, any free location can be re-used. So it's not all that bad
> as that comment makes it sound. Also, as you suggest using the control
> queue for bitmaps, we could have large bitmaps irrespective of the
> config space limit.
> 
> > > > > +static u32 find_next_bit_in_map(u32 *map)
> > > > > +{
> > > > > +	u32 port_bit;
> > > > > +
> > > > > +	port_bit = ffs(*map);
> > > > > +	port_bit--; /* ffs returns bit location */


simple u32 port_bit = ffs(*map) - 1; not clear enough?

> > > > > +
> > > > > +	*map &= ~(1U << port_bit);
> > > > 
> > > > The above only works well if map is non-zero.  This happens to be the
> > > > case the way we call it, but since this means the function is not
> > > > generic, it might be better to opencode it to make it obvious.
> > > 
> > > You're right; when I first had a bitmap-based approach, I had a
> > > find_next_active_port() and returned VIRTIO_CONSOLE_BAD_ID in case ffs
> > > returned 0. This is a valid case and should be fixed. I'll send out a
> > > v2.
> 
> BTW I just added a comment to the function mentioning it's to be called
> with 'map' non-zero. Should be sufficient for the current usage.
> 
> 		Amit

Or just opencode it, it's two lines.

-- 
MST
