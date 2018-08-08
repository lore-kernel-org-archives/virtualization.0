From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/cirrus: flip default to 32bpp
Date: Wed, 8 Aug 2018 10:46:05 +0200
Message-ID: <20180808084605.bnunbipv3uqxkmst@sirius.home.kraxel.org>
References: <20180706091249.25086-1-kraxel@redhat.com>
	<e127596f255261d78fdfe6f534a1000f60c3c605.camel@redhat.com>
	<20180709073924.GB3008@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180709073924.GB3008@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Adam Jackson <ajax@redhat.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 09, 2018 at 09:39:24AM +0200, Daniel Vetter wrote:
> On Fri, Jul 06, 2018 at 02:35:07PM -0400, Adam Jackson wrote:
> > On Fri, 2018-07-06 at 11:12 +0200, Gerd Hoffmann wrote:
> > > cirrus can handle 1024x768 (and slightly higher) with 24bpp depth.
> > > cirrus can handle up to 800x600 with 32bpp.
> > 
> > 16bpp is maybe a better choice? Nobody's using cirrus because they care
> > about color fidelity and it'll use less CPU to update. There's
> > precedent here, mgag200 defaults to 16bpp on sufficiently memory-
> > impaired devices.
> 
> Yeah nouveau does the same fallback to 16bpp if there's not enough vram.
> So do a bunch of other drivers.

Makes sense.  But appearently 16bpp support bitrotted over time, when
just flipping the default the driver Oopses at init time.  I'll look
into it.

cheers,
  Gerd
