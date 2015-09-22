From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 5/6] virtio-gpu: add basic prime support
Date: Tue, 22 Sep 2015 17:24:29 +0200
Message-ID: <1442935469.13084.36.camel__22438.0741049119$1442935491$gmane$org@redhat.com>
References: <1442828417-6165-1-git-send-email-kraxel@redhat.com>
	<1442828417-6165-6-git-send-email-kraxel@redhat.com>
	<20150922094027.GF3383@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150922094027.GF3383@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> > +int virtgpu_gem_prime_mmap(struct drm_gem_object *obj,
> > +		       struct vm_area_struct *area)
> > +{
> > +	WARN_ONCE(1, "not implemented");
> > +	return ENOSYS;
> 
> This can get called by userspace, so please don't WARN here. Also missing
> negate sign:
> 
> 	return -ENOSYS;

Hmm now checkpatch throws a warning at me:

<quote>
   WARNING: ENOSYS means 'invalid syscall nr' and nothing else
   #12: FILE: drivers/gpu/drm/virtio/virtgpu_prime.c:70:
   +       return -ENOSYS;
</quote>

I guess I should use something else then (here and elsewhere in the
file)?  Maybe -EINVAL?  Other suggestions?

thanks,
  Gerd
