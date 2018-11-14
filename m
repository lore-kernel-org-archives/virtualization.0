From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH -next] drm/qxl: remove set but not used variable 'map'
Date: Wed, 14 Nov 2018 13:16:02 +0100
Message-ID: <20181114121602.wb4gesmvhknvy4cc__48771.0461290137$1542197642$gmane$org@sirius.home.kraxel.org>
References: <1541821486-40631-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1541821486-40631-1-git-send-email-yuehaibing@huawei.com>
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Nov 10, 2018 at 03:44:46AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/qxl/qxl_object.c: In function 'qxl_bo_kunmap_atomic_page':
> drivers/gpu/drm/qxl/qxl_object.c:189:21: warning:
>  variable 'map' set but not used [-Wunused-but-set-variable]

Both qxl patches added to qemu queue, should land in drm-misc-next soon.

thanks,
  Gerd
