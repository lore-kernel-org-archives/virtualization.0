From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/5] Clean up TTM mmap offsets
Date: Mon, 11 Mar 2019 17:39:31 +0100
Message-ID: <2509b876-8335-4be6-b33b-bbf11a73145f@redhat.com>
References: <20190207085931.29569-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190207085931.29569-1-tzimmermann@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@redhat.com, kraxel@redhat.com, z.liuxinliang@hisilicon.com, zourongrong@gmail.com, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com, bskeggs@redhat.com, thellstrom@vmware.com, linux-graphics-maintainer@vmware.com, daniel@ffwll.ch, arnd@arndb.de, gregkh@linuxfoundation.org, ray.huang@amd.com, Jerry.Zhang@amd.com
Cc: spice-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On 07-02-19 09:59, Thomas Zimmermann wrote:
> Almost all TTM-based drivers use the same values for the mmap-able
> range of BO addresses. Each driver therefore duplicates the
> DRM_FILE_PAGE_OFFSET constant. OTOH, the mmap range's size is not
> configurable by drivers.
> 
> This patch set replaces driver-specific configuration with a single
> setup. All code is located within TTM. TTM and GEM share the same
> range for mmap-able BOs.
> 
> Thomas Zimmermann (5):
>    staging/vboxvideo: Use same BO mmap offset as other drivers
>    drm/ttm: Define a single DRM_FILE_PAGE_OFFSET constant
>    drm/ttm: Remove file_page_offset parameter from ttm_bo_device_init()
>    drm/ttm: Quick-test mmap offset in ttm_bo_mmap()
>    drm: Use the same mmap-range offset and size for GEM and TTM

Note I'm about to push a patch-series to drm-misc-next which moves
vboxvideo out of staging and I see that this series has not landed
in drm-misc-next yet, so it will needs to be rebased.

Regards,

Hans
