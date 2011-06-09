From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 7/7] [v5] drivers/virt: introduce Freescale hypervisor
	management driver
Date: Thu, 9 Jun 2011 13:31:17 -0700
Message-ID: <20110609203117.GB14235__29095.4058095396$1307651527$gmane$org@kroah.com>
References: <1307646794-26374-1-git-send-email-timur@freescale.com>
	<201106092213.13755.arnd@arndb.de> <4DF12A94.6070605@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: Arnd Bergmann <arnd@arndb.de>, konrad.wilk@oracle.com, benh@kernel.crashing.org, kumar.gala@freescale.com, linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-console@vger.kernel.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 09, 2011 at 03:18:28PM -0500, Timur Tabi wrote:
> > More importantly, the code you have chose (0) conflicts with existing drivers
> > (frame buffer, scsi and wavefront among others). Please chose a free one and
> > add it to Documentation/ioctl/ioctl-number.txt in the same patch.
> 
> Ok, I was really hoping to avoid doing this.  Like I said, binary compatibility
> is important, and changing the type will break my existing apps.  Are you
> insisting that I pick a new number?

Why is binary compatibility important?  Isn't this a brand new driver
for a brand new system?  What userspace tools are out there in the wild
for such a thing?

confused,

greg k-h
