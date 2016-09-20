From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v9 17/19] drm/virtio: kconfig: Fix recursive dependency
	issue.
Date: Tue, 20 Sep 2016 12:33:45 +0300
Message-ID: <8760pqncee.fsf__48701.3991493315$1474829906$gmane$org@intel.com>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
	<1473081421-16555-18-git-send-email-peter.griffin@linaro.org>
	<CACvgo52_g7anGBd9HTUyYsbp5QmQEk9LR3nNHgSTgjQ29G3ViA@mail.gmail.com>
	<20160920083251.GB26093@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160920083251.GB26093@griffinp-ThinkPad-X1-Carbon-2nd>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Griffin <peter.griffin@linaro.org>, Emil Velikov <emil.l.velikov@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: devicetree <devicetree@vger.kernel.org>, kernel@stlinux.com, vinod.koul@intel.com, linux-remoteproc@vger.kernel.org, patrice.chotard@st.com, ML dri-devel <dri-devel@lists.freedesktop.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, dan.j.williams@intel.com, bjorn.andersson@linaro.org, lee.jones@linaro.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 20 Sep 2016, Peter Griffin <peter.griffin@linaro.org> wrote:
> Hi Emil,
>
> On Tue, 20 Sep 2016, Emil Velikov wrote:
>
>> On 5 September 2016 at 14:16, Peter Griffin <peter.griffin@linaro.org> wrote:
>> > ST_SLIM_REMOTEPROC must select REMOTEPROC, which exposes the following
>> > recursive dependency.
>
>
>> >
>> From a humble skim through remoteproc, drm and a few other subsystems
>> I think the above is wrong. All the drivers (outside of remoteproc),
>> that I've seen, depend on the core component, they don't select it.
>
> I will let Bjorn comment on the remoteproc subsystem Kconfig design, and
> why it is like it is.
>
> For this particular SLIM_RPROC I have added it to Kconfig in keeping with all
> the other drivers in the remoteproc subsystem which has exposed this recursive
> dependency issue.
>
> For this particular kconfig symbol a quick grep reveals more drivers in
> the kernel using 'select', than 'depend on'
>
> git grep "select VIRTIO" | wc -l
> 14
>
> git grep "depends on VIRTIO" | wc -l
> 10
>
>
>> Furthermore most places explicitly hide the drivers from the menu if
>> the core component isn't enabled.
>
> Remoteproc subsystem takes a different approach, the core code is only enabled
> if a driver which relies on it is enabled. This IMHO makes sense, as
> remoteproc is not widely used (only a few particular ARM SoC's).
>
> It is true that for subsystems which rely on the core component being
> explicitly enabled, they often tend to hide drivers which depend on it
> from the menu unless it is. This also makes sense.
>
>> 
>> Is there something that requires such a different/unusual behaviour in
>> remoteproc ?
>> 
>
> I'm not sure it is that unusual...looking at config USB, it selects USB_COMMON in
> mfd subsystem, client drivers select MFD_CORE.
>
> I've added Arnd to this thread, as I've seen lots of Kconfig patches from him
> recently, maybe he has some thoughts on whether this is the correct fix or not?


Documentation/kbuild/kconfig-language.txt:

  Note:
	select should be used with care. select will force
	a symbol to a value without visiting the dependencies.
	By abusing select you are able to select a symbol FOO even
	if FOO depends on BAR that is not set.
	In general use select only for non-visible symbols
	(no prompts anywhere) and for symbols with no dependencies.
	That will limit the usefulness but on the other hand avoid
	the illegal configurations all over.

People tend to abuse select because it's "convenient". If you depend,
but some of your dependencies aren't met, you're in for some digging
through Kconfig to find the missing deps. Just to make the option you
want visible in menuconfig. If you instead select something with
dependencies, it'll be right most of the time, and it's "convenient",
until it breaks. (And hey, it usually breaks for someone else with some
other config, so it's still convenient for you.)

Perhaps kconfig should complain about selecting visible symbols and
symbols with dependencies.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Technology Center
