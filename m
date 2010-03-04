From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: virtio over PCI
Date: Wed, 3 Mar 2010 16:39:20 -0800
Message-ID: <20100304003920.GA12707@ovro.caltech.edu>
References: <1267596588.7814.159.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1267596588.7814.159.camel@concordia>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 03, 2010 at 05:09:48PM +1100, Michael Ellerman wrote:
> Hi guys,
> 
> I was looking around at virtio over PCI stuff and noticed you had
> started some work on a driver. The last I can find via google is v2 from
> mid last year, is that as far as it got?
> 
> http://lkml.org/lkml/2009/2/23/353
> 

Yep, that is pretty much as far as I got. It was more-or-less rejected
because I hooked two instances of virtio-net together, rather than
having a proper backend and using virtio-net as the frontend.

I got started on writing a backend, which was never posted to LKML
because I never finished it. Feel free to take the code and use it to
start your own project. Note that vhost-net exists now, and is an
in-kernel backend for virtio-net. It *may* be possible to use this,
rather than writing a userspace backend as I started to do.
http://www.mmarray.org/~iws/virtio-phys/

I also got started with the alacrityvm project, developing a driver for
their virtualization framework. That project is nowhere near finished.
The virtualization folks basically told GHaskins (alacrityvm author)
that alacrityvm wouldn't ever make it to mainline Linux.
http://www.mmarray.org/~iws/vbus/

Unfortunately, I've been pulled onto other projects for the time being.
However, I'd really like to be able to use a virtio-over-PCI style
driver, rather than relying on my own custom (slow, unoptimized) network
driver (PCINet).

If you get something mostly working (and mostly agreed upon by the
virtualization guys), I will make the time to test it and get it cleaned
up. I've had 10+ people email me privately about this kind of driver
now. It is an area where Linux is sorely lacking.

I'm happy to provide any help I can, including testing on
MPC8349EA-based system. I would suggest talking to the virtualization
mailing list before you get too deep in the project. They sometimes have
good advice. I've added them to the CC list, so maybe they can comment.
https://lists.linux-foundation.org/mailman/listinfo/virtualization

Good luck, and let me know if I can help.
Ira
