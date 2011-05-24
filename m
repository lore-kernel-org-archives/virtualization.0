From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch/tile: add /proc/tile, /proc/sys/tile,
	and a sysfs cpu attribute
Date: Tue, 24 May 2011 17:38:51 +0200
Message-ID: <201105241738.52146.arnd__39490.3199201964$1306251588$gmane$org@arndb.de>
References: <201105181807.p4II7C5g015224@farm-0002.internal.tilera.com>
	<4DD5334D.4060800@tilera.com> <201105191722.17685.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201105191722.17685.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 19 May 2011, Arnd Bergmann wrote:
> > 
> > # cat /proc/tile/board
> > board_part: 402-00002-05
> > board_serial: NBS-5002-00012
> > chip_serial: P62338.01.110
> > chip_revision: A0
> > board_revision: 2.2
> > board_description: Tilera TILExpressPro-64, TILEPro64 processor (866 MHz-capable), 1 10GbE, 6 1GbE
> > # cat /proc/tile/switch
> > control: mdio gbe/0
> 
> I think it's ok to have it below /sys/hypervisor, because the information
> is provided through a hypervisor ABI, even though it describes something
> else. This is more like /sys/firmware, but the boundaries between that
> and /sys/hypervisor are not clearly defined when running virtualized anyway.

A minor point that I meant to bring up but had not gotten to:

When you do a /sys/hypervisor/ interface, put everything into a subdirectory
under /sys/hypervisor with the name of your hypervisor, to avoid naming
conflicts, e.g.

/sys/hypervisor/tilera-hv/board/board_serial

	Arnd
