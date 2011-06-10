From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/7] [v5] drivers/virt: introduce Freescale hypervisor
	management driver
Date: Fri, 10 Jun 2011 11:45:51 +0100
Message-ID: <20110610104551.GB26441__4741.42770185626$1307736911$gmane$org@sirena.org.uk>
References: <1307646794-26374-1-git-send-email-timur@freescale.com>
	<201106092213.13755.arnd@arndb.de> <4DF12A94.6070605@freescale.com>
	<201106092233.08030.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201106092233.08030.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: konrad.wilk@oracle.com, benh@kernel.crashing.org, kumar.gala@freescale.com, linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-console@vger.kernel.org, greg@kroah.com, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>, alan@lxorguk.ukuu.org.uk
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 09, 2011 at 10:33:07PM +0200, Arnd Bergmann wrote:
> On Thursday 09 June 2011 22:18:28 Timur Tabi wrote:

> > Ok, I was really hoping to avoid doing this.  Like I said, binary compatibility
> > is important, and changing the type will break my existing apps.  Are you
> > insisting that I pick a new number?

> I definitely insist that you have a proper interface in the driver at the
> time that it gets merged, and that probably includes a collision-free
> ioctl code.

This sort of stuff is one of the issues that should be being factored in
to any decision not to publish and submit the kernel code - ABIs that
haven't been reviewed upstream may well have this sort of issue.
