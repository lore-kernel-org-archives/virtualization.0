From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCHv2] virtio: Introduce vringh wrappers in virtio_config
Date: Mon, 18 Mar 2013 01:29:40 +0200
Message-ID: <CAK=WgbbBJdFkJX8QoQwvaoFTLX5hn-sApg+WfLD+jx8yh1tBuQ@mail.gmail.com>
References: <1362737315-2894-1-git-send-email-sjur.brandeland@stericsson.com>
	<CAJK669avxo=jx1pL_cvLPOdS+19Y1hGS-VvOXEiT_diXOtzOqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJK669avxo=jx1pL_cvLPOdS+19Y1hGS-VvOXEiT_diXOtzOqg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjurbren@gmail.com>
Cc: =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjur@brendeland.net>, Linus Walleij <linus.walleij@linaro.org>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization <virtualization@lists.linux-foundation.org>, =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Sjur,

Sorry for the delay - just got back from you know where :)

On Wed, Mar 13, 2013 at 12:12 PM, Sjur Br=E6ndeland <sjurbren@gmail.com> wr=
ote:
>> From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
>>
>> Add wrappers for the host vrings to support loose
>> coupling between the virtio device and driver.
>>
>> A new struct vringh_config_ops with the functions
>> find_vrhs() and del_vrhs() is added to the virtio_device
>> struct. This enables virtio drivers to manage virtio
>> host rings without detailed knowledge of how the
>> vrings are created and deleted.
>>
>> The function vringh_notify() is added so vringh clients
>> can notify the other side that buffers are added to the
>> used-ring.
>>
>> Cc: Ohad Ben-Cohen <ohad@wizery.com>
>> Cc: Rusty Russell <rusty@rustcorp.com.au>
>> Signed-off-by: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
>
> As you have been pushing for this wrapper, could you please
> add your Ack or Reviewed tag if you are happy with this patch?

I am happy with this patch: the caif virtio driver is now decoupled
from remoteproc which I think is great. Thanks for doing it!

To provide a Reviewed-by tag though I need to review it from a virtio
point of view, which I can try to do after I'll finish going through
my backlog of pending patches. Let me finish that pile of patches I
have, and if you or Rusty will still want me to provide a Reviewed-by
tag here I'll do it.

Thanks,
Ohad.
