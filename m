From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/2] drm/qxl: qxl_release leak in
 qxl_hw_surface_alloc()
Date: Tue, 28 Apr 2020 12:07:28 +0200
Message-ID: <20200428100728.z5j3trkwgksxm2w5@sirius.home.kraxel.org>
References: <2e5a13ae-9ab2-5401-aa4d-03d5f5593423@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spice-devel-bounces@lists.freedesktop.org>
In-Reply-To: <2e5a13ae-9ab2-5401-aa4d-03d5f5593423@virtuozzo.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/spice-devel>,
 <mailto:spice-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/spice-devel>
List-Post: <mailto:spice-devel@lists.freedesktop.org>
List-Help: <mailto:spice-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/spice-devel>,
 <mailto:spice-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: spice-devel-bounces@lists.freedesktop.org
Sender: "Spice-devel" <spice-devel-bounces@lists.freedesktop.org>
To: Vasily Averin <vvs@virtuozzo.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>, spice-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, OpenVZ devel <devel@openvz.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 27, 2020 at 08:32:51AM +0300, Vasily Averin wrote:
> Cc: stable@vger.kernel.org
> Fixes: 8002db6336dd ("qxl: convert qxl driver to proper use for reservations")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Both patches pushed to drm-misc-fixes.

thanks,
  Gerd
