From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 0/5] Clean up TTM mmap offsets
Date: Mon, 11 Mar 2019 18:02:29 +0100
Message-ID: <20190311170229.GM2665@phenom.ffwll.local>
References: <20190207085931.29569-1-tzimmermann@suse.de>
	<2509b876-8335-4be6-b33b-bbf11a73145f@redhat.com>
	<0ac91c9b-5b8e-b27c-286b-7b9697a4f1c2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <0ac91c9b-5b8e-b27c-286b-7b9697a4f1c2@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, ray.huang@amd.com, alexander.deucher@amd.com, David1.Zhou@amd.com, thellstrom@vmware.com, amd-gfx@lists.freedesktop.org, z.liuxinliang@hisilicon.com, kong.kongxinwei@hisilicon.com, linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, spice-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de, puck.chen@hisilicon.com, Hans de Goede <hdegoede@redhat.com>, airlied@redhat.com, Jerry.Zhang@amd.com, gregkh@linuxfoundation.org, daniel@ffwll.ch, zourongrong@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 11, 2019 at 05:51:39PM +0100, Christian K=F6nig wrote:
> Am 11.03.19 um 17:39 schrieb Hans de Goede:
> > Hi,
> > =

> > On 07-02-19 09:59, Thomas Zimmermann wrote:
> > > Almost all TTM-based drivers use the same values for the mmap-able
> > > range of BO addresses. Each driver therefore duplicates the
> > > DRM_FILE_PAGE_OFFSET constant. OTOH, the mmap range's size is not
> > > configurable by drivers.
> > > =

> > > This patch set replaces driver-specific configuration with a single
> > > setup. All code is located within TTM. TTM and GEM share the same
> > > range for mmap-able BOs.
> > > =

> > > Thomas Zimmermann (5):
> > > =A0=A0 staging/vboxvideo: Use same BO mmap offset as other drivers
> > > =A0=A0 drm/ttm: Define a single DRM_FILE_PAGE_OFFSET constant
> > > =A0=A0 drm/ttm: Remove file_page_offset parameter from ttm_bo_device_=
init()
> > > =A0=A0 drm/ttm: Quick-test mmap offset in ttm_bo_mmap()
> > > =A0=A0 drm: Use the same mmap-range offset and size for GEM and TTM
> > =

> > Note I'm about to push a patch-series to drm-misc-next which moves
> > vboxvideo out of staging and I see that this series has not landed
> > in drm-misc-next yet, so it will needs to be rebased.
> =

> Mhm, TTM is usually not pushed upstream through drm-misc-next, so that wi=
ll
> certainly collide with the next TTM pull request.
> =

> So can you wait with that or should I make an exception and merge this
> change though drm-misc-next?

Other options:
- Get amdgpu added to drm-tip and linux-next so we have a heads-up about
  the conflict. That's usually good enough to avoid the broken merge
  conflict.
- Do a topic branch, pull it into both trees.
- Really stuff ttm into a shared tree if it's meant to be shared
  infrastructure :-P

Waiting+rebasing is imo the worst option, and usually not needed.
-Daniel
-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
