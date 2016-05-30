From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 7/7] [wip] virtio-gpu: add page flip support
Date: Mon, 30 May 2016 14:06:50 +0200
Message-ID: <1464610010.5179.34.camel@redhat.com>
References: <1443787104-24243-1-git-send-email-kraxel@redhat.com>
	<1443787104-24243-8-git-send-email-kraxel@redhat.com>
	<CAKMK7uFAjZ9DQSXwfJQWocjc1SXYORTCYdJ6i4d1i3p95Yai2w@mail.gmail.com>
	<1464335163.10663.7.camel@redhat.com>
	<20160527075027.GW27098@phenom.ffwll.local>
	<20160530084233.GA27098@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160530084233.GA27098@phenom.ffwll.local>
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
Cc: open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > But I'll take you up on the implied offer to help out and test ;-)
> 
> git://people.freedesktop.org/~danvet/drm stuff

Tried that branch.

> Would be really awesome if you could test this on virtio. Note that the
> new nonblocking helpers require that your atomic backend gets the drm
> event handling right. So if there's a bug in that logic then you'll see
> lots of dmesg noise about waits timing out (after 10s of waiting). From a
> quick inspection it should work though.

No timeouts.  Yay!

But it seems crtcs can be (temporarely) disabled now, so we might have
to pick up the crtc from old_state in virtio_gpu_plane_atomic_update to
figure which virtual output needs to be turned off.  Ran into this last
week already.  Happened with multihead setups only, but the same patch
fixes this one too ;)

https://lists.freedesktop.org/archives/dri-devel/2016-May/108772.html

cheers,
  Gerd
