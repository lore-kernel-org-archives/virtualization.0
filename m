From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH repost] virtio: don't crash when device is buggy
Date: Wed, 19 Sep 2012 13:40:43 +0930
Message-ID: <87d31ips8s.fsf__22429.4555759572$1348033520$gmane$org@rustcorp.com.au>
References: <20120903143018.GA5353@redhat.com>
	<CAJK669bkHHMAPYMEr22-6uOwfgJv1uKTbzNBQVVCq=OooExC0g@mail.gmail.com>
	<20120903202737.GD6181@redhat.com>
	<CAJK669ZvnnG6fGOog-Z47B7xqyn9hcx5dAD7S--+2PSgE+hrLA@mail.gmail.com>
	<20120904135022.GI9805@redhat.com>
	<CAJK669Z1UYakBWartChfoeKL_eU5=GFZMGhH8R_Q-difVm0ygQ@mail.gmail.com>
	<20120904185541.GB3602@redhat.com> <87k3w7j49i.fsf@rustcorp.com.au>
	<20120916094427.GA24075@redhat.com>
	<87ehm1s28q.fsf@rustcorp.com.au>
	<20120918222405.GB20285@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120918222405.GB20285@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjurbren@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Sep 17, 2012 at 01:57:17PM +0930, Rusty Russell wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > Because of a sanity check in virtio_dev_remove, a buggy device can crash
>> > kernel.  And in case of rproc it's userspace so it's not a good idea.
>> > We are unloading a driver so how bad can it be?
>> > Be less aggressive in handling this error: if it's a driver bug,
>> > warning once should be enough.
>> >
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> >
>> > --
>> >
>> > 3.6 material?
>> 
>> I have already applied, this, but it's not for stable, since it's a
>> "theoretical bugfix".  That check has been in there forever and noone
>> AFAIK has actually struck it.
>> 
>> Cheers,
>> Rusty.
>
> Yes but can't malicious userspace trigger this with remoteproc? If yes
> it's not a question of whether anyone has struck it since people don't
> normally run malicious userspace :)

I think that malicious userspace is already priveleged, isn't it?

Cheers,
Rusty.
