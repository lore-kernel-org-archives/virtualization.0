From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 00/14] improve the fb_setcmap helper
Date: Mon, 26 Jun 2017 21:13:19 +0200
Message-ID: <59515CCF.8060406__49579.1783360348$1509078637$gmane$org@axentia.se>
References: <1498111597-10714-1-git-send-email-peda@axentia.se>
	<20170626093526.7dezn6d74m5ktsok@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170626093526.7dezn6d74m5ktsok@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Russell King <linux@armlinux.org.uk>, Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@redhat.com>, intel-gfx@lists.freedesktop.org, Vincent Abriou <vincent.abriou@st.com>, Philippe Cornu <philippe.cornu@st.com>, Yannick Fertre <yannick.fertre@st.com>, Alex Deucher <alexander.deucher@amd.com>, =?windows-1252?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 2017-06-26 11:35, Daniel Vetter wrote:
> On Thu, Jun 22, 2017 at 08:06:23AM +0200, Peter Rosin wrote:
>> Hi!
>>
>> While trying to get CLUT support for the atmel_hlcdc driver, and
>> specifically for the emulated fbdev interface, I received some
>> push-back that my feeble in-driver attempts should be solved
>> by the core. This is my attempt to do it right.
>>
>> I have obviously not tested all of this with more than a compile,
>> but patches 1 and 3 are enough to make the atmel-hlcdc driver
>> do what I need (when patched to support CLUT modes). The rest is
>> just lots of removals and cleanup made possible by the improved
>> core.
>>
>> Please test, I would not be surprised if I have fouled up some
>> bit-manipulation somewhere in this mostly mechanical change...
>>
>> Changes since v1:
>>
>> - Rebased to next-20170621
>> - Split 1/11 into a preparatory patch, a cleanup patch and then
>>   the meat in 3/14.
>> - Handle pseudo-palette for FB_VISUAL_TRUECOLOR.
>> - Removed the empty .gamma_get/.gamma_set fb helpers from the
>>   armada driver that I had somehow managed to ignore but which
>>   0day found real quick.
>> - Be less judgemental on drivers only providing .gamma_get and
>>   .gamma_set, but no .load_lut. That's actually a valid thing
>>   to do if you only need pseudo-palette for FB_VISUAL_TRUECOLOR.
>> - Add a comment about colliding bitfields in the nouveau driver.
>> - Remove gamma_set/gamma_get declarations from the radeon driver
>>   (the definitions were removed in v1).
> 
> Ok some nits/questions on the first three, but in principle looks all ok I
> think. The driver patches also look good (but I didn't yet carefully
> review all the conversion). What we might want to do is entirely remove
> driver's reliance on ->gamma_store (mostly amounts to in-lining the
> load_lut functions) and only update ->gamma_store after gamma_set returned
> successfully. But that's a bit more work.
> 
> Save/restoring it instead might be simpler to fix that bug, but since it's
> pre-existing also ok as follow-up.

I'm traveling and cannot make progress this week. The merge window is
also real close so this series will therefore probably miss it unless
something unexpected happens...

I'll get back to this for the next cycle, just a heads up.

Cheers,
peda
