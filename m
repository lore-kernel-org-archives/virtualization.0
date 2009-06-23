From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [Qemu-devel] virtio-serial: A guest <-> host interface for
	simple communication
Date: Tue, 23 Jun 2009 18:30:23 +0530
Message-ID: <20090623130023.GA32110__6411.64225894517$1245762242$gmane$org@amit-x200.redhat.com>
References: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
	<200906231355.53557.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906231355.53557.paul@codesourcery.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Brook <paul@codesourcery.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Jun 23 2009 [13:55:52], Paul Brook wrote:
> > Here are two patches. One implements a virtio-serial device in qemu
> > and the other is the driver for a guest kernel.
> 
> So I'll ask again. Why is this separate from virtio-console?

I'm basically writing a vmchannel and found out that a lot can be shared
between some virtio devices. So I'm just trying to abstract out those
things in virtio-serial. Once we're sure virtio-serial is good and ready
to be merged, I will look at converting over virtio-console to the
virtio-serial interface.

Is that an acceptable approach?

Thanks,
		Amit
