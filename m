From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] virtio_console: Don't access uninitialized data.
Date: Wed, 06 Feb 2013 10:14:59 +0800
Message-ID: <5111BCA3.4040303__31340.1344269097$1360116983$gmane$org@cn.fujitsu.com>
References: <1358425292-4449-1-git-send-email-sjur.brandeland@stericsson.com>
	<20130125090801.GA30483@amit.redhat.com>
	<87vca9klwm.fsf@rustcorp.com.au>
	<20130204063251.GB32509@amit.redhat.com>
	<871ucul2wr.fsf@rustcorp.com.au> <20130206014015.GB816@kroah.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130206014015.GB816@kroah.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>, sjur.brandeland@stericsson.com
List-Id: virtualization@lists.linuxfoundation.org

On 02/06/2013 09:40 AM, Greg KH wrote:
> On Wed, Feb 06, 2013 at 10:38:36AM +1030, Rusty Russell wrote:
>> Amit Shah <amit.shah@redhat.com> writes:
>>> On (Mon) 04 Feb 2013 [10:09:05], Rusty Russell wrote:
>>>> Amit Shah <amit.shah@redhat.com> writes:
>>>>> On (Thu) 17 Jan 2013 [13:21:32], sjur.brandeland@stericsson.com wrote:
>>>>>> From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
>>>>>>
>>>>>> Don't access uninitialized work-queue when removing device.
>>>>>> The work queue is initialized only if the device multi-queue.
>>>>>> So don't call cancel_work unless this is a multi-queue device.
>>>>>>
>>>>>> This fixes the following panic:
>>>>>
>>>>> [snip]
>>>>>
>>>>>> Signed-off-by: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
>>>>>
>>>>> Acked-by: Amit Shah <amit.shah@redhat.com>
>>>>>
>>>>>> This fix is intended of v3.8.
>>>>>
>>>>> Should also be CC'ed to stable@
>> ...
>>>> I've already sent it to Linus.  Sjur said: "This fix is intended of
>>>> v3.8.".  If it needs to be in -stable, please tell me and I'll fwd it
>>>> manually.
>>>
>>> This can result in a panic when removing the device or module (when
>>> not using multiport).  I'd vote for submitting to stable.
>>>
>>> 		Amit
>>
>> OK stable, please cherry-pick from Linus' tree:
>>
>> commit b26ada9abe26290b1dcd06075935b977548c50db
>> Author: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
>> Date:   Tue Jan 22 09:50:26 2013 +1030
>>
>>     virtio_console: Don't access uninitialized data.
> =

>  $ git show b26ada9abe26290b1dcd06075935b977548c50db
>  fatal: bad object b26ada9abe26290b1dcd06075935b977548c50db
> =

> What am I missing here?

It seems just in rusty's tree but not in linus' tree.
http://git.kernel.org/?p=3Dlinux/kernel/git/rusty/linux.git;a=3Dcommitdiff;=
h=3Db26ada9abe26290b1dcd06075935b977548c50db

Thanks,
Wanlong Gao

> =

> greg k-h
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> =
