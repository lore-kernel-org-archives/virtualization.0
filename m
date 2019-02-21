From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH -next] drm/qxl: remove set but not used variable 'bo_old'
Date: Thu, 21 Feb 2019 13:05:45 +0100
Message-ID: <20190221120545.dnllvgdszdk4yf5z__305.205436755784$1550750985$gmane$org@sirius.home.kraxel.org>
References: <20190218085459.196470-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190218085459.196470-1-yuehaibing@huawei.com>
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>, spice-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 18, 2019 at 08:54:59AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/qxl/qxl_display.c: In function 'qxl_primary_atomic_update':
> drivers/gpu/drm/qxl/qxl_display.c:538:17: warning:
>  variable 'bo_old' set but not used [-Wunused-but-set-variable]
> 
> It's not used any more after 4979904c62b9 ("drm/qxl: use shadow bo directly")

Pushed to drm-misc-next.

thanks,
  Gerd
