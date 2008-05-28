From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/3] virtio: fix delayed xmit of packet and freeing of old
	packets.
Date: Wed, 28 May 2008 14:59:09 +1000
Message-ID: <200805281459.09564.rusty__30678.7440822974$1211950920$gmane$org@rustcorp.com.au>
References: <200805261742.43215.rusty@rustcorp.com.au>
	<200805261748.13449.rusty@rustcorp.com.au>
	<1211886068.3637.42.camel@muff>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1211886068.3637.42.camel@muff>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: netdev@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 27 May 2008 21:01:08 Mark McLoughlin wrote:
> On Mon, 2008-05-26 at 17:48 +1000, Rusty Russell wrote:
> > diff -r 1d1ff03de434 drivers/net/virtio_net.c
> ...
> > +	tasklet_init(&vi->tasklet, xmit_tasklet, (unsigned long)vi);
> > +
> >  	err = register_netdev(dev);
>
> Missing a tasklet_kill() in virtnet_remove() ?

Thanks Mark!  Added.

Nice spotting,
Rusty.
