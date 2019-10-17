From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH -next] drm/qxl: Fix randbuild error
Date: Thu, 17 Oct 2019 14:32:48 +0200
Message-ID: <20191017123248.b4d4jd6wfu7np25n__33632.7665181429$1571315586$gmane$org@sirius.home.kraxel.org>
References: <20191008024054.32368-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191008024054.32368-1-yuehaibing@huawei.com>
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
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, daniel@ffwll.ch, spice-devel@lists.freedesktop.org, airlied@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 08, 2019 at 10:40:54AM +0800, YueHaibing wrote:
> If DEM_QXL is y and DRM_TTM_HELPER is m, building fails:
> 
> drivers/gpu/drm/qxl/qxl_object.o: undefined reference to `drm_gem_ttm_print_info'
> 
> Select DRM_TTM_HELPER to fix this.

Queued up for drm-misc-next.

thanks,
  Gerd
