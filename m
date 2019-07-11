From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH] virtio_pmem: fix sparse warning
Date: Thu, 11 Jul 2019 14:37:57 -0400 (EDT)
Message-ID: <1212628880.41065287.1562870277331.JavaMail.zimbra__9543.86147657118$1562870621$gmane$org@redhat.com>
References: <20190710142700.10215-1-pagupta@redhat.com>
	<20190711134403-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190711134403-mutt-send-email-mst@kernel.org>
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
Cc: linux-nvdimm@lists.01.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, yuval shaia <yuval.shaia@oracle.com>, virtualization@lists.linux-foundation.org, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com
List-Id: virtualization@lists.linuxfoundation.org



> 
> On Wed, Jul 10, 2019 at 07:57:00PM +0530, Pankaj Gupta wrote:
> > This patch fixes below sparse warning related to __virtio
> > type in virtio pmem driver. This is reported by Intel test
> > bot on linux-next tree.
> > 
> > nd_virtio.c:56:28: warning: incorrect type in assignment (different base
> > types)
> > nd_virtio.c:56:28:    expected unsigned int [unsigned] [usertype] type
> > nd_virtio.c:56:28:    got restricted __virtio32
> > nd_virtio.c:93:59: warning: incorrect type in argument 2 (different base
> > types)
> > nd_virtio.c:93:59:    expected restricted __virtio32 [usertype] val
> > nd_virtio.c:93:59:    got unsigned int [unsigned] [usertype] ret
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > ---
> > 
> > This fixes a warning, so submitting it as a separate
> > patch on top of virtio pmem series.
> >  
> >  include/uapi/linux/virtio_pmem.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/uapi/linux/virtio_pmem.h
> > b/include/uapi/linux/virtio_pmem.h
> > index efcd72f2d20d..f89129bf1f84 100644
> > --- a/include/uapi/linux/virtio_pmem.h
> > +++ b/include/uapi/linux/virtio_pmem.h
> > @@ -23,12 +23,12 @@ struct virtio_pmem_config {
> >  
> >  struct virtio_pmem_resp {
> >  	/* Host return status corresponding to flush request */
> > -	__u32 ret;
> > +	__virtio32 ret;
> >  };
> >  
> >  struct virtio_pmem_req {
> >  	/* command type */
> > -	__u32 type;
> > +	__virtio32 type;
> >  };
> >  
> >  #endif
> 
> req/resp are in memory right?
> Then this looks like a wrong fix.
> The accessors should all use cpu_to/from_le
> and they types should be __le32.

o.k

> 
> > --
> > 2.20.1
> 
