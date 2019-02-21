From: Alistair Francis <alistair23@gmail.com>
Subject: Re: [PATCH] drm/bochs: Fix the ID mismatch error
Date: Thu, 21 Feb 2019 10:44:06 -0800
Message-ID: <CAKmqyKM_pb-riJ+jO65eT0SsVDxrstPOgurPuDf92Fd4C8k1Ug__24947.8732280963$1555717163$gmane$org@mail.gmail.com>
References: <20190221003231.31625-1-alistair.francis@wdc.com>
	<20190221115227.ipwjpn3xm4q7jfg2@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190221115227.ipwjpn3xm4q7jfg2@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "kraxel@redhat.com" <kraxel@redhat.com>
Cc: "david.abdurachmanov@gmail.com" <david.abdurachmanov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Alistair Francis <Alistair.Francis@wdc.com>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 21, 2019 at 3:52 AM kraxel@redhat.com <kraxel@redhat.com> wrote:
>
> On Thu, Feb 21, 2019 at 12:33:03AM +0000, Alistair Francis wrote:
> > When running RISC-V QEMU with the Bochs device attached via PCIe the
> > probe of the Bochs device fails with:
> >     [drm:bochs_hw_init] *ERROR* ID mismatch
> >
> > This was introduced by this commit:
> >     7780eb9ce8 bochs: convert to drm_dev_register
> >
> > To fix the error we ensure that pci_enable_device() is called before
> > bochs_load().
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reported-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
>
> Pushed to drm-misc-fixes.

Thanks. Any chance this will make it into 5.0?

Alistair

>
> thanks,
>   Gerd
>
