From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: introduce mdev based hardware backend
Date: Thu, 26 Sep 2019 09:26:22 -0400
Message-ID: <20190926091945-mutt-send-email-mst__39318.5056209163$1569504402$gmane$org@kernel.org>
References: <20190926045427.4973-1-tiwei.bie@intel.com>
	<20190926042156-mutt-send-email-mst@kernel.org>
	<20190926131439.GA11652@___>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190926131439.GA11652@___>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, zhihong.wang@intel.com, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, netdev@vger.kernel.org, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 26, 2019 at 09:14:39PM +0800, Tiwei Bie wrote:
> > 4. Does device need to limit max ring size?
> > 5. Does device need to limit max number of queues?
> 
> I think so. It's helpful to have ioctls to report the max
> ring size and max number of queues.

Also, let's not repeat the vhost net mistakes, let's lock
everything to the order required by the virtio spec,
checking status bits at each step.
E.g.:
	set backend features
	set features
	detect and program vqs
	enable vqs
	enable driver

and check status at each step to force the correct order.
e.g. don't allow enabling vqs after driver ok, etc

-- 
MST
