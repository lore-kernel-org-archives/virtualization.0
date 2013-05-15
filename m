From: Asias He <asias@redhat.com>
Subject: Re: [PATCH] vhost-scsi: Depend on NET for memcpy_fromiovec
Date: Wed, 15 May 2013 11:44:56 +0800
Message-ID: <20130515034456.GA18256@hj.localdomain>
References: <20130515095558.918f2b29ba318a477eb5dde2@canb.auug.org.au>
	<1368579583-13097-1-git-send-email-asias@redhat.com>
	<1368587420.9012.36.camel@haakon3.risingtidesystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1368587420.9012.36.camel@haakon3.risingtidesystems.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Randy Dunlap <rdunlap@infradead.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, linux-next@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 14, 2013 at 08:10:20PM -0700, Nicholas A. Bellinger wrote:
> On Wed, 2013-05-15 at 08:59 +0800, Asias He wrote:
> > scsi.c includes vhost.c which uses memcpy_fromiovec.
> > 
> > This patch fixes this build failure.
> > 
> >    From Randy Dunlap:
> >    '''
> >    on x86_64:
> > 
> >    ERROR: "memcpy_fromiovec" [drivers/vhost/vhost_scsi.ko] undefined!
> > 
> >    It needs to depend on NET since net/core/ provides that function.
> >    '''
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Asias He <asias@redhat.com>
> 
> Hey Asias & MST,
> 
> FYI, I'll be sending a PULL request to Linus in the next couple of days
> for -rc2.
> 
> Let me know if you'd like this to be picked up.

Yes, this is 3.10 material. Sounds good to me.

> --nab
> 
> > ---
> >  drivers/vhost/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index 8b9226d..0403323 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -12,7 +12,7 @@ config VHOST_NET
> >  
> >  config VHOST_SCSI
> >  	tristate "VHOST_SCSI TCM fabric driver"
> > -	depends on TARGET_CORE && EVENTFD && m
> > +	depends on NET && TARGET_CORE && EVENTFD && m
> >  	select VHOST_RING
> >  	default n
> >  	---help---
> 
> 

-- 
Asias
