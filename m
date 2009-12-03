From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 12/28] virtio: console: Buffer data that comes in from
	the host
Date: Thu, 3 Dec 2009 09:13:25 +0530
Message-ID: <20091203034325.GA5340@amit-x200.redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<200912021414.20206.rusty@rustcorp.com.au>
	<20091202092406.GB28265@amit-x200.redhat.com>
	<200912030924.23783.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200912030924.23783.rusty@rustcorp.com.au>
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
Cc: Shirley Ma <mashirle@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) Dec 03 2009 [09:24:23], Rusty Russell wrote:
> On Wed, 2 Dec 2009 07:54:06 pm Amit Shah wrote:
> > On (Wed) Dec 02 2009 [14:14:20], Rusty Russell wrote:
> > > On Sat, 28 Nov 2009 05:20:35 pm Amit Shah wrote:
> > > > The console could be flooded with data from the host; handle
> > > > this situation by buffering the data.
> > > 
> > > All this complexity makes me really wonder if we should just
> > > have the host say the max # ports it will ever use, and just do this
> > > really dumbly.  Yes, it's a limitation, but it'd be much simpler.
> > 
> > As in make sure the max nr ports is less than 255 and have per-port vqs?
> > And then the buffering will be done inside the vqs themselves?
> 
> Well < 128 (two vqs per port).  The config would say (with a feature bit)
> how many vq pairs there are.

Sure. This was how the previous versions behaved as well.

>  If we want expect sparse port numbers, it can
> also provide an array mapping the vq pairs to the port number (65535 or
> something meaning unused).  In practice I suspect 4 or 8 will be plenty
> for now.
> 
> That makes hotplugging ports pretty simple: change the array, ping
> config_changed.

The very early versions of this patch used this approach: a nr_ports u32
and a bitmap...

> Or we could abandon numbers and just use the names; I don't mind (we still
> need a way to figure out what ports are active I guess, maybe a bitmap in
> the config?)

... but we dropped that approach and are now just using the 'names' as
a means of identifying ports. Currently, there's only a 'nr_ports' entry
in the config. For hotplug, the entry is bumped by the host and the
guest adds the new ports.

That's definitely simpler than maintaining the bitmap, and also we don't
associate any special meaning to the port numbers themselves, which is a
big plus. (Hot plug after hot unplug can be made to work with a control
message as well, but that support can come in later.)

Looks like we're just going back to what this patch looked like when it
was sent out first.

> But we get the vq buffering and flow control for free with this approach.

I'll see if I can send out this spin today.

		Amit
