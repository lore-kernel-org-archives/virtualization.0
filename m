From: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 4/4] xen kconfig: describe xen tmem in the config menu
Date: Thu, 12 Jan 2012 05:54:49 -0500 (EST)
Message-ID: <929b2415-1926-4efa-90b1-eef07e1f2c9c@zmail13.collab.prod.int.phx2.redhat.com>
References: <20120111173536.GD4449@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120111173536.GD4449@phenom.dumpdata.com>
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
Cc: konrad@darnok.org, jeremy@goop.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, stefano stabellini <stefano.stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org



----- Original Message -----
> On Wed, Jan 11, 2012 at 05:36:41PM +0100, Andrew Jones wrote:
> > Add a description to the config menu for xen tmem.
> 
> We will have another config option asked during 'make oldconfig'
> right?
> 
> I thought part of this cleanup patch is to remove some of this
> complexity - not make it _more_ complex.
> 

Another candidate for 'if EXPERT' then, IMHO.

> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  drivers/xen/Kconfig |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> > index 1d24061..7e8d728 100644
> > --- a/drivers/xen/Kconfig
> > +++ b/drivers/xen/Kconfig
> > @@ -143,7 +143,7 @@ config SWIOTLB_XEN
> >  	select SWIOTLB
> >  
> >  config XEN_TMEM
> > -	bool
> > +	bool "Xen Transcendent Memory (tmem)"
> >  	default y if (CLEANCACHE || FRONTSWAP)
> >  	help
> >  	  Shim to interface in-kernel Transcendent Memory hooks
> > --
> > 1.7.7.5
> 
