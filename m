From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [pciutils patch v2] add virtio vendor capability support
Date: Thu, 22 Jan 2015 10:17:57 +0100
Message-ID: <1421918277.9213.10.camel__48439.6414635286$1421918293$gmane$org@nilsson.home.kraxel.org>
References: <1421854504-11945-1-git-send-email-kraxel@redhat.com>
	<mj+md-20150122.090952.11254.nikam@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-AHPoM09+Kyg1UWtiBQGk"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <mj+md-20150122.090952.11254.nikam@ucw.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Martin Mares <mj@ucw.cz>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--=-AHPoM09+Kyg1UWtiBQGk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Do, 2015-01-22 at 10:10 +0100, Martin Mares wrote:
> lspci -vxxx

Attached is a dump of a virtio-net device (both verbose=2 and hex).

cheers,
  Gerd


--=-AHPoM09+Kyg1UWtiBQGk
Content-Type: text/plain; name="virtio-net.txt"; charset="UTF-8"
Content-Description: 
Content-Disposition: inline; filename="virtio-net.txt"
Content-Transfer-Encoding: 7bit

00:09.0 Ethernet controller: Red Hat, Inc Virtio network device
	Subsystem: Red Hat, Inc Virtio network device
	Physical Slot: 9
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at c060 [size=32]
	Region 1: Memory at febd6000 (32-bit, non-prefetchable) [size=4K]
	Region 2: Memory at fea00000 (32-bit, non-prefetchable) [size=512K]
	Expansion ROM at feb80000 [disabled] [size=256K]
	Capabilities: [84] MSI-X: Enable+ Count=3 Masked-
		Vector table: BAR=1 offset=00000000
		PBA: BAR=1 offset=00000800
	Capabilities: [70] VirtIO: Notify
		BAR=2 offset=00003000 size=00040000
		multiplier=00001000
	Capabilities: [60] VirtIO: DeviceCfg
		BAR=2 offset=00002000 size=00001000
	Capabilities: [50] VirtIO: ISR
		BAR=2 offset=00001000 size=00001000
	Capabilities: [40] VirtIO: CommonCfg
		BAR=2 offset=00000000 size=00001000
	Kernel driver in use: virtio-pci
00: f4 1a 00 10 07 05 10 00 00 00 00 02 00 00 00 00
10: 61 c0 00 00 00 60 bd fe 00 00 a0 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f4 1a 01 00
30: 00 00 b8 fe 84 00 00 00 00 00 00 00 0a 01 00 00
40: 09 00 10 01 02 00 00 00 00 00 00 00 00 10 00 00
50: 09 40 10 03 02 00 00 00 00 10 00 00 00 10 00 00
60: 09 50 10 04 02 00 00 00 00 20 00 00 00 10 00 00
70: 09 60 14 02 02 00 00 00 00 30 00 00 00 00 04 00
80: 00 10 00 00 11 70 02 80 01 00 00 00 01 08 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--=-AHPoM09+Kyg1UWtiBQGk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--=-AHPoM09+Kyg1UWtiBQGk--
