From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Date: Wed, 3 Apr 2019 12:27:40 +0200
Message-ID: <20190403102740.qc3hlfchd7eogx44__34594.1283785336$1554287275$gmane$org@sirius.home.kraxel.org>
References: <20190403072318.31507-1-kraxel@redhat.com>
	<CAKMK7uGWh02L9n4etQC3V-RX3aWovJLpadNFe08LdWXRNz2yuw@mail.gmail.com>
	<20190403085341.2cxdgxqrjlwecx3n@sirius.home.kraxel.org>
	<0c959f3a-15e9-8295-dc11-2f6b9a4229ac@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <0c959f3a-15e9-8295-dc11-2f6b9a4229ac@tronnes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > So I can just remove cirrus_fb_dirty() and hook up
> > drm_atomic_helper_dirtyfb() instead.  Easy ;)
> 
> You can even use drm_gem_fb_create_with_dirty() instead of
> drm_gem_fb_create_with_funcs().

Ah, cool.  /me happily continues removing code lines.

thanks,
  Gerd

PS: incremental fixups are at
    https://git.kraxel.org/cgit/linux/log/?h=drm-rewrite-cirrus
