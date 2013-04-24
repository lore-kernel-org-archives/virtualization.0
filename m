From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8 2/3] tcm_vhost: Add hotplug/hotunplug support
Date: Wed, 24 Apr 2013 13:51:19 +0300
Message-ID: <20130424105119.GA12865@redhat.com>
References: <1366774344-11127-1-git-send-email-asias@redhat.com>
	<1366774344-11127-3-git-send-email-asias@redhat.com>
	<20130424091833.GB11245@redhat.com>
	<20130424100625.GA19845@hj.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130424100625.GA19845@hj.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 24, 2013 at 06:06:25PM +0800, Asias He wrote:
> > > +{
> > > +
> > > +	struct vhost_scsi *vs = tpg->vhost_scsi;
> > > +	struct vhost_virtqueue *vq;
> > > +	u32 reason;
> > > +	int ret;
> > > +
> > > +	mutex_lock(&tpg->tv_tpg_mutex);
> > > +	vs = tpg->vhost_scsi;
> > > +	mutex_unlock(&tpg->tv_tpg_mutex);
> > > +	if (!vs)
> > > +		return -ENODEV;
> > > +
> > 
> > What if clear_endpoint and close happen at this
> > point? Can vhost_scsi go away so tcm_vhost_check_feature
> > references freed memory?
> 
> There is no easy way to handle this.

Take a reference somewhere so this can't happen?
