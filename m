From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 59/59] drm/bochs: Remove explicit drm_connector_register
Date: Tue, 21 Apr 2020 09:39:00 +0200
Message-ID: <20200421073900.mc2mknilgp3lxd6h@sirius.home.kraxel.org>
References: <20200415074034.175360-1-daniel.vetter@ffwll.ch>
 <20200415074034.175360-60-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200415074034.175360-60-daniel.vetter@ffwll.ch>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Daniel Vetter <daniel.vetter@intel.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 15, 2020 at 09:40:34AM +0200, Daniel Vetter wrote:
> This is leftovers from the old drm_driver->load callback
> upside-down issues. It doesn't do anything for not-hotplugged
> connectors since drm_dev_register takes care of that.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org

Acked-by: Gerd Hoffmann <kraxel@redhat.com>
