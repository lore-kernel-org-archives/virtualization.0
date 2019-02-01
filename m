From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 2/6] drm/virtio: use struct to pass params to
	virtio_gpu_object_create()
Date: Fri, 1 Feb 2019 09:10:59 +0100
Message-ID: <20190201081059.44w2x6vwap724coz__26935.9812651359$1549066596$gmane$org@sirius.home.kraxel.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
	<20190130094338.14203-3-kraxel@redhat.com>
	<46c0feb8-3a0d-eeac-180c-cb0f3147fe11@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <46c0feb8-3a0d-eeac-180c-cb0f3147fe11@tronnes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> > -	ret = virtio_gpu_gem_create(file_priv, dev, args->size, &gobj,
> > +	params.pinned = false,
> 
> You have a comma here, but assigning to false isn't really necessary
> since the struct is zeroed. Same goes for the same assignment further down.

Hmm, yes, but it likewise isn't used, so I think I can just scratch it
altogether.

It's also wrong, virtio-gpu objects don't move around, so they are all
pinned.  Not that this bug changes much in practice given virtio-gpu
supports a single kind of storage only, so there is no opportunity for
ttm to try move objects from one to another.  I'll fix it nevertheless
in v3.

cheers,
  Gerd
