From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH -next] drm/cirrus: Remove set but not used variable 'bo'
Date: Wed, 21 Nov 2018 09:14:40 +0100
Message-ID: <20181121081440.nmrjsx24niopbimc__25945.6658074216$1542787964$gmane$org@sirius.home.kraxel.org>
References: <1542283836-152176-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1542283836-152176-1-git-send-email-yuehaibing@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: Daniel Stone <daniels@collabora.com>, David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Adam Jackson <ajax@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, Thierry Reding <treding@nvidia.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 15, 2018 at 12:10:36PM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/cirrus/cirrus_fbdev.c: In function 'cirrusfb_create':
> drivers/gpu/drm/cirrus/cirrus_fbdev.c:172:20: warning:
>  variable 'bo' set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction in commit
> f9aa76a85248 ("drm/kms: driver for virtual cirrus under qemu")

queued for -next.

thanks,
  Gerd
