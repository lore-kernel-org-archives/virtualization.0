From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v1 09/33] drm/qxl: drop use of drmP.h
Date: Mon, 1 Jul 2019 08:38:43 +0200
Message-ID: <20190701063843.qhkzyxuyfdv2wyw4__24797.2151891858$1561963142$gmane$org@sirius.home.kraxel.org>
References: <20190630061922.7254-1-sam@ravnborg.org>
	<20190630061922.7254-10-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190630061922.7254-10-sam@ravnborg.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Dave Airlie <airlied@redhat.com>, spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jun 30, 2019 at 08:18:58AM +0200, Sam Ravnborg wrote:
> Drop use of the deprecated drmP.h header file.
> While touching the files divided includes in blocks,
> and when needed sort the blocks.
> Fix fallout.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: spice-devel@lists.freedesktop.org

Acked-by: Gerd Hoffmann <kraxel@redhat.com>
