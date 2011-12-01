From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] virtio: use mandatory barriers for remote processor vdevs
Date: Thu, 01 Dec 2011 12:58:59 +1030
Message-ID: <87zkfdrpn8.fsf@rustcorp.com.au>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
	<20111129131110.GC19157@redhat.com>
	<CAK=WgbZoGYVyKt=XXvnPVdh0koSBJC0zcgkLaYRkmjwBLOFA-A@mail.gmail.com>
	<20111129151958.GA31789@redhat.com>
	<CAK=WgbZ5aBFNro3XC0cN+Ao4ZWrBHwwd3d__CSHA=n56gKmKXw@mail.gmail.com>
	<20111130145004.GD21413@redhat.com>
	<CAK=WgbY59n9N_-2_TZ9wNBNcTMV1DCrz65e-Ae=xamcg6A0dOA@mail.gmail.com>
	<20111130231306.GD30031@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111130231306.GD30031@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 1 Dec 2011 01:13:07 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> For x86, stores into memory are ordered. So I think that yes, smp_XXX
> can be selected at compile time.
> 
> So let's forget the virtio strangeness for a minute,

Hmm, we got away with light barriers because we knew we were not
*really* talking to a device.  But now with virtio-mmio, turns out we
are :)

I'm really tempted to revert d57ed95 for 3.2, and we can revisit this
optimization later if it proves worthwhile.

Thoughts?
Rusty. 
