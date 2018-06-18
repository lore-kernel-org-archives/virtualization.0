From: Dave Airlie <airlied@gmail.com>
Subject: Re: v4.14.21+: ATOMIC_SLEEP splat bisected to 9428088c90b6 ("drm/qxl:
	reapply cursor after resetting primary")
Date: Mon, 18 Jun 2018 12:33:52 +1000
Message-ID: <CAPM=9tzkKWM2wjeQvWG2qKM-xgFwGD3bjWfgmDUDTQO+tXF-ig__30549.2620835595$1529289114$gmane$org@mail.gmail.com>
References: <1529163551.16103.16.camel@gmx.de>
	<20180617093607.GA27652@kroah.com>
	<1529231886.5303.6.camel@gmx.de> <20180617110200.GA19216@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180617110200.GA19216@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ray Strode <rstrode@redhat.com>, Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 17 June 2018 at 21:02, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sun, Jun 17, 2018 at 12:38:06PM +0200, Mike Galbraith wrote:
>> On Sun, 2018-06-17 at 11:36 +0200, Greg KH wrote:
>> >
>> > And if you revert that patch, does everything work again?
>>
>> Yes.
>
> Great, Dave, care to revert this in 4.18 so I can queue up that revert
> in older kernels as well?
>
> thanks,
>
> greg k-h

Hi MIke,

Does
https://patchwork.freedesktop.org/patch/229980/

fix it?

I can queue up a revert asap, but since a revert just brings us back
another broken behaviour, I'd rather we just hurry the fix up.

Dave.
