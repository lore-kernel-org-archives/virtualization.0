From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 7/7] [wip] virtio-gpu: add page flip support
Date: Tue, 31 May 2016 09:34:45 +0200
Message-ID: <1464680085.5978.40.camel__8934.06172185696$1464680099$gmane$org@redhat.com>
References: <1443787104-24243-1-git-send-email-kraxel@redhat.com>
	<1443787104-24243-8-git-send-email-kraxel@redhat.com>
	<CAKMK7uFAjZ9DQSXwfJQWocjc1SXYORTCYdJ6i4d1i3p95Yai2w@mail.gmail.com>
	<1464335163.10663.7.camel@redhat.com>
	<20160527075027.GW27098@phenom.ffwll.local>
	<20160530084233.GA27098@phenom.ffwll.local>
	<1464610010.5179.34.camel@redhat.com>
	<20160530144325.GJ27098@phenom.ffwll.local>
	<1464675500.5978.15.camel@redhat.com>
	<CAKMK7uFkB9SX8pNdANSK87M7wr1WzPYkP2t2CHoJZeeM62eCpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAKMK7uFkB9SX8pNdANSK87M7wr1WzPYkP2t2CHoJZeeM62eCpA@mail.gmail.com>
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

> > Right now the virtual outputs are linked to drm_crtc.  To apply any
> > changes I need to lookup the crtc to figure which virtual output should
> > be updated.

> > So, setting active_only should make sure I have a valid crtc pointer on
> > plane updates, right?  It probably also skips the disable + enable crtc
> > steps on commit?  What happens when outputs are disabled?

> Nah, I just misunderstood your patch. If it's all about finding the
> corresponding crtc, then you're all good.

Yes, it's all about finding the crtc.

> I thought there was some
> other reason (like the virtual hw getting upset about certain things).

virtio wouldn't be upset.

It's a pointless exercise though to first disable the output, just to
re-enable it the next moment with the new page-flipped framebuffer.  So
I guess I should look at the active_only thing nevertheless.

> btw can you pls drop an ack or r-b
> onto my virtio conversion? I already added your tested-by.

Grr, mail is not in my dri-devel folder.  Guess that is the <censored>
"avoid-duplicates" mailman option at work.

Feel free to just add the r-b too.  Or I'll send it for the next version
of the series.

cheers,
  Gerd
