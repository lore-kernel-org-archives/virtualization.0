From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/1] Add virtio-input driver.
Date: Fri, 20 Mar 2015 11:36:39 +0100
Message-ID: <1426847799.32097.66.camel__3215.21379887617$1426847818$gmane$org@nilsson.home.kraxel.org>
References: <1426756391-26585-1-git-send-email-kraxel@redhat.com>
	<1426756391-26585-2-git-send-email-kraxel@redhat.com>
	<CANq1E4TDj4pq3J_BVc=Yuzo5dVR=QcNexVUqaqwjg7Qi5_xX4Q@mail.gmail.com>
	<1426844885.32097.36.camel@nilsson.home.kraxel.org>
	<CANq1E4QLPSK6NVeEx6yihYPdF-XPpXx4rKv0deHwX+s2RzFHCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CANq1E4QLPSK6NVeEx6yihYPdF-XPpXx4rKv0deHwX+s2RzFHCg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, mst@redhat.com, "open
	list:ABI/API" <linux-api@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > There will also be pass-through support, i.e. qemu
> > opening /dev/input/event<nr> and forwarding everything to the guest.
> > How should that be handled best?  Copy all four from the host?  Even
> > though the bustype is BUS_USB?  Not sure this actually improves things
> > because the guest can match the device, or whenever this confuses apps
> > due to BUS_USB being applied to virtio devices ...
> 
> Lemme give an example: We have databases in user-space, that allow
> applications to figure out the mouse DPI values of a device. Those
> databases match on all four, bus+vid+pid+ver (sometimes even more,
> like name and dmi). If one of those is not forwarded, it will not be
> detected.

Ok, so forward as much as possible.

> I'd like to see all four forwarded from the host. I'd be fine with
> "bus" being set to VIRTUAL, but I'm not sure why that would be a good
> thing to do?

I think for the emulated devices it's fine to use VIRTUAL.

For the passthrough case suspected we could confuse apps because ->phys
points to a virtio device whereas ->type says "I'm usb".

But at least the device database probably doesn't care much about the
physical path I guess, because the mouse is the same no matter which usb
port I plug it in, correct?

cheers,
  Gerd
