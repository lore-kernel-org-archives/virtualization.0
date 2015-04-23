From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 1/8] virtio: introduce virtio_is_little_endian() helper
Date: Thu, 23 Apr 2015 19:26:13 +0200
Message-ID: <20150423192613.6c58042f__37212.1322121986$1429896734$gmane$org@thh440s>
References: <20150423152608.11795.4373.stgit@bahia.local>
	<20150423152617.11795.13272.stgit@bahia.local>
	<20150423192215.12182311@thh440s>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150423192215.12182311@thh440s>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Thu, 23 Apr 2015 19:22:15 +0200
schrieb Thomas Huth <thuth@redhat.com>:

> Am Thu, 23 Apr 2015 17:26:20 +0200
> schrieb Greg Kurz <gkurz@linux.vnet.ibm.com>:
> 
> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > ---
> >  include/linux/virtio_config.h |   17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index ca3ed78..bd1a582 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -205,35 +205,40 @@ int virtqueue_set_affinity(struct virtqueue *vq, int cpu)
> >  	return 0;
> >  }
> >  
> > +static inline bool virtio_is_little_endian(struct virtio_device *vdev)
> > +{
> > +	return virtio_has_feature(vdev, VIRTIO_F_VERSION_1);
> > +}
> 
> So this function returns false when _not_ using version 1, but running
> on a little endian host + guest? Sounds confusing. Maybe you could name
> it "virtio_is_v1()" or so instead?

Ah, never mind, I should have looked at patch 6 first, then it makes
sense. (maybe you could put a note to the later patch in this patch
description?)

 Thomas
