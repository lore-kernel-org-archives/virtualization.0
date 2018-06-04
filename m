From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4] virtio_blk: add DISCARD and WRIET ZEROES commands
	support
Date: Mon, 4 Jun 2018 12:02:48 +0200
Message-ID: <102ec75b-68c9-a488-d0c3-223ab09254bc@redhat.com>
References: <1527558144-3825-1-git-send-email-changpeng.liu@intel.com>
	<20180531103047.GB27838@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B6DCEE5@SHSMSX103.ccr.corp.intel.com>
	<20180601085935.GA8196@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B6DD85E@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B6DD85E@SHSMSX103.ccr.corp.intel.com>
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
To: "Liu, Changpeng" <changpeng.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "cavery@redhat.com" <cavery@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 04/06/2018 06:14, Liu, Changpeng wrote:
>>> But I believe the specification says VIRTIO_BLK_T_OUT means direction, so
>>> OR the two bits together should compliance with the specification.
>> I cannot find that in the specification:
>>
>>   http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-
>> 2020002
>>
>> and it would contradict the "The type of the request is either ... or
>> ..." wording that I quoted from the spec above.
>>
>> If you do find something in the spec, please let me know and we can
>> figure out how to make the spec consistent.
>
> I saw comments from file linux/usr/include/uapi/linux/virtio_blk.h, which says
> VIRTIO_BLK_T_OUT may be combined with other commands and means direction,
> the specification does not have such description.

I don't think it is in the specification indeed (however, 11 and 13 were
chosen so that VIRTIO_BLK_T_OUT can still indicate direction).

Paolo
