From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 7/7] [wip] virtio-gpu: add page flip support
Date: Fri, 27 May 2016 09:50:27 +0200
Message-ID: <20160527075027.GW27098__35760.5126373985$1464335441$gmane$org@phenom.ffwll.local>
References: <1443787104-24243-1-git-send-email-kraxel@redhat.com>
	<1443787104-24243-8-git-send-email-kraxel@redhat.com>
	<CAKMK7uFAjZ9DQSXwfJQWocjc1SXYORTCYdJ6i4d1i3p95Yai2w@mail.gmail.com>
	<1464335163.10663.7.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1464335163.10663.7.camel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 27, 2016 at 09:46:03AM +0200, Gerd Hoffmann wrote:
> On Mi, 2016-05-25 at 18:37 +0200, Daniel Vetter wrote:
> > On Fri, Oct 2, 2015 at 1:58 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > 
> > So I entirely missed this, but this isn't really how to implement
> > page_flip for an atomic driver. Working on some stuff and will hack up
> > a likely totally broken patch, but should be enough as guideline.
> > -Daniel
> 
> Hmm, no patch in my inbox yet.  Care to send it over or give some hints
> what is wrong with this?

You should use drm_atomic_helper_page_flip as .page_flip hook instead of
rolling your own, when you have a brand-new atomic driver. If that helper
doesn't work that means you have a bug in your driver somewhere.

And indeed virtio just plugs in drm_atomic_helper_commit, which thus far
doesnt' do nonblocking commits, which means the page flip stuff won't
work. I'm working on generic nonblocking atomic to fix this up. Currently
still wip and buggy though, hence no patches.

But I'll take you up on the implied offer to help out and test ;-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
