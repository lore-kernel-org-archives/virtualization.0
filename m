From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v9 17/19] drm/virtio: kconfig: Fix recursive dependency
	issue.
Date: Thu, 6 Oct 2016 12:31:25 +0100
Message-ID: <CACvgo52zh5ZH8YhOJ=eE=RA7m=4vUoVFCdW+YSyN8WSHVi=Maw__28143.9346181743$1475753525$gmane$org@mail.gmail.com>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
	<1473081421-16555-18-git-send-email-peter.griffin@linaro.org>
	<CACvgo52_g7anGBd9HTUyYsbp5QmQEk9LR3nNHgSTgjQ29G3ViA@mail.gmail.com>
	<20160920083251.GB26093@griffinp-ThinkPad-X1-Carbon-2nd>
	<CACvgo53fuoPVjBAkZbWFPVxosObjvxoDgFdR_BkSTgevqyGg9g@mail.gmail.com>
	<20161006104807.GB436@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161006104807.GB436@griffinp-ThinkPad-X1-Carbon-2nd>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: devicetree <devicetree@vger.kernel.org>, kernel@stlinux.com, Arnd Bergmann <arnd@arndb.de>, vinod.koul@intel.com, Lee Jones <lee.jones@linaro.org>, linux-remoteproc@vger.kernel.org, patrice.chotard@st.com, ML dri-devel <dri-devel@lists.freedesktop.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>, dmaengine@vger.kernel.org, dan.j.williams@intel.com, Bjorn Andersson <bjorn.andersson@linaro.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Peter,

On 6 October 2016 at 11:48, Peter Griffin <peter.griffin@linaro.org> wrote:
> Hi Emil,
>
> On Wed, 21 Sep 2016, Emil Velikov wrote:
>
>> On 20 September 2016 at 09:32, Peter Griffin <peter.griffin@linaro.org> wrote:
>> > Hi Emil,
>> >
>> > On Tue, 20 Sep 2016, Emil Velikov wrote:
>> >
>> >> On 5 September 2016 at 14:16, Peter Griffin <peter.griffin@linaro.org> wrote:
>> >> > ST_SLIM_REMOTEPROC must select REMOTEPROC, which exposes the following
>> >> > recursive dependency.
>> >
>> >
>> >> >
>> >> From a humble skim through remoteproc, drm and a few other subsystems
>> >> I think the above is wrong. All the drivers (outside of remoteproc),
>> >> that I've seen, depend on the core component, they don't select it.
>> >
>> > I will let Bjorn comment on the remoteproc subsystem Kconfig design, and
>> > why it is like it is.
>> >
>> > For this particular SLIM_RPROC I have added it to Kconfig in keeping with all
>> > the other drivers in the remoteproc subsystem which has exposed this recursive
>> > dependency issue.
>> >
>> > For this particular kconfig symbol a quick grep reveals more drivers in
>> > the kernel using 'select', than 'depend on'
>> >
>> > git grep "select VIRTIO" | wc -l
>> > 14
>> >
>> > git grep "depends on VIRTIO" | wc -l
>> > 10
>> >
>> Might be worth taking a closer look into these at some point.
>
> VIRTIO has no dependencies, and is a non visible symbol. Its Kconfig help also
> mentions that drivers should select it.
>
This is a (un)fortunate detail cannot/should not overrule the other
arguments I've mentioned, should it ?

>>
>> >
>> >> Furthermore most places explicitly hide the drivers from the menu if
>> >> the core component isn't enabled.
>> >
>> > Remoteproc subsystem takes a different approach, the core code is only enabled
>> > if a driver which relies on it is enabled. This IMHO makes sense, as
>> > remoteproc is not widely used (only a few particular ARM SoC's).
>> >
>> > It is true that for subsystems which rely on the core component being
>> > explicitly enabled, they often tend to hide drivers which depend on it
>> > from the menu unless it is. This also makes sense.
>> >
>> >>
>> >> Is there something that requires such a different/unusual behaviour in
>> >> remoteproc ?
>> >>
>> >
>> > I'm not sure it is that unusual...looking at config USB, it selects USB_COMMON in
>> > mfd subsystem, client drivers select MFD_CORE.
>> >
>> On the USB case I'm not sure what the reasoning behind the USB vs
>> USB_COMMON split. In seems that one could just fold them, but that's
>> another topic. On the MFD side... it follows the select {,mis,ab}use.
>> With one (the only one?) MFD driver not using/selecting MFD_CORE doing
>> it's own version of mfd_add_devices... which could be reworked,
>> possibly.
>
> Much like selecting VIRTIO in this patch, MFD_CORE is a non visible symbol
> with no dependencies so it matches the documentation Jani referenced.
>
> I personally think the approach taken makes sense, as why would you want to have
> a CONFIG_MFD_CORE=y symbol being enabled unless you actually have a MFD device
> which uses it also enabled in your kernel?
>
> It seems to me a good solution to make the client drivers select the core
> component so that it only gets enabled if at least one driver requires it.
> This avoids having useless core code which will never be used compiled into the
> kernel and in the end a smaller kernel size for a given kernel configuration (better
> cache use etc etc).
>
>> > I've added Arnd to this thread, as I've seen lots of Kconfig patches from him
>> > recently, maybe he has some thoughts on whether this is the correct fix or not?
>> >
>> Ack. Fwiw, I believe that the reasoning put by Jani is perfeclty
>> reasonable, but it'll be great to hear others as well.
>
> Yes me to. However I don't think anything in this patch is at odds with the
> documentation Jani has referenced.
>
It case it's not clear, let me elaborate:

Yes, using depend might not be the most user-friendly thing to do and
in the long term we might want to move to select.
Yes, I agree with the argument about symbol visibility but that is not
the only contributing factor.

If one wants to pick on specific users which opt for $driver select
$core they must do the same for $driver depends on $core. Check the
number 'in favour" of each case and draw their conclusions ;-)

In particular: both MFD_CORE and USB_COMMON, are _optional_ as only
some drivers depends on them. Thus giving them as an example is
wrong/irrelevant, I'm afraid.

Thanks
Emil
