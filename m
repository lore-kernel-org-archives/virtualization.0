From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 7/7] [wip] virtio-gpu: add page flip support
Date: Tue, 31 May 2016 08:18:20 +0200
Message-ID: <1464675500.5978.15.camel__6944.19205324284$1464675516$gmane$org@redhat.com>
References: <1443787104-24243-1-git-send-email-kraxel@redhat.com>
	<1443787104-24243-8-git-send-email-kraxel@redhat.com>
	<CAKMK7uFAjZ9DQSXwfJQWocjc1SXYORTCYdJ6i4d1i3p95Yai2w@mail.gmail.com>
	<1464335163.10663.7.camel@redhat.com>
	<20160527075027.GW27098@phenom.ffwll.local>
	<20160530084233.GA27098@phenom.ffwll.local>
	<1464610010.5179.34.camel@redhat.com>
	<20160530144325.GJ27098@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160530144325.GJ27098@phenom.ffwll.local>
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

> > https://lists.freedesktop.org/archives/dri-devel/2016-May/108772.html
> 
> Hm, smells more like virtio isn't too happy with the default ordering of
> the commit operation. The default is:
> 
> - Disable any crtc/encoders that need to be disabled/change.
> - Bash new plane setup into hw.
> - Enable all crtcs/encoders that need to be enabled/have changed.
> 
> There's two problems:
> - some hw gets real grumpy if you bash in plane state without the crtc
>   state yet matching.
> - if you do runtime pm nothing is enabled and the writes get lost at best,
>   or hang your interconnect at worst.
> 
> That's why you can overwrite atomic_commit_tail, and use something more
> sensible. See for example what it looks like for rockchip. I have a gut
> feeling that should also take care of your troubles. Using the old crtc is
> definitely not what you want.

> Another option is that virtio isn't happy about bashing in plane state for
> disabled crtc. Again helpers have you covered, look at the active_only
> parameter for drm_atomic_helper_commit_planes().

virtio-gpu is a bit simplified compared to real hardware, so there isn't
really separate plane/crtc state.

Right now the virtual outputs are linked to drm_crtc.  To apply any
changes I need to lookup the crtc to figure which virtual output should
be updated.

So, setting active_only should make sure I have a valid crtc pointer on
plane updates, right?  It probably also skips the disable + enable crtc
steps on commit?  What happens when outputs are disabled?

Maybe it makes sense to link our virtual outputs to (primary) planes not
crtcs?

cheers,
  Gerd
