From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [EXTERNAL] Re: [PATCH 1/1] drm/bochs: Fix connector leak during
	driver unload
Date: Mon, 17 Jun 2019 07:45:00 +0200
Message-ID: <20190617054500.73am3e5yv5uzpga7@sirius.home.kraxel.org>
References: <93b363ad62f4938d9ddf3e05b2a61e3f66b2dcd3.1558416473.git.sbobroff@linux.ibm.com>
	<20190521081029.dexgf7e7d3b7wxdw@sirius.home.kraxel.org>
	<20190617012033.GA1151@tungsten.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190617012033.GA1151@tungsten.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sam Bobroff <sbobroff@linux.ibm.com>
Cc: airlied@linux.ie, daniel@ffwll.ch, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 17, 2019 at 11:20:34AM +1000, Sam Bobroff wrote:
> On Tue, May 21, 2019 at 10:10:29AM +0200, Gerd Hoffmann wrote:
> >   Hi,
> > 
> > The bug is in the driver, so ...
> > 
> > > Bisecting the issue for commits to drivers/gpu/drm/bochs/ points to:
> > > 6579c39594ae ("drm/bochs: atomic: switch planes to atomic, wire up helpers.")
> > > ... but the issue also seems to be due to a change in the generic drm code
> > 
> > ... this one is the culprit and should be listed.
> > 
> > > (reverting it separately fixes the issue):
> > > 846c7dfc1193 ("drm/atomic: Try to preserve the crtc enabled state in drm_atomic_remove_fb, v2.")
> > > ... so I've included both in the commit.  Is that the right thing to do?
> > 
> > That only triggers the driver bug.
> > 
> > I'll fix it up on commit,
> >   Gerd
> 
> Sorry if I misunderstood, but were you going to take the patch and fix
> it up or would you like me to post a v2?

Patch is in drm-misc-next, I fixed it on commit.

cheers,
  Gerd
