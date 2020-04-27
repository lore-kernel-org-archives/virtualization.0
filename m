From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4] vhost: disable for OABI
Date: Mon, 27 Apr 2020 05:20:17 -0400
Message-ID: <20200427051918-mutt-send-email-mst@kernel.org>
References: <20200420143229.245488-1-mst@redhat.com>
 <CAMuHMdWaG5EUsbTOMPkj4i50D40T0TLRvB6g-Y8Dj4C0v7KTqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWaG5EUsbTOMPkj4i50D40T0TLRvB6g-Y8Dj4C0v7KTqQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>, netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, KVM list <kvm@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 27, 2020 at 08:45:22AM +0200, Geert Uytterhoeven wrote:
> Hi Michael,
> 
> Thanks for your patch!
> 
> On Mon, Apr 20, 2020 at 5:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > vhost is currently broken on the some ARM configs.
> >
> > The reason is that the ring element addresses are passed between
> > components with different alignments assumptions. Thus, if
> > guest selects a pointer and host then gets and dereferences
> > it, then alignment assumed by the host's compiler might be
> > greater than the actual alignment of the pointer.
> > compiler on the host from assuming pointer is aligned.
> >
> > This actually triggers on ARM with -mabi=apcs-gnu - which is a
> > deprecated configuration. With this OABI, compiler assumes that
> > all structures are 4 byte aligned - which is stronger than
> > virtio guarantees for available and used rings, which are
> > merely 2 bytes. Thus a guest without -mabi=apcs-gnu running
> > on top of host with -mabi=apcs-gnu will be broken.
> >
> > The correct fix is to force alignment of structures - however
> > that is an intrusive fix that's best deferred until the next release.
> >
> > We didn't previously support such ancient systems at all - this surfaced
> > after vdpa support prompted removing dependency of vhost on
> > VIRTULIZATION. So for now, let's just add something along the lines of
> >
> >         depends on !ARM || AEABI
> >
> > to the virtio Kconfig declaration, and add a comment that it has to do
> > with struct member alignment.
> >
> > Note: we can't make VHOST and VHOST_RING themselves have
> > a dependency since these are selected. Add a new symbol for that.
> 
> Adding the dependencies to VHOST and VHOST_RING themselves is indeed not
> sufficient.  But IMHO you should still add VHOST_DPN dependencies t
>  these two symbols, so any driver selecting them without fulfilling the
> VHOST_DPN dependency will trigger a Kconfig warning.  Else the
> issue will be ignored silently.

Good point.
For now I'm trying to just get rid of this work around.
If I can't I will add the suggested change.
Thanks!

> > We should be able to drop this dependency down the road.
> >
> > Fixes: 20c384f1ea1a0bc7 ("vhost: refine vhost and vringh kconfig")
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Suggested-by: Richard Earnshaw <Richard.Earnshaw@arm.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
