From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 11/11] drm: remove unused and redundant callbacks
Date: Thu, 22 Jun 2017 09:13:36 +0200
Message-ID: <20170622091336.3ef46ba5__24122.5105863579$1498115640$gmane$org@bbrezillon>
References: <1497986735-14418-12-git-send-email-peda@axentia.se>
	<201706220036.6WxRju5X%fengguang.wu@intel.com>
	<20170622063755.3bfwybkotacyn4p7@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170622063755.3bfwybkotacyn4p7@phenom.ffwll.local>
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
Cc: kbuild-all@01.org, kbuild test robot <lkp@intel.com>, Philippe Cornu <philippe.cornu@st.com>, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Yannick Fertre <yannick.fertre@st.com>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Vincent Abriou <vincent.abriou@st.com>, Peter Rosin <peda@axentia.se>, Ben Skeggs <bskeggs@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 22 Jun 2017 08:37:55 +0200
Daniel Vetter <daniel@ffwll.ch> wrote:

> On Thu, Jun 22, 2017 at 12:34:36AM +0800, kbuild test robot wrote:
> > Hi Peter,
> > 
> > [auto build test ERROR on drm/drm-next]
> > [also build test ERROR on next-20170621]
> > [cannot apply to v4.12-rc6]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Peter-Rosin/improve-the-fb_setcmap-helper/20170621-205441
> > base:   git://people.freedesktop.org/~airlied/linux.git drm-next
> > config: arm-allmodconfig (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> > reproduce:
> >         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=arm 
> > 
> > All errors (new ones prefixed by >>):
> >   
> > >> drivers/gpu//drm/armada/armada_fbdev.c:121:2: error: unknown field 'gamma_set' specified in initializer  
> >      .gamma_set = armada_drm_crtc_gamma_set,  
> 
> Looks like you've missed at least the armada driver in your conversion?

Already fixed in v2 ;-).
