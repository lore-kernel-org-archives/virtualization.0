From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 5/5] virtgpu: mark as a render gpu
Date: Fri, 11 Sep 2015 11:16:38 +0200
Message-ID: <1441962998.29362.17.camel__10945.2421813787$1441963016$gmane$org@redhat.com>
References: <1441798946-26233-1-git-send-email-kraxel@redhat.com>
	<1441798946-26233-6-git-send-email-kraxel@redhat.com>
	<CACvgo53wYvAk_bVouPZ-F7wNm=Diyouue8m1AvO0=U+PvL61_Q@mail.gmail.com>
	<1441895002.11233.6.camel@redhat.com>
	<CACvgo50SU46SYXBbVe+VGcAb6uFSj-iBY0E4=Vuuzf5RKbE+2Q@mail.gmail.com>
	<1441896765.11233.25.camel@redhat.com>
	<CACvgo51skbWdw8E8RftZZjA2wUV0_RHPCiPbSR42XPY9aCfg6w@mail.gmail.com>
	<CAPM=9tz_4NSXnmmT6EuXGWp5wUK0vZfUhk-zhnhQ6QTgtEuVfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPM=9tz_4NSXnmmT6EuXGWp5wUK0vZfUhk-zhnhQ6QTgtEuVfQ@mail.gmail.com>
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
Cc: Dave Airlie <airlied@redhat.com>, Emil Velikov <emil.l.velikov@gmail.com>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fr, 2015-09-11 at 16:32 +1000, Dave Airlie wrote:
> doh, yes we need to add DRM_RENDER_ALLOW to the ioctls, can you do
> that?

Done.

cheers,
  Gerd
