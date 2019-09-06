From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 08/18] virtiofs: Drain all pending requests during
	->remove time
Date: Fri, 6 Sep 2019 10:18:49 -0400
Message-ID: <20190906101819-mutt-send-email-mst__41198.9654226758$1567779546$gmane$org@kernel.org>
References: <20190905194859.16219-1-vgoyal@redhat.com>
	<20190905194859.16219-9-vgoyal@redhat.com>
	<20190906105210.GP5900@stefanha-x1.localdomain>
	<20190906141705.GF22083@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190906141705.GF22083@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: miklos@szeredi.hu, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 06, 2019 at 10:17:05AM -0400, Vivek Goyal wrote:
> On Fri, Sep 06, 2019 at 11:52:10AM +0100, Stefan Hajnoczi wrote:
> > On Thu, Sep 05, 2019 at 03:48:49PM -0400, Vivek Goyal wrote:
> > > +static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
> > > +{
> > > +	WARN_ON(fsvq->in_flight < 0);
> > > +
> > > +	/* Wait for in flight requests to finish.*/
> > > +	while (1) {
> > > +		spin_lock(&fsvq->lock);
> > > +		if (!fsvq->in_flight) {
> > > +			spin_unlock(&fsvq->lock);
> > > +			break;
> > > +		}
> > > +		spin_unlock(&fsvq->lock);
> > > +		usleep_range(1000, 2000);
> > > +	}
> > 
> > I think all contexts that call this allow sleeping so we could avoid
> > usleep here.
> 
> usleep_range() is supposed to be used from non-atomic context.
> 
> https://github.com/torvalds/linux/blob/master/Documentation/timers/timers-howto.rst
> 
> What construct you are thinking of?
> 
> Vivek

completion + signal on vq callback?

-- 
MST
