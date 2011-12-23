From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RESENDx2] [PULL] virtio: fix barriers for virtio-mmio
Date: Fri, 23 Dec 2011 01:31:12 -0800
Message-ID: <CA+55aFyvMkAtXPRxiFR+UpZKGHMhp8Vd9aYg1dkaoKMwD5MLcw@mail.gmail.com>
References: <8739cbkgv2.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8739cbkgv2.fsf@rustcorp.com.au>
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

On Thu, Dec 22, 2011 at 9:16 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> This one as a signed tag on github, in case the inline patch was
> the reason you dropped this.

No, and please why do you make your tag-names be your email address?
That's just odd. It seems to be related to some broken SCM system that
thinks that tag-names are global and somehow different from
branch-names.

No, the reason I didn't pull was that the games with the barriers just
threw me off. They seem hacky and disgusting beyond words. And afaik
there are no actual *devices* that implement virtio-mmu, and the
commit that adds the mmu thing talks about qemu interfaces to. So it's
still just virtual, which makes the whole thing just masturbatory,
afaik. There's nothing out-of-order in virtual mmio.

So the whole thing looks confused. There's never any reason to
actually use the expensive sfence/rfences at all. Afaik you still just
want smp_*mb() for all cases.

                  Linus
