From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2 v1] blkdrv: Add queue limits parameters for sg block
	drive
Date: Wed, 22 Aug 2012 14:09:28 +0200
Message-ID: <5034CBF8.3050602@redhat.com>
References: <1345537427-21601-1-git-send-email-mc@linux.vnet.ibm.com>
	<50334B51.6050900@redhat.com> <503357B2.5040901@linux.vnet.ibm.com>
	<CAJSP0QX8BL9R_M0NxisiP+wejjgh6C6-nz9LPAfgHppPpNpYnA@mail.gmail.com>
	<50335F78.1030005@redhat.com> <5034BCD1.9020603@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5034BCD1.9020603@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cong Meng <mc@linux.vnet.ibm.com>
Cc: stefanha@linux.vnet.ibm.com, zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 22/08/2012 13:04, Cong Meng ha scritto:
>>
>> Cong, what is the limit that the host HBA enforces (and what is the
>> HBA)?  What commands see a problem?  Is it fixed by using scsi-block
>> instead of scsi-generic (if you can use scsi-block at all, i.e. it's not
>> a tape or similar device)?
>>
> I don't see real problem caused by the the queue limits actually. It's a
> bug which Stefan told me.

I'd rather avoid patching the specification if not to solve real (rather
than known-but-theoretical) problems.

>> With scsi-generic, QEMU uses a bounce buffer for non-I/O commands to a
>> SCSI passthrough device, so the only problem in that case should be the
>> maximum segment size.  This could change in the future, but max_segments
>> and max_sectors should not yet be a problem.
> 
> about bounce buffer, do you meat the buffer allocated in
> scsi_send_command() of hw/scsi-generic.c?

Yes.

Paolo
