From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 12/19] drm/bochs: Convert bochs driver to VRAM MM
Date: Mon, 6 May 2019 14:40:31 +0200
Message-ID: <20190506124031.jwo5exbz6xk5fjan__13516.4873719745$1557146499$gmane$org@sirius.home.kraxel.org>
References: <20190506082649.942-1-tzimmermann@suse.de>
	<20190506082649.942-13-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190506082649.942-13-tzimmermann@suse.de>
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

  Hi,

>  static const struct file_operations bochs_fops = {
>  	.owner		= THIS_MODULE,
> -	.open		= drm_open,
> -	.release	= drm_release,
> -	.unlocked_ioctl	= drm_ioctl,
> -	.compat_ioctl	= drm_compat_ioctl,
> -	.poll		= drm_poll,
> -	.read		= drm_read,
>  	.llseek		= no_llseek,
> -	.mmap           = bochs_mmap,
> +	DRM_VRAM_MM_FILE_OPERATIONS
>  };

What about llseek?  I think it should either be deleted (if not needed)
or added to DRM_VRAM_MM_FILE_OPERATIONS (if needed).

cheers,
  Gerd
