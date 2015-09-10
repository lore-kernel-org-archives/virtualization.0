From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 5/5] virtgpu: mark as a render gpu
Date: Thu, 10 Sep 2015 16:52:45 +0200
Message-ID: <1441896765.11233.25.camel__37633.1260231838$1441897442$gmane$org@redhat.com>
References: <1441798946-26233-1-git-send-email-kraxel@redhat.com>
	<1441798946-26233-6-git-send-email-kraxel@redhat.com>
	<CACvgo53wYvAk_bVouPZ-F7wNm=Diyouue8m1AvO0=U+PvL61_Q@mail.gmail.com>
	<1441895002.11233.6.camel@redhat.com>
	<CACvgo50SU46SYXBbVe+VGcAb6uFSj-iBY0E4=Vuuzf5RKbE+2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CACvgo50SU46SYXBbVe+VGcAb6uFSj-iBY0E4=Vuuzf5RKbE+2Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open
	list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > Dave?  Looking at the ioctls they are all fine for render nodes, there
> > isn't anything modesetting related in the device-specific ioctls.
> >
> > Correct?
> >
> Unless I've overdone the coffee this time - modesetting is done via
> the card# node, while render via either card# or renderD#.

Exactly, thats why anything modesetting-related must be disabled for
renderD#.  Looking at the virtio-gpu device-specific ioctls I don't
think there is anything doing modesetting (which we would have to leave
out), so we can apply DRM_RENDER_ALLOW everythere I think.  Or maybe
there is a global switch to flip DRM_RENDER_ALLOW for the whole list ...

cheers,
  Gerd
