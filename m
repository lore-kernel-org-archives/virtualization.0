From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [RFC PATCH 0/2] Mdev: support mutiple kinds of devices
Date: Wed, 18 Sep 2019 01:54:43 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D57B260__13332.6614320808$1568771704$gmane$org@SHSMSX104.ccr.corp.intel.com>
References: <20190912094012.29653-1-jasowang@redhat.com>
	<20190917113125.6b2970e5@x1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190917113125.6b2970e5@x1.home>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alex Williamson <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "airlied@linux.ie" <airlied@linux.ie>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sebott@linux.ibm.com" <sebott@linux.ibm.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "farman@linux.ibm.com" <farman@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

> From: Alex Williamson
> Sent: Wednesday, September 18, 2019 1:31 AM
> 
> [cc +Parav]
> 
> On Thu, 12 Sep 2019 17:40:10 +0800
> Jason Wang <jasowang@redhat.com> wrote:
> 
> > Hi all:
> >
> > During the development of virtio-mdev[1]. I find that mdev needs to be
> > extended to support devices other than vfio mdev device. So this
> > series tries to extend the mdev to be able to differ from different
> > devices by:
> >
> > - device id and matching for mdev bus
> > - device speicfic callbacks and move vfio callbacks there
> >
> > Sent for early reivew, compile test only!
> >
> > Thanks
> >
> > [1] https://lkml.org/lkml/2019/9/10/135
> 
> I expect Parav must have something similar in the works for their
> in-kernel networking mdev support.  Link to discussion so far:
> 
> https://lore.kernel.org/kvm/20190912094012.29653-1-
> jasowang@redhat.com/T/#t
> 

It links to the current thread. Is it intended or do you want
people to look at another thread driven by Parav? :-)

Thanks
Kevin
