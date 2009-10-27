From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] megasas: LSI MegaRAID SAS HBA emulation
Date: Tue, 27 Oct 2009 17:59:28 +0100
Message-ID: <4AE726F0.9010800__28609.161618124$1256662828$gmane$org@redhat.com>
References: <20091027152849.F37C439742@ochil.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091027152849.F37C439742@ochil.suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hannes Reinecke <hare@suse.de>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

   Hi,

> +    /* The current Qemu infrastructure allows only for LUN 0 */
> +    if (lun == 0&&  target<  MAX_RAID_DEVS)
> +	cmd->lun =&s->luns[target];

One more thing which should be fixed in qemu instead of worked around in 
your driver.  After all even good old parallel scsi knows multiple luns. 
  Guess this is how you end up with 128 scsi devices (16 ids with 8 luns 
each)?

cheers,
   Gerd
