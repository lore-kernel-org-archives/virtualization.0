From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/1] KVM support for VMD devices
Date: Wed, 22 Apr 2020 23:16:31 -0700
Message-ID: <20200423061631.GA12688@infradead.org>
References: <20200422171444.10992-1-jonathan.derrick@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200422171444.10992-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, qemu-devel@nongnu.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org, Andrzej Jakowski <andrzej.jakowski@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 22, 2020 at 01:14:44PM -0400, Jon Derrick wrote:
> The two patches (Linux & QEMU) add support for passthrough VMD devices
> in QEMU/KVM. VMD device 28C0 already supports passthrough natively by
> providing the Host Physical Address in a shadow register to the guest
> for correct bridge programming.
> 
> The QEMU patch emulates the 28C0 mode by creating a shadow register and
> advertising its support by using QEMU's subsystem vendor/id.
> The Linux patch matches the QEMU subsystem vendor/id to use the shadow
> register.

Please pick a different PCI ID for Qemu vs real hardware so that we
can properly quirk them if they end up behaving differently due to
hardware or software bugs.
