From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Xen-devel] [PATCH 2/4 v2] xen kconfig: relax
	INPUT_XEN_KBDDEV_FRONTEND deps
Date: Thu, 15 Mar 2012 23:24:28 -0700
Message-ID: <20120316062428.GA16291@core.coreip.homeip.net>
References: <20120111161130.GA18203@andromeda.dapyr.net>
	<7e004a73-b1ef-49f4-91e8-68fdf48c3ccb@zmail13.collab.prod.int.phx2.redhat.com>
	<20120315172305.GA32759@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120315172305.GA32759@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andrew Jones <drjones@redhat.com>, xen-devel@lists.xensource.com, FlorianSchandinat@gmx.de, jeremy@goop.org, virtualization@lists.linux-foundation.org, Konrad Rzeszutek Wilk <konrad@darnok.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 15, 2012 at 01:23:05PM -0400, Konrad Rzeszutek Wilk wrote:
> On Wed, Jan 11, 2012 at 11:29:20AM -0500, Andrew Jones wrote:
> > 
> > 
> > ----- Original Message -----
> > > On Mon, Jan 09, 2012 at 06:51:41PM +0100, Andrew Jones wrote:
> > > > PV-on-HVM guests may want to use the xen keyboard/mouse frontend,
> > > > but
> > > > they don't use the xen frame buffer frontend. For this case it
> > > > doesn't
> > > 
> > > Ok, but PV does?
> > > > make much sense for INPUT_XEN_KBDDEV_FRONTEND to depend on
> > > > XEN_FBDEV_FRONTEND. The opposite direction always makes more sense,
> > > > i.e.
> > > > if you're using xenfb, then you'll want xenkbd. Switch the
> > > > dependencies.
> > > 
> > > That sounds like it would be universal irregardless if it is
> > > PV or PVonHVM?
> > 
> > This patch makes it such that if you want to use both, then you must
> > select both. It also says that if you want FB, then you need the
> > KBD. However, if you only want the KBD then you're fine with just
> > that. So there isn't any risk of breaking configs designed to use
> > FB, because FB should be manually selected for those configs anyway.
> 
> Dmitry,
> 
> I am OK with this patch. Should I pick it up on my tree for 3.4 or
> are you OK doing it via your tree?

Konrad,

I don't have a good copy of the patch so it you could pick it up that
would be great.

Thanks.

-- 
Dmitry
