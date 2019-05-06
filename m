From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 00/19] Share TTM code among DRM framebuffer drivers
Date: Mon, 6 May 2019 14:22:33 +0200
Message-ID: <20190506122233.76pya5kpdfgp4f25__19018.3197659039$1557145442$gmane$org@sirius.home.kraxel.org>
References: <20190506082649.942-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190506082649.942-1-tzimmermann@suse.de>
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

> GEM VRAM could implement PRIME helpers, which would allow for using
> the generic fbcon.

bochs_gem_prime_*() functions with this series applied look like you can
just rename them & move over to vram helpers.

It's not a full prime implementation, specifically actual export/import
isn't there.  But pin+vmap (needed by generic fbcon) is implemented.

cheers,
  Gerd
