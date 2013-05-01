From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH] tcm_vhost: Add vhost_scsi as an alias for tcm_vhost
Date: Wed, 01 May 2013 09:07:56 -0700
Message-ID: <1367424476.10977.4.camel__22892.7713739269$1367424342$gmane$org@haakon3.risingtidesystems.com>
References: <1367034129-31214-1-git-send-email-asias@redhat.com>
	<20130501064222.GA15084@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130501064222.GA15084@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2013-05-01 at 09:42 +0300, Michael S. Tsirkin wrote:
> On Sat, Apr 27, 2013 at 11:42:09AM +0800, Asias He wrote:
> > Signed-off-by: Asias He <asias@redhat.com>
> 
> 
> Nicholas, thoughts?
> How about we move tcm_vhost.c to scsi.c
> call module vhost_scsi and add tcm_vhost as an alias?
> If not - want this alias in?
> 

No objection on my side..

Shall I rebase a branch on top of your vhost-net-next + perform the
rename, or do you want to send this via net-next..?

--nab

> > ---
> >  drivers/vhost/tcm_vhost.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> > index 1677238..bddc39a 100644
> > --- a/drivers/vhost/tcm_vhost.c
> > +++ b/drivers/vhost/tcm_vhost.c
> > @@ -1928,5 +1928,6 @@ static void tcm_vhost_exit(void)
> >  
> >  MODULE_DESCRIPTION("TCM_VHOST series fabric driver");
> >  MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("vhost_scsi");
> >  module_init(tcm_vhost_init);
> >  module_exit(tcm_vhost_exit);
> > -- 
> > 1.8.1.4
> --
> To unsubscribe from this list: send the line "unsubscribe target-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
