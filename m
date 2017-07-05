From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] virtio-blk: add DISCARD support to virtio-blk driver
Date: Wed, 5 Jul 2017 10:00:23 +0200
Message-ID: <1e57bca7-cf5c-741d-b0f2-d026826d2dcc@redhat.com>
References: <1499244279-3484-1-git-send-email-changpeng.liu@intel.com>
	<01542f21-6fa3-c406-65e1-a37d04130fb7@redhat.com>
	<FF7FC980937D6342B9D289F5F3C7C2625B595B29@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B595B29@SHSMSX103.ccr.corp.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Liu, Changpeng" <changpeng.liu@intel.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "hch@lst.de" <hch@lst.de>, "mst@redhat.com" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



On 05/07/2017 09:57, Liu, Changpeng wrote:
>> Please include a patch for the specification.  Since we are at it, I
> Thanks Paolo, do you mean include a text file which describe the changes for the specification?

The specification is hosted in an svn (Subversion) repository at
https://tools.oasis-open.org/version-control/svn/virtio.  You can
provide a patch and send it to virtio-comment@lists.oasis-open.org.

Thanks,

Paolo

>> would like to have three operations defined using the same descriptor:
>>
>> - discard (SCSI UNMAP)
>>
>> - write zeroes (SCSI WRITE SAME without UNMAP flag)
>>
>> - write zeroes and possibly discard (SCSI WRITE SAME with UNMAP flag)
>>
>> The last two can use the same command VIRTIO_BLK_T_WRITE_ZEROES, using
>> the reserved field as a flags field.
>
> Will add write zeroes feature.
