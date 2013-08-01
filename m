From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/5] Enable Drivers for Intel MIC X100 Coprocessors.
Date: Wed, 31 Jul 2013 18:46:08 -0700
Message-ID: <20130801014608.GD6941__28333.3396692344$1375342277$gmane$org@kroah.com>
References: <cover.1374717252.git.sudeep.dutt@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1374717252.git.sudeep.dutt@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>, "Yaozu (Eddie) Dong" <eddie.dong@intel.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Harshavardhan R Kharche <harshavardhan.r.kharche@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, Rob Landley <rob@landley.net>, Caz Yokoyama <Caz.Yokoyama@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 24, 2013 at 08:31:31PM -0700, Sudeep Dutt wrote:
> An Intel MIC X100 device is a PCIe form factor add-in coprocessor
> card based on the Intel Many Integrated Core (MIC) architecture
> that runs a Linux OS. It is a PCIe endpoint in a platform and therefore
> implements the three required standard address spaces i.e. configuration,
> memory and I/O. The host OS loads a device driver as is typical for
> PCIe devices. The card itself runs a bootstrap after reset that
> transfers control to the card OS downloaded from the host driver.
> The card OS as shipped by Intel is a Linux kernel with modifications
> for the X100 devices.
> 
> Since it is a PCIe card, it does not have the ability to host hardware
> devices for networking, storage and console. We provide these devices
> on X100 coprocessors thus enabling a self-bootable equivalent environment
> for applications. A key benefit of our solution is that it leverages
> the standard virtio framework for network, disk and console devices,
> though in our case the virtio framework is used across a PCIe bus.
> 
> Here is a block diagram of the various components described above. The
> virtio backends are situated on the host rather than the card given better
> single threaded performance for the host compared to MIC and the ability of
> the host to initiate DMA's to/from the card using the MIC DMA engine.
> 
>                               |
>        +----------+           |             +----------+
>        | Card OS  |           |             | Host OS  |
>        +----------+           |             +----------+
>                               |
> +-------+ +--------+ +------+ | +---------+  +--------+ +--------+
> | Virtio| |Virtio  | |Virtio| | |Virtio   |  |Virtio  | |Virtio  |
> | Net   | |Console | |Block | | |Net      |  |Console | |Block   |
> | Driver| |Driver  | |Driver| | |backend  |  |backend | |backend |
> +-------+ +--------+ +------+ | +---------+  +--------+ +--------+
>     |         |         |     |      |            |         |
>     |         |         |     |Ring 3|            |         |
>     |         |         |     |------|------------|---------|-------
>     +-------------------+     |Ring 0+--------------------------+
>               |               |      | Virtio over PCIe IOCTLs  |
>               |               |      +--------------------------+
>       +--------------+        |                   |
>       |Intel MIC     |        |            +---------------+
>       |Card Driver   |        |            |Intel MIC      |
>       +--------------+        |            |Host Driver    |
>               |               |            +---------------+
>               |               |                   |
>      +-------------------------------------------------------------+
>      |                                                             |
>      |                    PCIe Bus                                 |
>      +-------------------------------------------------------------+

That's some nice information, why isn't it in one of the patches you
sent, so that others can read it later on to try to figure out what is
going on with this codebase?

thanks,

greg k-h
