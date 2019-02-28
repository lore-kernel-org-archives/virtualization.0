From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/2] drm/bochs: Drop best_encoder
Date: Thu, 28 Feb 2019 09:55:22 +0100
Message-ID: <20190228085522.mkf6tcueygihyjht__42178.2381528587$1551344758$gmane$org@sirius.home.kraxel.org>
References: <20190221155857.19773-1-daniel.vetter@ffwll.ch>
	<20190221155857.19773-2-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190221155857.19773-2-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Daniel Vetter <daniel.vetter@intel.com>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 21, 2019 at 04:58:57PM +0100, Daniel Vetter wrote:
> This is the default for atomic drivers.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> ---
>  drivers/gpu/drm/bochs/bochs_kms.c | 11 -----------
>  1 file changed, 11 deletions(-)

Pushed to drm-misc-next.

thanks,
  Gerd
