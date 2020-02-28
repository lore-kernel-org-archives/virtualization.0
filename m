From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v4 0/4] drm: Provide a simple encoder
Date: Fri, 28 Feb 2020 20:36:03 +0100
Message-ID: <20200228193603.GA22966@ravnborg.org>
References: <20200228081828.18463-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200228081828.18463-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, virtualization@lists.linux-foundation.org, noralf@tronnes.org, daniel@ffwll.ch, alexander.deucher@amd.com, spice-devel@lists.freedesktop.org, emil.velikov@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Thomas.

On Fri, Feb 28, 2020 at 09:18:24AM +0100, Thomas Zimmermann wrote:
> Many DRM drivers implement an encoder with an empty implementation. This
> patchset adds drm_simple_encoder_init(), which drivers can use instead.
> Except for the destroy callback, the simple encoder's implementation is
> empty.
> 
> The patchset also converts 4 encoder instances to use the simple-encoder
> helpers. But there are at least 11 other drivers which can use the helper
> and I think I did not examine all drivers yet.
> 
> The patchset was smoke-tested on mgag200 by running the fbdev console
> and Gnome on X11.
> 
> v4:
> 	* print error messages with drm_err() (Sam)
> 	* qxl: handle errors of drm_simple_encoder_init() (Sam)

Looked through the patches - all looked good.
IMO ready to apply.

	Sam
