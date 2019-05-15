From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v5 00/20] Share TTM code among DRM framebuffer drivers
Date: Wed, 15 May 2019 16:22:35 +0200
Message-ID: <20190515142235.qfwnvsrhnogj67hz@sirius.home.kraxel.org>
References: <20190508082630.15116-1-tzimmermann@suse.de>
	<05884df3-207a-6c2f-226e-d01266f17b77@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <05884df3-207a-6c2f-226e-d01266f17b77@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: noralf@tronnes.org, airlied@linux.ie, puck.chen@hisilicon.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, hdegoede@redhat.com, kong.kongxinwei@hisilicon.com, ray.huang@amd.com, daniel@ffwll.ch, zourongrong@gmail.com, sam@ravnborg.org, christian.koenig@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 15, 2019 at 09:05:54AM +0200, Thomas Zimmermann wrote:
> Hi,
> 
> most of this patch set still needs reviews.
> 
> If it's too large for merging or reviewing at once, I could move the
> driver changes into separate patch sets. The vbox driver's changes have
> been accepted by Hans already. So only keeping the core changes plus
> vbox would be an option.

Looks all good to me.  bochs survived my testing, vbox is reviewed and
IIRC you've tested two of the other three drivers.  So all but one
driver is covered.

I'll go push this to drm-misc-next in a moment.

> > Future directions: with these changes, the respective drivers can also
> > share some of their mode-setting or fbdev code. GEM VRAM's PRIME helpers
> > allow for using the generic fbcon emulation.

Using generic fbcon should be easy now.

cheers,
  Gerd
