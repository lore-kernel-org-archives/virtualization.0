From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 1/1] Add virtio-input driver.
Date: Fri, 20 Mar 2015 11:43:46 +0100
Message-ID: <CANq1E4T_=iwveCz2RYDbHCwwVgyVfs6yM0W6jhquy86K-StChA__7840.41202064163$1426848239$gmane$org@mail.gmail.com>
References: <1426756391-26585-1-git-send-email-kraxel@redhat.com>
	<1426756391-26585-2-git-send-email-kraxel@redhat.com>
	<CANq1E4TDj4pq3J_BVc=Yuzo5dVR=QcNexVUqaqwjg7Qi5_xX4Q@mail.gmail.com>
	<1426844885.32097.36.camel@nilsson.home.kraxel.org>
	<CANq1E4QLPSK6NVeEx6yihYPdF-XPpXx4rKv0deHwX+s2RzFHCg@mail.gmail.com>
	<1426847799.32097.66.camel@nilsson.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1426847799.32097.66.camel@nilsson.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, mst@redhat.com, "open list:ABI/API" <linux-api@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi

On Fri, Mar 20, 2015 at 11:36 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> I'd like to see all four forwarded from the host. I'd be fine with
>> "bus" being set to VIRTUAL, but I'm not sure why that would be a good
>> thing to do?
>
> I think for the emulated devices it's fine to use VIRTUAL.

Yes, on the host side just use BUS_VIRTUAL if you don't have a real bus to set.

> For the passthrough case suspected we could confuse apps because ->phys
> points to a virtio device whereas ->type says "I'm usb".

That's not an issue. The "phys" field hasn't been standardized in any
way that I'm aware of (except on a per-driver basis, maybe).

> But at least the device database probably doesn't care much about the
> physical path I guess, because the mouse is the same no matter which usb
> port I plug it in, correct?

Correct!

Thanks
David
