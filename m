From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2] drm/bochs: add edid support.
Date: Thu, 18 Oct 2018 07:11:02 +0200
Message-ID: <20181018051102.7hkrtj5siw6fss2y__46209.871923975$1539839341$gmane$org@sirius.home.kraxel.org>
References: <20181005120934.21959-1-kraxel@redhat.com>
	<CAPM=9twEjDr5dj+9B==QSYtAB7uqy0Szn2d7cw9swSk+THMA2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPM=9twEjDr5dj+9B==QSYtAB7uqy0Szn2d7cw9swSk+THMA2g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > Recent qemu (latest master branch, upcoming 3.1 release) got support
> > for EDID data.  This patch adds guest driver support.
> >
> > EDID support in qemu is not (yet) enabled by default, so please use
> > 'qemu -device VGA,edid=on' for testing.
> 
> The EDID never changes after boot?

Right now it doesn't.

> Is there plans to let it?

Needs more virtual hardware changes, the stdvga has no support for
interrupts, so qemu can't signal an edid update to the guest.

So not not sure yet what to do about it.  Maybe add it later (but it's
not high priority).  Maybe simply recommend to use virtio-gpu instead.

> > +       kfree(bochs->edid);
> > +       bochs->edid = kmalloc(len, GFP_KERNEL);
> 
> Don't you need to free it somewhere?

Oh, yes, we leak that on driver unload.
I'll fix it.

cheers,
  Gerd
