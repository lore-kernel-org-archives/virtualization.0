From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v1 09/33] drm/qxl: drop use of drmP.h
Date: Mon, 15 Jul 2019 18:29:00 +0200
Message-ID: <20190715162900.GE27038__29440.1798908197$1563208156$gmane$org@ravnborg.org>
References: <20190630061922.7254-1-sam@ravnborg.org>
	<20190630061922.7254-10-sam@ravnborg.org>
	<20190701063843.qhkzyxuyfdv2wyw4@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190701063843.qhkzyxuyfdv2wyw4@sirius.home.kraxel.org>
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
Cc: Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, spice-devel@lists.freedesktop.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 01, 2019 at 08:38:43AM +0200, Gerd Hoffmann wrote:
> On Sun, Jun 30, 2019 at 08:18:58AM +0200, Sam Ravnborg wrote:
> > Drop use of the deprecated drmP.h header file.
> > While touching the files divided includes in blocks,
> > and when needed sort the blocks.
> > Fix fallout.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: virtualization@lists.linux-foundation.org
> > Cc: spice-devel@lists.freedesktop.org
> 
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>

Thanks, applied.

	Sam
