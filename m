From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [PATCH 0/25] Replace DEFINE_PCI_DEVICE_TABLE macro use
Date: Fri, 18 Jul 2014 12:22:13 -0400
Message-ID: <20140718162213.GC31114__36262.1946646415$1405701364$gmane$org@tuxdriver.com>
References: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benoit Taine <benoit.taine@lip6.fr>
Cc: linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, ath5k-devel@venema.h4ckr.net, linux-acenic@sunsite.dk, linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, ath10k@lists.infradead.org, linux-hippi@sunsite.dk, industrypack-devel@lists.sourceforge.net, linux-mmc@vger.kernel.org, MPT-FusionLinux.pdl@avagotech.com, virtualization@lists.linux-foundation.org, ath9k-devel@venema.h4ckr.net, wil6210@qca.qualcomm.com, linux-pcmcia@lists.infradead.org, linux-can@vger.kernel.org, xen-devel@lists.xenproject.org, platform-driver-x86@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, users@rt2x00.serialmonkey.com, e1000-devel@lists.sourceforge.net, linux-crypto@vger.kernel.org, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 18, 2014 at 05:26:47PM +0200, Benoit Taine wrote:
> We should prefer `const struct pci_device_id` over
> `DEFINE_PCI_DEVICE_TABLE` to meet kernel coding style guidelines.
> This issue was reported by checkpatch.

Honestly, I prefer the macro -- it stands-out more.  Maybe the style
guidelines and/or checkpatch should change instead?

John
-- 
John W. Linville		Someday the world will need a hero, and you
linville@tuxdriver.com			might be all we have.  Be ready.
