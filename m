From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RESENDx2] [PULL] virtio: fix barriers for virtio-mmio
Date: Sat, 24 Dec 2011 13:31:14 +1030
Message-ID: <87pqfeisg5.fsf@rustcorp.com.au>
References: <8739cbkgv2.fsf@rustcorp.com.au>
	<CA+55aFyvMkAtXPRxiFR+UpZKGHMhp8Vd9aYg1dkaoKMwD5MLcw@mail.gmail.com>
	<CA+55aFzKU0GWqpQo2AzAawoVm=qPaJiwKTcifeYApyZP_Hj3nQ@mail.gmail.com>
	<CAK=WgbacH1tXHJiHNKLNNsFA7-vnFT_J6vYOANh0wzGyUj8Zpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAK=WgbacH1tXHJiHNKLNNsFA7-vnFT_J6vYOANh0wzGyUj8Zpg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 23 Dec 2011 13:35:26 +0200, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Fri, Dec 23, 2011 at 11:35 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On x86, there really is never any reason to use the heavy memory
> > barriers unless you are talking to a real device. And last I saw,
> > "virtio" was still about virtual IO.

Not any more, as the commit message describes.

But I missed that they're using rpmsg, which isn't merged yet.

Sorry for the noise,
Rusty.
PS. Switching barriers by bus type is too crude anyway, let's come up
    with something better...
