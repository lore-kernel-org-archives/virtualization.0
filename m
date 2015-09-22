From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 5/6] virtio-gpu: add basic prime support
Date: Tue, 22 Sep 2015 18:15:44 +0200
Message-ID: <20150922161544.GY3383@phenom.ffwll.local>
References: <1442828417-6165-1-git-send-email-kraxel@redhat.com>
	<1442828417-6165-6-git-send-email-kraxel@redhat.com>
	<20150922094027.GF3383@phenom.ffwll.local>
	<1442935469.13084.36.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1442935469.13084.36.camel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 22, 2015 at 05:24:29PM +0200, Gerd Hoffmann wrote:
> > > +int virtgpu_gem_prime_mmap(struct drm_gem_object *obj,
> > > +		       struct vm_area_struct *area)
> > > +{
> > > +	WARN_ONCE(1, "not implemented");
> > > +	return ENOSYS;
> > 
> > This can get called by userspace, so please don't WARN here. Also missing
> > negate sign:
> > 
> > 	return -ENOSYS;
> 
> Hmm now checkpatch throws a warning at me:
> 
> <quote>
>    WARNING: ENOSYS means 'invalid syscall nr' and nothing else
>    #12: FILE: drivers/gpu/drm/virtio/virtgpu_prime.c:70:
>    +       return -ENOSYS;
> </quote>
> 
> I guess I should use something else then (here and elsewhere in the
> file)?  Maybe -EINVAL?  Other suggestions?

-ENODEV is what we occasionally pick. drm is fairly creative at errno
abuse, e.g. we already use -ENOENT to signal any kind of lookup failure in
ioctls (even if the fd itself is obviously there so not possible that the
fd isn't there).

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
