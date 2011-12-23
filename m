From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RESENDx2] [PULL] virtio: fix barriers for virtio-mmio
Date: Fri, 23 Dec 2011 01:35:26 -0800
Message-ID: <CA+55aFzKU0GWqpQo2AzAawoVm=qPaJiwKTcifeYApyZP_Hj3nQ@mail.gmail.com>
References: <8739cbkgv2.fsf@rustcorp.com.au>
	<CA+55aFyvMkAtXPRxiFR+UpZKGHMhp8Vd9aYg1dkaoKMwD5MLcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+55aFyvMkAtXPRxiFR+UpZKGHMhp8Vd9aYg1dkaoKMwD5MLcw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 23, 2011 at 1:31 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So the whole thing looks confused. There's never any reason to
> actually use the expensive sfence/rfences at all. Afaik you still just
> want smp_*mb() for all cases.

But note that I haven't thought deeply about it, I just looked at the
patch and went "Hmm, that can't be right", and then it kind of got
dropped because I forgot about it.

On x86, there really is never any reason to use the heavy memory
barriers unless you are talking to a real device. And last I saw,
"virtio" was still about virtual IO.

Now, I could in theory imagine that you migth want to unconditionally
have the "smp_*mb()" barriers in the case where you are running UP
guest in an SMP host, but that's not what the patch actually did. It
did that odd crazy dynamic "IO barrier or SMP barrier" thing, which
just is confused and doesn't make sense to me in any situation I can
think of.

                    Linus
