From: Benoit Taine <benoit.taine@lip6.fr>
Subject: [PATCH 0/25] Replace DEFINE_PCI_DEVICE_TABLE macro use
Date: Fri, 18 Jul 2014 17:26:47 +0200
Message-ID: <1405697232-11785-1-git-send-email-benoit.taine__19578.6555101678$1405698823$gmane$org@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-pci@vger.kernel.org
Cc: linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org, linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, benoit.taine@lip6.fr, ath5k-devel@venema.h4ckr.net, linux-acenic@sunsite.dk, linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, ath10k@lists.infradead.org, linux-hippi@sunsite.dk, industrypack-devel@lists.sourceforge.net, xen-devel@lists.xenproject.org, MPT-FusionLinux.pdl@avagotech.com, virtualization@lists.linux-foundation.org, ath9k-devel@venema.h4ckr.net, wil6210@qca.qualcomm.com, linux-pcmcia@lists.infradead.org, linux-can@vger.kernel.org, platform-driver-x86@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, users@rt2x00.serialmonkey.com, e1000-devel@lists.sourceforge.net, linux-crypto@vger.kernel.org, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

We should prefer `const struct pci_device_id` over
`DEFINE_PCI_DEVICE_TABLE` to meet kernel coding style guidelines.
This issue was reported by checkpatch.

A simplified version of the semantic patch that makes this change is as
follows (http://coccinelle.lip6.fr/):

// <smpl>

@@
identifier i;
declarer name DEFINE_PCI_DEVICE_TABLE;
initializer z;
@@

- DEFINE_PCI_DEVICE_TABLE(i)
+ const struct pci_device_id i[]
= z;

// </smpl>

I have 103 patches ready, and will only send a few for you to judge if
it is useful enough, and to prevent from spamming too much.

Thanks.
