From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Nouveau] [PATCH v2 00/14] improve the fb_setcmap helper
Date: Tue, 27 Jun 2017 09:19:48 +0200
Message-ID: <20170627071948.a2v6ibxvfuvk2gxs__49187.815297819$1498548006$gmane$org@phenom.ffwll.local>
References: <1498111597-10714-1-git-send-email-peda@axentia.se>
	<20170626093526.7dezn6d74m5ktsok@phenom.ffwll.local>
	<59515CCF.8060406@axentia.se>
	<CAPM=9tzr_B9cWG4gEU_+PgkmVnpKtfBFGfQ85gwWpFs+3WQMjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPM=9tzr_B9cWG4gEU_+PgkmVnpKtfBFGfQ85gwWpFs+3WQMjg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, dri-devel <dri-devel@lists.freedesktop.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, nouveau <nouveau@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Philippe Cornu <philippe.cornu@st.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, Russell King <linux@armlinux.org.uk>, Yannick Fertre <yannick.fertre@st.com>, Daniel Vetter <daniel.vetter@intel.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Vincent Abriou <vincent.abriou@st.com>, Peter Rosin <peda@axentia.se>, LKML <linux-kernel@vger.kernel.org>, Ben Skeggs <bskeggs@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 27, 2017 at 05:50:38AM +1000, Dave Airlie wrote:
> >
> > I'm traveling and cannot make progress this week. The merge window is
> > also real close so this series will therefore probably miss it unless
> > something unexpected happens...
> 
> Don't worry you missed the merge window for drm already, we don't merge
> things after -rc6. Please remember the Linus merge window is for maintainers
> to merge stuff to Linus, things need to be ready long before it, and for drm
> you shouldn't really tie yourself to the merge cycle.

Yeah, drm-misc is open for refactorings like this all the time, and
maintainers make sure the code will get into upstream asap, without
interferring with the upstream merge window schedules. Like Dave said,
don't worry.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
