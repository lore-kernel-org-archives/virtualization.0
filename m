From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: what should a virtio-mmio transport without a backend look like?
Date: Fri, 21 Jun 2013 17:41:04 +0100
Message-ID: <CAFEAcA9SM7K=-UFAkFOzRX0jcc5yJj6jAw4QFhWwC8VBO8SggA@mail.gmail.com>
References: <CAFEAcA9qCUQLZho8wJvewYJ0AEhDBc37_LpZWs8XBV1U7RVZgA@mail.gmail.com>
	<1371726501.3231.22.camel@hornet> <51C2FC5B.7080406@codeaurora.org>
	<CAFEAcA98py6MHQih8y0Vfr1T1PQj-Cy54cOzPbMfAOH3Xnf+Tw@mail.gmail.com>
	<51C4792F.6010709@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51C4792F.6010709@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christopher Covington <cov@codeaurora.org>
Cc: =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 21 June 2013 17:02, Christopher Covington <cov@codeaurora.org> wrote:
> Would using CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES enumeration
> instead of device tree be any easier?

My general view is that the kernel command line is
the user's to manipulate, and that QEMU shouldn't
touch it at all (just pass it through). (Conversely,
QEMU shouldn't require the user to specify odd
kernel command line arguments in order to make things
work.)

(Having talked with Grant Likely I now have a reasonable
plan for manipulating the dtb to add virtio nodes, so
I'm happy that that's the right way to go.)

As it happens, if you use the command line to specify
a virtio device it doesn't make the same complaint about
bad magic number as if you specify it via dtb, but that
should probably be fixed in the kernel :-)

> How does the back end know which devices to create?

Anything specified via -device on the QEMU command line
is created after the board model has initialized. When a
virtio-blk-backend (or whatever) is created it's automatically
plugged into the first available matching bus (in the same
way that if you create a PCI card via -device it plugs
into the first available PCI slot).

-- PMM
