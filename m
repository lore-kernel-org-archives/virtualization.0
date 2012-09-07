From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC 1/2] virtio_console: Add support for DMA memory allocation
Date: Fri, 7 Sep 2012 10:35:50 +0200
Message-ID: <CAJK669avB+nsq6YrvKwODSSz=5NzFP5JdM41qkHz9k5ZOVyc2w@mail.gmail.com>
References: <1346680277-5887-1-git-send-email-sjur.brandeland@stericsson.com>
	<20120903143018.GA5353@redhat.com>
	<CAJK669bkHHMAPYMEr22-6uOwfgJv1uKTbzNBQVVCq=OooExC0g@mail.gmail.com>
	<20120903202737.GD6181@redhat.com>
	<CAJK669ZvnnG6fGOog-Z47B7xqyn9hcx5dAD7S--+2PSgE+hrLA@mail.gmail.com>
	<20120904135022.GI9805@redhat.com>
	<CAJK669Z1UYakBWartChfoeKL_eU5=GFZMGhH8R_Q-difVm0ygQ@mail.gmail.com>
	<20120904185541.GB3602@redhat.com> <87k3w7j49i.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87k3w7j49i.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Ohad,

>> A simplest thing to do is change dev id. rusty?
>
> For generic usage, this is correct.  But my opinion is that fallback on
> feature non-ack is quality-of-implementation issue: great to have, but
> there are cases where you just want to fail with "you're too old".
>
> And in this case, an old system simply will never work.  So it's a
> question of how graceful the failure is.
>
> Can your userspace loader can refuse to proceed if the driver doesn't
> ack the bits?  If so, it's simpler than a whole new ID.

Ohad: Are there any way we could avoid starting up the remote processor
if mandatory virtio features (such as DMA memory) are not supported by
the virtio-driver?

Regards,
Sjur
