From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Spice-devel] [PATCH 1/3] drm/qxl: add mode/framebuffer check
	functions
Date: Wed, 16 Jan 2019 12:28:00 +0100
Message-ID: <20190116112800.v73xmxedt4b3gktj__29342.764177318$1547692501$gmane$org@sirius.home.kraxel.org>
References: <20190116083521.22673-1-kraxel@redhat.com>
	<20190116083521.22673-2-kraxel@redhat.com>
	<636470684.58090538.1547630691403.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <636470684.58090538.1547630691403.JavaMail.zimbra@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Frediano Ziglio <fziglio@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>
List-Id: virtualization@lists.linuxfoundation.org

> > +static int qxl_check_mode(struct qxl_device *qdev,
> > +			  unsigned int width,
> > +			  unsigned int height)
> > +{
> > +	if (width * height * 4 > qdev->vram_size)
> 
> Is someone checking for integer overflows already?

Need to have a look.  This is just ...

> > -	if (bo->surf.stride * bo->surf.height > qdev->vram_size) {
> > -		DRM_ERROR("Mode doesn't fit in vram size (vgamem)");
> > -		return -EINVAL;
> > -	}

... that check moved into the new function.

cheers,
  Gerd
