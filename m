From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [patch] vhost: NULL vs ERR_PTR bug
Date: Wed, 15 Jul 2015 10:21:12 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1507151020460.2919__29541.987021412$1436970098$gmane$org@hadrien>
References: <20150715111659.GA22854@mwanda>
	<20150715142420-mutt-send-email-mst@redhat.com>
	<55A64574.1090907@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <55A64574.1090907@bfs.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: walter harms <wharms@bfs.de>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org, Igor Mammedov <imammedo@redhat.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 15 Jul 2015, walter harms wrote:

>
>
> Am 15.07.2015 13:28, schrieb Michael S. Tsirkin:
> > On Wed, Jul 15, 2015 at 02:16:59PM +0300, Dan Carpenter wrote:
> >> There is only one caller for vhost_kvzalloc() and it expects NULL on
> >> allocation failure.  Most people would probably expect that so let's
> >> change ERR_PTR(-ENOMEM) to NULL.
> >>
> >> Fixes: 4de7255f7d2b ('vhost: extend memory regions allocation to vmalloc')
> >> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > Ouch. Thanks a lot for noticing this, and it's a good thing
> > you did before Linus merged it.
> > I'll squash this into Igor's patch and redo my pull request.
> >
>
> Is this function needed at all ?
>
> e.g. I followed vzalloc() to __vmalloc_node_range()
>
> a check for size==0 seems to be done there.

At least it looks like one could return the result of vzalloc directly?

julia

>
> re,
>  wh
>
>
> >>
> >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >> index a9fe859..99d613b 100644
> >> --- a/drivers/vhost/vhost.c
> >> +++ b/drivers/vhost/vhost.c
> >> @@ -686,7 +686,7 @@ static void *vhost_kvzalloc(unsigned long size)
> >>  	if (!n) {
> >>  		n = vzalloc(size);
> >>  		if (!n)
> >> -			return ERR_PTR(-ENOMEM);
> >> +			return NULL;
> >>  	}
> >>  	return n;
> >>  }
> > --
> > To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
