From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: Use vmalloc for command buffer allocations.
Date: Mon, 2 Sep 2019 07:19:21 +0200
Message-ID: <20190902051921.nczclnaqcmxlh7bz__7868.611141906$1567401575$gmane$org@sirius.home.kraxel.org>
References: <20190829212417.257397-1-davidriley@chromium.org>
	<20190830060857.tzrzgoi2hrmchdi5@sirius.home.kraxel.org>
	<CAASgrz2v0DYb_5A3MnaWFM4Csx1DKkZe546v7DG7R+UyLOA8og@mail.gmail.com>
	<20190830111605.twzssycagmjhfa45@sirius.home.kraxel.org>
	<CAPaKu7QeYDqek7pBSHmg1E5A9h9E=njrvLxBMnkCtqeb3s77Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPaKu7QeYDqek7pBSHmg1E5A9h9E=njrvLxBMnkCtqeb3s77Cg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chia-I Wu <olvaffe@gmail.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, Gurchetan Singh <gurchetansingh@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, "open list:VIRTIO CORE,
	NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> > Completely different approach: use get_user_pages() and don't copy the
> > execbuffer at all.
> It would be really nice if execbuffer does not copy.
> 
> The user space owns the buffer and may overwrite the contents
> immediately after the ioctl.

Oh, right.  The exec ioctl doesn't block.  So this doesn't work (breaks
userspace abi).  Scratch the idea then.

> We also need a flag to indicate that the
> ownership of the buffer is transferred to the kernel.

Yes, with an additional flag for the changed behavior it could work.

cheers,
  Gerd
