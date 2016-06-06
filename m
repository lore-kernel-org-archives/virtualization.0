From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] tools/virtio/ringtest: add usage example to README
Date: Mon, 6 Jun 2016 09:56:18 +0300
Message-ID: <201606060656.u566riO0006559@mx0a-001b2d01.pphosted.com>
References: <1462342376-16065-1-git-send-email-rppt@linux.vnet.ibm.com>
	<20160524124104.GB4725@rapoport-lnx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160524124104.GB4725@rapoport-lnx>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ping?

On Tue, May 24, 2016 at 03:41:04PM +0300, Mike Rapoport wrote:
> Michael,
> 
> Any updates on this?
> 
> On Wed, May 04, 2016 at 09:12:55AM +0300, Mike Rapoport wrote:
> > Having typical usage example in the README file is more convinient than in
> > the git history...
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > ---
> >  tools/virtio/ringtest/README | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/virtio/ringtest/README b/tools/virtio/ringtest/README
> > index 34e94c4..d83707a 100644
> > --- a/tools/virtio/ringtest/README
> > +++ b/tools/virtio/ringtest/README
> > @@ -1,2 +1,6 @@
> >  Partial implementation of various ring layouts, useful to tune virtio design.
> >  Uses shared memory heavily.
> > +
> > +Typical use:
> > +
> > +# sh run-on-all.sh perf stat -r 10 --log-fd 1 -- ./ring
> > -- 
> > 1.9.1
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
