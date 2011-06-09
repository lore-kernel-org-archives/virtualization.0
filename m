From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v5] drivers/virt: introduce Freescale hypervisor
	management driver
Date: Thu, 9 Jun 2011 22:33:07 +0200
Message-ID: <201106092233.08030.arnd__2581.61079041219$1307651638$gmane$org@arndb.de>
References: <1307646794-26374-1-git-send-email-timur@freescale.com>
	<201106092213.13755.arnd@arndb.de> <4DF12A94.6070605@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4DF12A94.6070605@freescale.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Timur Tabi <timur@freescale.com>
Cc: konrad.wilk@oracle.com, benh@kernel.crashing.org, kumar.gala@freescale.com, linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-console@vger.kernel.org, greg@kroah.com, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 09 June 2011 22:18:28 Timur Tabi wrote:
> > More importantly, the code you have chose (0) conflicts with existing drivers
> > (frame buffer, scsi and wavefront among others). Please chose a free one and
> > add it to Documentation/ioctl/ioctl-number.txt in the same patch.
> 
> Ok, I was really hoping to avoid doing this.  Like I said, binary compatibility
> is important, and changing the type will break my existing apps.  Are you
> insisting that I pick a new number?

I definitely insist that you have a proper interface in the driver at the
time that it gets merged, and that probably includes a collision-free
ioctl code.

You can probably make the driver support both the traditional and the
new interface, but I would prefer if you kept that as a private patch
on top a clean kernel driver. It's also a good idea to keep the header
file clean and only define the new interface there, to ensure that all
applications that are built in the future have to use the new interface.

When you make the patch to add backwards compat support, just add it
to the driver itself, not to the header.

	Arnd
