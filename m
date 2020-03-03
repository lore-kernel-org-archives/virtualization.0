From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 29/51] drm/cirrus: Drop explicit
 drm_mode_config_cleanup call
Date: Tue, 3 Mar 2020 08:51:35 +0100
Message-ID: <20200303075135.7acjiurgyjilmkig@sirius.home.kraxel.org>
References: <20200302222631.3861340-1-daniel.vetter@ffwll.ch>
 <20200302222631.3861340-30-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20200302222631.3861340-30-daniel.vetter@ffwll.ch>
Content-Disposition: inline
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 02, 2020 at 11:26:09PM +0100, Daniel Vetter wrote:
> We can even delete the drm_driver.release hook now!
> 
> This is made possible by a preceeding patch which added a drmm_
> cleanup action to drm_mode_config_init(), hence all we need to do to
> ensure that drm_mode_config_cleanup() is run on final drm_device
> cleanup is check the new error code for _init().

Acked-by: Gerd Hoffmann <kraxel@redhat.com>
