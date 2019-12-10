From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC net-next v8 1/3] netdev: pass the stuck queue to the
 timeout handler
Date: Tue, 10 Dec 2019 09:27:27 -0500
Message-ID: <20191210092623-mutt-send-email-mst__19312.1128411562$1575988074$gmane$org@kernel.org>
References: <20191203201804.662066-1-mst@redhat.com>
 <20191203201804.662066-2-mst@redhat.com>
 <CAMuHMdXDm0NiCk1pD_-wS9c-ErmRKkrqnPc_pGKzG=QB35mj9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMuHMdXDm0NiCk1pD_-wS9c-ErmRKkrqnPc_pGKzG=QB35mj9A@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dnmendes76@gmail.com, Jakub Kicinski <jakub.kicinski@netronome.com>, netdev <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Martin Habets <mhabets@solarflare.com>, Julio Faracco <jcfaracco@gmail.com>, Shannon Nelson <snelson@pensando.io>, "David S. Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 09, 2019 at 08:40:06AM +0100, Geert Uytterhoeven wrote:
> Hi Michael,
> 
> On Tue, Dec 3, 2019 at 9:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > This allows incrementing the correct timeout statistic without any mess.
> > Down the road, devices can learn to reset just the specific queue.
> >
> > The patch was generated with the following script:
> 
> [...]
> 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> > --- a/drivers/net/ethernet/8390/8390p.c
> > +++ b/drivers/net/ethernet/8390/8390p.c
> > @@ -41,9 +41,9 @@ void eip_set_multicast_list(struct net_device *dev)
> >  }
> >  EXPORT_SYMBOL(eip_set_multicast_list);
> >
> > -void eip_tx_timeout(struct net_device *dev)
> > +void eip_tx_timeout(struct net_device *dev, unsigned int txqueue)
> >  {
> > -       __ei_tx_timeout(dev);
> > +       __ei_tx_timeout(dev, txqueue);
> >  }
> >  EXPORT_SYMBOL(eip_tx_timeout);
> 
> On Mon, Dec 9, 2019 at 6:37 AM <noreply@ellerman.id.au> wrote:
> > FAILED linux-next/m68k-defconfig/m68k Mon Dec 09, 16:34
> >
> > http://kisskb.ellerman.id.au/kisskb/buildresult/14060060/
> >
> > Commit:   Add linux-next specific files for 20191209
> >           6cf8298daad041cd15dc514d8a4f93ca3636c84e
> > Compiler: m68k-linux-gcc (GCC) 4.6.3 / GNU ld (GNU Binutils) 2.22
> >
> > Possible errors
> > ---------------
> >
> > drivers/net/ethernet/8390/8390p.c:44:6: error: conflicting types for 'eip_tx_timeout'
> > drivers/net/ethernet/8390/8390p.c:48:1: error: conflicting types for 'eip_tx_timeout'
> > make[5]: *** [scripts/Makefile.build:266: drivers/net/ethernet/8390/8390p.o] Error 1
> > make[4]: *** [scripts/Makefile.build:503: drivers/net/ethernet/8390] Error 2
> > make[3]: *** [scripts/Makefile.build:503: drivers/net/ethernet] Error 2
> > make[2]: *** [scripts/Makefile.build:503: drivers/net] Error 2
> > make[1]: *** [Makefile:1693: drivers] Error 2
> > make: *** [Makefile:179: sub-make] Error 2
> 
> Looks like you forgot to update the forward declaration in
> drivers/net/ethernet/8390/8390.h

Fixed now.

> There may be others...

Could not find any but pls do let me know.

> http://kisskb.ellerman.id.au/kisskb/head/6cf8298daad041cd15dc514d8a4f93ca3636c84e/
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
