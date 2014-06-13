From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Why is virtio_console not a tty?
Date: Fri, 13 Jun 2014 10:36:10 +0930
Message-ID: <877g4lpqil.fsf@rustcorp.com.au>
References: <539A004F.20906@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <539A004F.20906@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

"H. Peter Anvin" <hpa@zytor.com> writes:
> I have gotten scattered reports of strange problems caused by the fact
> that virtio_console doesn't behave like a normal tty (support termios
> and so on.)  This seems to be an odd restriction -- is there any
> fundamental reason for this design choice?

Not that I know.  I tacked it into hvc_console which provided the glue
to make it a console.  Avoided me digging into console implementation,
which is pretty horrible.

Given my ignorance, how much change do we need to make it behave like a
TTY?

Cheers,
Rusty.
