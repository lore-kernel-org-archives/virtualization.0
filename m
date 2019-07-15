From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v1 27/33] drm/virtgpu: drop use of drmP.h
Date: Mon, 15 Jul 2019 18:30:16 +0200
Message-ID: <20190715163016.GI27038__19480.5589549773$1563208229$gmane$org@ravnborg.org>
References: <20190630061922.7254-1-sam@ravnborg.org>
	<20190630061922.7254-28-sam@ravnborg.org>
	<20190701063856.5uutpqzfjuea4rzb@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190701063856.5uutpqzfjuea4rzb@sirius.home.kraxel.org>
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
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 01, 2019 at 08:38:56AM +0200, Gerd Hoffmann wrote:
> On Sun, Jun 30, 2019 at 08:19:16AM +0200, Sam Ravnborg wrote:
> > Drop use of the deprecated drmP.h header file.
> > Fix fallout by adding missing include files.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: virtualization@lists.linux-foundation.org
> 
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>

Thanks, applied.

	Sam
