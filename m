From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3] drm/bochs: add edid support.
Date: Tue, 30 Oct 2018 10:44:08 +0100
Message-ID: <20181030094408.GR21967__28700.9488478818$1540892550$gmane$org@phenom.ffwll.local>
References: <20181029134507.7775-1-kraxel@redhat.com>
	<87in1kejgj.fsf@intel.com>
	<20181029200520.jfnmvbkng2er5qbc@sirius.home.kraxel.org>
	<20181030090632.GJ21967@phenom.ffwll.local>
	<87y3afokav.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87y3afokav.fsf@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 30, 2018 at 11:28:24AM +0200, Jani Nikula wrote:
> On Tue, 30 Oct 2018, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Mon, Oct 29, 2018 at 09:05:20PM +0100, Gerd Hoffmann wrote:
> >> On Mon, Oct 29, 2018 at 07:44:28PM +0200, Jani Nikula wrote:
> >> > On Mon, 29 Oct 2018, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >> > > Recent qemu (latest master branch, upcoming 3.1 release) got support
> >> > > for EDID data.  This patch adds guest driver support.
> >> > >
> >> > > EDID support in qemu is not (yet) enabled by default, so please use
> >> > > 'qemu -device VGA,edid=on' for testing.
> >> > 
> >> > Any chance of making this use drm_get_edid() (requires an i2c_adapter)
> >> > or at least drm_do_get_edid()?
> >> 
> >> I'll have a look at using drm_do_get_edid().  drm_get_edid() will not
> >> fly as there is no i2c adapter in the first place.
> >
> > Hm, not sure that makes sense. drm_do_get_edid is to handle the real-world
> > flakiness of sinks (it's where all the retry logic resides), if you don't
> > have a i2c_adapater (because the hw has some magic "give me an edid"
> > block). For virtual hw we hopefully don't randomly drop bits on the floor
> > between the guest and host. Imo totally fine as-is.
> >
> > E.g. we also don't feed the VBT edid through drm_do_get_edid either.
> 
> But nowadays we do handle the debugfs EDID override and the EDID
> firmware loading in drm_do_get_edid(), so using that gives you those
> features.

Oh, missed that. Would be good to clarify the kernel doc and mention this
in e.g. both drm_add_edid_modes() and &drm_connector_helper_funcs.get_modes?

And maybe make it more obvious that drm_do_get_edid is also for virtual
drivers, atm the kerneldoc talks a lot about DDC and everything hw.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
