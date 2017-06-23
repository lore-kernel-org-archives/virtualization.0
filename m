From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 13/14] drm: stm: remove dead code and pointless local
	lut storage
Date: Fri, 23 Jun 2017 07:29:06 +0200
Message-ID: <c5dc7fca-a359-b6d4-fd14-2488f6b1a64e__36332.5741528117$1509078570$gmane$org@axentia.se>
References: <1498111597-10714-1-git-send-email-peda@axentia.se>
	<1498111597-10714-14-git-send-email-peda@axentia.se>
	<159dad37-7f12-0b4d-5512-d19a80670d5c@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <159dad37-7f12-0b4d-5512-d19a80670d5c@st.com>
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
To: Philippe CORNU <philippe.cornu@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Russell King <linux@armlinux.org.uk>, Jani Nikula <jani.nikula@linux.intel.com>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Yannick FERTRE <yannick.fertre@st.com>, Sean Paul <seanpaul@chromium.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Vincent ABRIOU <vincent.abriou@st.com>, =?UTF-8?Q?Christian_K=c3
List-Id: virtualization@lists.linuxfoundation.org

On 2017-06-22 13:49, Philippe CORNU wrote:
> On 06/22/2017 08:06 AM, Peter Rosin wrote:
>> The redundant fb helper .load_lut is no longer used, and can not
>> work right without also providing the fb helpers .gamma_set and
>> .gamma_get thus rendering the code in this driver suspect.
>>
> 
> Hi Peter,
> STM32 chipsets supports 8-bit CLUT mode but this driver version does not 
> support it "yet" (final patch has not been upstreamed because it was a 
> too big fbdev patch for simply adding CLUT...).
> 
> Regarding your patch below, if it helps you to ease the drm framework 
> update then I am agree to "acknowledge it" asap, else if you are not in 
> a hurry, I would prefer a better and definitive patch handling 8-bit 
> CLUT properly and I am ok to help or/and to do it : )

Hi!

The thing is, without my series you will have to provide four callbacks.
The crtc .gamma_set and the three redundant fb helpers .gamma_get,
.gamma_set and .load_lut that pretty much does exactly what the crtc
.gamma_set is doing. Well not .gamma_get, but...

With my series, you only have to provide the crtc .gamma_set, which you
have to provide anyway. and ...the core will handle everything that
.gamma_get was used for...

I.e., your work to provide CLUT support should start with drm support,
which means the crtc .gamma_set, and then move on to the fbdev
emulation. And I have just eliminated the second step for you, and
as suger on top, you no longer have to convince the core drm maintainers
that adding a lot of fbdev emulation code is needed.

So, I think you actually want to wait for my series to land before adding
CLUT support.

> Extra questions:
> - any plan to update modetest with the DRM_FORMAT_C8 support + gamma 
> get/set?

I don't know that code base at all, but from the glimpse I got when browsing
it, it seemed like it was pretty hardwired to non-palettized modes. I ended
up having no need for it, see below...

> - do you have a simple way to test clut with fbdev, last year we where 
> using an old version of the SDL but I am still looking for a small piece 
> of code to do it (else I will do it myself but C8 on fbdev is not really 
> a priority ;-)

I'm doing pretty much the same thing, I have an application that requires
an old SDL, and I'm using the programs/demos/demo.c program from the very
old libggi as a second test app. But that's just because libggi is what
I'm most familiar with, and it doesn't try to be "nice" and do things
automatically, instead you have to manually insert helpers providing
e.g. palette emulation if the application assumes a palettized mode and
only truecolor modes are available from the HW. SDL tends to add those
things for you, making it less easy to test thing, but I'm not an
"SDL-guy", so there may very well exist some knobs I don't know about.

Oh, you probably didn't see this:
http://marc.info/?l=linux-kernel&m=149786920731175&w=4

It sports modeset-pal.c that sets the C8 mode, and does a 5 second
palette animation, w/o using fbdev. I used it instead of digging
further into modetest.

Cheers,
peda
