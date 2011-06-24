From: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: RE: [PATCH 02/02] virtio: Add virtio platform driver
Date: Fri, 24 Jun 2011 04:08:50 +0000
Message-ID: <B8D6CA50DACE9E4AAADE9A4D56FBAAE6166FD3__11357.6966374696$1308936101$gmane$org@039-SN1MPN1-004.039d.mgd.msft.net>
References: <20110621102605.1382.90232.sendpatchset@t400s>
	<20110621102623.1382.71841.sendpatchset@t400s>
	<B8D6CA50DACE9E4AAADE9A4D56FBAAE6166661@039-SN1MPN1-004.039d.mgd.msft.net>
	<BANLkTi=QhwBAv5GtrTpitVhx+yDZPnRN+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi=QhwBAv5GtrTpitVhx+yDZPnRN+g@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "vapier@gentoo.org" <vapier@gentoo.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mst@redhat.com" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Thanks for the explanation. I also thought of same purpose for this patch but I got confused by function names and data structure names in the patch. They still have lguest in it.

Thanks
-Bharat

> -----Original Message-----
> From: Magnus Damm [mailto:magnus.damm@gmail.com]
> Sent: Friday, June 24, 2011 6:44 AM
> To: Bhushan Bharat-R65777
> Cc: linux-kernel@vger.kernel.org; vapier@gentoo.org; mst@redhat.com;
> linux-sh@vger.kernel.org; virtualization@lists.linux-foundation.org
> Subject: Re: [PATCH 02/02] virtio: Add virtio platform driver
> 
> Hi Bhushan Bharat,
> 
> On Thu, Jun 23, 2011 at 5:54 PM, Bhushan Bharat-R65777
> <R65777@freescale.com> wrote:
> > What purpose this virtio platform driver serves? Are you trying to make
> driver layers here and each virtio device driver can hook up into this
> platform driver. Is that correct ?
> 
> The idea behind the virto platform driver is to have a reusable layer
> that handles common virtio and vring functionality. Regular virtio
> drivers for console, network and disk and interfacing to the virtio
> platform driver, so these paravirtualized drivers can with this virtio
> platform driver easily be reused by embedded platforms.
> 
> Vendor specific code is abstracted away from the virtio platform driver
> and interfaced to using regular interrupts and SoC-specific callbacks. So
> with this patch virtio can be interfaced as any regular platform driver.
> This version of the driver is simply reusing the configuration method
> from lguest.
> 
> If you want to see all code involved (including extremely experimental
> backing drivers) then have a look at:
> http://www.spinics.net/lists/linux-sh/msg07188.html
> 
> Cheers,
> 
> / magnus
