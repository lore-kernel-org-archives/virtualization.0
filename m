From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] megaraid_sas HBA emulation
Date: Wed, 28 Oct 2009 10:20:00 +0200
Message-ID: <4AE7FEB0.6000207__17216.5239615881$1256718074$gmane$org@redhat.com>
References: <4AE71116.6080809@suse.de> <4AE72419.60608@redhat.com>
	<20091028091129.n46xqd1lww8oosc8@imap.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091028091129.n46xqd1lww8oosc8@imap.suse.de>
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
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/28/2009 10:11 AM, Hannes Reinecke wrote:
>
> The problem is I don't have any documentation for the LSI parallel
> SCSI controller. So I don't know if and in what shape I/O is passed
> down, nor anything else. And as the SCSI disk emulation is really
> tied into the LSI parallel SCSI controller, any change in the former
> is likely to break the latter.
> And what with me no way of fixing it. Hence I decided on this approach.
>
> I surely can go ahead and patch up the scsi disk emulation, but it's
> quite likely to break the LSI controller. If that's okay with everybody,
> I'll surely go ahead there.

Reverse engineered devices are dangerous.  They might work on some 
guests but break badly on others, or even worse, break when a guest 
driver is updated.

Is there no way to get the documentation?

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
