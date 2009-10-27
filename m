From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] megaraid_sas HBA emulation
Date: Tue, 27 Oct 2009 17:47:21 +0100
Message-ID: <4AE72419.60608__31780.5624953055$1256662363$gmane$org@redhat.com>
References: <4AE71116.6080809@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AE71116.6080809@suse.de>
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

> The device can be accessed by
>
> -drive if=raid,file=XXX

Don't extend that qemu automagic please.  The new way to handle this is:

   -drive if=none,id=mydisk,file=/path/to/some/disk.img
   -device megasas,id=raid
   -device scsi-disk,bus=raid.0,scsi-id=1,drive=mydisk

> In order to support SCSI command emulation I had to update /
> patch up the existing SCSI disk support. This might be
> not to everyones taste, so I'm open to alternative
> suggestions.
>
> But I certainly do _not_ want to update the SCSI disk
> emulation, as this is really quite tied to the SCSI parallel
> interface used by the old lsi53c895a.c.

--verbose please.  I'd prefer to fix scsi-disk bugs and/or limitations 
instead of working around them.

> Plus it doesn't do scatter-gather list handling,

Which should be fixed anyway.

cheers,
   Gerd
