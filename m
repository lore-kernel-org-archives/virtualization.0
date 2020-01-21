From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 0/4] Use no_vblank property for drivers without VBLANK
Date: Tue, 21 Jan 2020 10:36:04 +0100
Message-ID: <20200121093604.ruclkfho5gmflasq@sirius.home.kraxel.org>
References: <20200120122051.25178-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200120122051.25178-1-tzimmermann@suse.de>
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
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: david@lechnology.com, oleksandr_andrushchenko@epam.com, airlied@linux.ie, sam@ravnborg.org, dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, virtualization@lists.linux-foundation.org, hdegoede@redhat.com, noralf@tronnes.org, laurent.pinchart@ideasonboard.com, daniel@ffwll.ch, xen-devel@lists.xenproject.org, sean@poorly.run, emil.velikov@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 20, 2020 at 01:20:47PM +0100, Thomas Zimmermann wrote:
> Instead of faking VBLANK events by themselves, drivers without VBLANK
> support can enable drm_crtc_vblank.no_vblank and let DRM do the rest.
> The patchset makes this official and converts over drivers.
> 
> The current implementation looks at the number of initialized CRTCs
> wrt vblanking. If vblanking has been initialized for a CRTC, the driver
> is responsible for sending out VBLANK events. Otherwise, DRM will send
> out the event. The behaviour selected by initializing no_vblank as part
> of drm_atomic_helper_check_modeset().
> 
> I went through all drivers, looking for those that call send out VBLANK
> events but do not call drm_vblank_init(). These are converted to the new
> semantics. This affects tiny drivers; drivers for virtual hardware; and
> a few others, which do not support interrupts. Xen comes with its
> own VBLANK logic and disables no_vblank explictly.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>
