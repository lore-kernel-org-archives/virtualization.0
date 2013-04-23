From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCHv2 virtio-next] remoteproc: Add support for host virtio
	rings (vringh)
Date: Tue, 23 Apr 2013 17:16:48 +0300
Message-ID: <CAK=WgbZoiVN4V_-fQdpfu+Fnuf4bYq42Nim0zD3oOjzQEPWCCw@mail.gmail.com>
References: <1365543588-5152-1-git-send-email-sjur.brandeland@stericsson.com>
	<CAK=WgbZoqD5aoLt6nqGW3Y42=e_qK2kH0hf0FTLJr=WGW81Azg@mail.gmail.com>
	<CANHm3Phh8fwJ981rbE94pHWPpu1cmGS+tKjUc2fgP7d1p6XPzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CANHm3Phh8fwJ981rbE94pHWPpu1cmGS+tKjUc2fgP7d1p6XPzQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjur@brendeland.net>
Cc: Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Linus Walleij <linus.walleij@linaro.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Sjur,

On Tue, Apr 23, 2013 at 11:32 AM, Sjur Br=E6ndeland <sjur@brendeland.net> w=
rote:
> Quite frankly I would *really* like to see vringh support in remoteproc
> included in 3.10, and I am afraid your suggestion will cause us to miss
> the merge window once again.
>
> How about including my simple, but verbose patch in virtio-next for 3.10.
> Then you could post patches that refactors remoteproc and vringh
> making the code more elegant and less verbose on top of my patch.
>
> Doing this iteratively would also make it easy to verify your changes,
> and show how your patches reduces overall code size and provides
> a more elegant solution.

I realize this is frustrating for you, and I'm sorry about that. You
did a great job and I'm sure the patch works great for you.

I don't feel the patch is ready for mainline merger at this point though.

There's a good chance that eventually not much will be left from this
patch as it is mostly a duplication of existing code with very little
changes, and I'm afraid that if we do merge it now it's going to be
much harder to change things after the fact and this will become a
maintainability burden for us.

If STE requires this functionality ASAP then this patch can surely be
applied out-of-tree - I doubt there's any product out there that is
built purely out of vanilla upstream kernel anyway. Please feel free
to blame me if there's any internal pressure on you because of this
delay.

I would also appreciate any help from you (or Dmitry) to try and
implement the changes I've outlined, as I'm not sure how much free
time I'm going to have which I can dedicate for this work. I'm happy
to offer any help to further elaborate or prototype this if needed.
Hopefully we can work together towards a satisfactory result.

Thanks!
Ohad.
