From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 02/13] fbdev: add remove_conflicting_pci_framebuffers()
Date: Fri, 1 Dec 2017 14:10:15 +0000
Message-ID: <20171201141015.GA7126@sudip-tp>
References: <cover.1511544782.git.mirq-linux@rere.qmqm.pl>
	<1738dbed0239bffc886f126fd3091daa39cd14c9.1511544782.git.mirq-linux@rere.qmqm.pl>
	<20171127102758.y7c6yzyey6wfntxh@phenom.ffwll.local>
	<20171127205219.GA3537@sudip-laptop>
	<20171128102217.b7ynyqarwzkdvmdq@phenom.ffwll.local>
	<20171128113238.GA29456@kroah.com>
	<20171128123008.GA12986@sudip-tp>
	<20171129095634.ymeld4l7zaehbuvn@phenom.ffwll.local>
	<20171130234953.GA5542@sudip-laptop>
	<20171201071916.jpl5ucxq4glduho4@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171201071916.jpl5ucxq4glduho4@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, David Airlie <airlied@linux.ie>, Greg KH <gregkh@linuxfoundation.org>, amd-gfx@lists.freedesktop.org, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, virtualization@lists.linux-foundation.org, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 01, 2017 at 08:19:16AM +0100, Daniel Vetter wrote:
> On Thu, Nov 30, 2017 at 11:49:53PM +0000, Sudip Mukherjee wrote:
> > Hi Daniel,
> > 
> > <snip>
> > 
> > > > > > 
> > > > > > Greg?
> > > > > 
> > > > > Yes, if no one is working to get it out of staging, that means no one
> > > > > cares about it, and it needs to be removed from the tree.
> > > > 
> > > > Agreed. I was not working on getting it out of staging as there is no
> > > > place for it to go.
> > > > But, Teddy Wang told me that they have a working drm driver for it, but
> > > > it is not atomic like Daniel was asking for. If it is ok, then I can send
> > > > in a patch to remove the existing sm750 from staging and add the new sm750
> > > > drm driver to staging. And after it is ready, we can go ahead with moving
> > > > it out of staging to drm.
> > > 
> > > Please keep the todo item that it needs to be converted to atomic. And
> > > tbh, it's probably faster if you just submit it to dri-devel, assuming you
> > > have time to work on it. For small drivers we tend to be fairly quick in
> > > getting them into good enough shape.
> > 
> > I have received the driver from Teddy and pushed it to
> > https://github.com/sudipm-mukherjee/parport/tree/drm_smi for your first
> > look into it. It is not even building with next-20171130 and has lots of
> > build warnings. I will have to do a lot of work on it before I can even
> > submit it to dri-devel.
> > 
> > Time will be the problem, as this is not part of my day job.
> > 
> > > 
> > > Staging is also a major pain for drm subsystem refactorings, I really,
> > > really, really prefer we don't add more than the vbox pain we have
> > > already.
> > 
> > I am hoping that after seeing it, you will agree to have it in staging. :)
> 
> So I know Greg is willing to take anything into staging, but I'm no fan.
> We refactor and improve drm a lot, with a lot of cross-driver changes
> necessary to move things forward. We can do that since we have a generally
> rather active development community, and we try hard to keep most drivers
> in reasonable good shape and so easy to maintain.
> 
> If you know throw a pile of unmaintainable stuff into staging, but without
> working on it, then that's just cost, no benefit to the dri-devel
> community. On top, staging tree is separate from drm trees, so more pain
> to synchronize trees (and we have to do that a few times per release cycle
> or drivers simply stop compiling). Where's the upside of taking this
> driver into staging?
> 
> One is users, but ime for soc display drivers usually everything else is
> in worse shape (e.g. even great drivers like the one for qualcom must be
> tested on some vendor tree because critical core bits are missing in
> upstream), so "more users" is not the good reason. And it's clearly not
> "more developers", because no time to clean things up. So what exactly is
> the good reason to put this into staging instead of just waiting until
> someone has the time to clean it up quickly?

Ok, I will not try to give any more reasons now. :)

I will cleanup the basic things I can and then submit it to dri-devel.

Greg - Please keep the SM750 driver in staging for now. I will send
a patch later to add in TODO the git location where the drm driver is
being developed. And when that drm driver is ready, I will send a patch
to remove the sm750fb driver from staging.

--
Regards
Sudip
