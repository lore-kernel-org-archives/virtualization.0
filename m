From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 02/37] drm: Remove drm_device->virtdev
Date: Mon, 29 May 2017 08:52:44 +0200
Message-ID: <1496040764.21582.0.camel__25082.4851253585$1496040774$gmane$org@redhat.com>
References: <20170524145212.27837-1-daniel.vetter@ffwll.ch>
	<20170524145212.27837-3-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170524145212.27837-3-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@intel.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2017-05-24 at 16:51 +0200, Daniel Vetter wrote:
> This is a leftover from the drm_bus days, where we've had a
> bus-specific device type for every bus type in drm_device. Except for
> pci (which we can't remove because dri1 drivers) this is all gone.
> And
> the virt driver also doesn't really need it, dev_to_virtio works
> perfectly fine.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
