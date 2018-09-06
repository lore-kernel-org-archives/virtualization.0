From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] bochs: convert to drm_fb_helper_fbdev_setup/teardown
Date: Thu, 6 Sep 2018 09:23:54 +0200
Message-ID: <20180906072354.2vsv67k2a2m43vx5__25183.0432251611$1536218519$gmane$org@sirius.home.kraxel.org>
References: <20180905144127.5690-1-peter@lekensteyn.nl>
	<20180905144628.GG4929@phenom.ffwll.local>
	<20180905150630.GA25979@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180905150630.GA25979@al>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Wu <peter@lekensteyn.nl>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > You can probably get rid of this one if you're refactoring even more. The
> > generic fb_probe implementation (already merged) plus gem-shmem support
> > for it (still in flight) from Noralf should be able to pull that off. That
> > gives you the fb_mmap implementation, but with 100% generic code instead
> > of a driver specific hack like Max did.
> 
> Aside from the warning, I have not observed actual issues. This patch
> was prepared on top of v4.18.1 but the new drm_fb_helper_generic_probe
> helper is in master (future 4.19). I suppose that it can be done as a
> future cleanup. Nice work Noralf on reducing duplication!

FYI: qemu kms driver patches go through drm-misc-next, so you can also
work against that branch.

> > I'll leave merging to Gerd.
> 
> Thanks, I somehow missed a patch. This one does not compile due to
> "fb.initialized" still being used in bochs_drv.c. Removal is trivial,
> I'll wait for some more feedback and then send a v2 with another patch
> prepended.

Patch looks good to me (except for the build failure which you've
noticed already).

cheers,
  Gerd
