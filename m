From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 3/6] virtio: console: Switch to using a port bitmap for
	port discovery
Date: Mon, 22 Mar 2010 18:01:53 +0530
Message-ID: <20100322123153.GK19148@amit-x200.redhat.com>
References: <1269000408-29962-1-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-2-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-3-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-4-git-send-email-amit.shah@redhat.com>
	<20100321112945.GA12339@redhat.com>
	<20100322040401.GA24577@amit-x200.redhat.com>
	<20100322085336.GB16574@redhat.com>
	<20100322094524.GA19148@amit-x200.redhat.com>
	<20100322121632.GA17287@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100322121632.GA17287@redhat.com>
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

On (Mon) Mar 22 2010 [14:16:32], Michael S. Tsirkin wrote:
> > > > I can't certainly predict how many ports might be needed, but I think
> > > > we'll have other ways of communication if we need > 200 ports.
> > > 
> > > If, say, 32 bytes are sufficient, let's just reserve a fixed size
> > > array and everything will be simpler?
> > 
> > Yes, 32 bytes means 256 ports. Should be OK; if not, one could add more
> > such devices and get more ports. But if I have to choose between fixing
> > the number of ports in the config space vs using the control queue for
> > the bitmap, I'll go for the latter. That's assuming we really really
> > don't want to use the config space for storing the bitmap.
> 
> I guess with control queue we also simply use message per port
> state change - would that be simpler than a bitmap?

Yes, that's how hot-unplug is done currently (before this patchset).
I'll cook up a similar version like you suggest for adding ports as
well.

> > > > > > +	port_bit = ffs(*map);
> > > > > > +	port_bit--; /* ffs returns bit location */
> 
> simple u32 port_bit = ffs(*map) - 1; not clear enough?

Well yeah; I'll just open-code it.

		Amit
-- 
http://log.amitshah.net/
