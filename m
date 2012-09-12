From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFCv3] virtio_console: Add support for virtio remoteproc serial
Date: Wed, 12 Sep 2012 15:30:08 +0930
Message-ID: <87ehm7dbmf.fsf@rustcorp.com.au>
References: <1347001066-13521-1-git-send-email-sjur.brandeland@stericsson.com>
	<1347001066-13521-1-git-send-email-sjur.brandeland@stericsson.com>
	<1347290307-8155-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1347290307-8155-1-git-send-email-sjur.brandeland@stericsson.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjurbren@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

sjur.brandeland@stericsson.com writes:
> I actually like this new approach better.
> It solves the issues Michael has pointed out, and we don't have to
> think through side effects of weired combination of feature bits.

Agreed.

Just one thing, should it depend on CONFIG_REMOTEPROC?  And have
OMAP_REMOTEPROC depend on CONFIG_HAS_DMA (if it doesn't already).

Thanks,
Rusty.
PS.  I've reserved 11 for you in the latest virtio spec draft.
