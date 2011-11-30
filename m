From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC] virtio: use mandatory barriers for remote processor vdevs
Date: Wed, 30 Nov 2011 18:24:16 +0200
Message-ID: <CAK=WgbazBq4GVo16sZsrZirgMYbwMcWtPaqn90c6d9Phr0gh3A@mail.gmail.com>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
	<20111129131110.GC19157@redhat.com>
	<CAK=WgbZoGYVyKt=XXvnPVdh0koSBJC0zcgkLaYRkmjwBLOFA-A@mail.gmail.com>
	<20111129151607.GE30966@redhat.com>
	<CAK=WgbZK+k4uuyMPHUfr_PMyrR5ceRTvuDRpmhXfgwpSUOPw0g@mail.gmail.com>
	<20111130145958.GE21413@redhat.com>
	<CAK=WgbYyFdLftE_kp2_JOThVhn-FzGsDqVqKn0Jwm2teQyZBNA@mail.gmail.com>
	<20111130161555.GB25812@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111130161555.GB25812@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 30, 2011 at 6:15 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> How are the rings mapped? normal memory, right?

No, device memory.

> We allocate them with plan alloc_pages_exact in virtio_pci.c ...

I'm not using virtio_pci.c; remoteproc is allocating the rings using
the DMA API.

> Yes wmb() is required to ensure ordering for MMIO.
> But here both accesses: index and ring - are for
> memory, not MMIO.

I'm doing IO with a device over shared memory. It does require
mandatory barriers as I explained.

> Is this something you see in practice?

Yes. These bugs are very real.
