From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/2] drm/bochs: Drop best_encoder
Date: Thu, 28 Feb 2019 10:32:08 +0100
Message-ID: <20190228093208.GI2665__24354.7086183511$1551346767$gmane$org@phenom.ffwll.local>
References: <20190221155857.19773-1-daniel.vetter@ffwll.ch>
	<20190221155857.19773-2-daniel.vetter@ffwll.ch>
	<20190228085522.mkf6tcueygihyjht@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190228085522.mkf6tcueygihyjht@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, virtualization@lists.linux-foundation.org, DRI Development <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 28, 2019 at 09:55:22AM +0100, Gerd Hoffmann wrote:
> On Thu, Feb 21, 2019 at 04:58:57PM +0100, Daniel Vetter wrote:
> > This is the default for atomic drivers.
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: virtualization@lists.linux-foundation.org
> > ---
> >  drivers/gpu/drm/bochs/bochs_kms.c | 11 -----------
> >  1 file changed, 11 deletions(-)
> 
> Pushed to drm-misc-next.

Thanks. r-b on the first patch too so I can pull that in?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
