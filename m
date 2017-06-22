From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 01/11] drm/fb-helper: do a generic fb_setcmap helper in
	terms of crtc .gamma_set
Date: Thu, 22 Jun 2017 10:48:10 +0200
Message-ID: <854a89af-d146-8414-73e7-2460c8f33598__20549.1177541719$1509078518$gmane$org@axentia.se>
References: <1497986735-14418-1-git-send-email-peda@axentia.se>
	<1497986735-14418-2-git-send-email-peda@axentia.se>
	<20170621073804.akyg4rxvoavjjt2v@phenom.ffwll.local>
	<fc8ca240-61ad-b5b6-174c-490858401237@axentia.se>
	<20170622063645.k5ciwdeqfafgnxtv@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170622063645.k5ciwdeqfafgnxtv@phenom.ffwll.local>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Philippe Cornu <philippe.cornu@st.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Yannick Fertre <yannick.fertre@st.com>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, Vincent Abriou <vincent.abriou@st.com>, Ben Skeggs <bskeggs@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 2017-06-22 08:36, Daniel Vetter wrote:
> On Wed, Jun 21, 2017 at 11:40:52AM +0200, Peter Rosin wrote:
>> On 2017-06-21 09:38, Daniel Vetter wrote:
>>> On Tue, Jun 20, 2017 at 09:25:25PM +0200, Peter Rosin wrote:
>>>> This makes the redundant fb helpers .load_lut, .gamma_set and .gamma_get
>>>> totally obsolete.
>>>>
>>>> I think the gamma_store can end up invalid on error. But the way I read
>>>> it, that can happen in drm_mode_gamma_set_ioctl as well, so why should
>>>> this pesky legacy fbdev stuff be any better?
>>>>
>>>> drm_fb_helper_save_lut_atomic justs saves the gamma lut for later. However,
>>>> it saves it to the gamma_store which should already be up to date with what
>>>> .gamma_get would return and is thus a nop. So, zap it.
>>>
>>> Removing drm_fb_helper_save_lut_atomic should be a separate patch I
>>> think.
>>
>> Then 3 patches would be needed, first some hybrid thing that does it the
>> old way, but also stores the lut in .gamma_store, then the split-out that
>> removes drm_fb_helper_save_lut_atomic, then whatever is needed to get
>> to the desired code. I can certainly do that, but do you want me to?
> 
> Explain that in the commit message and it's fine.

I did the split in v2, I assume that's ok too. Better in case anyone ever
needs to run a bisect on this...

>>> It's a pre-existing bug, but should we also try to restore the fbdev lut
>>> in drm_fb_helper_restore_fbdev_mode_unlocked()? Would be yet another bug,
>>> but might be relevant for your use-case. Just try to run both an fbdev
>>> application and some kms-native thing, and then SIGKILL the native kms
>>> app.
>>>
>>> But since pre-existing not really required, and probably too much effort.
>>
>> Good thing too, because I don't really know my way around this code...
> 
> Btw I cc'ed you on one of my patches in the fbdev locking series, we might
> need to do the same legacy vs. atomic split for the new lut code as I did
> for dpms. The rule with atomic is that you can't do multiple commits under
> drm_modeset_lock_all, you either have to do one overall atomic commit
> (preferred) or drop&reacquire locks again. This matters for LUT since
> you're updating the LUT on all CRTCs, which when using the gamma_set
> atomic helper would be multiple commits :-/

Ahh, ok, I see the problem.

> Using the dpms patch as template it shouldn't be too hard to address that
> for your patch here too.

Hmm, in that patch you handle the legacy case in a separate function, and
doing that for the lut case looks difficult when the atomic commit happens
inside the helper (typically drm_atomic_helper_legacy_gamma_set which
could perhaps be handled, but a real drag to handle for drivers that have
a custom crtc .gamma_set).

So, I'm aiming for the drop&reacquire approach...

However, I don't have all of that series, and I suspect that is why I do
not have any fb_helper->lock.

I'll send my best guess as a follow-up to patch 3/14 in v2.

Cheers,
peda
