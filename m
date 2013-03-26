From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] drivers: virtio: Use PTR_RET function
Date: Tue, 26 Mar 2013 20:53:27 +1030
Message-ID: <87620ecvds.fsf@rustcorp.com.au>
References: <1364217936-6284-1-git-send-email-gheorghiuandru@gmail.com>
	<87fvzidenm.fsf@rustcorp.com.au>
	<20130325220150.af9795a7.akpm@linux-foundation.org>
	<CADca43+r4kPBv-=kqo5VZ4+E2-OD1Y6ipkPXzxmFwrt2x1Z7Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CADca43+r4kPBv-=kqo5VZ4+E2-OD1Y6ipkPXzxmFwrt2x1Z7Vw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andru Gheorghiu <gheorghiuandru@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Andru Gheorghiu <gheorghiuandru@gmail.com> writes:
> PTR_RET does return. It's perfectly equivalent to using IS_ERR and the
> returning PTR_ERR. The implementation is here [1].

Um, I read the implementation, thanks.

> The reason for using it is this: if you have a function that does
> something why not call it instead of reproducing it's behavior by
> explicitly writing what it does.

Because clarity matters, and this function makes callers less clear.
It's the most breathtakingly bad name since BUILD_BUG_ON_ZERO().

Why not change PTR_ERR to return 0 if !IS_ERR()?  Noone breaks, gcc
probably produces the same code, and noone needs to learn your weird
new kernel meme.

In fact, as gcc will produce the same code for "if (PTR_ERR(p))" as it
does for "if (IS_ERR(p))", you get to be one of the very, very few
people who have ever *reduced* the complexity of a kernel interface.

Cheers,
Rusty.
