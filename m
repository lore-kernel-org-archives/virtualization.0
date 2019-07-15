From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v1 31/33] drm/bochs: drop use of drmP.h
Date: Mon, 15 Jul 2019 18:32:15 +0200
Message-ID: <20190715163215.GK27038__47184.5418376446$1563208352$gmane$org@ravnborg.org>
References: <20190630061922.7254-1-sam@ravnborg.org>
	<20190630061922.7254-32-sam@ravnborg.org>
	<20190701063908.5mufonj45bgitzyt@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190701063908.5mufonj45bgitzyt@sirius.home.kraxel.org>
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

On Mon, Jul 01, 2019 at 08:39:08AM +0200, Gerd Hoffmann wrote:
> On Sun, Jun 30, 2019 at 08:19:20AM +0200, Sam Ravnborg wrote:
> > Drop use of the deprecated drmP.h header file.
> > Made bochs.h self-contained and then fixed
> > fallout in remaining files.
> > Several unused includes was dropped in the process.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: virtualization@lists.linux-foundation.org
> 
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>

Thanks again, applied.

	Sam
