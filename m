From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 29/52] drm/bochs: Drop explicit drm_mode_config_cleanup
Date: Mon, 24 Feb 2020 09:15:59 +0100
Message-ID: <20200224081559.7id67nrk5bbob5kc@sirius.home.kraxel.org>
References: <20200219102122.1607365-1-daniel.vetter@ffwll.ch>
 <20200219102122.1607365-30-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200219102122.1607365-30-daniel.vetter@ffwll.ch>
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

On Wed, Feb 19, 2020 at 11:20:59AM +0100, Daniel Vetter wrote:
> Instead rely on the automatic clean, for which we just need to check
> that drm_mode_config_init succeeded. To avoid an inversion in the
> cleanup we also have to move the dev_private allocation over to
> drmm_kzalloc.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org

Acked-by: Gerd Hoffmann <kraxel@redhat.com>
