From: Leszek Urbanski <tygrys@moo.pl>
Subject: Re: BUG - qdev - partial loss of network connectivity
Date: Tue, 5 Oct 2010 23:29:13 +0200
Message-ID: <20101005212913.GA27869__32331.1502150775$1286314283$gmane$org@moo.pl>
References: <20100922171832.GA28721@moo.pl> <4C9A3FAF.9090503@codemonkey.ws>
	<20100922182049.GA29263@moo.pl>
	<4C9A4C77.2080806@codemonkey.ws> <20100923140437.GA9256@moo.pl>
	<20100926154324.GD21843@redhat.com> <20100927213203.GA28089@moo.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100927213203.GA28089@moo.pl>
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
Cc: netdev@vger.kernel.org, linux-nfs@vger.kernel.org, qemu-devel@nongnu.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

<20100927213203.GA28089@moo.pl>; from Leszek Urbanski on Mon, Sep 27, 2010 at 23:32:03 +0200

> > > > >It's vanilla 2.6.32.22, but I also reproduced this on Debian's 2.6.32-23
> > > > >(based on 2.6.32.21).
> > > > >
> > > > >If offload is the only difference, I'll play with different offload
> > > > >options and check which one causes it.
> > > > >   
> > > > 
> > > > It's not technically the only difference but it's the most likely 
> > > > culprit IMHO.
> > > 
> > > udp fragmentation offload is definitely the culprit.
> > 
> > I see. Most likely guest bug - won't be the first bug around UFO.
> > If so pls copy netdev linux-nfs and virtualization.
> > Do you see anything in dmesg? Can try 2.6.36-rc5?
> 
> (for reference: first post is at:
> http://lists.nongnu.org/archive/html/qemu-devel/2010-09/msg01685.html )
> 
> I can't reproduce it on 2.6.36-rc5. Do you have an idea which patch may have

This one definitely fixes it: http://patchwork.ozlabs.org/patch/55643/

(Herbert Xu: udp: Fix bogus UFO packet generation)

The patch works with 2.6.32.24 too - it should probably be backported to
2.6.32.x.


-- 
Leszek "Tygrys" Urbanski, SCSA, SCNA
 "Unix-to-Unix Copy Program;" said PDP-1. "You will never find a more
  wretched hive of bugs and flamers. We must be cautious." -- DECWARS
     http://cygnus.moo.pl/ -- Cygnus High Altitude Balloon
