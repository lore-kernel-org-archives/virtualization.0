From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: fix mmap page attributes
Date: Wed, 11 Dec 2019 09:15:41 +0100
Message-ID: <20191211081541.ejofg4uxo6poss6v__2240.33407155133$1576052165$gmane$org@sirius.home.kraxel.org>
References: <20191210085759.14763-1-kraxel@redhat.com>
 <e8915378-df67-e6f4-f40c-599797e16e9c@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <e8915378-df67-e6f4-f40c-599797e16e9c@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@linux.ie>, gurchetansingh@chromium.org, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> There's similar code in udl, [1] which still uses writecombine for
> imported buffers. Virtio does not need this?

virtio doesn't support dma-buf imports (yet).
So no worries for now.

Why pick writecombine for the imported buffer btw?
It'll probably be correct for the majority of imports, but it still
looks like a educated guess to me.  What if you import from vgem?

I guess we should either ...
  (1) Ask the exporting driver to handle things, simliar to how it is
      done for vmaps already, probably by calling dma_buf_mmap(), or
  (2) Refuse to mmap imported objects via drm api.

> Aside from this, do you think we could handle all special cases within
> shmem?

Probably makes sense to teach shmem helpers about caching.

cheers,
  Gerd
