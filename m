From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH for-2.6.35] virtio-pci: disable msi at startup
Date: Thu, 10 Jun 2010 08:34:32 -0700
Message-ID: <20100610083432.3c23ad6a__7663.76869655705$1276184259$gmane$org@virtuousgeek.org>
References: <20100610152252.GA3510@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100610152252.GA3510@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, linux-pci@vger.kernel.org, Matt Carlson <mcarlson@broadcom.com>, virtualization@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Bjorn@smtp1.linux-foundation.org, Randy@smtp1.linux-foundation.org, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Tejun Heo <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Helgaas <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 10 Jun 2010 18:22:52 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> virtio-pci resets the device at startup by writing to the status
> register, but this does not clear the pci config space,
> specifically msi enable status which affects register
> layout.
> 
> This breaks things like kdump when they try to use e.g. virtio-blk.
> 
> Fix by forcing msi off at startup. Since pci.c already has
> a routine to do this, we export and use it instead of duplicating code.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Tested-by: Vivek Goyal <vgoyal@redhat.com>
> Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> Cc: linux-pci@vger.kernel.org
> ---

Yeah, looks fine.

Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>

-- 
Jesse Barnes, Intel Open Source Technology Center
