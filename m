From: Paul Brook <paul@codesourcery.com>
Subject: Re: [Qemu-devel] virtio-serial: A guest <-> host interface for simple
	communication
Date: Tue, 23 Jun 2009 14:09:40 +0100
Message-ID: <200906231409.41428.paul__26202.7122815654$1245762646$gmane$org@codesourcery.com>
References: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
	<200906231355.53557.paul@codesourcery.com>
	<20090623130023.GA32110@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090623130023.GA32110@amit-x200.redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 23 June 2009, Amit Shah wrote:
> On (Tue) Jun 23 2009 [13:55:52], Paul Brook wrote:
> > > Here are two patches. One implements a virtio-serial device in qemu
> > > and the other is the driver for a guest kernel.
> >
> > So I'll ask again. Why is this separate from virtio-console?
>
> I'm basically writing a vmchannel and found out that a lot can be shared
> between some virtio devices. So I'm just trying to abstract out those
> things in virtio-serial. Once we're sure virtio-serial is good and ready
> to be merged, I will look at converting over virtio-console to the
> virtio-serial interface.

That doesn't really answer my question. We already have a virtual serial 
device (called virtio-console). Why are you inventing another one?

Paul
