From: Hannes Reinecke <hare@suse.de>
Subject: Re: [Qemu-devel] [PATCH 0/4] megaraid_sas HBA emulation
Date: Wed, 28 Oct 2009 09:11:29 +0100
Message-ID: <20091028091129.n46xqd1lww8oosc8__24874.0682182417$1256717836$gmane$org@imap.suse.de>
References: <4AE71116.6080809@suse.de> <4AE72419.60608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AE72419.60608@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Tue 27 Oct 2009 05:47:21 PM CET schrieb Gerd Hoffmann <kraxel@redhat.com>:

>   Hi,
>
>> The device can be accessed by
>>
>> -drive if=raid,file=XXX
>
> Don't extend that qemu automagic please.  The new way to handle this is:
>
>   -drive if=none,id=mydisk,file=/path/to/some/disk.img
>   -device megasas,id=raid
>   -device scsi-disk,bus=raid.0,scsi-id=1,drive=mydisk
>
Alright, no problem there. Didn't know this.

>> In order to support SCSI command emulation I had to update /
>> patch up the existing SCSI disk support. This might be
>> not to everyones taste, so I'm open to alternative
>> suggestions.
>>
>> But I certainly do _not_ want to update the SCSI disk
>> emulation, as this is really quite tied to the SCSI parallel
>> interface used by the old lsi53c895a.c.
>
> --verbose please.  I'd prefer to fix scsi-disk bugs and/or limitations
> instead of working around them.
>
The problem is I don't have any documentation for the LSI parallel
SCSI controller. So I don't know if and in what shape I/O is passed
down, nor anything else. And as the SCSI disk emulation is really
tied into the LSI parallel SCSI controller, any change in the former
is likely to break the latter.
And what with me no way of fixing it. Hence I decided on this approach.

I surely can go ahead and patch up the scsi disk emulation, but it's
quite likely to break the LSI controller. If that's okay with everybody,
I'll surely go ahead there.

>> Plus it doesn't do scatter-gather list handling,
>
> Which should be fixed anyway.
>
Quite. But as I said, the LSI parallel SCSI controller is going to
suffer.

Cheers,

Hannes
